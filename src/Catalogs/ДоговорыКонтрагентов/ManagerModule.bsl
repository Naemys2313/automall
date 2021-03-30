Функция am_ДоговорПоУмолчанию(Контрагент, Организация = Неопределено) Экспорт
	Если ТипЗнч(Контрагент) = Тип("СправочникОбъект.Контрагенты") Тогда
		КонтрагентСсылка = Контрагент.Ссылка;
	Иначе
		КонтрагентСсылка = Контрагент;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ОсновныеДоговорыКонтрагента.Договор
	|ИЗ
	|	РегистрСведений.ОсновныеДоговорыКонтрагента КАК ОсновныеДоговорыКонтрагента
	|ГДЕ
	|	ОсновныеДоговорыКонтрагента.Контрагент = &Контрагент
	|	И НЕ ОсновныеДоговорыКонтрагента.Договор.Ссылка ЕСТЬ NULL
	|	И ОсновныеДоговорыКонтрагента.Организация = &Организация";
	
	Запрос.УстановитьПараметр("Контрагент", КонтрагентСсылка);
	Запрос.УстановитьПараметр("Организация", Организация);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Справочники.ДоговорыКонтрагентов.ПустаяСсылка();
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	
	Выборка.Следующий();
	Возврат Выборка.Договор;
КонецФункции

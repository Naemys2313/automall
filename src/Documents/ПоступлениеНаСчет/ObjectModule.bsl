
&После("ПередЗаписью")
Процедура am_ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	               |	Патенты.Ссылка КАК Ссылка,
	               |	Патенты.ВерсияДанных КАК ВерсияДанных,
	               |	Патенты.ПометкаУдаления КАК ПометкаУдаления,
	               |	Патенты.Код КАК Код,
	               |	Патенты.Наименование КАК Наименование,
	               |	Патенты.ДатаНачала КАК ДатаНачала,
	               |	Патенты.ДатаОкончания КАК ДатаОкончания,
	               |	Патенты.Предопределенный КАК Предопределенный,
	               |	Патенты.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных
	               |ИЗ
	               |	Справочник.Патенты КАК Патенты
	               |ГДЕ
	               |	Патенты.ДатаНачала <= &ТекДата
	               |	И Патенты.ДатаОкончания >= &ТекДата";
	
	Запрос.УстановитьПараметр("ТекДата", ТекущаяДата());
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Патент = Справочники.Патенты.ПустаяСсылка();
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	
	Если Выборка.Следующий() Тогда
		Патент = Выборка.Ссылка;
	КонецЕсли;
КонецПроцедуры

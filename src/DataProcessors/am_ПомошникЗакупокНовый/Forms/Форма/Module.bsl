
&НаСервере
Процедура КомандаЗаполнитьНаСервере()
	
	zac_ОбщийМодульСервер.ЗапуститьАссистентаПоЗакупу();	
	
	
	
	//ТЗ = Новый ТаблицаЗначений;
	//ТЗ.Колонки.Добавить("Номенклатура");
	//ТЗ.Колонки.Добавить("Количество");
	//
	//Запрос = Новый Запрос;
	//Запрос.Текст = "ВЫБРАТЬ
	//               |	ОтчетОРозничныхПродажахЗапасы.Номенклатура КАК Номенклатура
	//               |ИЗ
	//               |	Документ.ОтчетОРозничныхПродажах.Запасы КАК ОтчетОРозничныхПродажахЗапасы
	//               |ГДЕ
	//               |	НЕ ОтчетОРозничныхПродажахЗапасы.Ссылка.zac_Processed_auto
	//               |	И ОтчетОРозничныхПродажахЗапасы.Ссылка.Проведен
	//               |
	//               |СГРУППИРОВАТЬ ПО
	//               |	ОтчетОРозничныхПродажахЗапасы.Номенклатура";
	//Результат = Запрос.Выполнить();
	//Выборка = Результат.Выбрать();
	//
	//Пока Выборка.Следующий() Цикл
	//	
	//	Остатки = 0;
	//	МинУрЗапаса = 0;
	//	МакУрЗапаса = 0;
	//	ВПути = 0;
	//	
	//	Рез = ПолучитьМинИМахОстаток(Выборка.Номенклатура);
	//	
	//	Остатки 	= ПолучитьОстатки(Выборка.Номенклатура, ТекущаяДата());
	//	МинУрЗапаса = Рез[0].МинЗначение;
	//	МакУрЗапаса = Рез[0].МахЗначение;
	//	ВПути		= ПолучитьОстаткиВПути(Выборка.Номенклатура, ТекущаяДата());	
	//	
	//	Если Остатки + ВПути > МакУрЗапаса Тогда
	//		Продолжить;
	//	КонецЕсли;
	//	
	//	Заказать = МакУрЗапаса - ВПути - Остатки - ?(Остатки <= МинУрЗапаса, МинУрЗапаса, 0);
	//	
	//	Если Заказать > 0 Тогда
	//		
	//		НоваяСтрока = ТЗ.Добавить();
	//		НоваяСтрока.Номенклатура 	= Выборка.Номенклатура;
	//		НоваяСтрока.Количество 		= Заказать;
	//		
	//	КонецЕсли;
	//	
	//КонецЦикла;
	//
	////Этап 2

	//СтруктураНовогоДокумента = ПодготовитьСтруктуруНовогоЗаказа();
	//
	//Для Каждого Строка Из ТЗ Цикл
	//	
	//	//Найдём у кого покупали
	//	Контрагент = УКогоКупили(Строка.Номенклатура);
	//	Цена = ПочёмКупили(Строка.Номенклатура);
	//	
	//	//НайдёмЗаказ
	//	РезЗапроса = НайдёмЗаказ(Контрагент);
	//	
	//	Если НЕ РезЗапроса = Неопределено Тогда
	//		
	//		Нашли = Ложь;
	//		ЗаказПостащику = РезЗапроса.ПолучитьОбъект();
	//		
	//		Для Каждого СтрокаЗаказа Из ЗаказПостащику.Запасы Цикл
	//			Если СтрокаЗаказа.Номенклатура = Строка.Номенклатура Тогда 	
	//				СтрокаЗаказа.Количество = Строка.Количество;
	//				Нашли = Истина;
	//			КонецЕсли;
	//		КонецЦикла;
	//		
	//		Если НЕ Нашли Тогда
	//			
	//			НоваяСтрока = ЗаказПостащику.Запасы.Добавить();
	//			НоваяСтрока.Номенклатура 		= Строка.Номенклатура;
	//			НоваяСтрока.Количество 			= Строка.Количество;
	//			НоваяСтрока.Цена 				= Цена;
	//			НоваяСтрока.Сумма 				= Цена * Строка.Количество;
	//			НоваяСтрока.ДатаПоступления 	= ТекущаяДата();
	//			НоваяСтрока.ЕдиницаИзмерения 	= Строка.Номенклатура.ЕдиницаИзмерения;
	//			НоваяСтрока.СтавкаНДС 			= СтруктураНовогоДокумента.СтавкаНДСПоУмолчанию;
	//			СтавкаНДС = УправлениеНебольшойФирмойПовтИсп.ПолучитьЗначениеСтавкиНДС(НоваяСтрока.СтавкаНДС);
	//			НоваяСтрока.СуммаНДС 			= ?(ЗаказПостащику.СуммаВключаетНДС, НоваяСтрока.Сумма - (НоваяСтрока.Сумма) / ((СтавкаНДС + 100) / 100), НоваяСтрока.Сумма * СтавкаНДС / 100);
	//			НоваяСтрока.Всего 				= НоваяСтрока.Сумма + ?(ЗаказПостащику.СуммаВключаетНДС, 0, НоваяСтрока.СуммаНДС);
	//			
	//			
	//		КонецЕсли;
	//		
	//		ЗаказПостащику.СуммаДокумента 	= ЗаказПостащику.Запасы.Итог("Всего");
	//		ЗаказПостащику.Записать(РежимЗаписиДокумента.Проведение);
	//		
	//	Иначе //Создадим новый заказ
	//		
	//		ЗаказПостащику = Документы.ЗаказПоставщику.СоздатьДокумент();
	//		
	//		ЗаполнитьЗначенияСвойств(ЗаказПостащику, СтруктураНовогоДокумента);
	//		
	//		ЗаказПостащику.Дата 			= ТекущаяДата();
	//		ЗаказПостащику.Контрагент 		= Контрагент;
	//		ЗаказПостащику.Договор 			= Справочники.ДоговорыКонтрагентов.ДоговорПоУмолчанию(Контрагент);
	//		
	//		НоваяСтрока = ЗаказПостащику.Запасы.Добавить();
	//		НоваяСтрока.Номенклатура 		= Строка.Номенклатура;
	//		НоваяСтрока.Количество 			= Строка.Количество;
	//		НоваяСтрока.Цена 				= Цена;
	//		НоваяСтрока.Сумма 				= Цена * Строка.Количество;
	//		НоваяСтрока.ДатаПоступления 	= ТекущаяДата();
	//		НоваяСтрока.ЕдиницаИзмерения 	= Строка.Номенклатура.ЕдиницаИзмерения;
	//		НоваяСтрока.СтавкаНДС 			= СтруктураНовогоДокумента.СтавкаНДСПоУмолчанию;
	//		СтавкаНДС = УправлениеНебольшойФирмойПовтИсп.ПолучитьЗначениеСтавкиНДС(НоваяСтрока.СтавкаНДС);
	//		НоваяСтрока.СуммаНДС 			= ?(ЗаказПостащику.СуммаВключаетНДС, НоваяСтрока.Сумма - (НоваяСтрока.Сумма) / ((СтавкаНДС + 100) / 100), НоваяСтрока.Сумма * СтавкаНДС / 100);
	//		НоваяСтрока.Всего 				= НоваяСтрока.Сумма + ?(ЗаказПостащику.СуммаВключаетНДС, 0, НоваяСтрока.СуммаНДС);
	//		
	//		ЗаказПостащику.СуммаДокумента 	= ЗаказПостащику.Запасы.Итог("Всего");
	//		ЗаказПостащику.Записать(РежимЗаписиДокумента.Проведение);
	//		
	//	КонецЕсли;
	//	
	//КонецЦикла;
	//
	//
	//Запрос = Новый Запрос;
	//Запрос.Текст = "ВЫБРАТЬ
	//|	ОтчетОРозничныхПродажах.Ссылка КАК Ссылка
	//|ИЗ
	//|	Документ.ОтчетОРозничныхПродажах КАК ОтчетОРозничныхПродажах
	//|ГДЕ
	//|	НЕ ОтчетОРозничныхПродажах.Ссылка.zac_Processed_auto
	//|	И ОтчетОРозничныхПродажах.Проведен";
	//Результат = Запрос.Выполнить();
	//Выборка = Результат.Выбрать();
	//
	//Пока Выборка.Следующий() Цикл
	//	
	//	Док = Выборка.Ссылка.ПолучитьОбъект();
	//	Док.zac_Processed_auto = Истина;
	//	Док.Записать(РежимЗаписиДокумента.Запись);
	//	
	//КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьОстатки(Номенклатура, Дата)
	
	РезЗапроса = 0;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ЗапасыОстатки.КоличествоОстаток КАК КоличествоОстаток
	|ИЗ
	|	РегистрНакопления.Запасы.Остатки(&Дата, Номенклатура = &Номенклатура) КАК ЗапасыОстатки";
	Запрос.УстановитьПараметр("Дата", Дата);
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Если Выборка.Следующий() Тогда
		РезЗапроса = Выборка.КоличествоОстаток;	
	КонецЕсли;
	
	Возврат РезЗапроса
	
КонецФункции

&НаСервере
Функция ПолучитьМинИМахОстаток(Номенклатура)
	
	ТЗ = Новый ТаблицаЗначений;
	ТЗ.Колонки.Добавить("МинЗначение");
	ТЗ.Колонки.Добавить("МахЗначение");
	
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	УправлениеЗапасами.МинимальныйУровеньЗапаса КАК МинимальныйУровеньЗапаса,
	|	УправлениеЗапасами.МаксимальныйУровеньЗапаса КАК МаксимальныйУровеньЗапаса
	|ИЗ
	|	РегистрСведений.УправлениеЗапасами КАК УправлениеЗапасами
	|ГДЕ
	|	УправлениеЗапасами.Номенклатура = &Номенклатура";
	
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	НоваяСтрока = ТЗ.Добавить();
	
	Если Выборка.Следующий() Тогда
		
		НоваяСтрока.МинЗначение	= Выборка.МинимальныйУровеньЗапаса;
		НоваяСтрока.МахЗначение	= Выборка.МаксимальныйУровеньЗапаса;

	Иначе
		
		НоваяСтрока.МинЗначение	= 0;
		НоваяСтрока.МахЗначение	= 0;
		
	КонецЕсли;	
	
	Возврат ТЗ
	
КонецФункции

&НаСервере
Функция ПолучитьОстаткиВПути(Номенклатура, Дата)
	
	РезЗапроса = 0;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ЗаказыПоставщикамОстатки.КоличествоОстаток КАК КоличествоОстаток
	|ИЗ
	|	РегистрНакопления.ЗаказыПоставщикам.Остатки(&Дата, Номенклатура = &Номенклатура) КАК ЗаказыПоставщикамОстатки";
	Запрос.УстановитьПараметр("Дата", Дата);
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Если Выборка.Следующий() Тогда
		РезЗапроса = Выборка.КоличествоОстаток;	
	КонецЕсли;	
	
	Возврат РезЗапроса
	
КонецФункции

&НаСервере
Функция УКогоКупили(Номенклатура)
	
	РезЗапроса = Справочники.Контрагенты.НайтиПоНаименованию("<Без контрагента>");  //создать если ненайден
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	               |	ПриходнаяНакладнаяЗапасы.Ссылка.Контрагент КАК Контрагент,
	               |	ПриходнаяНакладнаяЗапасы.Ссылка.Дата КАК Дата
	               |ИЗ
	               |	Документ.ПриходнаяНакладная.Запасы КАК ПриходнаяНакладнаяЗапасы
	               |ГДЕ
	               |	ПриходнаяНакладнаяЗапасы.Номенклатура = &Номенклатура
	               |	И НЕ ПриходнаяНакладнаяЗапасы.Ссылка.ПометкаУдаления
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Дата УБЫВ";
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Если Выборка.Следующий() Тогда
		РезЗапроса = Выборка.Контрагент;	
	КонецЕсли;	
	
	Возврат РезЗапроса
	
КонецФункции

&НаСервере
Функция ПочёмКупили(Номенклатура)
	
	РезЗапроса = 1;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	|	ПриходнаяНакладнаяЗапасы.Ссылка.Контрагент КАК Контрагент,
	|	ПриходнаяНакладнаяЗапасы.Ссылка.Дата КАК Дата,
	|	ПриходнаяНакладнаяЗапасы.Цена КАК Цена
	|ИЗ
	|	Документ.ПриходнаяНакладная.Запасы КАК ПриходнаяНакладнаяЗапасы
	|ГДЕ
	|	ПриходнаяНакладнаяЗапасы.Ссылка.Проведен
	|	И ПриходнаяНакладнаяЗапасы.Номенклатура = &Номенклатура
	|
	|УПОРЯДОЧИТЬ ПО
	|	Дата УБЫВ";
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Если Выборка.Следующий() Тогда
		РезЗапроса = Выборка.Цена;	
	КонецЕсли;	
	
	Возврат РезЗапроса
	
КонецФункции

&НаСервере
Функция НайдёмЗаказ(Контрагент)
	
	РезЗапроса = Неопределено;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	               |	ЗаказПоставщикуЗапасы.Ссылка КАК Ссылка
	               |ИЗ
	               |	Документ.ЗаказПоставщику.Запасы КАК ЗаказПоставщикуЗапасы
	               |ГДЕ
	               |	ЗаказПоставщикуЗапасы.Ссылка.Контрагент = &Контрагент
	               |	И ЗаказПоставщикуЗапасы.Ссылка.Проведен
	               |	И ЗаказПоставщикуЗапасы.Ссылка.zac_Processed_auto";
	Запрос.УстановитьПараметр("Контрагент", Контрагент);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Если Выборка.Следующий() Тогда
		РезЗапроса = Выборка.Ссылка;	
	КонецЕсли;	
	
	Возврат РезЗапроса
	
КонецФункции


&НаСервере
Функция ПодготовитьСтруктуруНовогоЗаказа()
	
	//ЗаказныеПозиции = Объект.НоменклатураКЗаказу.Выгрузить();
	//Для Индекс = -ЗаказныеПозиции.Количество() + 1 По 0 Цикл
	//	Если НЕ ЗаказныеПозиции[-Индекс].Выбор Тогда
	//		ЗаказныеПозиции.Удалить(-Индекс);
	//	КонецЕсли;
	//КонецЦикла;
	
	СтруктураНовогоДокумента = Новый Структура;
	СтруктураНовогоДокумента.Вставить("Организация", Справочники.Организации.ОрганизацияПоУмолчанию());
	СтруктураНовогоДокумента.Вставить("СтруктурнаяЕдиницаРезерв", Справочники.СтруктурныеЕдиницы.ОсновнойСклад);
	СтруктураНовогоДокумента.Вставить("СтруктурнаяЕдиница", Справочники.СтруктурныеЕдиницы.ОсновноеПодразделение);
	СтруктураНовогоДокумента.Вставить("ВалютаДокумента", Константы.ВалютаУчета.Получить());
	СтруктураНовогоДокумента.Вставить("СостояниеЗаказа", Справочники.СостоянияЗаказовПоставщикам.НайтиПоНаименованию("Новый")); //необходимо создать лемент при его отсутствии   
	СтруктураНовогоДокумента.Вставить("Автор", ПараметрыСеанса.ТекущийПользователь);
	СтруктураНовогоДокумента.Вставить("БанковскийСчет", Справочники.БанковскиеСчета.БанковскийСчетСубъекта(СтруктураНовогоДокумента.Организация));
	СтруктураНовогоДокумента.Вставить("ВидОперации", Перечисления.ВидыОперацийЗаказПоставщику.ЗаказНаЗакупку);
	СтруктураНовогоДокумента.Вставить("ДатаПоступления", ТекущаяДата() + 86400*7);
	СтруктураНовогоДокумента.Вставить("Касса", Справочники.Кассы.ПолучитьКассуПоУмолчанию(СтруктураНовогоДокумента.Организация));
	СтруктураНовогоДокумента.Вставить("Комментарий", "Документ создал ассистент закупок");
	СтруктураНовогоДокумента.Вставить("Кратность", 1);
	СтруктураНовогоДокумента.Вставить("Курс", 1);
	СтруктураНовогоДокумента.Вставить("НалогообложениеНДС", УправлениеНебольшойФирмойСервер.НалогообложениеНДС(СтруктураНовогоДокумента.Организация,, ТекущаяДата()));
	СтруктураНовогоДокумента.Вставить("НДСВключатьВСтоимость", Истина);
	//СтруктураНовогоДокумента.Вставить("Ответственный", Справочники.Пользователи.);
	СтруктураНовогоДокумента.Вставить("zac_Processed_auto", Истина);
	СтруктураНовогоДокумента.Вставить("ПоложениеДатыПоступления", Перечисления.ПоложениеРеквизитаНаФорме.ВШапке);
	СтруктураНовогоДокумента.Вставить("СуммаВключаетНДС", Истина);
	СтруктураНовогоДокумента.Вставить("ХозяйственнаяОперация", Справочники.ХозяйственныеОперации.ЗаказНаЗакупку);
	
	Если СтруктураНовогоДокумента.НалогообложениеНДС = Перечисления.ТипыНалогообложенияНДС.ОблагаетсяНДС Тогда
		СтруктураНовогоДокумента.Вставить("СтавкаНДСПоУмолчанию", Справочники.СтавкиНДС.НайтиПоНаименованию("20%", Истина));
	Иначе
		СтруктураНовогоДокумента.Вставить("СтавкаНДСПоУмолчанию", УправлениеНебольшойФирмойПовтИсп.ПолучитьСтавкуНДСБезНДС());
	КонецЕсли;

	Возврат СтруктураНовогоДокумента
	
КонецФункции


&НаКлиенте
Процедура КомандаЗаполнить(Команда)
	КомандаЗаполнитьНаСервере();
КонецПроцедуры


&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	НеОтмеченныеСтроки = am_ЗапасыЗаказа.НайтиСтроки(Новый Структура("Оставляем",Ложь));
	Если НеОтмеченныеСтроки.Количество() > 0 Тогда
		СрезатьНоменклатуруИУдержатьПроцент();
		ОткрытьФорму("Документ.ЧекККМВозврат.ФормаОбъекта", Новый Структура("Основание",Основание), ЭтотОбъект);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура СрезатьНоменклатуруИУдержатьПроцент()
	Док = Заказ.ПолучитьОбъект();
	
	НомерКППоУмолчанию = ?(Док.КоличествоВариантовКП>1,1,0);
	
	//Вначале очистим все варианты кроме основного
	ТЗ = Док.Запасы.Выгрузить(Новый Структура("НомерВариантаКП",НомерКППоУмолчанию));
	
	Док.Запасы.Очистить();
	
	Для каждого СтрокаДокумента из ТЗ Цикл
		НоваяСтрока = Док.Запасы.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока,СтрокаДокумента);
		НоваяСтрока.НомерВариантаКП = 1;
	КонецЦикла;
	
	
	СтрокиДляКопирования = am_ЗапасыЗаказа.НайтиСтроки(Новый Структура("Оставляем",Истина));
	
	Для каждого СтрокаКопирования из СтрокиДляКопирования Цикл
		СтрокиДокумента = Док.Запасы.НайтиСтроки(Новый Структура("Номенклатура,КлючСвязи",СтрокаКопирования.Номенклатура,СтрокаКопирования.КлючСвязи));
		Для каждого СтрокаДокумента из СтрокиДокумента Цикл
			НоваяСтрока = Док.Запасы.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока,СтрокаДокумента);
			НоваяСтрока.НомерВариантаКП = 2;
			
			ДанныеСтроки = Новый Структура;
			ДанныеСтроки.Вставить("Количество", СтрокаКопирования.Количество);
			ДанныеСтроки.Вставить("Цена", НоваяСтрока.Цена);
			ДанныеСтроки.Вставить("Сумма", 0);
			ДанныеСтроки.Вставить("СтавкаНДС", НоваяСтрока.СтавкаНДС);
			ДанныеСтроки.Вставить("СуммаНДС", 0);
			ДанныеСтроки.Вставить("СуммаВключаетНДС", Док.СуммаВключаетНДС);
			ДанныеСтроки.Вставить("Всего", 0);
			ДанныеСтроки.Вставить("ПроцентСкидкиНаценки", НоваяСтрока.ПроцентСкидкиНаценки);
			ДанныеСтроки.Вставить("СуммаСкидкиНаценки", 0);
			
			ЗаполнениеОбъектовУНФ.РассчитатьСуммыВСтрокеТабличнойЧасти(ДанныеСтроки);
			
			ЗаполнитьЗначенияСвойств(НоваяСтрока, ДанныеСтроки);
		КонецЦикла;
	КонецЦикла;	
	Док.ОсновнойВариантКП = 2;
	Док.КоличествоВариантовКП = 2;
	
	СуммаВозврата = Док.Запасы.Выгрузить(Новый Структура("НомерВариантаКП",1)).Итог("Всего") - Док.Запасы.Выгрузить(Новый Структура("НомерВариантаКП",2)).Итог("Всего");
	
	НоваяСтрока = Док.Запасы.Добавить();
	НоваяСтрока.Номенклатура = РегистрыСведений.am_ХранилищеНастроек.ПолучитьУслугуКомиссииПоУмолчанию();
	НоваяСтрока.НомерВариантаКП = 2;
	
	ДанныеСтроки = Новый Структура;
	ДанныеСтроки.Вставить("Количество", 1);
	ДанныеСтроки.Вставить("Цена", СуммаВозврата*РегистрыСведений.am_ХранилищеНастроек.ПолучитьПроцентКомиссииПоУмолчанию());
	ДанныеСтроки.Вставить("Сумма", 0);
	ДанныеСтроки.Вставить("СтавкаНДС", НоваяСтрока.СтавкаНДС);
	ДанныеСтроки.Вставить("СуммаНДС", 0);
	ДанныеСтроки.Вставить("СуммаВключаетНДС", Док.СуммаВключаетНДС);
	ДанныеСтроки.Вставить("Всего", 0);
	ДанныеСтроки.Вставить("ПроцентСкидкиНаценки", 0);
	ДанныеСтроки.Вставить("СуммаСкидкиНаценки", 0);
	
	ЗаполнениеОбъектовУНФ.РассчитатьСуммыВСтрокеТабличнойЧасти(ДанныеСтроки);
	
	ЗаполнитьЗначенияСвойств(НоваяСтрока, ДанныеСтроки);
	
	
	Док.Записать(РежимЗаписиДокумента.Проведение);
КонецПроцедуры	

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Основание = Параметры.Основание;
	Заказ = Параметры.Заказ;
	НомерКППоУмолчанию = ?(Параметры.Заказ.КоличествоВариантовКП>1,1,0);
	am_ЗапасыЗаказа.Загрузить(Заказ.Запасы.Выгрузить(Новый Структура("НомерВариантаКП",НомерКППоУмолчанию)));
КонецПроцедуры

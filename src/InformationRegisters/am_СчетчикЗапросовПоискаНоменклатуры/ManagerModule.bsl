#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Процедура УвеличитьЗначениеСчетчика(Знач ТекстПоиска, Знач Номенклатура, Знач Источник, Знач Пользователь) Экспорт
	
	ПредложенноеНаименование = "";
	Если ПустаяСтрока(ТекстПоиска) Тогда
	    ТекстПоиска = "<пустой>";
	ИначеЕсли Номенклатура = Справочники.Номенклатура.ПустаяСсылка() Тогда
		ПредложенноеНаименование = am_ОбщийМодульСервер.ПолучитьНаименованиеПоТекстуПоиска(ТекстПоиска, Пользователь);
	КонецЕсли; 
	
	МенеджерЗаписи = СоздатьМенеджерЗаписи();
	МенеджерЗаписи.ТекстПоиска 				= ТекстПоиска;
	МенеджерЗаписи.Номенклатура				= Номенклатура;
	МенеджерЗаписи.ПериодЗаписи 			= НачалоДня(ТекущаяДатаСеанса());
	МенеджерЗаписи.Источник					= Источник;
	МенеджерЗаписи.ПредложенноеНаименование	= ПредложенноеНаименование;
	МенеджерЗаписи.Пользователь				= Пользователь;
	МенеджерЗаписи.Прочитать();
	
	МенеджерЗаписи.ТекстПоиска 				= ТекстПоиска;
	МенеджерЗаписи.Номенклатура				= Номенклатура;
	МенеджерЗаписи.ПериодЗаписи 			= НачалоДня(ТекущаяДатаСеанса());
	МенеджерЗаписи.Источник					= Источник;
	МенеджерЗаписи.ПредложенноеНаименование	= ПредложенноеНаименование;
	МенеджерЗаписи.Пользователь				= Пользователь;
	МенеджерЗаписи.Счетчик 					= МенеджерЗаписи.Счетчик + 1;
	МенеджерЗаписи.Записать();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
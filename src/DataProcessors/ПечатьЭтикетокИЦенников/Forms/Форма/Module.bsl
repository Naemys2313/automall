&НаСервере
&После("ПриСозданииНаСервере")
Процедура После_ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Для каждого ТекущаяСтрока из Объект.Товары Цикл
		ТекущаяСтрока.ШаблонЦенника = РегистрыСведений.am_ХранилищеНастроек.ПолучитьШаблон();
		Если ЗначениеЗаполнено(ТекущаяСтрока.ШаблонЦенника) Тогда
			Если ТекущаяСтрока.ШаблонЦенника.ТипШаблона = Перечисления.ТипыШаблонов.ЭтикеткаЦенникПринтераЭтикеток Тогда
				ТекущаяСтрока.ТипШаблонаЦенника = 1;
			Иначе
				ТекущаяСтрока.ТипШаблонаЦенника = 2;
			КонецЕсли;
		КонецЕсли;
		ТекущаяСтрока.ШаблонЭтикетки = РегистрыСведений.am_ХранилищеНастроек.ПолучитьШаблон();
		Если ЗначениеЗаполнено(ТекущаяСтрока.ШаблонЭтикетки) Тогда
			Если ТекущаяСтрока.ШаблонЭтикетки.ТипШаблона = Перечисления.ТипыШаблонов.ЭтикеткаЦенникПринтераЭтикеток Тогда
				ТекущаяСтрока.ТипШаблонаЭтикетки = 1;
			Иначе
				ТекущаяСтрока.ТипШаблонаЭтикетки = 2;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры	
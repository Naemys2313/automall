
&НаКлиенте
Процедура am_ПриОткрытииПосле(Отказ)
	
	Если Объект.НомерЧекаККМ <> 0 Тогда
		Элементы.НапечататьЧек.Доступность = Ложь;
		Элементы.ПредварительныйПросмотрЧека.Доступность = Ложь;
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Процедура am_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	Объект.УчитыватьВНУ = РегистрыСведений.am_ХранилищеНастроек.ПолучитьПроставлятьУСНПоступлениеВКассу();
КонецПроцедуры

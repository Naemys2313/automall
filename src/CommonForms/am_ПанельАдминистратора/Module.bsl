
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗаполнитьПоказатели();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПоказатели() 
	
	ПеремКонтролироватьОстаткиПриПроведении         = Константы.КонтролироватьОстаткиПриПроведении.Получить();
	ПеремКонтролироватьОстаткиПриПробитииЧековККМ   = Константы.КонтролироватьОстаткиПриПробитииЧековККМ.Получить();
	
КонецПроцедуры

&НаКлиенте
Процедура ПеремКонтролироватьОстаткиПриПроведенииПриИзменении(Элемент)
	
	ЗаполнитьКонтролироватьОстаткиПриПроведенииНаСервере(ПеремКонтролироватьОстаткиПриПроведении);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗаполнитьКонтролироватьОстаткиПриПроведенииНаСервере(Галочка) 
	Константы.КонтролироватьОстаткиПриПроведении.Установить(Галочка);
КонецПроцедуры

&НаКлиенте
Процедура ПеремКонтролироватьОстаткиПриПробитииЧековККМПриИзменении(Элемент)
	ЗаполнитьКонтролироватьОстаткиПриПробитииЧековККМНаСервере(ПеремКонтролироватьОстаткиПриПробитииЧековККМ);
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗаполнитьКонтролироватьОстаткиПриПробитииЧековККМНаСервере(Галочка) 
	Константы.КонтролироватьОстаткиПриПробитииЧековККМ.Установить(Галочка);
КонецПроцедуры
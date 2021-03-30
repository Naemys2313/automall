#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура am_ПриОткрытииПосле(Отказ)
	
	am_РазместитьДинамическиеЭлементы();

КонецПроцедуры

#КонецОбласти

#Область Работа_с_динамическими_формами

&НаСервере
Процедура am_РазместитьДинамическиеЭлементы()
	
	Поле = ЭтаФорма.Элементы.Добавить("НовыйОбъектФормы_1", Тип("ПолеФормы"), Элементы.ГруппаПодключаемоеОборудование);
	Поле.Вид 			= ВидПоляФормы.ПолеВвода;
	Поле.ПутьКДанным 	= "Объект.am_Патент";
	Поле.Заголовок		= "Патент";
	
КонецПроцедуры



#КонецОбласти

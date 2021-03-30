&НаСервере
Процедура ЗаполнитьНаименование()
	
	Если ЗначениеЗаполнено(Объект.Модель) Тогда
		Объект.Наименование = Объект.Модель.Владелец.Наименование + " " + Объект.Модель.Наименование + ", г/н " + Объект.ГосударственныйРегистрационныйЗнак;
	Иначе
		Объект.Наименование = "";
	КонецЕсли;
	
	ЭтаФорма.Заголовок = Объект.Наименование;
	
КонецПроцедуры

&НаКлиенте
Процедура МодельПриИзменении(Элемент)
	ЗаполнитьНаименование();
КонецПроцедуры

&НаКлиенте
Процедура ГосударственныйРегистрационныйЗнакПриИзменении(Элемент)
	ЗаполнитьНаименование();
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	Записать();
    Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтаФорма.Заголовок = Объект.Наименование;
	Если ЗначениеЗаполнено(Объект.Модель) Тогда
		АдресИзображения = ПолучитьНавигационнуюСсылку(Объект.Модель, "ОсновноеИзображение");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВладелецАвтоПриИзменении(Элемент)
	Объект.Владелец = Объект.ВладелецАвто;
КонецПроцедуры

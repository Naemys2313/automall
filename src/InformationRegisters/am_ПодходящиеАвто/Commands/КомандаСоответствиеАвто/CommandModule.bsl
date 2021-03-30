
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ДоступностьФункционала = ПолучитьДоступностьФункционала();
	
	Если ДоступностьФункционала Тогда
		Отбор = Новый Структура("Номенклатура", ПараметрКоманды);
		ПараметрыФормы = Новый Структура("Отбор", Отбор);
		ОткрытьФорму("РегистрСведений.am_ПодходящиеАвто.Форма.ФормаДляНоменклатуры", ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьДоступностьФункционала()
	
	Возврат РегистрыСведений.am_ХранилищеНастроек.ПолучитьРазрешениеОтбораДеталейПоАвтомобилю();

КонецФункции

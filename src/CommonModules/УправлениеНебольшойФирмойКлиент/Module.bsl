
&После("РассчитатьСуммуНДСИВсего")
Процедура am_РассчитатьСуммуНДСИВсего(СтрокаТабличнойЧасти, ПараметрыРасчета)

	Если ПараметрыРасчета.Свойство("РассчитатьМинимальнуюЦену") Тогда
		НижеЗакупочной = Ложь;
		Если ПараметрыРасчета.Свойство("ЗаказПокупателя") И am_ОбщиеНастройкиПовтИсп.ПолучитьЗначениеНастройки("НижеЗакупочнойЗП",Ложь) Тогда
			НижеЗакупочной = Истина;
		ИначеЕсли ПараметрыРасчета.Свойство("РасходнаяНакладная") И am_ОбщиеНастройкиПовтИсп.ПолучитьЗначениеНастройки("НижеЗакупочнойРН",Ложь) Тогда
			НижеЗакупочной = Истина;
		ИначеЕсли ПараметрыРасчета.Свойство("ЧекККМ") И am_ОбщиеНастройкиПовтИсп.ПолучитьЗначениеНастройки("НижеЗакупочнойЧККМ",Ложь) Тогда
			НижеЗакупочной = Истина;
		КонецЕсли;	
		Если НижеЗакупочной Тогда
			Если СтрокаТабличнойЧасти.Свойство("Цена") И СтрокаТабличнойЧасти.Свойство("Номенклатура") Тогда
				ВидЦеныЗакупоная =  am_ОбщиеНастройкиПовтИсп.ПолучитьЗначениеНастройки("ЗакупочнаяЦена");
				СтруктураДанных = Новый Структура("Номенклатура,ВидЦен,ДатаОбработки,Характеристика,Коэффициент,ВалютаДокумента");
				ЗаполнитьЗначенияСвойств(СтруктураДанных,СтрокаТабличнойЧасти);
				СтруктураДанных.ВидЦен = ВидЦеныЗакупоная;
				Если СтруктураДанных.ДатаОбработки = Неопределено Тогда
					СтруктураДанных.ДатаОбработки = ТекущаяДата();
				КонецЕсли;
				Если СтруктураДанных.Коэффициент = Неопределено Тогда
					СтруктураДанных.Коэффициент = 1;
				КонецЕсли;
				Если СтруктураДанных.ВалютаДокумента = Неопределено Тогда
					СтруктураДанных.ВалютаДокумента = am_ОбщийМодульСервер.ВалютаУчета();
				КонецЕсли;
				МинимальнаяЦена = УправлениеНебольшойФирмойСервер.ПолучитьЦенуНоменклатурыПоВидуЦен(СтруктураДанных);
				Если МинимальнаяЦена > СтрокаТабличнойЧасти.Цена Тогда
					СтрокаТабличнойЧасти.Цена = МинимальнаяЦена;
					Если ПараметрыРасчета.Свойство("РассчитатьЦену") Тогда
						ПараметрыРасчета.Удалить("РассчитатьЦену");
					КонецЕсли;
					УправлениеНебольшойФирмойКлиент.РассчитатьСуммыВСтрокеТЧ(СтрокаТабличнойЧасти, ПараметрыРасчета);
					ПоказатьОповещениеПользователя("Цена не может быть ниже закупочной!",," Цена установлена на уровень закупочной.",БиблиотекаКартинок.Информация);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры


&НаСервере
Процедура am_ПриСозданииНаСервереПеред(Отказ, СтандартнаяОбработка)
	        
	Если НЕ РегистрыСведений.am_ХранилищеНастроек.ПолучитьПульсБизнесаБазовыеНастройки() Тогда
		Возврат;
	КонецЕсли;
	
	//++АМ Добавление команды "Заполнить показатели по умолчанию"
	
	Команда = Команды.Добавить("ам_ЗаполнитьПоказателиПоУмолчанию");
	Команда.Действие = "ам_ЗаполнитьПоказателиПоУмолчанию";
	Команда.Картинка = БиблиотекаКартинок[Метаданные.ОбщиеКартинки.ЗаполнитьПоОснованию.Имя];
	Команда.Заголовок = "+ Заполнить набор показателей по умолчанию";
	
	Кнопка = Элементы.Добавить(Команда.Имя, Тип("КнопкаФормы"), Элементы["ГруппаПоказатели"]);
	Кнопка.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
	Кнопка.ИмяКоманды = Команда.Имя;
	Кнопка.Картинка = Команда.Картинка;
	Кнопка.Заголовок = Команда.Заголовок;
	Кнопка.Отображение = ОтображениеКнопки.Текст;
	Кнопка.АвтоМаксимальнаяШирина = Ложь;
	//Кнопка.МаксимальнаяШирина = 30;
	Кнопка.РастягиватьПоГоризонтали = Истина;
	Кнопка.ЦветТекста = ЦветаСтиля.ТекстВторостепеннойНадписи;
	Кнопка.Шрифт = Новый Шрифт("Arial", 12);
	Кнопка.ОтображениеФигуры = ОтображениеФигурыКнопки.Нет;
	
	Элементы.Переместить(Кнопка, Элементы["ГруппаПоказатели"], Элементы["ДекорацияРазделительПоказатели"]);
	
	//--АМ
	
КонецПроцедуры

&НаСервере
&После("Инициализация")
Процедура am_Инициализация()
	
	Если НЕ РегистрыСведений.am_ХранилищеНастроек.ПолучитьПульсБизнесаБазовыеНастройки() Тогда
		Возврат;
	КонецЕсли;
	
	//++АМ Добавление новых показателей
	ДобавитьПоказатель("ам_ДопПоказатели", "ОтицательныйОстаток", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Отрицательный остаток (кол-во)'"), Истина,, "ЧН=-", "СКД_РН_Запасы", "Отчет.ОстаткиТоваровМеньшеНуля", "ОстаткиТоваровМеньшеНуля", "Количество", "Запасы"); // отчет не запускается, проблема с периодом
	ДобавитьПоказатель("ам_ДопПоказатели", "СуммаОстатокПоУчетнымЦенам", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Остаток (в закупочных ценах)'"), Истина,, "ЧДЦ=2; ЧН=-", "СКД_РН_Запасы", "Отчет.ОстаткиТоваров", "ПоМестамХранения", "Количество,Сумма", "Запасы");
	ДобавитьПоказатель("ам_ДопПоказатели", "КоличествоОстатокПоЗаказамПоставщикам", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Количество номенклатурных позиций в пути'"), Истина,, "ЧН=-", "СКД_РН_ЗаказыПоставщикам", "Отчет.am_ТоварыВПути", "ТоварыВПути",, "Запасы");
	ДобавитьПоказатель("ам_ДопПоказатели", "СуммаОстатокПоЗаказамПоставщикам", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Сумма номенклатурных позиций в пути'"), Истина,, "ЧН=-", "СКД_РН_ЗаказыПоставщикам", "Отчет.am_ТоварыВПути", "ТоварыВПути",, "Запасы");
	ДобавитьПоказатель("ам_ДопПоказатели", "КоличествоЧековПродажа", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Количество чеков (продажа)'"),,, "ЧН=-", "СКД_Розница", "Отчет.РозничныеПродажи", "am_ВариантОтчета_РозничныеПродажи_КоличествоЧеков");
	ДобавитьПоказатель("ам_ДопПоказатели", "КоличествоЧековВозврат", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Количество чеков (возврат)'"),,, "ЧН=-", "СКД_Розница", "Отчет.РозничныеПродажи", "am_ВариантОтчета_РозничныеПродажи_КоличествоЧеков");
	ДобавитьПоказатель("ам_ДопПоказатели", "СуммаЧековПродажа", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Сумма чеков (продажа)'"),,, "ЧДЦ=2; ЧН=-", "СКД_Розница", "Отчет.РозничныеПродажи", "am_ВариантОтчета_РозничныеПродажи_КоличествоЧеков");
	ДобавитьПоказатель("ам_ДопПоказатели", "СуммаЧековВозврат", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Сумма чеков (возврат)'"),,, "ЧДЦ=2; ЧН=-", "СКД_Розница", "Отчет.РозничныеПродажи", "am_ВариантОтчета_РозничныеПродажи_КоличествоЧеков");
	ДобавитьПоказатель("ам_ДопПоказатели", "СреднийЧекПоПродажам", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Средний чек по продажам'"),,, "ЧДЦ=2; ЧН=-", "СКД_Розница", "Отчет.РозничныеПродажи", "am_ВариантОтчета_РозничныеПродажи_КоличествоЧеков");
	
	ДобавитьПоказатель("ам_ДопПоказатели", "КоличествоЧековПредоплата", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Количество чеĸов (предоплата)'"),,, "ЧН=-", "СКД_Розница", "Отчет.am_ПредоплатаПоЧекам", "ПредоплатаПоЧекам");
	ДобавитьПоказатель("ам_ДопПоказатели", "СуммаЧековПредоплата", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Сумма чеĸов (предоплата)'"),,, "ЧН=-", "СКД_Розница", "Отчет.am_ПредоплатаПоЧекам", "ПредоплатаПоЧекам");
	
	ДобавитьПоказатель("ам_ДопПоказатели", "ПоступлениеНаличныхВКассыККМ", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Получение наличных (КассаККМ)'"),, Истина, "ЧДЦ=2; ЧН=-", "СКД_Розница", "Отчет.am_ДвижениеНаличныхВКассахККМ", "Получение");
	ДобавитьПоказатель("ам_ДопПоказатели", "ВыбытиеНаличныхИзКассыККМ", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Выдача наличных (КассаККМ)'"),, Истина, "ЧДЦ=2; ЧН=-", "СКД_Розница", "Отчет.am_ДвижениеНаличныхВКассахККМ", "Выдача");
	
	ДобавитьПоказатель("ам_ДопПоказатели", "ПолученоОплатКартой", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Получено оплат ĸартой'"),, Истина, "ЧДЦ=2; ЧН=-", "am_СКД_Карты", "Отчет.am_ДвиженияПоПлатежнымКартам", "ПоступлениеПоПлатежнымКартам");
	ДобавитьПоказатель("ам_ДопПоказатели", "ВозвратОплатКартой", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Выдача денег на ĸарту'"),, Истина, "ЧДЦ=2; ЧН=-", "am_СКД_Карты", "Отчет.am_ДвиженияПоПлатежнымКартам", "ВыбытиеПоПлатежнымКартам");
	
	ДобавитьПоказатель("ам_ДопПоказатели", "ПередачаНаличныхВСейф", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Передача наличных в Сейф'"), Истина, Истина, "ЧДЦ=2; ЧН=-", "СКД_РН_ДенежныеСредства", "Отчет.ДенежныеСредстваКПоступлению", "Основной");
	
	ДобавитьПоказатель("ам_ДопПоказатели", "ВыдачаНаличныхИзСейфа", НСтр("ru = 'Дополнительные показатели'"), НСтр("ru = 'Выдача наличных (Сейф)'"),, Истина, "ЧДЦ=2; ЧН=-", "СКД_РН_ДенежныеСредства", "Отчет.ДенежныеСредства", "am_ВариантОтчета_Деньги_ВыбытиеДС");
	
	// Переопределим варианты отчетов для некоторых показателей
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("Показатель", "Деньги");
	СтруктураПоиска.Вставить("Ресурс", "Поступления");
	Строки = НастройкиПоказателей.НайтиСтроки(СтруктураПоиска);
	Если Строки.Количество()>0 Тогда
		Для каждого СтрНастроек Из Строки Цикл
			СтрНастроек.КлючВарианта = "am_ВариантОтчета_Деньги_ПоступлениеДС";
			СтрНастроек.Вариант = СтрНастроек.ИмяОтчета + "." + СтрНастроек.КлючВарианта;
		КонецЦикла; 
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
&Вместо("РасшифроватьПоказатель")
Процедура am_РасшифроватьПоказатель(Идентификатор)
	
	//Если НЕ РегистрыСведений.am_ХранилищеНастроек.ПолучитьПульсБизнесаБазовыеНастройки() Тогда
	//	Возврат;
	//КонецЕсли;
	
	ТекСтр = ДобавленныеПоказатели.НайтиПоИдентификатору(Идентификатор);
	СтрНастроек = НастройкиПоказателей.НайтиПоИдентификатору(ТекСтр.ИдентификаторСтрокиНастроек);
	
	Если ТекСтр.Налоги Тогда
		// Вместо расшифровки открываем записи календаря подготовки отчетности
		ПараметрыОткрытия = Новый Структура;
		ПараметрыОткрытия.Вставить("Показатель", ТекСтр.Ресурс);
		ОткрытьФорму("Справочник.ЗаписиКалендаряПодготовкиОтчетности.Форма.КалендарьНалоговИОтчетности", ПараметрыОткрытия, ЭтотОбъект);
		Возврат;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(СтрНастроек.Вариант) Тогда
		Возврат;
	КонецЕсли;
	ВариантОтчета = ВариантОтчетаПоПолномуИмени(СтрНастроек.Вариант);
	Если ВариантОтчета=Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	Если ТекСтр.ВводОстатков Тогда
		// Вместо расшифровки открываем помощник ввода начальных остатков
		ПараметрыОткрытия = Новый Структура;
		ПараметрыОткрытия.Вставить("РазделУчета", СтрНастроек.РазделУчета);
		ОткрытьФорму("Обработка.ПомощникВводаНачальныхОстатков.Форма", ПараметрыОткрытия, ЭтотОбъект);
		Возврат;
	КонецЕсли; 
	
	ОтборРасшифровки = Новый Соответствие;
	Если СтрНастроек.Остаток Тогда
		ПериодРасшифровки = '0001-01-01';
		//++АМ На некоторых отчетах выходит ошибка, связано с параметрами
		//ОтборРасшифровки.Вставить("НачалоПериода", НачалоДня(ПериодРасшифровки));
		//ОтборРасшифровки.Вставить("Период", ПериодРасшифровки);
		//ОтборРасшифровки.Вставить("КонецПериода", ПериодРасшифровки);
		//++АМ
		// Для отчета "ОстаткиТоваровМеньшеНуля" переопределяем параметры
		Если Найти(СтрНастроек.Вариант, "ОстаткиТоваровМеньшеНуля") <> 0
			ИЛИ Найти(СтрНастроек.Вариант, "ТоварыВПути") <> 0 Тогда
			ОтборРасшифровки.Вставить("Период", ПериодРасшифровки);
		ИначеЕсли Найти(СтрНастроек.Вариант, "ПоМестамХранения") <> 0 Тогда
			ОтборРасшифровки.Вставить("Период", ПериодРасшифровки);
			ОтборРасшифровки.Вставить("ВидЦен", ПредопределенноеЗначение("Справочник.ВидыЦен.Учетная"));
			//++АМ Это штатное	
		Иначе		
			ОтборРасшифровки.Вставить("НачалоПериода", НачалоДня(ПериодРасшифровки));
			ОтборРасшифровки.Вставить("Период", ПериодРасшифровки);
			ОтборРасшифровки.Вставить("КонецПериода", ПериодРасшифровки);
		КонецЕсли; 
		//--АМ
	Иначе
		Если ТипЗнч(Период)=Тип("СтандартныйПериод") Тогда
			ДатаНачалаРасшифровки = НачалоДня(Период.ДатаНачала);
			ДатаКонцаРасшифровки = ?(ЗначениеЗаполнено(Период.ДатаОкончания), КонецДня(Период.ДатаОкончания), '0001-01-01');
		ИначеЕсли ТипЗнч(Период)=Тип("Структура") Тогда
			ОбновитьДатыНачалаИКонцаПериода(Период);
			ДатаНачалаРасшифровки = НачалоДня(Период.ДатаНачала);
			ДатаКонцаРасшифровки = ?(ЗначениеЗаполнено(Период.ДатаОкончания), КонецДня(Период.ДатаОкончания), '0001-01-01');
		Иначе
			ДатаНачалаРасшифровки = '0001-01-01';
			ДатаКонцаРасшифровки = '0001-01-01';
		КонецЕсли; 
		ОтборРасшифровки.Вставить("НачалоПериода", ДатаНачалаРасшифровки);
		ОтборРасшифровки.Вставить("КонецПериода", ДатаКонцаРасшифровки);
	КонецЕсли;
	Если ТипЗнч(ТекСтр.Фильтры)=Тип("ФиксированныйМассив") Тогда
		Для каждого Фильтр Из ТекСтр.Фильтры Цикл
			СтруктураЗначения = Новый Структура;
			СтруктураЗначения.Вставить("ВидСравнения", Фильтр.ВидСравнения);
			СтруктураЗначения.Вставить("Значение", Фильтр.Значение);
			ОтборРасшифровки.Вставить(Фильтр.Поле, СтруктураЗначения);
		КонецЦикла; 
	КонецЕсли; 
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("СформироватьПриОткрытии", Истина);
	Если НЕ ПустаяСтрока(СтрНастроек.КолонкиОтчета) Тогда
		ПараметрыФормы.Вставить("Колонки", СтрНастроек.КолонкиОтчета);
	КонецЕсли; 
	//++АМ
	// Для Универсального отчета переопределяем параметры
	Если Найти(СтрНастроек.ИмяОтчета, "УниверсальныйОтчет") <> 0 Тогда
		СтрОтбор = Новый Структура;
		СтрОтбор.Вставить("Период", Новый СтандартныйПериод());
		Для каждого Эл Из ОтборРасшифровки Цикл
			Если ТипЗнч(Эл.Ключ) = Тип("Строка") Тогда
				СтрОтбор.Вставить(Эл.Ключ, Эл.Значение);
			КонецЕсли; 
		КонецЦикла;
		
		ПараметрыФормы.Вставить("Отбор", СтрОтбор);
	Иначе
		//++АМ Это штатное
		ПараметрыФормы.Вставить("ОтборРасшифровки", ОтборРасшифровки);
	КонецЕсли;
	//--АМ
	ВариантыОтчетовКлиент.ОткрытьФормуОтчета(ЭтаФорма, ВариантОтчета, ПараметрыФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ам_ЗаполнитьПоказателиПоУмолчанию()
	
	//Если НЕ РегистрыСведений.am_ХранилищеНастроек.ПолучитьПульсБизнесаБазовыеНастройки() Тогда
	//	Возврат;
	//КонецЕсли;
	
 	ам_ЗаполнитьПоказателиПоУмолчаниюНаСервере();
	ам_ПроверитьВариантыОтчетовНаСервере();
	
	ОбновитьФорму();
	ЗапуститьФоновоеЗадание();

КонецПроцедуры
 
&НаСервере
Процедура ам_ЗаполнитьПоказателиПоУмолчаниюНаСервере()
	
	Если НЕ РегистрыСведений.am_ХранилищеНастроек.ПолучитьПульсБизнесаБазовыеНастройки() Тогда
		Возврат;
	КонецЕсли;
	
	ЭтаОбработка = РеквизитФормыВЗначение("Объект");
	
	ИмяФайла = ПолучитьИмяВременногоФайла("1ct");
	ДвДанные = ЭтаОбработка.ПолучитьМакет("am_ПоказателиПоУмолчанию");
	ДвДанные.Записать(ИмяФайла);
	
	ФайлТЗ = Новый ТекстовыйДокумент;
	ФайлТЗ.Прочитать(ИмяФайла);

	Таб = XMLЗначение(Тип("ХранилищеЗначения"), ФайлТЗ.ПолучитьТекст()).Получить();
	 
	Если ТипЗнч(Таб) = Тип("ТаблицаЗначений") И Таб.Количество() > 0 Тогда
		ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("ПульсБизнеса", "Показатели", Таб);
	Иначе
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не обнаружены настройки по умолчанию!'"));
	КонецЕсли;

КонецПроцедуры
 
&НаСервере
Процедура ам_ПроверитьВариантыОтчетовНаСервере()
	
	Если НЕ РегистрыСведений.am_ХранилищеНастроек.ПолучитьПульсБизнесаБазовыеНастройки() Тогда
		Возврат;
	КонецЕсли;
	
	Варианты = Новый Массив;
	
	Контекст = Новый Структура;
	Контекст.Вставить("ОтчетСсылка", 
	Справочники.ИдентификаторыОбъектовМетаданных.НайтиПоРеквизиту("ПолноеИмя", "Отчет.РозничныеПродажи")); // Идентификатор объекта метаданных
	Контекст.Вставить("ИмяМакетаНастройки", "am_ВариантОтчета_РозничныеПродажи_КоличествоЧеков");
	Контекст.Вставить("ВариантНаименование", "АМ Количество чеков");
	
	Варианты.Добавить(Контекст);
	
	
	//Контекст = Новый Структура;
	//Контекст.Вставить("ОтчетСсылка", 
	//Справочники.ИдентификаторыОбъектовМетаданных.НайтиПоРеквизиту("ПолноеИмя", "Отчет.ДенежныеСредства")); // Идентификатор объекта метаданных
	//Контекст.Вставить("ИмяМакетаНастройки", "ам_ВариантОтчета_Деньги_ПоступлениеДСПоХозОперациям");
	//Контекст.Вставить("ВариантНаименование", "АМ Поступление ДС по хоз. операциям");
	//
	//Варианты.Добавить(Контекст);
	
	//Контекст = Новый Структура;
	//Контекст.Вставить("ОтчетСсылка", 
	//Справочники.ИдентификаторыОбъектовМетаданных.НайтиПоРеквизиту("ПолноеИмя", "Отчет.СводныйАнализЗаказовПоставщикам")); // Идентификатор объекта метаданных
	//Контекст.Вставить("ИмяМакетаНастройки", "ам_ВариантОтчета_СводныйАнализЗаказовПоставщикам_ТоварыВПути");
	//Контекст.Вставить("ВариантНаименование", "АМ Товары в пути");
	//
	//Варианты.Добавить(Контекст);
	
	Контекст = Новый Структура;
	Контекст.Вставить("ОтчетСсылка", 
	Справочники.ИдентификаторыОбъектовМетаданных.НайтиПоРеквизиту("ПолноеИмя", "Отчет.ДенежныеСредства")); // Идентификатор объекта метаданных
	Контекст.Вставить("ИмяМакетаНастройки", "am_ВариантОтчета_Деньги_ПоступлениеДС");
	Контекст.Вставить("ВариантНаименование", "АМ Поступление ДС");
	
	Варианты.Добавить(Контекст);
	
	Контекст = Новый Структура;
	Контекст.Вставить("ОтчетСсылка", 
	Справочники.ИдентификаторыОбъектовМетаданных.НайтиПоРеквизиту("ПолноеИмя", "Отчет.ДенежныеСредства")); // Идентификатор объекта метаданных
	Контекст.Вставить("ИмяМакетаНастройки", "am_ВариантОтчета_Деньги_ВыбытиеДС");
	Контекст.Вставить("ВариантНаименование", "АМ Выдача ДС");
	
	Варианты.Добавить(Контекст);
	
	
	Для каждого Контекст Из Варианты Цикл
	
		ВариантОтчета = Справочники.ВариантыОтчетов.НайтиПоРеквизиту("КлючВарианта", Контекст.ИмяМакетаНастройки);
		//Если НЕ ЗначениеЗаполнено(ВариантОтчета) Тогда
			ам_ЗаписатьВариантОтчетаНаСервере(Контекст, ВариантОтчета);	
		//КонецЕсли; 	
	
	КонецЦикла; 
	
КонецПроцедуры

&НаСервере
Процедура ам_ЗаписатьВариантОтчетаНаСервере(Контекст, ВариантОтчета)
	
	Если НЕ РегистрыСведений.am_ХранилищеНастроек.ПолучитьПульсБизнесаБазовыеНастройки() Тогда
		Возврат;
	КонецЕсли;
	
	Если ВариантОтчета = Справочники.ВариантыОтчетов.ПустаяСсылка() Тогда
		ВариантОбъект = Справочники.ВариантыОтчетов.СоздатьЭлемент();
	Иначе
	    ВариантОбъект = ВариантОтчета.ПолучитьОбъект();
	КонецЕсли; 
	ВариантОбъект.Отчет            = Контекст.ОтчетСсылка;
	ВариантОбъект.ТипОтчета        = Перечисления.ТипыОтчетов.Внутренний;
	ВариантОбъект.КлючВарианта     = Контекст.ИмяМакетаНастройки;
	ВариантОбъект.Пользовательский = Истина;
	ВариантОбъект.Автор            = Пользователи.ТекущийПользователь();
	ВариантОбъект.ЗаполнитьРодителя();
	
	ВариантОбъект.Наименование = Контекст.ВариантНаименование;
	//ВариантОбъект.Описание     = ВариантОписание;
	ВариантОбъект.ТолькоДляАвтора = Ложь; 
	
	ЭтаОбработка = РеквизитФормыВЗначение("Объект");
	
	ИмяФайла = ПолучитьИмяВременногоФайла("xml");
	ДвДанные = ЭтаОбработка.ПолучитьМакет(Контекст.ИмяМакетаНастройки);
	ДвДанные.Записать(ИмяФайла);
	
	МакетНастройкиXML = Новый ЧтениеXML;
	МакетНастройкиXML.ОткрытьФайл(ИмяФайла);
	
	НастройкиКомпоновкиДанных = СериализаторXDTO.ПрочитатьXML(МакетНастройкиXML, Тип("НастройкиКомпоновкиДанных"));
	ВариантОбъект.Настройки = Новый ХранилищеЗначения(НастройкиКомпоновкиДанных);
	
	
	ВариантОбъект.Записать();
	
	
	// Настройки вариантов УНФ
	Менеджер = РегистрыСведений.НастройкиВариантовОтчетовУНФ.СоздатьМенеджерЗаписи();
	Менеджер.Вариант = ВариантОбъект.Ссылка;
	Менеджер.ИзмененаПользователем = Истина;
	Менеджер.Записать(Истина);

КонецПроцедуры

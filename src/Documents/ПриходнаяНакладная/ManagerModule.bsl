// Делает записи в регистр сведений Цены номенклатуры.
//
Процедура амо_ЗарегистрироватьУчетныеЦены(ДокументСсылкаПриходнаяНакладная, Отказ) Экспорт
	
	ЗакупочнаяЦена = РегистрыСведений.am_ХранилищеНастроек.ПолучитьВидЦенДляРегистрацииПрихода();
	
	Если Отказ = Истина Тогда
		Возврат;
	КонецЕсли;
			
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ПриходнаяНакладная",	ДокументСсылкаПриходнаяНакладная);
	Запрос.УстановитьПараметр("ДатаОбработки",		ДокументСсылкаПриходнаяНакладная.Дата);
	Запрос.УстановитьПараметр("Закуп",				ЗакупочнаяЦена);
	
	// Две одинаковые позиции с разными ед. измерений приводят к ошибке записи регистра сведений
	// поэтому сразу выбираем уникальную номенклатуру + характеристику, а потом подтягиваем к строкам остальную информацию
	Запрос.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ПриходнаяНакладнаяЗапасы.Ссылка.Дата КАК Период,
	|	ПриходнаяНакладнаяЗапасы.Номенклатура КАК Номенклатура,
	|	ПриходнаяНакладнаяЗапасы.Характеристика КАК Характеристика,
	|	МИНИМУМ(ПриходнаяНакладнаяЗапасы.НомерСтроки) КАК НомерСтроки
	|ПОМЕСТИТЬ вт_НоменклатураБезДублей
	|ИЗ
	|	Документ.ПриходнаяНакладная.Запасы КАК ПриходнаяНакладнаяЗапасы
	|ГДЕ
	|	ПриходнаяНакладнаяЗапасы.Ссылка = &ПриходнаяНакладная
	|	И ПриходнаяНакладнаяЗапасы.Цена <> 0
	|
	|СГРУППИРОВАТЬ ПО
	|	ПриходнаяНакладнаяЗапасы.Ссылка.Дата,
	|	ПриходнаяНакладнаяЗапасы.Номенклатура,
	|	ПриходнаяНакладнаяЗапасы.Характеристика
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	вт_НоменклатураБезДублей.Период КАК Период,
	|	вт_НоменклатураБезДублей.Номенклатура КАК Номенклатура,
	|	вт_НоменклатураБезДублей.Характеристика КАК Характеристика,
	|	ПриходнаяНакладнаяЗапасы.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	ПриходнаяНакладнаяЗапасы.Цена КАК Цена
	|ПОМЕСТИТЬ вт_НовыеЦены
	|ИЗ
	|	вт_НоменклатураБезДублей КАК вт_НоменклатураБезДублей
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПриходнаяНакладная.Запасы КАК ПриходнаяНакладнаяЗапасы
	|		ПО вт_НоменклатураБезДублей.НомерСтроки = ПриходнаяНакладнаяЗапасы.НомерСтроки
	|ГДЕ
	|	ПриходнаяНакладнаяЗапасы.Ссылка = &ПриходнаяНакладная
	|	И ПриходнаяНакладнаяЗапасы.Цена <> 0
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЦеныНоменклатурыСрезПоследних.Номенклатура КАК Номенклатура,
	|	ЦеныНоменклатурыСрезПоследних.Характеристика КАК Характеристика,
	|	ЦеныНоменклатурыСрезПоследних.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	ЦеныНоменклатурыСрезПоследних.Цена КАК Цена
	|ПОМЕСТИТЬ вт_УстановленныеЦены
	|ИЗ
	|	РегистрСведений.ЦеныНоменклатуры.СрезПоследних(
	|			&ДатаОбработки,
	|			Актуальность
	|				И ВидЦен = &Закуп
	|				И (Номенклатура, Характеристика, ЕдиницаИзмерения) В
	|					(ВЫБРАТЬ
	|						Т.Номенклатура,
	|						Т.Характеристика,
	|						Т.ЕдиницаИзмерения
	|					ИЗ
	|						вт_НовыеЦены КАК Т)) КАК ЦеныНоменклатурыСрезПоследних
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	вт_НовыеЦены.Период КАК Период,
	|	вт_НовыеЦены.Номенклатура КАК Номенклатура,
	|	вт_НовыеЦены.Характеристика КАК Характеристика,
	|	вт_НовыеЦены.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	вт_НовыеЦены.Цена КАК Цена,
	|	ИСТИНА КАК Актуальность,
	|	ЗНАЧЕНИЕ(Справочник.видыцен.Учетная) КАК ВидЦен
	|ИЗ
	|	вт_НовыеЦены КАК вт_НовыеЦены
	|		ЛЕВОЕ СОЕДИНЕНИЕ вт_УстановленныеЦены КАК вт_УстановленныеЦены
	|		ПО вт_НовыеЦены.Номенклатура = вт_УстановленныеЦены.Номенклатура
	|			И вт_НовыеЦены.Характеристика = вт_УстановленныеЦены.Характеристика
	|			И вт_НовыеЦены.ЕдиницаИзмерения = вт_УстановленныеЦены.ЕдиницаИзмерения
	|ГДЕ
	|	вт_НовыеЦены.Цена <> ЕСТЬNULL(вт_УстановленныеЦены.Цена, 0)";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	КоличествоЗаписейТранзакции	= 0;
	ТранзакцияОткрыта			= Ложь;
	
	Попытка
		
		Пока Выборка.Следующий() Цикл
			
			Если НЕ ТранзакцияОткрыта
				И КоличествоЗаписейТранзакции = 0 Тогда
				
				НачатьТранзакцию();
				ТранзакцияОткрыта = Истина;
				
			КонецЕсли;
			
			КоличествоЗаписейТранзакции		= КоличествоЗаписейТранзакции + 1;
			
			МенеджерЗаписи = РегистрыСведений.ЦеныНоменклатуры.СоздатьМенеджерЗаписи();
			ЗаполнитьЗначенияСвойств(МенеджерЗаписи, Выборка);
			МенеджерЗаписи.Автор = Пользователи.АвторизованныйПользователь();
			МенеджерЗаписи.ВидЦен = ЗакупочнаяЦена;
			МенеджерЗаписи.Записать(Истина);
			
			Если КоличествоЗаписейТранзакции > ЗагрузкаДанныхИзВнешнегоИсточникаПереопределяемый.МаксимумЗаписейВОднойТранзакции() Тогда
				
				ЗафиксироватьТранзакцию();
				ТранзакцияОткрыта = Ложь;
				КоличествоЗаписейТранзакции = 0;
				
			КонецЕсли;
			
		КонецЦикла;
		
		Если КоличествоЗаписейТранзакции > 0 Тогда
			
			ЗафиксироватьТранзакцию();
			ТранзакцияОткрыта = Ложь;
			
		КонецЕсли;
		
	Исключение
		
		ЗаписьЖурналаРегистрации(Нстр("ru='АМ_УстановкаУчетнойЦены'"), УровеньЖурналаРегистрации.Ошибка, Метаданные.РегистрыСведений.ЦеныНоменклатуры, , ОписаниеОшибки());
		ОтменитьТранзакцию();
		
	КонецПопытки;
	
КонецПроцедуры // ЗарегистрироватьЦеныПоставщика()

// Удаляет записи из регистра сведений Цены номенклатуры.
//
Процедура амо_УдалитьУчетныеЦены(ДокументСсылкаПриходнаяНакладная) Экспорт
	
	ЗакупочнаяЦена = РегистрыСведений.am_ХранилищеНастроек.ПолучитьВидЦенДляРегистрацииПрихода();

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ПриходнаяНакладнаяЗапасы.Ссылка.Дата КАК Период,
	|	ПриходнаяНакладнаяЗапасы.Номенклатура КАК Номенклатура,
	|	ПриходнаяНакладнаяЗапасы.Характеристика КАК Характеристика,
	|	МИНИМУМ(ПриходнаяНакладнаяЗапасы.НомерСтроки) КАК НомерСтроки
	|ПОМЕСТИТЬ вт_НоменклатураБезДублей
	|ИЗ
	|	Документ.ПриходнаяНакладная.Запасы КАК ПриходнаяНакладнаяЗапасы
	|ГДЕ
	|	ПриходнаяНакладнаяЗапасы.Ссылка = &ПриходнаяНакладная
	|	И ПриходнаяНакладнаяЗапасы.Цена <> 0
	|
	|СГРУППИРОВАТЬ ПО
	|	ПриходнаяНакладнаяЗапасы.Ссылка.Дата,
	|	ПриходнаяНакладнаяЗапасы.Номенклатура,
	|	ПриходнаяНакладнаяЗапасы.Характеристика
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	вт_НоменклатураБезДублей.Период КАК Период,
	|	вт_НоменклатураБезДублей.Номенклатура КАК Номенклатура,
	|	вт_НоменклатураБезДублей.Характеристика КАК Характеристика,
	|	ПриходнаяНакладнаяЗапасы.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	ПриходнаяНакладнаяЗапасы.Цена КАК Цена
	|ПОМЕСТИТЬ вт_НовыеЦены
	|ИЗ
	|	вт_НоменклатураБезДублей КАК вт_НоменклатураБезДублей
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПриходнаяНакладная.Запасы КАК ПриходнаяНакладнаяЗапасы
	|		ПО вт_НоменклатураБезДублей.НомерСтроки = ПриходнаяНакладнаяЗапасы.НомерСтроки
	|ГДЕ
	|	ПриходнаяНакладнаяЗапасы.Ссылка = &ПриходнаяНакладная
	|	И ПриходнаяНакладнаяЗапасы.Цена <> 0
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЦеныНоменклатурыСрезПоследних.Номенклатура КАК Номенклатура,
	|	ЦеныНоменклатурыСрезПоследних.Характеристика КАК Характеристика,
	|	ЦеныНоменклатурыСрезПоследних.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	ЦеныНоменклатурыСрезПоследних.Цена КАК Цена,
	|	ЦеныНоменклатурыСрезПоследних.Период КАК Период
	|ПОМЕСТИТЬ вт_УстановленныеЦены
	|ИЗ
	|	РегистрСведений.ЦеныНоменклатуры.СрезПоследних(
	|			&ДатаОбработки,
	|			Актуальность
	|				И ВидЦен = &Закуп
	|				И (Номенклатура, Характеристика, ЕдиницаИзмерения) В
	|					(ВЫБРАТЬ
	|						Т.Номенклатура,
	|						Т.Характеристика,
	|						Т.ЕдиницаИзмерения
	|					ИЗ
	|						вт_НовыеЦены КАК Т)) КАК ЦеныНоменклатурыСрезПоследних
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	вт_НовыеЦены.Период КАК Период,
	|	вт_НовыеЦены.Номенклатура КАК Номенклатура,
	|	вт_НовыеЦены.Характеристика КАК Характеристика,
	|	вт_НовыеЦены.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	вт_НовыеЦены.Цена КАК Цена,
	|	ИСТИНА КАК Актуальность,
	|	ЗНАЧЕНИЕ(Справочник.видыцен.Учетная) КАК ВидЦен
	|ИЗ
	|	вт_НовыеЦены КАК вт_НовыеЦены
	|		ЛЕВОЕ СОЕДИНЕНИЕ вт_УстановленныеЦены КАК вт_УстановленныеЦены
	|		ПО вт_НовыеЦены.Номенклатура = вт_УстановленныеЦены.Номенклатура
	|			И вт_НовыеЦены.Характеристика = вт_УстановленныеЦены.Характеристика
	|			И вт_НовыеЦены.ЕдиницаИзмерения = вт_УстановленныеЦены.ЕдиницаИзмерения
	|			И (НАЧАЛОПЕРИОДА(вт_НовыеЦены.Период, ДЕНЬ) = вт_УстановленныеЦены.Период)
	|ГДЕ
	|	вт_НовыеЦены.Цена = ЕСТЬNULL(вт_УстановленныеЦены.Цена, 0)";
	
	Запрос.УстановитьПараметр("ПриходнаяНакладная",	ДокументСсылкаПриходнаяНакладная);
	Запрос.УстановитьПараметр("ДатаОбработки",		ДокументСсылкаПриходнаяНакладная.Дата);
	Запрос.УстановитьПараметр("Закуп",				ЗакупочнаяЦена);
	
	РезультатЗапроса = Запрос.Выполнить();
	ТаблицаЗаписей = РезультатЗапроса.Выгрузить();	
	
	Для каждого СтрокаТаблицы Из ТаблицаЗаписей Цикл
		НаборЗаписей = РегистрыСведений.ЦеныНоменклатуры.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Период.Установить(СтрокаТаблицы.Период);
		НаборЗаписей.Отбор.ВидЦен.Установить(ЗакупочнаяЦена);
		НаборЗаписей.Отбор.Номенклатура.Установить(СтрокаТаблицы.Номенклатура);
		НаборЗаписей.Отбор.Характеристика.Установить(СтрокаТаблицы.Характеристика);
		НаборЗаписей.Записать();
	КонецЦикла;	

КонецПроцедуры // УдалитьЦеныПоставщика()

&Вместо("ПечатнаяФормаНакладная")
Функция am_ПечатнаяФормаНакладная(МассивОбъектов, ОбъектыПечати)
	
Перем ПервыйДокумент, НомерСтрокиНачало;
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	ТабличныйДокумент.КлючПараметровПечати = "ПараметрыПечати_ПриходнаяНакладная";
	ТабличныйДокумент.ИмяПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_ПриходнаяНакладная_Накладная";
	Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.ПриходнаяНакладная.am_ПФ_MXL_ПриходнаяНакладная");
		
	ПредставлениеСкидки = Константы.ПредставлениеСкидкиВПечатнойФорме.Получить();
	
	ПараметрыНоменклатуры = Новый Структура;
	
	Запрос = Новый Запрос();
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПриходнаяНакладная.Ссылка КАК Ссылка,
	|	ПриходнаяНакладная.Дата КАК ДатаДокумента,
	|	ПриходнаяНакладная.Контрагент КАК Организация,
	|	ПриходнаяНакладная.Организация КАК Контрагент,
	|	ПриходнаяНакладная.КонтактноеЛицоПодписант.Наименование КАК КонтактноеЛицоПодписант,
	|	ПриходнаяНакладная.ПодписьКладовщика.Должность КАК ДолжностьКладовщика,
	|	ПриходнаяНакладная.ПодписьКладовщика.РасшифровкаПодписи КАК РасшифровкаПодписиКладовщика,
	|	ПриходнаяНакладная.СуммаВключаетНДС КАК СуммаВключаетНДС,
	|	ПриходнаяНакладная.Номер,
	|	ПриходнаяНакладная.Организация.Префикс КАК Префикс,
	|	ПриходнаяНакладная.ВалютаДокумента КАК ВалютаДокумента,
	|	ВЫБОР
	|		КОГДА ПриходнаяНакладная.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПриходнаяНакладная.ПоступлениеОтПоставщика)
	|			ТОГДА ""(Поступление от поставщика)""
	|		КОГДА ПриходнаяНакладная.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПриходнаяНакладная.ПриемНаКомиссию)
	|			ТОГДА ""(Прием на комиссию)""
	|		КОГДА ПриходнаяНакладная.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПриходнаяНакладная.ПриемВПереработку)
	|			ТОГДА ""(Прием в переработку)""
	|		КОГДА ПриходнаяНакладная.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПриходнаяНакладная.ПриемНаОтветХранение)
	|			ТОГДА ""(Прием от контрагента на ответственное хранение)""
	|		КОГДА ПриходнаяНакладная.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПриходнаяНакладная.ВозвратОтПокупателя)
	|			ТОГДА ""(Возврат от покупателя)""
	|		КОГДА ПриходнаяНакладная.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПриходнаяНакладная.ВозвратОтКомиссионера)
	|			ТОГДА ""(Возврат от комиссионера)""
	|		КОГДА ПриходнаяНакладная.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПриходнаяНакладная.ВозвратОтПереработчика)
	|			ТОГДА ""(Возврат от переработчика)""
	|		КОГДА ПриходнаяНакладная.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПриходнаяНакладная.ВозвратСОтветХранения)
	|			ТОГДА ""(Возврат от контрагента с ответственного хранения)""
	|	КОНЕЦ КАК ВидОперации,
	|	ПриходнаяНакладная.ВидОперации КАК ВидОперацииСсылка,
	|	ПриходнаяНакладная.Запасы.(
	|		НомерСтроки КАК НомерСтроки,
	|		ВЫБОР
	|			КОГДА (ВЫРАЗИТЬ(ПриходнаяНакладная.Запасы.Номенклатура.НаименованиеПолное КАК СТРОКА(1000))) = """"
	|				ТОГДА ПриходнаяНакладная.Запасы.Номенклатура.Наименование
	|			ИНАЧЕ ВЫРАЗИТЬ(ПриходнаяНакладная.Запасы.Номенклатура.НаименованиеПолное КАК СТРОКА(1000))
	|		КОНЕЦ КАК Запас,
	|		Номенклатура.Код КАК Код,
	|		Номенклатура.Артикул КАК Артикул,
	|		Номенклатура.Ячейка КАК Ячейка,
	|		ЕдиницаИзмерения КАК ЕдиницаХранения,
	|		Количество КАК Количество,
	|		Цена КАК Цена,
	|		ПроцентСкидкиНаценки,
	|		0 КАК СуммаАвтоматическойСкидки,
	|		ВЫБОР
	|			КОГДА ПриходнаяНакладная.Запасы.ПроцентСкидкиНаценки <> 0
	|				ТОГДА 1
	|			ИНАЧЕ 0
	|		КОНЕЦ КАК ЕстьСкидка,
	|		Сумма КАК Сумма,
	|		СуммаНДС,
	|		Всего,
	|		Характеристика,
	|		Партия,
	|		Содержание,
	|		КлючСвязи,
	|		ЛОЖЬ КАК ЭтоНабор,
	|		ВЫБОР
	|			КОГДА НоменклатураНабора <> ЗНАЧЕНИЕ(Справочник.Номенклатура.ПустаяСсылка)
	|					И НоменклатураНабора.ВариантПечатиНабора = ЗНАЧЕНИЕ(Перечисление.ВариантыПечатиНаборов.НаборИКомплектующие)
	|				ТОГДА ИСТИНА
	|			ИНАЧЕ ЛОЖЬ
	|		КОНЕЦ КАК НеобходимоВыделитьКакСоставНабора,
	|		НоменклатураНабора КАК НоменклатураНабора,
	|		ХарактеристикаНабора КАК ХарактеристикаНабора
	|	) КАК ТаблицаЗапасы,
	|	ПриходнаяНакладная.ДобавленныеНаборы.(
	|		НоменклатураНабора КАК НоменклатураНабора,
	|		ХарактеристикаНабора КАК ХарактеристикаНабора,
	|		Количество КАК Количество,
	|		ВЫБОР
	|			КОГДА (ВЫРАЗИТЬ(НоменклатураНабора.НаименованиеПолное КАК СТРОКА(1000))) = """"
	|				ТОГДА НоменклатураНабора.Наименование
	|			ИНАЧЕ ВЫРАЗИТЬ(НоменклатураНабора.НаименованиеПолное КАК СТРОКА(1000))
	|		КОНЕЦ КАК ЗапасНабора,
	|		НоменклатураНабора.ВариантПечатиНабора КАК ВариантПечатиНабора,
	|		НоменклатураНабора.ТипНоменклатуры КАК ТипНоменклатурыНабора,
	|		НоменклатураНабора.Артикул КАК АртикулНабора,
	|		НоменклатураНабора.Код КАК КодНабора,
	|		НоменклатураНабора.ЕдиницаИзмерения КАК ЕдиницаИзмеренияНабора,
	|		НоменклатураНабора.ЕдиницаИзмерения.Код КАК КодЕдиницыИзмеренияНабора,
	|		ИСТИНА КАК ВыводитьИтоги
	|	) КАК ТаблицаДобавленныеНаборы,
	|	ПриходнаяНакладная.СерийныеНомера.(
	|		СерийныйНомер,
	|		КлючСвязи
	|	) КАК ТаблицаСерийныеНомера
	|ИЗ
	|	Документ.ПриходнаяНакладная КАК ПриходнаяНакладная
	|ГДЕ
	|	ПриходнаяНакладная.Ссылка В (&МассивОбъектов)
	|
	|УПОРЯДОЧИТЬ ПО Ссылка, НомерСтроки";
		
	ДанныеДокументов = Запрос.Выполнить().Выгрузить();
	
	// Наборы
	НаборыСервер.КомпоноватьТабличнуюЧастьПоНаборам(ДанныеДокументов, "ТаблицаЗапасы");
	
	Для Каждого ДанныеДокумента Из ДанныеДокументов Цикл

		ПечатьДокументовУНФ.ПередНачаломФормированияДокумента(ТабличныйДокумент, ПервыйДокумент, НомерСтрокиНачало);

		СведенияОбОрганизации = УправлениеНебольшойФирмойСервер.СведенияОЮрФизЛице(ДанныеДокумента.Организация,
			ДанныеДокумента.ДатаДокумента, , );
		СведенияОбКонтрагенте = УправлениеНебольшойФирмойСервер.СведенияОЮрФизЛице(ДанныеДокумента.Контрагент,
			ДанныеДокумента.ДатаДокумента, , );

		НомерДокумента = ПечатьДокументовУНФ.ПолучитьНомерНаПечатьСУчетомДатыДокумента(ДанныеДокумента.ДатаДокумента,
			ДанныеДокумента.Номер, ДанныеДокумента.Префикс);

		ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
		ОбластьЗаголовок.Параметры.ТекстЗаголовка = СтрШаблон(НСтр("ru = 'Приходная накладная № %1 от %2'"),
			НомерДокумента, Формат(ДанныеДокумента.ДатаДокумента, "ДЛФ=DD"));

		ОбластьЗаголовок.Параметры.Заполнить(ДанныеДокумента);
		ШтрихкодированиеПечатныхФорм.ВывестиШтрихкодВТабличныйДокумент(ТабличныйДокумент, Макет, ОбластьЗаголовок,
			ДанныеДокумента.Ссылка);
		ТабличныйДокумент.Вывести(ОбластьЗаголовок);

		ОбластьПоставщик = Макет.ПолучитьОбласть("Поставщик");
		ОбластьПоставщик.Параметры.Заполнить(ДанныеДокумента);
		ОбластьПоставщик.Параметры.ПредставлениеПоставщика = УправлениеНебольшойФирмойСервер.ОписаниеОрганизации(
			СведенияОбОрганизации, "ПолноеНаименование,ИНН,КПП,РегистрационныйНомер,ЮридическийАдрес,Телефоны,");
		ТабличныйДокумент.Вывести(ОбластьПоставщик);

		ОбластьПокупатель = Макет.ПолучитьОбласть("Покупатель");
		ОбластьПокупатель.Параметры.ПредставлениеПолучателя = УправлениеНебольшойФирмойСервер.ОписаниеОрганизации(
			СведенияОбКонтрагенте, "ПолноеНаименование,ИНН,КПП,ЮридическийАдрес,Телефоны,");
		ТабличныйДокумент.Вывести(ОбластьПокупатель);

		ЕстьСкидки = ДанныеДокумента.ТаблицаЗапасы.Итог("ЕстьСкидка") <> 0;

		Если ЕстьСкидки Тогда

			ОбластьШапка = Макет.ПолучитьОбласть("ШапкаТаблицыСоСкидкой");
			ТабличныйДокумент.Вывести(ОбластьШапка);
			ОбластьСтрока = Макет.ПолучитьОбласть("СтрокаСоСкидкой");

		Иначе

			ОбластьШапка = Макет.ПолучитьОбласть("ШапкаТаблицы");
			ТабличныйДокумент.Вывести(ОбластьШапка);
			ОбластьСтрока = Макет.ПолучитьОбласть("Строка");

		КонецЕсли;

		Итоги = Новый Структура;
		Итоги.Вставить("Сумма", 0);
		Итоги.Вставить("СуммаНДС", 0);
		Итоги.Вставить("Всего", 0);
		Итоги.Вставить("Количество", 0);
		Итоги.Вставить("НомерСтроки", 0);
		Итоги.Вставить("ЕстьСкидки", ЕстьСкидки);
		Итоги.Вставить("ПредставлениеСкидки", ПредставлениеСкидки);
		ДанныеПечати = Новый Структура;

		Для Каждого СтрокаЗапасы Из ДанныеДокумента.ТаблицаЗапасы Цикл

			Если СтрокаЗапасы.Количество = 0 Тогда
				Продолжить;
			КонецЕсли;

			ЗаполнитьДанныеПечатиПоСтрокеТабличнойЧасти(СтрокаЗапасы, ДанныеПечати, ПараметрыНоменклатуры, Итоги,
				ДанныеДокумента);

			ОбластьСтрока.Параметры.Заполнить(СтрокаЗапасы);
			ОбластьСтрока.Параметры.Заполнить(ДанныеПечати);
			ТабличныйДокумент.Вывести(ОбластьСтрока);
			
			// Наборы
			НаборыСервер.УчестьОформлениеСтрокиНабора(ТабличныйДокумент, ОбластьСтрока, СтрокаЗапасы);

		КонецЦикла;

		ВывестиОбластиИтогиНДССуммаПрописью(Итоги, Макет, ДанныеДокумента, ТабличныйДокумент);
		
		ОбластьПодписи = Макет.ПолучитьОбласть("Подписи");
		ОбластьПодписи.Параметры.Заполнить(ДанныеДокумента);
		ТабличныйДокумент.Вывести(ОбластьПодписи);

		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабличныйДокумент, НомерСтрокиНачало, ОбъектыПечати,
			ДанныеДокумента.Ссылка);

	КонецЦикла;
	
	Возврат ТабличныйДокумент;	
	
КонецФункции

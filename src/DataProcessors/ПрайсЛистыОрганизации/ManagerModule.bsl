
&Вместо("ЭлементыИИерархияНоменклатуры")
Процедура am_ЭлементыИИерархияНоменклатуры(ПараметрыФормирования, СтруктураТаблицДанных)
	// Вставить содержимое метода.
	// 0. Предварительно
	Если ПараметрыФормирования.ИерархияСодержимого = Перечисления.ИерархияПрайсЛистов.ИерархияКатегорийНоменклатуры Тогда
		
		ИмяВариантаСКД = "ИерархияКатегорий";
		ПараметрыФормирования.ИмяПоляПредставленияГруппы = "КатегорияНоменклатуры";
		
	ИначеЕсли ПараметрыФормирования.ИерархияСодержимого = Перечисления.ИерархияПрайсЛистов.ИерархияЦеновыхГрупп Тогда
		
		ИмяВариантаСКД = "ИерархияЦеновыхГрупп";
		ПараметрыФормирования.ИмяПоляПредставленияГруппы = "ИерархияПоЦеновымГруппам";
		
	Иначе // ПараметрыФормирования.ИерархияСодержимого =Перечисления.ИерархияПрайсЛистов.ИерархияНоменклатуры
		
		ИмяВариантаСКД = "ИерархияНоменклатуры";
		ПараметрыФормирования.ИмяПоляПредставленияГруппы = "ИерархияПоНоменклатуре";
		
	КонецЕсли;
	
	// 1. Получим СКД
	ИмяСхемыКД = ?(ПараметрыФормирования.ИспользоватьХарактеристики = Истина, "СКД_НоменклатураИХарактеристики1", "СКД_Номенклатура1");
	СхемаКомпоновкиДанных = ПолучитьМакет(ИмяСхемыКД);
	
	// 2. Создаем настройки для схемы 
	НастройкиКомпоновкиДанных = СхемаКомпоновкиДанных.ВариантыНастроек[ИмяВариантаСКД].Настройки;
	
	// 2.1 Установим значения параметров
	УстановитьЗначениеПараметраВНастройкахСКД(НастройкиКомпоновкиДанных, "МассивВидовЦен",		ПараметрыФормирования.ВидыЦен);
	УстановитьЗначениеПараметраВНастройкахСКД(НастройкиКомпоновкиДанных, "ПериодЦен",			ПараметрыФормирования.ПериодЦен);
	УстановитьЗначениеПараметраВНастройкахСКД(НастройкиКомпоновкиДанных, "Организация",			ПараметрыФормирования.ОтборОрганизация);
	УстановитьЗначениеПараметраВНастройкахСКД(НастройкиКомпоновкиДанных, "СтруктурнаяЕдиница",	ПараметрыФормирования.ОтборСклад);
	
	// 2.2 установим значения отборов
	ЭлементыОтбораВНастройкиСКД(НастройкиКомпоновкиДанных.Отбор.Элементы, ПараметрыФормирования.НастройкиКомпоновкиДанных.Элементы);
	
	Если ПараметрыФормирования.НоменклатураБезЦен
		ИЛИ ПараметрыФормирования.ВидыЦен.Количество() = 0 Тогда
		
		ТекстЗапроса = СхемаКомпоновкиДанных.НаборыДанных.НаборДанных1.Запрос;
		СхемаКомпоновкиДанных.НаборыДанных.НаборДанных1.Запрос = СтрЗаменить(ТекстЗапроса, "НЕ ЕстьЗаписиСЦенами.ЕстьЗаписи ЕСТЬ NULL", "ИСТИНА");
		
	КонецЕсли;
	
	Если ПараметрыФормирования.ФормироватьПоНаличию Тогда
		
		НастройкиКомпоновкиДанных.Отбор.Элементы.Получить(0).Использование = Истина;
		
	КонецЕсли;
	
	// 2.3 установим сортировку
	Если ПараметрыФормирования.ВариантыСортировки = 1 Тогда
		
		Если ПараметрыФормирования.ИерархияСодержимого = Перечисления.ИерархияПрайсЛистов.ИерархияКатегорийНоменклатуры Тогда
			
			НастройкиКомпоновкиДанных.Структура[0].Порядок.Элементы[0].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
			НастройкиКомпоновкиДанных.Структура[0].Порядок.Элементы[1].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
			
			НастройкиКомпоновкиДанных.Структура[0].Структура[0].Порядок.Элементы[0].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
			НастройкиКомпоновкиДанных.Структура[0].Структура[0].Порядок.Элементы[1].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
			
			НастройкиКомпоновкиДанных.Структура[0].Структура[0].Структура[0].Порядок.Элементы[0].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
			НастройкиКомпоновкиДанных.Структура[0].Структура[0].Структура[0].Порядок.Элементы[1].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
			
			Если ПараметрыФормирования.ИспользоватьХарактеристики Тогда
				
				НастройкиКомпоновкиДанных.Структура[0].Структура[0].Структура[0].Порядок.Элементы[2].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
				
			КонецЕсли;
			
		Иначе
			// Ветка для:
			// ПараметрыФормирования.ИерархияСодержимого = Перечисления.ИерархияПрайсЛистов.ИерархияЦеновыхГрупп
			// ПараметрыФормирования.ИерархияСодержимого = Перечисления.ИерархияПрайсЛистов.ИерархияНоменклатуры
			
			НастройкиКомпоновкиДанных.Структура[0].Порядок.Элементы[0].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
			НастройкиКомпоновкиДанных.Структура[0].Порядок.Элементы[1].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
			НастройкиКомпоновкиДанных.Структура[0].Порядок.Элементы[2].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
			
			НастройкиКомпоновкиДанных.Структура[0].Структура[0].Порядок.Элементы[0].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
			НастройкиКомпоновкиДанных.Структура[0].Структура[0].Порядок.Элементы[1].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
			
			Если ПараметрыФормирования.ИспользоватьХарактеристики Тогда
				
				НастройкиКомпоновкиДанных.Структура[0].Структура[0].Порядок.Элементы[2].ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных.Убыв;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
	// 3. готовим макет 
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	Макет = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, НастройкиКомпоновкиДанных, , , Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
	
	// 4. исполняем макет 
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(Макет);
	ПроцессорКомпоновки.Сбросить();
	
	// 5. выводим результат 
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
	ПроцессорВывода.УстановитьОбъект(СтруктураТаблицДанных.ДеревоНоменклатуры);
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);
КонецПроцедуры

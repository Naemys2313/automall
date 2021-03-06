&Вместо("ИнициализироватьДанныеДокумента")
// Инициализирует таблицы значений, содержащие данные табличных частей документа.
// Таблицы значений сохраняет в свойствах структуры "ДополнительныеСвойства".
Процедура Вместо_ИнициализироватьДанныеДокумента(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства, Регистры = Неопределено) Экспорт
	
	Если НЕ СтруктураДополнительныеСвойства.Свойство("УчетнаяПолитика") Тогда // ЕГАИС
		СтруктураДополнительныеСвойства.ТаблицыДляДвижений.Вставить("ТаблицаОстаткиАлкогольнойПродукцииЕГАИС", Новый ТаблицаЗначений);
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = СтруктураДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ЧекККМВозврат.Ссылка КАК Ссылка,
	|	ЧекККМВозврат.Дата КАК Дата,
	|	ЧекККМВозврат.Дата КАК Период,
	|	ЧекККМВозврат.Организация КАК Организация,
	|	ЧекККМВозврат.Контрагент КАК Контрагент,
	|	ЧекККМВозврат.Договор КАК Договор,
	|	ЧекККМВозврат.Заказ КАК Заказ,
	|	ВЫБОР
	|		КОГДА ЧекККМВозврат.Заказ = ЗНАЧЕНИЕ(Документ.ЗаказПокупателя.ПустаяСсылка)
	|			ТОГДА ЧекККМВозврат.ЧекККМ
	|		ИНАЧЕ ЧекККМВозврат.Заказ
	|	КОНЕЦ КАК Документ,
	|	ЧекККМВозврат.КассаККМ КАК КассаККМ,
	|	ЧекККМВозврат.КассаККМ.СчетУчета КАК КассаККМСчетУчета,
	|	ЧекККМВозврат.ВалютаДокумента КАК ВалютаДокумента,
	|	ЧекККМВозврат.ВалютаДокумента КАК ВалютаДенежныхСредств,
	|	ЧекККМВозврат.Договор.ВалютаРасчетов КАК ДоговорВалютаРасчетов,
	|	ЧекККМВозврат.СуммаДокумента КАК Сумма,
	|	ЧекККМВозврат.СуммаДокумента КАК СуммаВал,
	|	ЗНАЧЕНИЕ(Справочник.ХозяйственныеОперации.ОтПокупателя) КАК ХозяйственнаяОперация,
	|	ЧекККМВозврат.Контрагент.ВестиРасчетыПоЗаказам КАК ВестиРасчетыПоЗаказам,
	|	ЧекККМВозврат.Контрагент.ВестиРасчетыПоДокументам КАК ВестиРасчетыПоДокументам,
	|	ЧекККМВозврат.Контрагент.ВестиРасчетыПоДоговорам КАК ВестиРасчетыПоДоговорам,
	|	ЧекККМВозврат.Контрагент.ВестиУчетОплатыПоСчетам КАК ВестиУчетОплатыПоСчетам,
	|	ЧекККМВозврат.СпособЗачетаПредоплаты КАК СпособЗачетаПредоплаты,
	|	ЧекККМВозврат.Курс КАК Курс,
	|	ЧекККМВозврат.Кратность КАК Кратность
	|ПОМЕСТИТЬ ВременнаяТаблицаШапка
	|ИЗ
	|	Документ.ЧекККМВозврат КАК ЧекККМВозврат
	|ГДЕ
	|	ЧекККМВозврат.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	1 КАК НомерСтроки,
	|	ЧекККМВозврат.Ссылка КАК Ссылка,
	|	ЧекККМВозврат.Дата КАК Дата,
	|	&Организация КАК Организация,
	|	ЧекККМВозврат.Контрагент КАК Контрагент,
	|	ЧекККМВозврат.Договор КАК Договор,
	|	ЧекККМВозврат.Заказ КАК Заказ,
	|	ЧекККМВозврат.ЧекККМ КАК Документ,
	|	ЧекККМВозврат.КассаККМ КАК КассаККМ,
	|	ЧекККМВозврат.КассаККМ.СчетУчета КАК КассаККМСчетУчета,
	|	ЧекККМВозврат.ВалютаДокумента КАК ВалютаДокумента,
	|	ЧекККМВозврат.ВалютаДокумента КАК ВалютаДенежныхСредств,
	|	ЧекККМВозврат.ВалютаДокумента КАК ВалютаРасчетов,
	|	ЧекККМВозврат.СуммаДокумента КАК СуммаПлатежа,
	|	ЧекККМВозврат.СуммаДокумента КАК СуммаРасчетов,
	|	ЧекККМВозврат.СуммаДокумента КАК СуммаУчета,
	|	ЧекККМВозврат.СуммаДокумента КАК Сумма,
	|	ЧекККМВозврат.СуммаДокумента КАК СуммаВал,
	|	ЗНАЧЕНИЕ(Перечисление.СпособыЗачетаИРаспределенияПлатежей.Вручную) КАК СпособЗачета,
	|	ЧекККМВозврат.Контрагент.ВестиРасчетыПоДоговорам КАК ВестиРасчетыПоДоговорам,
	|	ЧекККМВозврат.Контрагент.ВестиРасчетыПоДокументам КАК ВестиРасчетыПоДокументам,
	|	ЧекККМВозврат.Контрагент.ВестиРасчетыПоЗаказам КАК ВестиРасчетыПоЗаказам,
	|	ЧекККМВозврат.Контрагент.ВестиУчетОплатыПоСчетам КАК ВестиУчетОплатыПоСчетам,
	|	ИСТИНА КАК ПризнакАванса,
	|	1 КАК Курс,
	|	1 КАК Кратность,
	|	&СтавкаБезНДС КАК СтавкаНДС,
	|	0 КАК СуммаНДС,
	|	ЗНАЧЕНИЕ(Документ.СчетНаОплату.ПустаяСсылка) КАК СчетНаОплату,
	|	ЗНАЧЕНИЕ(Перечисление.ВидыОперацийРасходИзКассы.Покупателю) КАК ВидОперации
	|ПОМЕСТИТЬ ВременнаяТаблицаРасшифровкаПлатежа
	|ИЗ
	|	Документ.ЧекККМВозврат КАК ЧекККМВозврат
	|ГДЕ
	|	ЧекККМВозврат.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЧекККМЗапасы.НомерСтроки КАК НомерСтроки,
	|	ЧекККМЗапасы.Ссылка.ЧекККМ КАК Документ,
	|	ЧекККМЗапасы.Ссылка.Дата КАК Дата,
	|	ЧекККМЗапасы.Ссылка.Дата КАК Период,
	|	ЧекККМЗапасы.Заказ КАК ЗаказПокупателя,
	|	ЧекККМЗапасы.Ссылка.КассаККМ КАК КассаККМ,
	|	ЧекККМЗапасы.Ссылка.КассаККМ.Владелец КАК КассаККМВладелец,
	|	ЧекККМЗапасы.Ссылка.КассаККМ.СчетУчета КАК КассаККМСчетУчета,
	|	ЧекККМЗапасы.Ссылка.ВалютаДокумента КАК ВалютаДокумента,
	|	&Организация КАК Организация,
	|	ВЫБОР
	|		КОГДА ЧекККМЗапасы.Ссылка.ПоложениеСклада В (ЗНАЧЕНИЕ(Перечисление.ПоложениеРеквизитаНаФорме.ВШапке), ЗНАЧЕНИЕ(Перечисление.ПоложениеРеквизитаНаФорме.ПустаяСсылка))
	|			ТОГДА ЧекККМЗапасы.Ссылка.СтруктурнаяЕдиница
	|		ИНАЧЕ ЧекККМЗапасы.СтруктурнаяЕдиница
	|	КОНЕЦ КАК СтруктурнаяЕдиница,
	|	ЧекККМЗапасы.Ссылка.Подразделение КАК Подразделение,
	|	ЧекККМЗапасы.Ссылка.Ответственный КАК Ответственный,
	|	ЧекККМЗапасы.Номенклатура.ТипНоменклатуры КАК ТипНоменклатуры,
	|	ЧекККМЗапасы.Номенклатура.НаправлениеДеятельности КАК НаправлениеДеятельности,
	|	ЧекККМЗапасы.Номенклатура.НаправлениеДеятельности.СчетУчетаВыручкиОтПродаж КАК СчетУчетаВыручкиОтПродаж,
	|	ЧекККМЗапасы.Номенклатура.НаправлениеДеятельности.СчетУчетаСебестоимостиПродаж КАК СчетУчетаСебестоимость,
	|	ВЫБОР
	|		КОГДА ЧекККМЗапасы.Ссылка.ПоложениеСклада = ЗНАЧЕНИЕ(Перечисление.ПоложениеРеквизитаНаФорме.ВШапке)
	|			ТОГДА ЧекККМЗапасы.Ссылка.Ячейка
	|		ИНАЧЕ ЧекККМЗапасы.Ячейка
	|	КОНЕЦ КАК Ячейка,
	|	ЧекККМЗапасы.Номенклатура.СчетУчетаЗапасов КАК СчетУчетаЗапасов,
	|	ВЫБОР
	|		КОГДА &ИспользоватьПартии
	|				И ЧекККМЗапасы.Партия.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыПартий.ТоварыНаКомиссии)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ТоварыНаКомиссии,
	|	ЧекККМЗапасы.Номенклатура КАК Номенклатура,
	|	ВЫБОР
	|		КОГДА &ИспользоватьХарактеристики
	|			ТОГДА ЧекККМЗапасы.Характеристика
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.ХарактеристикиНоменклатуры.ПустаяСсылка)
	|	КОНЕЦ КАК Характеристика,
	|	ЧекККМЗапасы.НоменклатураНабора КАК НоменклатураНабора,
	|	ВЫБОР
	|		КОГДА &ИспользоватьХарактеристики
	|			ТОГДА ЧекККМЗапасы.ХарактеристикаНабора
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.ХарактеристикиНоменклатуры.ПустаяСсылка)
	|	КОНЕЦ КАК ХарактеристикаНабора,
	|	ВЫБОР
	|		КОГДА &ИспользоватьПартии
	|			ТОГДА ЧекККМЗапасы.Партия
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.ПартииНоменклатуры.ПустаяСсылка)
	|	КОНЕЦ КАК Партия,
	|	ВЫБОР
	|		КОГДА ТИПЗНАЧЕНИЯ(ЧекККМЗапасы.ЕдиницаИзмерения) = ТИП(Справочник.КлассификаторЕдиницИзмерения)
	|			ТОГДА ЧекККМЗапасы.Количество
	|		ИНАЧЕ ЧекККМЗапасы.Количество * ЧекККМЗапасы.ЕдиницаИзмерения.Коэффициент
	|	КОНЕЦ КАК Количество,
	|	ЧекККМЗапасы.СтавкаНДС КАК СтавкаНДС,
	|	ВЫРАЗИТЬ(ВЫБОР
	|			КОГДА ЧекККМЗапасы.Ссылка.НДСВключатьВСтоимость
	|				ТОГДА 0
	|			ИНАЧЕ ЧекККМЗапасы.СуммаНДС * КурсыДокВалюты.Курс * КурсыУпрВалюты.Кратность / (КурсыУпрВалюты.Курс * КурсыДокВалюты.Кратность)
	|		КОНЕЦ КАК ЧИСЛО(15, 2)) КАК СуммаНДС,
	|	ВЫРАЗИТЬ(ЧекККМЗапасы.СуммаНДС * КурсыДокВалюты.Курс * КурсыУпрВалюты.Кратность / (КурсыУпрВалюты.Курс * КурсыДокВалюты.Кратность) КАК ЧИСЛО(15, 2)) КАК СуммаНДСЗакупкиПродажи,
	|	ВЫРАЗИТЬ(ЧекККМЗапасы.Всего * КурсыДокВалюты.Курс * КурсыУпрВалюты.Кратность / (КурсыУпрВалюты.Курс * КурсыДокВалюты.Кратность) КАК ЧИСЛО(15, 2)) КАК Сумма,
	|	ВЫРАЗИТЬ(ЧекККМЗапасы.СуммаНДС КАК ЧИСЛО(15, 2)) КАК СуммаНДСВал,
	|	ВЫРАЗИТЬ(ЧекККМЗапасы.Всего КАК ЧИСЛО(15, 2)) КАК СуммаВал,
	|	ВЫРАЗИТЬ(ЧекККМЗапасы.Всего КАК ЧИСЛО(15, 2)) КАК ВсегоВалютаДокумента,
	|	ЧекККМЗапасы.КлючСвязи КАК КлючСвязи,
	|	НЕОПРЕДЕЛЕНО КАК КоррСтруктурнаяЕдиница,
	|	НЕОПРЕДЕЛЕНО КАК КоррНоменклатура,
	|	НЕОПРЕДЕЛЕНО КАК КоррСчетУчетаЗапасов,
	|	ВЫБОР
	|		КОГДА &ИспользоватьХарактеристики
	|			ТОГДА ЧекККМЗапасы.Характеристика
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.ХарактеристикиНоменклатуры.ПустаяСсылка)
	|	КОНЕЦ КАК КоррХарактеристика,
	|	ВЫБОР
	|		КОГДА &ИспользоватьПартии
	|			ТОГДА ЧекККМЗапасы.Партия
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.ПартииНоменклатуры.ПустаяСсылка)
	|	КОНЕЦ КАК КоррПартия,
	|	ЧекККМЗапасы.Ссылка.КассоваяСмена КАК КассоваяСмена,
	|	ЧекККМЗапасы.Ссылка.Контрагент.ВестиУчетОплатыПоСчетам КАК ВестиУчетОплатыПоСчетам,
	|	ЧекККМЗапасы.Ссылка.Контрагент.ВестиРасчетыПоЗаказам КАК ВестиРасчетыПоЗаказам,
	|	ВЫРАЗИТЬ(ВЫБОР
	|			КОГДА ЧекККМЗапасы.Номенклатура.ПроизвольныйНоминал
	|				ТОГДА ЧекККМЗапасы.Сумма / ВЫБОР
	|						КОГДА ЧекККМЗапасы.Номенклатура.ИспользоватьСерийныеНомера
	|							ТОГДА ЧекККМЗапасы.Количество
	|						ИНАЧЕ 1
	|					КОНЕЦ
	|			ИНАЧЕ ЧекККМЗапасы.Номенклатура.Номинал / ВЫБОР
	|					КОГДА ЧекККМЗапасы.Номенклатура.ИспользоватьСерийныеНомера
	|						ТОГДА 1
	|					ИНАЧЕ 1 / ЧекККМЗапасы.Количество
	|				КОНЕЦ
	|		КОНЕЦ КАК ЧИСЛО(15, 2)) КАК НоминалСертификата,
	|	ЧекККМЗапасы.Номенклатура.ЧастичноеПогашение КАК ЧастичноеПогашениеСертификата,
	|	ЧекККМЗапасы.Номенклатура.ПроизвольныйНоминал КАК ПроизвольныйНоминал,
	|	ЧекККМЗапасы.Номенклатура.ИспользоватьСерийныеНомера КАК ИспользоватьСерийныеНомера,
	|	ЧекККМЗапасы.СуммаСкидкиНаценки КАК СуммаСкидкиНаценки,
	|	ЧекККМЗапасы.Цена КАК Цена,
	|	ЧекККМЗапасы.СуммаСкидкиОплатыБонусом КАК СуммаСкидкиОплатыБонусом,
	|	ЧекККМЗапасы.СуммаАвтоматическойСкидки КАК СуммаАвтоматическойСкидки,
	|	ЧекККМЗапасы.Ссылка.Контрагент КАК Контрагент,
	|	ЧекККМЗапасы.Ссылка.Контрагент.СчетУчетаРасчетовСПокупателем КАК СчетУчетаРасчетовСПокупателем,
	|	ЧекККМЗапасы.Ссылка.Контрагент.СчетУчетаАвансовПоставщику КАК СчетУчетаАвансовПоставщику,
	|	ЧекККМЗапасы.Ссылка.Договор КАК Договор,
	|	ЧекККМЗапасы.Ссылка.ВалютаДокумента КАК ВалютаРасчетов
	|ПОМЕСТИТЬ ВременнаяТаблицаЗапасы
	|ИЗ
	|	Документ.ЧекККМВозврат.Запасы КАК ЧекККМЗапасы
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КурсыВалют.СрезПоследних(
	|				&МоментВремени,
	|				Валюта В
	|					(ВЫБРАТЬ
	|						Константы.ВалютаУчета
	|					ИЗ
	|						Константы КАК Константы)) КАК КурсыУпрВалюты
	|		ПО (ИСТИНА)
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КурсыВалют.СрезПоследних(&МоментВремени, ) КАК КурсыДокВалюты
	|		ПО ЧекККМЗапасы.Ссылка.ВалютаДокумента = КурсыДокВалюты.Валюта
	|ГДЕ
	|	ЧекККМЗапасы.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТабличнаяЧасть.НомерСтроки КАК НомерСтроки,
	|	ТабличнаяЧасть.Ссылка.Дата КАК Дата,
	|	&Ссылка КАК Документ,
	|	&Организация КАК Организация,
	|	ТабличнаяЧасть.Ссылка.КассаККМ КАК КассаККМ,
	|	ТабличнаяЧасть.Ссылка.КассаККМ.СчетУчета КАК КассаККМСчетУчета,
	|	ТабличнаяЧасть.ЭквайринговыйТерминал.СчетУчета КАК ЭквайринговыйТерминалСчетУчета,
	|	ТабличнаяЧасть.Ссылка.ВалютаДокумента КАК ВалютаДокумента,
	|	ВЫРАЗИТЬ(ТабличнаяЧасть.Сумма * КурсыВалютКассы.Курс * КурсыВалютУчетаСрезПоследних.Кратность / (КурсыВалютУчетаСрезПоследних.Курс * КурсыВалютКассы.Кратность) КАК ЧИСЛО(15, 2)) КАК Сумма,
	|	ТабличнаяЧасть.Сумма КАК СуммаВал,
	|	ТабличнаяЧасть.ВидОплаты КАК ВидОплаты,
	|	ТабличнаяЧасть.ВидПлатежнойКарты КАК ВидПлатежнойКарты,
	|	ТабличнаяЧасть.НомерПлатежнойКарты КАК НомерПлатежнойКарты,
	|	ТабличнаяЧасть.ЭквайринговыйТерминал.Эквайрер КАК Эквайрер,
	|	ТабличнаяЧасть.ЭквайринговыйТерминал.Договор КАК Договор,
	|	ТабличнаяЧасть.ЭквайринговыйТерминал КАК ЭквайринговыйТерминал,
	|	ТабличнаяЧасть.ПодарочныйСертификат КАК ПодарочныйСертификат,
	|	ТабличнаяЧасть.НомерСертификата КАК НомерСертификата,
	|	ТабличнаяЧасть.ПодарочныйСертификат.ЧастичноеПогашение КАК ЧастичноеПогашение,
	|	ТабличнаяЧасть.ПодарочныйСертификат.Номинал КАК Номинал,
	|	ТабличнаяЧасть.Сумма КАК СуммаСертификата,
	|	ТабличнаяЧасть.Ссылка.СтруктурнаяЕдиница КАК СтруктурнаяЕдиница,
	|	ТабличнаяЧасть.Ссылка.Заказ КАК Заказ,
	|	ТабличнаяЧасть.Ссылка.Контрагент КАК Контрагент
	|ПОМЕСТИТЬ ВременнаяТаблицаОплатаПлатежнымиКартами
	|ИЗ
	|	Документ.ЧекККМВозврат.БезналичнаяОплата КАК ТабличнаяЧасть
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КурсыВалют.СрезПоследних(
	|				&МоментВремени,
	|				Валюта В
	|					(ВЫБРАТЬ
	|						Константы.ВалютаУчета
	|					ИЗ
	|						Константы КАК Константы)) КАК КурсыВалютУчетаСрезПоследних
	|		ПО (ИСТИНА)
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КурсыВалют.СрезПоследних(&МоментВремени, ) КАК КурсыВалютКассы
	|		ПО ТабличнаяЧасть.Ссылка.ВалютаДокумента = КурсыВалютКассы.Валюта
	|ГДЕ
	|	ТабличнаяЧасть.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЧекККМВозвратПредоплата.НомерСтроки КАК НомерСтроки,
	|	ЧекККМВозвратПредоплата.Ссылка.Дата КАК Дата,
	|	ЧекККМВозвратПредоплата.Ссылка.Дата КАК Период,
	|	ЧекККМВозвратПредоплата.Документ КАК Документ,
	|	ЧекККМВозвратПредоплата.Заказ КАК ЗаказПокупателя,
	|	ЧекККМВозвратПредоплата.Курс КАК Курс,
	|	ЧекККМВозвратПредоплата.Кратность КАК Кратность,
	|	ЧекККМВозвратПредоплата.Ссылка.КассаККМ КАК КассаККМ,
	|	ЧекККМВозвратПредоплата.Ссылка.КассаККМ.СчетУчета КАК КассаККМСчетУчета,
	|	&Организация КАК Организация,
	|	ЧекККМВозвратПредоплата.Ссылка.СтруктурнаяЕдиница КАК СтруктурнаяЕдиница,
	|	ЧекККМВозвратПредоплата.Ссылка.ВалютаДокумента КАК ВалютаДокумента,
	|	ЧекККМВозвратПредоплата.СуммаРасчетов КАК Сумма,
	|	ЧекККМВозвратПредоплата.СуммаРасчетов КАК СуммаВал,
	|	ЧекККМВозвратПредоплата.СуммаРасчетов КАК СуммаРасчетов,
	|	ЧекККМВозвратПредоплата.СуммаПлатежа КАК СуммаПлатежа,
	|	ЧекККМВозвратПредоплата.Ссылка КАК Ссылка,
	|	ЧекККМВозвратПредоплата.Ссылка.Контрагент КАК Контрагент,
	|	ЧекККМВозвратПредоплата.Ссылка.Договор КАК Договор,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыРасчетов.Аванс) КАК ТипРасчетов,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыРасчетов.Долг) КАК ТипРасчетовКуда,
	|	ЛОЖЬ КАК ОплатаСертификатом,
	|	ЗНАЧЕНИЕ(Справочник.СерийныеНомера.ПустаяСсылка) КАК НомерСертификата,
	|	ЧекККМВозвратПредоплата.Ссылка.Контрагент.СчетУчетаРасчетовСПокупателем КАК СчетУчетаРасчетовСПокупателем,
	|	ЧекККМВозвратПредоплата.Ссылка.Контрагент.СчетУчетаАвансовПоставщику КАК СчетУчетаАвансовПоставщику,
	|	ЧекККМВозвратПредоплата.Ссылка.ВалютаДокумента КАК ВалютаРасчетов
	|ПОМЕСТИТЬ ВременнаяТаблицаПредоплата
	|ИЗ
	|	Документ.ЧекККМВозврат.Предоплата КАК ЧекККМВозвратПредоплата
	|ГДЕ
	|	ЧекККМВозвратПредоплата.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЧекККМВозвратСкидкиНаценки.КлючСвязи КАК КлючСвязи,
	|	ЧекККМВозвратСкидкиНаценки.СкидкаНаценка КАК СкидкаНаценка,
	|	ВЫРАЗИТЬ(ВЫБОР
	|			КОГДА ЧекККМВозвратСкидкиНаценки.Ссылка.ВалютаДокумента = КонстантаНациональнаяВалюта.Значение
	|				ТОГДА ЧекККМВозвратСкидкиНаценки.Сумма * КурсыРегВалюты.Курс * КурсыУпрВалюты.Кратность / (КурсыУпрВалюты.Курс * КурсыРегВалюты.Кратность)
	|			ИНАЧЕ ЧекККМВозвратСкидкиНаценки.Сумма * КурсыУпрВалюты.Кратность / КурсыУпрВалюты.Курс
	|		КОНЕЦ КАК ЧИСЛО(15, 2)) КАК Сумма,
	|	ЧекККМВозвратСкидкиНаценки.Ссылка.Дата КАК Период,
	|	ЧекККМВозвратСкидкиНаценки.Ссылка.СтруктурнаяЕдиница КАК СтруктурнаяЕдиница
	|ПОМЕСТИТЬ ВременнаяТаблицаАвтоСкидкиНаценки
	|ИЗ
	|	Документ.ЧекККМВозврат.СкидкиНаценки КАК ЧекККМВозвратСкидкиНаценки
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КурсыВалют.СрезПоследних(
	|				&МоментВремени,
	|				Валюта В
	|					(ВЫБРАТЬ
	|						КонстантаВалютаУчета.Значение
	|					ИЗ
	|						Константа.ВалютаУчета КАК КонстантаВалютаУчета)) КАК КурсыУпрВалюты
	|		ПО (ИСТИНА)
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КурсыВалют.СрезПоследних(
	|				&МоментВремени,
	|				Валюта В
	|					(ВЫБРАТЬ
	|						КонстантаНациональнаяВалюта.Значение
	|					ИЗ
	|						Константа.НациональнаяВалюта КАК КонстантаНациональнаяВалюта)) КАК КурсыРегВалюты
	|		ПО (ИСТИНА),
	|	Константа.НациональнаяВалюта КАК КонстантаНациональнаяВалюта
	|ГДЕ
	|	ЧекККМВозвратСкидкиНаценки.Ссылка = &Ссылка
	|	И ЧекККМВозвратСкидкиНаценки.Сумма <> 0
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЭквайринговыеТерминалыВидыПлатежныхКарт.ВидПлатежнойКарты КАК ВидПлатежнойКарты,
	|	МАКСИМУМ(ЭквайринговыеТерминалыВидыПлатежныхКарт.ПроцентКомиссии) КАК ПроцентКомиссии
	|ПОМЕСТИТЬ ВременнаяТаблицаПроцентыКомиссии
	|ИЗ
	|	Справочник.ЭквайринговыеТерминалы.ВидыПлатежныхКарт КАК ЭквайринговыеТерминалыВидыПлатежныхКарт
	|ГДЕ
	|	ЭквайринговыеТерминалыВидыПлатежныхКарт.Ссылка = &ЭквайринговыйТерминал
	|
	|СГРУППИРОВАТЬ ПО
	|	ЭквайринговыеТерминалыВидыПлатежныхКарт.ВидПлатежнойКарты
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЧекККМСерийныеНомера.КлючСвязи КАК КлючСвязи,
	|	ЧекККМСерийныеНомера.СерийныйНомер КАК СерийныйНомер
	|ПОМЕСТИТЬ ВременнаяТаблицаСерийныеНомера
	|ИЗ
	|	Документ.ЧекККМВозврат.СерийныеНомера КАК ЧекККМСерийныеНомера
	|ГДЕ
	|	ЧекККМСерийныеНомера.Ссылка = &Ссылка
	|	И &ИспользоватьСерийныеНомера
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) КАК ВидДвижения,
	|	ТаблицаАкцизныеМарки.Ссылка.Дата КАК Период,
	|	ТаблицаАкцизныеМарки.Ссылка КАК Ссылка,
	|	&ОрганизацияЕГАИС КАК ОрганизацияЕГАИС,
	|	ТаблицаАкцизныеМарки.Справка2 КАК Справка2,
	|	Справки2ЕГАИС.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ТаблицаАкцизныеМарки.АкцизнаяМарка) КАК Количество,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ТаблицаАкцизныеМарки.АкцизнаяМарка) КАК СвободныйОстаток
	|ПОМЕСТИТЬ ВременнаяТаблицаАкцизныеМарки
	|ИЗ
	|	Документ.ЧекККМВозврат.АкцизныеМарки КАК ТаблицаАкцизныеМарки
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Справки2ЕГАИС КАК Справки2ЕГАИС
	|		ПО (Справки2ЕГАИС.Ссылка = ТаблицаАкцизныеМарки.Справка2)
	|ГДЕ
	|	ТаблицаАкцизныеМарки.Ссылка = &Ссылка
	|	И ТаблицаАкцизныеМарки.Справка2 <> ЗНАЧЕНИЕ(Справочник.Справки2ЕГАИС.ПустаяСсылка)
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаАкцизныеМарки.Ссылка,
	|	ТаблицаАкцизныеМарки.Справка2,
	|	Справки2ЕГАИС.АлкогольнаяПродукция,
	|	ТаблицаАкцизныеМарки.Ссылка.Дата
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЧекККМВозвратБонусныеБаллыКНачислению.НомерСтроки КАК НомерСтроки,
	|	ЧекККМВозвратБонусныеБаллыКНачислению.Ссылка.Дата КАК Период,
	|	ЧекККМВозвратБонусныеБаллыКНачислению.Ссылка.ДисконтнаяКарта КАК БонуснаяКарта,
	|	ЧекККМВозвратЗапасы.Номенклатура КАК Номенклатура,
	|	ЧекККМВозвратЗапасы.Характеристика КАК Характеристика,
	|	-ЧекККМВозвратБонусныеБаллыКНачислению.КоличествоБонусныхБаллов КАК Количество,
	|	ЧекККМВозвратБонусныеБаллыКНачислению.ДатаНачисления КАК ДатаНачисления,
	|	ЧекККМВозвратБонусныеБаллыКНачислению.ДатаСписания КАК ДатаСгорания,
	|	ЧекККМВозвратБонусныеБаллыКНачислению.Ссылка КАК Ссылка,
	|	ЧекККМВозвратБонусныеБаллыКНачислению.СкидкаНаценка КАК АналитикаНачисленияБонусов
	|ПОМЕСТИТЬ ВременнаяТаблицаНачисленияБонусов
	|ИЗ
	|	Документ.ЧекККМВозврат.БонусныеБаллыКНачислению КАК ЧекККМВозвратБонусныеБаллыКНачислению
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ЧекККМВозврат.Запасы КАК ЧекККМВозвратЗапасы
	|		ПО ЧекККМВозвратБонусныеБаллыКНачислению.Ссылка = ЧекККМВозвратЗапасы.Ссылка
	|			И ЧекККМВозвратБонусныеБаллыКНачислению.КлючСвязи = ЧекККМВозвратЗапасы.КлючСвязи
	|ГДЕ
	|	ЧекККМВозвратБонусныеБаллыКНачислению.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЧекККМВозвратБезналичнаяОплата.НомерСтроки КАК НомерСтроки,
	|	НАЧАЛОПЕРИОДА(ЧекККМВозвратБезналичнаяОплата.Ссылка.Дата, ДЕНЬ) КАК Период,
	|	ЧекККМВозвратБезналичнаяОплата.БонуснаяКарта КАК БонуснаяКарта,
	|	ЧекККМВозвратБезналичнаяОплата.СуммаБонусов КАК Количество,
	|	0 КАК КСписанию,
	|	ЧекККМВозвратБезналичнаяОплата.Ссылка КАК Ссылка
	|ПОМЕСТИТЬ ВременнаяТаблицаСписанияБонусов
	|ИЗ
	|	Документ.ЧекККМВозврат.БезналичнаяОплата КАК ЧекККМВозвратБезналичнаяОплата
	|ГДЕ
	|	ЧекККМВозвратБезналичнаяОплата.Ссылка = &Ссылка
	|	И ЧекККМВозвратБезналичнаяОплата.ВидОплаты = ЗНАЧЕНИЕ(Перечисление.ВидыБезналичныхОплат.Бонусы)";
	
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылкаЧекККМВозврат);
	Запрос.УстановитьПараметр("Организация", СтруктураДополнительныеСвойства.ДляПроведения.Организация);
	Запрос.УстановитьПараметр("МоментВремени", Новый Граница(СтруктураДополнительныеСвойства.ДляПроведения.МоментВремени, ВидГраницы.Включая));
	Запрос.УстановитьПараметр("ИспользоватьХарактеристики", СтруктураДополнительныеСвойства.УчетнаяПолитика.ИспользоватьХарактеристики);
	Запрос.УстановитьПараметр("ИспользоватьПартии", СтруктураДополнительныеСвойства.УчетнаяПолитика.ИспользоватьПартии);
	
	СтруктураРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ДокументСсылкаЧекККМВозврат, "Организация,СтруктурнаяЕдиница,ЭквайринговыйТерминал");
	
	Запрос.УстановитьПараметр("ЭквайринговыйТерминал", СтруктураРеквизитов.ЭквайринговыйТерминал);
	Запрос.УстановитьПараметр("ИспользоватьСерийныеНомера", СтруктураДополнительныеСвойства.УчетнаяПолитика.ИспользоватьСерийныеНомера);
	
	ОрганизацияЕГАИС = Справочники.КлассификаторОрганизацийЕГАИС.ОрганизацияЕГАИСПоОрганизацииИТорговомуОбъекту(СтруктураРеквизитов.Организация, СтруктураРеквизитов.СтруктурнаяЕдиница);
	Запрос.УстановитьПараметр("ОрганизацияЕГАИС", ОрганизацияЕГАИС);
	Запрос.УстановитьПараметр("СтавкаБезНДС", УправлениеНебольшойФирмойПовтИсп.ПолучитьСтавкуНДСБезНДС());
	
	Запрос.ВыполнитьПакет();
	
	// Формирование проводок документа.
	УправлениеНебольшойФирмойСервер.СформироватьТаблицуПроводок(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	
	СформироватьТаблицаЗапасы(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	СформироватьТаблицаЗапасыНаСкладах(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	СформироватьТаблицаДенежныеСредстваВКассахККМ(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	СформироватьТаблицаДоходыИРасходы(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	СформироватьТаблицаДоходыИРасходыНераспределенные(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	СформироватьТаблицаДоходыИРасходыКассовыйМетод(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	СформироватьТаблицаПродажи(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	
	
	// ДисконтныеКарты
	СформироватьТаблицаПродажиПоДисконтнойКарте(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	
	// Скидки
	СформироватьТаблицаПродажиПоПредоставленнымСкидкам(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	
	// Эквайринг
	СформироватьТаблицаОплатаПлатежнымиКартами(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	
	// Серийные номера
	СформироватьТаблицаСерийныеНомера(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	
	// Подарочные сертификаты
	СформироватьТаблицаПодарочныеСертификаты(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	СформироватьТаблицаОплатаПодарочнымиСертификатами(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	СформироватьТаблицаРасчетыСПокупателями(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	
	// Бонусы
	СформироватьТаблицаБонусныеБаллы(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	СформироватьТаблицаНачисленияБонусныхБаллов(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	
	// Заказ покупателя в розничной торговле
	СформироватьТаблицаЗаказыПокупателей(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	СформироватьТаблицаПлатежныйКалендарь(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	
	Если СтруктураДополнительныеСвойства.ДляПроведения.ОперацияСДенежнымиСредствами
		И СтруктураДополнительныеСвойства.ДляПроведения.ЧекПробит
		И Не СтруктураДополнительныеСвойства.ДляПроведения.Архивный Тогда
		РасчетыПроведениеДокументов.СформироватьТаблицаОплатаСчетовИЗаказовДенежныеДокументы(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	КонецЕсли;
	СформироватьТаблицаОплатаСчетовИЗаказов(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	
	СформироватьТаблицаОстаткиАлкогольнойПродукцииЕГАИС(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	
	СформироватьТаблицаУправленческий(ДокументСсылкаЧекККМВозврат, СтруктураДополнительныеСвойства);
	
КонецПроцедуры // ИнициализироватьДанныеДокумента()


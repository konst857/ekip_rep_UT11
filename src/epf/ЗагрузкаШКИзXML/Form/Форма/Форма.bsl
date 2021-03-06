﻿
// загрузка ///////////////////////////////////////////

&НаКлиенте
Процедура Загрузить(Команда)
	АдресФайла = "";
	ИмяФайлаДляРасширения = "";

	
	ОписаниеОповещения = Новый ОписаниеОповещения("ЗагрузитьСервВызов", ЭтотОбъект, Новый Структура("НаборСвойств", НаборСвойств));
	НачатьПомещениеФайла(ОписаниеОповещения, АдресФайла, ИмяФайла ,Ложь, УникальныйИдентификатор);

	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = "Загрузка завершена";
	Сообщение.УстановитьДанные(ЭтотОбъект);
	Сообщение.Сообщить();
	
	//ЗагрузитьСервВызов(Истина, АдресФайла, ИмяФайлаДляРасширения, Неопределено);
	 //Форма=Документ.ПолучитьФорму();
	 Если ВладелецФормы<>Неопределено Тогда
		 ВладелецФормы.прочитать();
	 КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьСервВызов(Результат, пАдресФайла, ВыбранноеИмяФайла, ДополнительныеПараметры)

	ВремФайл=Новый Файл(ИмяФайла);
	
	
	//ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	
	ВременноеУникальноеИмяФайла=ПолучитьИмяВременногоФайла("xml");
	
	
	ВремФайл=Новый Файл (ВременноеУникальноеИмяФайла);
	
	ПолноеИмяФВеренногоФайла=КаталогВременныхФайлов()+ВремФайл.Имя;

	
 	ИмяФайлаНаСервере(пАдресФайла, ПолноеИмяФВеренногоФайла);

	
	ЗагрузитьНаСервере(ПолноеИмяФВеренногоФайла, ДополнительныеПараметры);
	
	
	
	
	//ЗначениеВРеквизитФормы(ОбработкаОбъект, "Объект");   

	ВремФайл=Новый Файл (ПолноеИмяФВеренногоФайла);

	
	Если ВремФайл.Существует() Тогда
		Попытка
			УдалитьФайлы(ВремФайл.ПолноеИмя);
		Исключение
			СообщитьСерв("Ошибка удаления временного файла "+ПолноеИмяФВеренногоФайла,ЭтаФорма);
		КонецПопытки
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
процедура ИмяФайлаНаСервере(АдресФайла, НовоеИмяФайлаНаСервере)

	ДвоичныеДанные = ПолучитьИзВременногоХранилища(АдресФайла);
	ДвоичныеДанные.Записать(НовоеИмяФайлаНаСервере);
	
конецПроцедуры // ИмяФайлаНаСервере()

&НаКлиенте
процедура ИмяФайлаНаКлиент(АдресФайла, НовоеИмяФайлаНаСервере)

	ДвоичныеДанные = ПолучитьИзВременногоХранилища(АдресФайла);
	ДвоичныеДанные.Записать(НовоеИмяФайлаНаСервере);
	
конецПроцедуры // ИмяФайлаНаСервере()



&НаСервере
Функция ПрочитатьБыстроЛистExcel(ТЗ = Неопределено, ЛистЭксель = Неопределено, НомерПервойСтроки = 1, НомерПервойКолонки = 1, ВсегоСтрок = 0, ВсегоКолонок = 0, СчитываемыйОбъект="Value") Экспорт
	
	Если ЛистЭксель = Неопределено Тогда
		ЛистЭксель = ПолучитьCOMОбъект(,"Excel.Application");
	КонецЕсли;
	Если ВсегоСтрок = 0 Тогда
		ВсегоСтрок = ЛистЭксель.Cells.SpecialCells(11).Row;
	КонецЕсли;
	Если ВсегоКолонок = 0 Тогда
		ВсегоКолонок = ЛистЭксель.Cells.SpecialCells(11).Column;
	КонецЕсли;
	
 	КоличествоКолонок=ВсегоКолонок-НомерПервойКолонки+1;

	
	Если ТЗ = Неопределено Тогда
		ТЗ =  Новый ТаблицаЗначений;
		//Для Счетчик = 1 По ВсегоКолонок Цикл
		Для Счетчик = 1 По КоличествоКолонок Цикл
			ТЗ.Колонки.Добавить("Колонка"+Счетчик, Новый ОписаниеТипов("Строка"));
		КонецЦикла;
	КонецЕсли;
	Для Счетчик = НомерПервойСтроки По ВсегоСтрок Цикл
		НоваяСтрока = ТЗ.Добавить();
	КонецЦикла;
	
	Область = ЛистЭксель.Range(ЛистЭксель.Cells(НомерПервойСтроки,НомерПервойКолонки), ЛистЭксель.Cells(ВсегоСтрок,ВсегоКолонок));
	//Данные = Область.Value.Выгрузить();
	Данные = Область[СчитываемыйОбъект].Выгрузить();
	
	
	//Для Счетчик = 0 По ВсегоКолонок-1 Цикл
	Для Счетчик = 0 По КоличествоКолонок-1 Цикл
		ТЗ.ЗагрузитьКолонку(Данные[Счетчик], Счетчик);
	КонецЦикла;
	ЛистЭксель = Неопределено;
	Возврат ТЗ;
КонецФункции


&НаСервере
Процедура ЗагрузитьНаСервере(пИмяФайла, пДополнительныеПараметры)


	
	
	// 1 последовательный обход
	ФайлCML = Новый ТекстовыйДокумент;
	ФайлCML.Прочитать(пИмяФайла);
	
	

	ЧтениеXML = Новый ЧтениеXML(); 
	ЧтениеXML.УстановитьСтроку(ФайлCML.ПолучитьТекст()); 
	
	Если ВозможностьЧтенияXML(ЧтениеXML) Тогда 
		Данные = ПрочитатьXML(ЧтениеXML); 	
		Данные.Записать(); 
	КонецЕсли; 
	
	
	//СтрокаCML = ФайлCML.ПолучитьТекст();
	//ДеревоЗапчастей = РазобратьCML(СтрокаCML);

	//2
	//ОбходXML_XTDO_рекурсивно(СтрокаCML);
	
	//3
	//ОбходДереваDOM(пИмяФайла);

	
	//ОбработкаТаблицыФайла(ДеревоЗапчастей, пДополнительныеПараметры);


КонецПроцедуры

&НаСервере
Процедура ОбходXML_XTDO_рекурсивно(Знач СтрокаCML)
	
	Перем ДеревоЗн;
	
	ДеревоЗн=Новый ДеревоЗначений;
	ПоместитьВДерево(СтрокаCML,ДеревоЗн);

КонецПроцедуры

&НаСервере
Процедура ОбходДереваDOM(Знач пИмяФайла)
	
	Перем ДокументDOM, ПостроительDOM, РеквизитАтрибутЗначение, РеквизитАтрибутИмя, ТекстРеквизита, ТекстСправочника, ЧтениеXML, ЭлементРеквизит, ЭлементСправочник;
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(пИмяФайла);
	ПостроительDOM = Новый ПостроительDOM;
	ДокументDOM = ПостроительDOM.Прочитать(ЧтениеXML);
	
	// Простой обход дерева
	Для Каждого ЭлементСправочник Из ДокументDOM.ЭлементДокумента.ДочерниеУзлы Цикл
		Если ЭлементСправочник.ТипУзла <> ТипУзлаDOM.Элемент Тогда
			Продолжить;
		КонецЕсли;
		
		//Если ЭлементСправочник.ИмяУзла <> "Справочник" Тогда
		//	Продолжить;
		//КонецЕсли;
		
		Для Каждого ЭлементРеквизит Из ЭлементСправочник.ДочерниеУзлы Цикл
			Если ЭлементРеквизит.ТипУзла = ТипУзлаDOM.Текст Тогда  
				ТекстСправочника = ЭлементРеквизит.ЗначениеУзла;
			ИначеЕсли  ЭлементРеквизит.ТипУзла = ТипУзлаDOM.Элемент Тогда
				Если ЭлементРеквизит.ИмяУзла = "Реквизит" Тогда 
					ТекстРеквизита = ЭлементРеквизит.ТекстовоеСодержимое;
					РеквизитАтрибутИмя = ЭлементРеквизит.ПолучитьАтрибут("Имя");
					РеквизитАтрибутЗначение = ЭлементРеквизит.ПолучитьАтрибут("Значение");
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		
	КонецЦикла;

КонецПроцедуры


// загрузка ///////////////////////////////////////////



// Чтение из файла//////////////////////////////////

&НаСервере
Процедура ОбработкаТаблицыФайла(пДзИзФайла,   пДополнительныеПараметры)

	 Отказ=Ложь;
	 
		 
	 ТзЗапчастей=Новый ТаблицаЗначений;
	 ТзЗапчастей.Колонки.Добавить("Запчасть", Новый ОписаниеТипов("Строка",,,,Новый КвалификаторыСтроки(100)));
	 
	 // создадим Тз артикулов з/ч
	 Для Каждого СтрокаДз из пДзИзФайла.Строки Цикл
		 
		 Для Каждого ДетальнаяСтрокаДз из СтрокаДз.Строки Цикл
			 
			  НоваяСтрокаТЗ=ТзЗапчастей.Добавить();
			  НоваяСтрокаТЗ.Запчасть=ДетальнаяСтрокаДз.Запчасть;
			  
		 КонецЦикла;	 
		 
	 КонецЦикла;	 
	 
	ТзЗапчастей.Свернуть("Запчасть");
	
	// найдем наменклатуру по арт.
	ДобавитьКолонкуНоменклатура_в_ТзФайла(ТзЗапчастей, НайтиСсылкуПоРеквизиту(ТзЗапчастей, "Номенклатура", "Запчасть", "Артикул", Отказ));
	
	ТзЗапчастей.Колонки.Добавить("Колонка4",,"Модель");    
	ТзЗапчастей.Колонки.Добавить("Колонка3",,"Направление");    
	ТзЗапчастей.Колонки.Добавить("Колонка2",,"Год");    
	
	Для Каждого СтрокаДз из пДзИзФайла.Строки Цикл
		
		Для Каждого ДетальнаяСтрокаДз из СтрокаДз.Строки Цикл
			
			МассивСтрокаТз=ТзЗапчастей.НайтиСтроки(Новый Структура("Запчасть", ДетальнаяСтрокаДз.Запчасть));
			
			Для Каждого СтрокаТз из МассивСтрокаТз Цикл
				
				СтрокаТз.Колонка4=Строка(СтрокаТз.Колонка4)+" "+ДетальнаяСтрокаДз.Мотоцикл;
				
			КонецЦикла;	
			
		КонецЦикла;	 
		
	КонецЦикла;	
	
	//ТзЗапчастей.вЫБРАТЬсТРОКУ();
	
	ДобавитьДанныеИзФайла_в_Номенклатуру(ТзЗапчастей, пДополнительныеПараметры);
 
КонецПроцедуры


&НаСервере
Процедура ДобавитьДанныеИзФайла_в_Номенклатуру(пТаблицаИзФайла, пДополнительныеПараметры)
	
	//СвВоМодель=ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.НайтиПоНаименованию("МОДЕЛЬНЫЙ РЯД");
	//СвВоНаправление=ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.НайтиПоНаименованию("НАПРАВЛЕНИЕ");
	//СвВоГод=ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.НайтиПоНаименованию("ГОД");
	
	ТзСвойств=ПолучитьТзСвВ(пДополнительныеПараметры.НаборСвойств);
	
	СвВоМодель=НайтиСвоВо(ТзСвойств, "МОДЕЛЬНЫЙ РЯД (Тюнинг)");	
	СвВоНаправление=НайтиСвоВо(ТзСвойств, "НАПРАВЛЕНИЕ (Тюнинг)");	
	СвВоГод=НайтиСвоВо(ТзСвойств, "ГОД (Тюнинг)");	
	
	Для Каждого СтрокаТз из пТаблицаИзФайла Цикл
		
		Если Не ЗначениеЗаполнено(СтрокаТз.Номенклатура) Тогда
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = "Не заполнен товар "+ Строка(СтрокаТз.Запчасть);
			Сообщение.Сообщить();
			Продолжить;
		КонецЕсли;	
		
		ОбъектНоменклатура=СтрокаТз.Номенклатура.ПолучитьОбъект();
		ДобавитьСвойство( СтрокаТз.Колонка4,  ОбъектНоменклатура,  СвВоМодель);
		ДобавитьСвойство( СтрокаТз.Колонка3,  ОбъектНоменклатура,  СвВоНаправление);
		ДобавитьСвойство( СтрокаТз.Колонка2,  ОбъектНоменклатура,  СвВоГод);
		
		Попытка
			
			ОбъектНоменклатура.записать();
			
		Исключение
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = ОписаниеОшибки();
			Сообщение.Сообщить();
			
		КонецПопытки;
		
		
	КонецЦикла;	

	
КонецПроцедуры


Функция ПолучитьТзСвВ(пНаборСвойств)

	    	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДополнительныеРеквизитыИСведения.Ссылка,
		|	ДополнительныеРеквизитыИСведения.Наименование
		|ИЗ
		|	ПланВидовХарактеристик.ДополнительныеРеквизитыИСведения КАК ДополнительныеРеквизитыИСведения
		|ГДЕ
		|	ДополнительныеРеквизитыИСведения.НаборСвойств = &НаборСвойств";
	
	Запрос.УстановитьПараметр("НаборСвойств", пНаборСвойств);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	
	Возврат  РезультатЗапроса.Выгрузить();

КонецФункции // ПолучитьТзСвВ()


Функция НайтиСвоВо(пТз, пНаименование)

	СтрокаТз=НайтиСтрокуТабЧасти(пТз, Новый Структура("Наименование",пНаименование));
	
	Если СтрокаТз=Неопределено Тогда
		Возврат Неопределено;
	Иначе
		Возврат СтрокаТз.ССылка
	КонецЕсли;

КонецФункции // НайтиСвоВо()


&НаСервере
Процедура ДобавитьСвойство( ЗначениеСвойства,  ОбъектСправочник,  СвВо)
	
	Если СвВо=ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.ПустаяСсылка() или СвВо=Неопределено  Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Не найдено свВо "+строка(ЗначениеСвойства);
		Сообщение.Сообщить();
		Возврат;
	КонецЕсли;	

	
	НайденоСвВо=Ложь;
	
	Для Каждого СтрокаДопСвВо из ОбъектСправочник.ДополнительныеРеквизиты Цикл
		
		Если СтрокаДопСвВо.Свойство=СвВо Тогда
			
			СтрокаДопСвВо.Значение=ЗначениеСвойства;
			
			НайденоСвВо=Истина;
			
		КонецЕсли;	
		
	КонецЦикла;	
	
	
	
	Если Не НайденоСвВо Тогда
		
		//Сообщение = Новый СообщениеПользователю;
		//Сообщение.Текст = "Свойство будет добавлено в табл. часть магазина "+строка(СвВо);
		//Сообщение.Сообщить();
		
		НоваяСтрока=ОбъектСправочник.ДополнительныеРеквизиты.Добавить();
		НоваяСтрока.Свойство=СвВо;
		НоваяСтрока.Значение=ЗначениеСвойства;
	КонецЕсли;
	
КонецПроцедуры



&НаСервере
// Позволяет определить есть ли среди реквизитов табличной части документа
// реквизит с переданным именем.
//
// Параметры: 
//  ИмяРеквизита - строковое имя искомого реквизита, 
//  МетаданныеДокумента - объект описания метаданных документа, среди реквизитов которого производится поиск.
//  ИмяТабЧасти  - строковое имя табличной части документа, среди реквизитов которого производится поиск
//
// Возвращаемое значение:
//  Истина - нашли реквизит с таким именем, Ложь - не нашли.
//
Функция ЕстьРеквизитТабЧастиДокумента(ИмяРеквизита, МетаданныеДокумента, ИмяТабЧасти) Экспорт

	ТабЧасть = МетаданныеДокумента.ТабличныеЧасти.Найти(ИмяТабЧасти);
	Если ТабЧасть = Неопределено Тогда // Нет такой таб. части в документе
		Возврат Ложь;
	Иначе
		Если ТабЧасть.Реквизиты.Найти(ИмяРеквизита) = Неопределено Тогда
			Возврат Ложь;
		Иначе
			Возврат Истина;
		КонецЕсли;
	КонецЕсли;

КонецФункции // ЕстьРеквизитТабЧастиДокумента()

&НаСервере
Процедура ИменоватьКолонкиТз(пТзИзФайла,  пКолонкаЦены)

	Для Каждого КолонкаТз из пТзИзФайла.Колонки Цикл
		
		
		Если Нрег(пТзИзФайла[0][КолонкаТз.имя])=НреГ("Наименование") Тогда
			
			пТзИзФайла.Колонки[КолонкаТз.имя].Имя="Наименование";
			Прервать;
		КонецЕсли;	
		
	КонецЦикла;	

	
	//Если ЗначениеЗаполнено(пКолонкаКоличество) Тогда
	//	пТзИзФайла.Колонки[пКолонкаКоличество-1].Имя="Количество"
	//КонецЕсли;	
	
	Если ЗначениеЗаполнено(пКолонкаЦены) Тогда
		пТзИзФайла.Колонки[пКолонкаЦены-1].Имя="Цена"
	КонецЕсли;	
	
	
	пТзИзФайла.Удалить(пТзИзФайла[0]);
	
	КоличествоСтрок=пТзИзФайла.количество()-1;
	
	Для i=0 По КоличествоСтрок Цикл
		пТзИзФайла[КоличествоСтрок-i].Наименование=СтрЗаменить(Строка(пТзИзФайла[КоличествоСтрок-i].Наименование), Символ(160), "");
		
		Если НЕ ЗначениеЗаполнено(пТзИзФайла[КоличествоСтрок-i].Наименование) Тогда
			  пТзИзФайла.Удалить(пТзИзФайла[КоличествоСтрок-i]);
		КонецЕсли;	
	
	КонецЦикла; 
	
КонецПроцедуры



Процедура ДобавитьКолонкуНоменклатура_в_ТзФайла(пТзИзФайла, пТзСсылок)

	 пТзИзФайла.Колонки.Добавить("Номенклатура");
	
	 Для каждого СтрокаТЗ Из пТзИзФайла Цикл
	 
		
		СтрокаТзСсылок=НайтиСтрокуТабЧасти(пТзСсылок, Новый Структура("ЗначениеПоиска", СтрокаТЗ.Запчасть));
		
		Если  СтрокаТзСсылок<>Неопределено Тогда
			
			СтрокаТЗ.Номенклатура= СтрокаТзСсылок.Ссылка;
			
			//СнятьПометкуУдаления(СтрокаТЗ.Номенклатура)

			
		КонецЕсли;	
		
	 КонецЦикла;

КонецПроцедуры


Процедура СнятьПометкуУдаления(пНоменклатураСсылка)
	//пНоменклатураСсылка=Справочники.Номенклатура.ПустаяСсылка();
	
	Если пНоменклатураСсылка.ПометкаУдаления Тогда
		ОбъектНоменклатура=пНоменклатураСсылка.получитьобъект();
		ОбъектНоменклатура.ПометкаУдаления=Ложь;
		ОбъектНоменклатура.Записать();
	КонецЕсли;	

КонецПроцедуры


&НаСервере
// Функция выполняет поиск первой, удовлетворяющей условию поика, строки табличной части.
//
// Параметры:
//  ТабличнаяЧасть - табличная часть документа, в которой осуществляется поиск,
//  СтруктураОтбора - структура - задает условие поиска.
//
// Возвращаемое значение: 
//  Строка табличной части - найденная строка табличной части,
//  Неопределено           - строка табличной части не найдена.
//
Функция НайтиСтрокуТабЧасти(ТабличнаяЧасть, СтруктураОтбора) Экспорт

	СтрокаТабличнойЧасти = Неопределено;
	МассивНайденныхСтрок = ТабличнаяЧасть.НайтиСтроки(СтруктураОтбора);
	Если МассивНайденныхСтрок.Количество() > 0 Тогда

		// Нашли. Вернем первую найденную строку.
		СтрокаТабличнойЧасти = МассивНайденныхСтрок[0];
	КонецЕсли;

	Возврат СтрокаТабличнойЧасти;

КонецФункции // НайтиСтрокуТабЧасти()


&НаСервере
// Ф-ия возращает Тз с колонками:
// Ссылка - спр. ,
// ЗначениеПоиска - строка - значение по которому ищем в спр-ке
// Параметры: 
// пТзЗначенийПолейДляПоиска Тз - с колонками пИмяПоляДляПоиска, список значений по которому ищмем в спр-ке 
// пИмяСправочника - строка - Имя таблицы справочника, в котором ищем  
// пИмяПоляДляПоиска - строка - имя колонки в  пТзЗначенийПолейДляПоиска по которой ищем
// пИмяРеквизита - строк - имя реквизита в справочнике с которым сраниваем значение из колонки ТЗ  пИмяПоляДляПоиска
Функция НайтиСсылкуПоРеквизиту(пТзЗначенийПолейДляПоиска, пИмяСправочника, пИмяПоляДляПоиска , пИмяРеквизита, Отказ)  Экспорт 
	
	
	Запрос=Новый Запрос;

	Отбор=Новый Структура("Ссылка",Null);
	
	
	
	Запрос.Текст=   "ВЫБРАТЬ РАЗЛИЧНЫЕ
	   |	Номенклатура.Ссылка,
	   |	Номенклатура."+пИмяРеквизита+" как ЗначениеПоиска
	   |ИЗ
	   |	Справочник.Номенклатура КАК Номенклатура
	   |ГДЕ
	   |	Номенклатура.Артикул В(&МассивЗначенийДляПоиска)";
	
	////  проверка наименований товаров---------------------------------------
	//Запрос.Текст="ВЫБРАТЬ
	//             |	ВнешнийИсточник."+пИмяПоляДляПоиска+"
	//             |ПОМЕСТИТЬ ВнешнийИсточник
	//             |ИЗ
	//             |	&ВнешнийИсточник КАК ВнешнийИсточник
	//			 //|ГДЕ
	//			 //|	ВнешнийИсточник.Наименование <> &ПустаяСтрока
	//             |;
	//             |
	//             |////////////////////////////////////////////////////////////////////////////////
	//             |ВЫБРАТЬ
	//             |	Номенклатура.Ссылка,
	//             |	ВнешнийИсточник."+пИмяПоляДляПоиска+" как ЗначениеПоиска 
	//             |ИЗ
	//             |	ВнешнийИсточник КАК ВнешнийИсточник
	//             |		ЛЕВОЕ СОЕДИНЕНИЕ Справочник."+пИмяСправочника+" КАК Номенклатура
	//             |		ПО (ВнешнийИсточник."+пИмяПоляДляПоиска+" ПОДОБНО Номенклатура."+пИмяРеквизита+")
	//             |;
	//             |
	//             |////////////////////////////////////////////////////////////////////////////////
	//             |УНИЧТОЖИТЬ ВнешнийИсточник";

	
	Запрос.УстановитьПараметр("ВнешнийИсточник",пТзЗначенийПолейДляПоиска);
	Запрос.УстановитьПараметр("МассивЗначенийДляПоиска",пТзЗначенийПолейДляПоиска.ВыгрузитьКолонку(пИмяПоляДляПоиска));
	Запрос.УстановитьПараметр("ПустаяСтрока","");
	
	Тз=Запрос.Выполнить().Выгрузить();

	  
	Если Тз.Количество()=0 Тогда
		Сообщение="Не найден ни один элемент из справочника "+пИмяСправочника;
		СообщитьСерв(Сообщение, ЭтаФорма);
		Отказ=Истина;
	КонецЕсли;  
	 	  
	  	  
	МассивОшибок=Тз.НайтиСтроки(Отбор);
	
	
	//Для Каждого Элемент ИЗ МассивОшибок Цикл
	//	Сообщение="Не найдено элемент в справочнике "+пИмяСправочника+" "+Элемент.ЗначениеПоиска;
	//	СообщитьСерв(Сообщение, ЭтаФорма);
	//	Тз.Удалить(Элемент);
	//	Отказ=Истина;
	//КонецЦикла;  
	  

	Возврат Тз;
	
	
КонецФункции // НайтиНоменклатураПоНаименованию()


// Чтение из файла ///////////////////////////////////
Функция РазобратьCML(СтрокаCML)
	
	Успешно = Истина;
	
	ОбъектCML = Новый ЧтениеXML;
	
	Попытка
		ОбъектCML.УстановитьСтроку(СтрокаCML);
	Исключение
		СообщитьОбИсключительнойОшибке(Ложь);
		Возврат Неопределено;
	КонецПопытки;
	
	ПоследовательностьЭлементов = "";
	
	ДеревоЗапчастей = Новый ДеревоЗначений;
	
	ДеревоЗапчастей.Колонки.Добавить("Мотоцикл");
	ДеревоЗапчастей.Колонки.Добавить("Запчасть");
		
	Пока Истина Цикл
		
		ОчереднойУзелCMLПрочитан = Ложь;
		
		Попытка
			ОчереднойУзелCMLПрочитан = ОбъектCML.Прочитать();
		Исключение
			Успешно = Ложь;
			СообщитьОбИсключительнойОшибке(Ложь);
			Прервать;
		КонецПопытки;	
		
		Если НЕ ОчереднойУзелCMLПрочитан Тогда
			Прервать;
		КонецЕсли;	
		
		ТипУзла = ОбъектCML.ТипУзла;
		ИмяУзла = ОбъектCML.Имя;
		
		Если ТипУзла = ТипУзлаXML.НачалоЭлемента Тогда
			
			ПоследовательностьЭлементов = ДобавитьЭлементКПоследовательности(ПоследовательностьЭлементов, ИмяУзла);
			Успешно = ОбработатьНачалоЭлемента(ОбъектCML, ПоследовательностьЭлементов, ДеревоЗапчастей);
			Если НЕ Успешно Тогда
				СообщитьПользователю("Не удалось обработать начало элемента (" + ПоследовательностьЭлементов + ").", Ложь);
				Прервать;
			КонецЕсли;	
			
		ИначеЕсли ТипУзла = ТипУзлаXML.КонецЭлемента Тогда

			ПоследовательностьЭлементов = УдалитьПоследнийЭлементИзПоследовательности(ПоследовательностьЭлементов);
			
		ИначеЕсли ТипУзла = ТипУзлаXML.Текст Тогда	
			
			ЗначениеЭлемента = ОбъектCML.Значение;  
			Успешно = ОбработатьЗначениеЭлемента(ПоследовательностьЭлементов, ЗначениеЭлемента, ДеревоЗапчастей);
			Если НЕ Успешно Тогда
				СообщитьПользователю("Не удалось обработать значение элемента (" + ПоследовательностьЭлементов + ") = (" + ЗначениеЭлемента + ").", Ложь);
				Прервать;
			КонецЕсли;	
			
		КонецЕсли;
		
		
		
	КонецЦикла;
	
	ОбъектCML.Закрыть();
	
	Если НЕ Успешно Тогда
		ДеревоЗапчастей = Неопределено;
	КонецЕсли;	
	
	//ДеревоЗапчастей.ВыбратьСтроку();
	
    Кол=ДеревоЗапчастей.Строки.количество()-1;
	
	Для i=0 по Кол Цикл
		
		ТекСтрока=ДеревоЗапчастей.Строки[Кол-i];
		
		Если ТекСтрока.Строки.Количество()=0 Тогда
			ДеревоЗапчастей.Строки.Удалить(ТекСтрока);
		КонецЕсли;	
		
	КонецЦикла;	
	
	Возврат ДеревоЗапчастей;
	
КонецФункции	

Функция ДобавитьЭлементКПоследовательности(Знач ПоследовательностьЭлементов, Знач ИмяУзла)
	
	ИсключатьИзПоследовательности = Новый Массив;
	ИсключатьИзПоследовательности.Добавить("КоммерческаяИнформация");
	
	Если ИсключатьИзПоследовательности.Найти(ИмяУзла) = Неопределено Тогда
		
		Если НЕ ПоследовательностьЭлементов = "" Тогда
			ПоследовательностьЭлементов = ПоследовательностьЭлементов + ".";	
		КонецЕсли;	
		ПоследовательностьЭлементов = ПоследовательностьЭлементов + ИмяУзла;
		
	КонецЕсли;
	
	Возврат ПоследовательностьЭлементов;

КонецФункции	


			
Функция УдалитьПоследнийЭлементИзПоследовательности(Знач ПоследовательностьЭлементов);
	
	ПромСтрока 			= СтрЗаменить(ПоследовательностьЭлементов, ".", Символы.ПС);
	КоличествоЭлементов = СтрЧислоСтрок(ПромСтрока);
	
	ПоследовательностьЭлементов	= "";
	Если КоличествоЭлементов > 0 Тогда
		КоличествоЭлементов = КоличествоЭлементов - 1;
		Для Счетчик = 1 По КоличествоЭлементов Цикл
			ПоследовательностьЭлементов	= ПоследовательностьЭлементов + "." + СтрПолучитьСтроку(ПромСтрока, Счетчик);
		КонецЦикла;	
		ПоследовательностьЭлементов = Прав(ПоследовательностьЭлементов, СтрДлина(ПоследовательностьЭлементов) - 1);
	КонецЕсли;
	
	Возврат ПоследовательностьЭлементов;
КонецФункции	

Функция ПолучитьИмяЭлементаИзПоследовательности(Знач ПоследовательностьЭлементов)
	
	ПромСтрока 			= СтрЗаменить(ПоследовательностьЭлементов, ".", Символы.ПС);
	КоличествоЭлементов = СтрЧислоСтрок(ПромСтрока);
	
	ИмяПоследнегоЭлемента = "";
	Если КоличествоЭлементов > 0 Тогда
		ИмяПоследнегоЭлемента = СтрПолучитьСтроку(ПромСтрока, КоличествоЭлементов);
	КонецЕсли;
	
	Возврат ИмяПоследнегоЭлемента;
	
КонецФункции	

Функция ОбработатьЗначениеЭлемента(Знач ИмяЭлемента, Знач ЗначениеЭлемента, ДеревоЗапчастей);
	
	
		
	Возврат Истина;

КонецФункции

// Процедура выводит текст сообщения об исключительной ошибке
//
// Параметры:
//
Процедура СообщитьОбИсключительнойОшибке(ИнформацияОВыгрузке, ТекстНачалаСообщения =  "", ТекстОкончанияСообщения = "")
	
	РасширеннаяИнформацияОбОшибке = ИнформацияОбОшибке();
	ТекстСообщения = "";
	Если ЗначениеЗаполнено(ТекстНачалаСообщения) Тогда
		ТекстСообщения = ТекстНачалаСообщения + Символы.ПС;
	КонецЕсли;	
	ТекстСообщения = ТекстСообщения
				   + "Произошла ошибка: "
				   + РасширеннаяИнформацияОбОшибке.Описание;
	
	Если НЕ Строка(РасширеннаяИнформацияОбОшибке.Причина) = "ИнформацияОбОшибке" Тогда
		ТекстСообщения = ТекстСообщения
					   + ". По причине: "
					   + РасширеннаяИнформацияОбОшибке.Причина;
	КонецЕсли;	
	
	ТекстСообщения = ТекстСообщения + Символы.ПС + ТекстОкончанияСообщения;
	
	Сообщение = Новый СообщениеПользователю;
 Сообщение.Текст = ТекстСообщения;
 Сообщение.Сообщить();
	
КонецПроцедуры	

Функция ОбработатьНачалоЭлемента(ОбъектCML, Знач ИмяЭлемента, ДеревоЗапчастей);
	
	Успешно = Истина;
	
	ТекущаяСтрокаДерева  	  = Неопределено;
	ТекущаяСтрокаТоваровУслуг = Неопределено;
	
	КоличествоДокументов 	  = ДеревоЗапчастей.Строки.Количество();
	
	Если КоличествоДокументов > 0 Тогда
		ТекущаяСтрокаДерева    = ДеревоЗапчастей.Строки[КоличествоДокументов - 1];
	КонецЕсли;	
	
	Если ИмяЭлемента="CMPDN.ROOT_PRODUKTE.PRODUKT.BEZIEHUNGEN.BEZIEHUNGSTYP.PRODUKT" Тогда
		Если ОбъектCML.КоличествоАтрибутов() > 0 Тогда
			Пока ОбъектCML.ПрочитатьАтрибут() Цикл
				Если ОбъектCML.Имя = "name" Тогда
					НомерМодели = ОбъектCML.Значение;

					МассивСтрок= ДеревоЗапчастей.Строки.НайтиСтроки(Новый Структура("Мотоцикл", НомерМодели)); 
					
					Если МассивСтрок=Неопределено или МассивСтрок.Количество()=0 Тогда
						НовСтрокаДерева 			   = ДеревоЗапчастей.Строки.Добавить();
						НовСтрокаДерева.Мотоцикл = НомерМодели;
					КонецЕсли;
				КонецЕсли;	
			КонецЦикла
		КонецЕсли;
	КонецЕсли;

	Если ИмяЭлемента="CMPDN.ROOT_PRODUKTE.PRODUKT" Тогда     // новые мотоциклы дорожные 
		Если ОбъектCML.КоличествоАтрибутов() > 0 Тогда
			Пока ОбъектCML.ПрочитатьАтрибут() Цикл
				Если ОбъектCML.Имя = "name" Тогда
					НомерМодели = ОбъектCML.Значение;
					
					МассивСтрок= ДеревоЗапчастей.Строки.НайтиСтроки(Новый Структура("Мотоцикл", НомерМодели)); 
					
					Если МассивСтрок=Неопределено или МассивСтрок.Количество()=0 Тогда
						НовСтрокаДерева 			   = ДеревоЗапчастей.Строки.Добавить();
						НовСтрокаДерева.Мотоцикл = НомерМодели;
					КонецЕсли;
				КонецЕсли;	
			КонецЦикла
		КонецЕсли;
	КонецЕсли;

	
	
	
	
	Если ИмяЭлемента="CMPDN.ROOT_PRODUKTE.PRODUKT.BEZIEHUNGEN.BEZIEHUNGSTYP.PRODUKT.RELATEDARTICLES.RELATEDARTICLE" Тогда
		Если ОбъектCML.КоличествоАтрибутов() > 0 Тогда
			Пока ОбъектCML.ПрочитатьАтрибут() Цикл
				Если ОбъектCML.Имя = "name" Тогда
					НомерЗапчасти = ОбъектCML.Значение;
					НовСтрокаДерева 			   = ТекущаяСтрокаДерева.Строки.Добавить();
					НовСтрокаДерева.Запчасть = НомерЗапчасти;
					НовСтрокаДерева.Мотоцикл=ТекущаяСтрокаДерева.Мотоцикл;
				КонецЕсли;	
			КонецЦикла
		КонецЕсли;
	КонецЕсли;

	
	Если ИмяЭлемента="CMPDN.ROOT_PRODUKTE.PRODUKT.BEZIEHUNGEN.BEZIEHUNGSTYP.PRODUKT" Тогда          // з/ч к  новым мотоциклы дорожные 
		Если ОбъектCML.КоличествоАтрибутов() > 0 Тогда
			Пока ОбъектCML.ПрочитатьАтрибут() Цикл
				Если ОбъектCML.Имя = "name" Тогда
					НомерЗапчасти = ОбъектCML.Значение;
					НовСтрокаДерева 			   = ТекущаяСтрокаДерева.Строки.Добавить();
					НовСтрокаДерева.Запчасть = НомерЗапчасти;
					НовСтрокаДерева.Мотоцикл=ТекущаяСтрокаДерева.Мотоцикл;
				КонецЕсли;	
			КонецЦикла
		КонецЕсли;
	КонецЕсли;

	
	
		
	Возврат Успешно;
	
КонецФункции  

Процедура СообщитьПользователю(Текст, текст2="")
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = Текст;
	Сообщение.Сообщить();

	

КонецПроцедуры



Процедура ПоместитьВДерево(Текст, Дерево)
	Чтение = Новый ЧтениеXML;
	Чтение.УстановитьСтроку(Текст);
	Об = ФабрикаXDTO.ПрочитатьXML(Чтение);
	
	Строка = Дерево.ПолучитьЭлементы().Добавить();
	Строка.Узел = "Корневой узел";
	ПрочитатьУзел(Об, Строка);
КонецПроцедуры

Процедура ПрочитатьУзел(Об, лДерево)
	Если ТипЗнч(Об) = Тип("СписокXDTO") Тогда 
		Для Каждого Ст ИЗ Об Цикл
			Строка = лДерево.ПолучитьЭлементы().Добавить();
			Строка.Узел = Об.ВладеющееСвойство;
			Если ТипЗнч(Ст) = Тип("СписокXDTO") ИЛИ ТипЗнч(Ст) = Тип("ОбъектXDTO") Тогда
				ПрочитатьУзел(Ст, Строка);
			Иначе
				Строка.Элемент = Ст;
			КонецЕсли;
		КонецЦикла;
	Иначе
		Для Каждого Ст ИЗ Об.Свойства() Цикл
			Строка = лДерево.ПолучитьЭлементы().Добавить();
			Строка.Узел = Ст.Имя;
			Если ТипЗнч(Об[Ст.Имя]) = Тип("СписокXDTO") ИЛИ ТипЗнч(Об[Ст.Имя]) = Тип("ОбъектXDTO") Тогда
				ПрочитатьУзел(Об[Ст.Имя], Строка);
			Иначе
				Строка.Элемент = Об[Ст.Имя];
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция РасширениеФайла(Знач ИмяФайла)
	
	ПозицияТочки = ПоследнийРазделитель(ИмяФайла);
	
	Расширение = Прав(ИмяФайла,СтрДлина(ИмяФайла) - ПозицияТочки + 1);
	
	Возврат Расширение;
	
КонецФункции


&НаСервере
Функция ПоследнийРазделитель(СтрокаСРазделителем, Разделитель = ".")
	
	ДлинаСтроки = СтрДлина(СтрокаСРазделителем);
	
	Пока ДлинаСтроки > 0 Цикл
		
		Если Сред(СтрокаСРазделителем, ДлинаСтроки, 1) = Разделитель Тогда
			
			Возврат ДлинаСтроки; 
			
		КонецЕсли;
		
		ДлинаСтроки = ДлинаСтроки - 1;
		
	КонецЦикла;

КонецФункции

//////////// Обработчки элементов формы  ///////////////////////////////////////


// выбор файла
&НаКлиенте
Процедура ВыборФайла(Элемент, ПроверятьСуществование=Ложь)

	

	ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	
	ДиалогВыбора.Фильтр     = "Файл данных xml (*.xml)";
	ДиалогВыбора.Расширение = "xml";
	
	ДиалогВыбора.Заголовок ="Выберите файл для загрузки данных ";
	
	ДиалогВыбора.ПредварительныйПросмотр     = Ложь;
	ДиалогВыбора.ИндексФильтра               = 0;
	ДиалогВыбора.ПроверятьСуществованиеФайла = ПроверятьСуществование;
	//ДиалогВыбора.ПолноеИмяФайла				=	Элемент.Значение;
	
	
	Если ДиалогВыбора.Выбрать() Тогда
		//Элемент = ДиалогВыбора.ПолноеИмяФайла;
		ИмяФайла= ДиалогВыбора.ПолноеИмяФайла;
	КонецЕсли;			
	


КонецПроцедуры // ВыборФойла()

&НаКлиенте
Процедура ИмяФайлаОткрытие(Элемент, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	ЗапуститьПриложение(ИмяФайла);
	СтандартнаяОбработка = Ложь;

КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	ВыборФайла(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаПриИзменении(Элемент)
	// Вставить содержимое обработчика.
	ВыборФайла(Элемент);
КонецПроцедуры
// выбор файла



//////////// Обработчки элементов формы  ///////////////////////////////////////

///Вспомогательные ф-ии/////////////////////////

&НаСервере
Процедура СообщитьСерв(пСтрокаСообщения, пОбъект)

	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = пСтрокаСообщения;
	//Сообщение.Поле = "";
	//Сообщение.КлючДанных=пОбъект.ссылка;
	Сообщение.УстановитьДанные(пОбъект);
	Сообщение.Сообщить();
	

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
  //  //Вставить содержимое обработчика
  //   Сообщение = Новый СообщениеПользователю;
  //Сообщение.Текст = Строка(ВладелецФормы.Объект.Дата);
  ////Сообщение.Поле = "";
  //Сообщение.УстановитьДанные(ЭтаФорма);
  //Сообщение.Сообщить();
  //Документ=ВладелецФормы.Объект;
КонецПроцедуры


///Вспомогательные ф-ии/////////////////////////



&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("ОбъектыНазначения") тогда
		Документ = Параметры.ОбъектыНазначения[0];
		
		//Сообщение = Новый СообщениеПользователю;
		//Сообщение.Текст = Строка(Документ);
		////Сообщение.Поле = "";
		//Сообщение.УстановитьДанные(ЭтаФорма);
		//Сообщение.Сообщить();

	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ВыгрузитьНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура Выгрузить(Команда)
	Структура = ВыгрузитьДанные();
    ПолучитьФайл(Структура.Адрес,Структура.Имя);
КонецПроцедуры

&НаСервере
Функция ВыгрузитьДанные()
	
    Файл=Новый Файл(ПолучитьИмяВременногоФайла("xml"));

	
    Запрос = Новый Запрос;
    Запрос.Текст = 
	        "ВЫБРАТЬ
	 |	ШтрихкодыНоменклатуры.Штрихкод КАК Штрихкод,
	 |	ШтрихкодыНоменклатуры.Номенклатура КАК Номенклатура,
	 |	ШтрихкодыНоменклатуры.Характеристика КАК Характеристика,
	 |	ШтрихкодыНоменклатуры.Упаковка КАК Упаковка
	 |ИЗ
	 |	РегистрСведений.ШтрихкодыНоменклатуры КАК ШтрихкодыНоменклатуры";
    
    
    Выборка = Запрос.Выполнить().Выбрать();
	
	ЗаписьXML=Новый ЗаписьXML(); 
	ЗаписьXML.ОткрытьФайл(Файл.ПолноеИмя); 
	ЗаписьXML.ЗаписатьНачалоЭлемента("Root"); 

	
	пока Выборка.Следующий() Цикл
		
		
		Набор = РегистрыСведений.ШтрихкодыНоменклатуры.СоздатьНаборЗаписей();
		Набор.Отбор.Штрихкод.Установить(Выборка.Штрихкод);
		Набор.Прочитать();
		
		ЗаписатьXML(ЗаписьXML, Набор);
		
		//ЗаписьXML.Закрыть();
		
	КонецЦикла;	
	
	
	ЗаписьXML.ЗаписатьКонецЭлемента(); 
	ЗаписьXML.Закрыть();
	
	//ТекстСообщения = ЗаписьXML.Закрыть(); 
	//
	//Текст = Новый ТекстовыйДокумент; 
	//Текст.УстановитьТекст(ТекстСообщения); 
	//Текст.Записать(Файл.ПолноеИмя); 
	
	//БД = Новый XBase;
	//БД.Поля.Добавить("CODE", "S", "32");
	//БД.Поля.Добавить("SUMMA", "N", "16", "2");
	//БД.поля.Добавить("FIO", "S", "40");
    
	//ИмяТемпФайла=СтрЗаменить(Файл.ПолноеИмя,Файл.Имя,"")+Лев(Файл.ИмяБезРасширения,8)+Файл.Расширение;
    
     
    ДД = Новый ДвоичныеДанные(Файл.ПолноеИмя);
    Адрес=ПоместитьВоВременноеХранилище(ДД);
    
    возврат Новый Структура("Адрес,Имя",Адрес,Файл.ПолноеИмя);
    
КонецФункции


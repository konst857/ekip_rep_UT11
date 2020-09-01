﻿
Процедура КнопкаВыполнитьНажатие(Кнопка)
	
	ТабДок=Новый ТабличныйДокумент;
	
	мПрочитатьТабличныйДокументИзCalc(ТабДок,ПутьДоФайла);
	
	ТабДок.Показать();
	
	Возврат;
	
	Если НЕ ЗначениеЗаполнено(ПутьДоФайла) Тогда
		Сообщение="Не выбран файл";
		#Если Клиент Тогда
			Сообщить(Сообщение);
		#КонецЕсли	
	КонецЕсли;
	ПроверкаЗаполненияПолейДиалога(ЭлементыФормы);
	МенеджерНоменклаутры=Справочники.Номенклатура;
	ТЗ=Новый ТаблицаЗначений;
	ТЗ.Колонки.Добавить("Номенклатура");
	ТЗ.Колонки.Добавить("Количество");
	ТЗ.Колонки.Добавить("ЕдиницаИзмерения");
	ТЗ.Колонки.Добавить("Коэффициент");
	ТЗ.Колонки.Добавить("Качество");
	ТЗ.Колонки.Добавить("Цена");


	НомерЛистаЕксель=?(ЗначениеЗаполнено(ЛистЕксель),ЛистЕксель,1);
     НомерКолонкиНаименование=КолонкаНаим;
	 
	Попытка
		Excel     = Новый COMОбъект("Excel.Application");
		WB         = Excel.Workbooks.Open(ПутьДоФайла);
		WS         = WB.Worksheets(НомерЛистаЕксель);
	Исключение
		#Если Клиент Тогда
			Предупреждение("Внимание! Файл не открыт."+Символы.ПС+"Попробуйте открыть и пересохранить данный файл программой Эксель.",15);
		#КонецЕсли
		Возврат;
	КонецПопытки;

	Для i=НачальнаяСтрока по КонечнаяСтрока Цикл
		ОбработкаПрерыванияПользователя(); 
		СчитывавемоеЗначениеКол=WS.Cells(i,КолонкаКол).Value;
		СчитывавемоеЗначениеКол=?(ТипЗнч(СчитывавемоеЗначениеКол)=Тип("Число"),СчитывавемоеЗначениеКол,0);
		
		Если ЗначениеЗаполнено(КолонкаЦена) Тогда
			СчитываемоеЗначениеЦена=WS.Cells(i,КолонкаЦена).Value;
			СчитываемоеЗначениеЦена=?(ТипЗнч(СчитываемоеЗначениеЦена)=Тип("Число"),СчитываемоеЗначениеЦена,0);
		КонецЕсли;
		
		
		Если СчитывавемоеЗначениеКол=0 Тогда
			Продолжить;
		КонецЕсли;
		
		
		
		СчитывавемоеЗначениеТовар=СокрЛП(Формат(WS.Cells(i,НомерКолонкиНаименование).Value,"ЧГ=0"));
		
		Если ПоНаим=0 Тогда
			СсылкаНаТовар=МенеджерНоменклаутры.НайтиПоНаименованию(СчитывавемоеЗначениеТовар,Истина);
		ИначеЕсли  ПоНаим=2 Тогда // по коду
			СсылкаНаТовар=МенеджерНоменклаутры.НайтиПоКоду(СчитывавемоеЗначениеТовар);
		Иначе    // по артикулу
			СсылкаНаТовар=МенеджерНоменклаутры.НайтиПоРеквизиту("Артикул",СчитывавемоеЗначениеТовар);
		КонецЕсли;
		
		Если НЕ(СсылкаНаТовар=МенеджерНоменклаутры.ПустаяСсылка() или СсылкаНаТовар=Неопределено) Тогда
			Если СсылкаНаТовар.ЭтоГруппа Тогда
				Продолжить;
			КонецЕсли;	
			НоваяСтрока=ТЗ.Добавить();
			НоваяСтрока.Номенклатура=СсылкаНаТовар;
			НоваяСтрока.количество=СчитывавемоеЗначениеКол;
			НоваяСтрока.ЕдиницаИзмерения=СсылкаНаТовар.ЕдиницаХраненияОстатков;
			НоваяСтрока.Коэффициент=СсылкаНаТовар.ЕдиницаХраненияОстатков.Коэффициент;
			НоваяСтрока.качество=Справочники.Качество.Новый;
			Если ЗначениеЗаполнено(КолонкаЦена) Тогда
				НоваяСтрока.цена=СчитываемоеЗначениеЦена;
			КонецЕсли;
		Иначе
			Сообщение="Не найден товар "+СчитывавемоеЗначениеТовар;
			#Если Клиент Тогда
				Сообщить(Сообщение,СтатусСообщения.Важное);
			#КонецЕсли	
		КонецЕсли;	
	КонецЦикла;	
	WB.Close();
	Excel=Неопределено;
	
		
     ЭтаФорма.Закрыть();


КонецПроцедуры





Процедура НачалоВыбораФайла(Элемент)
	ВыборФайла(Элемент);
	
	
КонецПроцедуры  // НачалоВыбораФайла()



Процедура ПутьДоФайлаНачалоВыбора(Элемент, СтандартнаяОбработка)
	НачалоВыбораФайла(Элемент)    ;
	
КонецПроцедуры

Процедура ПутьДоФайлаОткрытие(Элемент, СтандартнаяОбработка)
	ЗапуститьПриложение(Элемент.Значение);
	СтандартнаяОбработка = Ложь;
КонецПроцедуры


Процедура ВыборФайла(Элемент, ПроверятьСуществование=Ложь)
	ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	
	ДиалогВыбора.Фильтр     = "Файл данных (*.xls)|*.xls|Файл данных 07(*.xlsx)|*.xlsx";
	ДиалогВыбора.Расширение = "xls";
	
	ДиалогВыбора.Заголовок ="Выберите файл для загрузки данных ";
	
	ДиалогВыбора.ПредварительныйПросмотр     = Ложь;
	ДиалогВыбора.ИндексФильтра               = 0;
	ДиалогВыбора.ПроверятьСуществованиеФайла = ПроверятьСуществование;
	ДиалогВыбора.ПолноеИмяФайла				=	Элемент.Значение;
	
	
	Если ДиалогВыбора.Выбрать() Тогда
		Элемент.Значение = ДиалогВыбора.ПолноеИмяФайла;
	КонецЕсли;			
	
КонецПроцедуры

Функция ПроверкаЗаполненияПолейДиалога (ЭлементыФормы)   Экспорт 
	Для каждого Элемент из ЭлементыФормы Цикл
		Если ТипЗнч(Элемент)=Тип("ПолеВвода") Тогда
			Если Элемент.АвтоОтметкаНезаполненного и Не ЗначениеЗаполнено(Элемент.Значение)Тогда
				сообщение="Не заполнено поле формы "+Элемент.Имя;
				#Если Клиент Тогда
					Сообщить(Сообщение,СтатусСообщения.Важное);
				#КонецЕсли
				Возврат истина;
			КонецЕсли;	
		КонецЕсли;	
	КонецЦикла;
	Возврат ложь;
КонецФункции	

Процедура ПоНаимПриИзменении(Элемент)
	Если ПоНаим=0 Тогда
		ЭлементыФормы.НадписьКолонкаНаим.Заголовок="Колонка наименования:";
	ИначеЕсли ПоНаим=1 Тогда
		ЭлементыФормы.НадписьКолонкаНаим.Заголовок="Колонка артикул:";
	Иначе
		ЭлементыФормы.НадписьКолонкаНаим.Заголовок="Колонка код:";
     КонецЕсли;
КонецПроцедуры

Процедура ПослеВосстановленияЗначений()
Если ПоНаим=0 Тогда
	ЭлементыФормы.НадписьКолонкаНаим.Заголовок="Колонка наименования:";
ИначеЕсли ПоНаим=1 Тогда
	ЭлементыФормы.НадписьКолонкаНаим.Заголовок="Колонка артикул:";
Иначе
	ЭлементыФормы.НадписьКолонкаНаим.Заголовок="Колонка код:";
КонецЕсли;
	
	
	
	
КонецПроцедуры



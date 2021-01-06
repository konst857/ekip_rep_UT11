﻿Функция ЭксельВТаблицуЗначений(ВыбранноеИмяФайла)
	
	ТабДок=Новый ТабличныйДокумент;
	ТабДок.Прочитать(ВыбранноеИмяФайла, СпособЧтенияЗначенийТабличногоДокумента.Значение);
	
	ПостроительЗапроса=Новый ПостроительЗапроса;
	ПостроительЗапроса.ИсточникДанных=Новый ОписаниеИсточникаДанных (ТабДок.Область()); // Строкой передается имя Листа в экселе
	ПостроительЗапроса.Выполнить();
	//В файле первой строчкой должны идти названия колонок. Если этого не будет, то построитель не вернет ТЗ, т.к. не будут заданы имена колонок.
	
	РезТаб=ПостроительЗапроса.Результат.Выгрузить();  //Выбрать или еще что-нить
	Возврат РезТаб;
	
КонецФункции // ЭксельВТаблицуЗначений()



  Функция СведенияОВнешнейОбработке() Экспорт
	  
	  РегистрационныеДанные = Новый Структура;
         РегистрационныеДанные.Вставить("Наименование", "Сравнение сайт 1с");
         РегистрационныеДанные.Вставить("БезопасныйРежим", Ложь);
         РегистрационныеДанные.Вставить("Версия", "1.0");
         
         //ДополнительнаяОбработка
         //ДополнительныйОтчет
         //ЗаполнениеОбъекта
         //Отчет
         //ПечатнаяФорма
         //СозданиеСвязанныхОбъектов
         РегистрационныеДанные.Вставить("Вид", "ДополнительныйОтчет");
         
         РегистрационныеДанные.Вставить("Информация", "Сравнение сайт 1с");
         
         ///////////// команды /////////////////////////
         тзКоманд = Новый ТаблицаЗначений;
         тзКоманд.Колонки.Добавить("Идентификатор");
         тзКоманд.Колонки.Добавить("Представление");
         тзКоманд.Колонки.Добавить("Модификатор");
         тзКоманд.Колонки.Добавить("ПоказыватьОповещение");
         тзКоманд.Колонки.Добавить("Использование");
         
         строкаКоманды = тзКоманд.Добавить();
         строкаКоманды.Идентификатор = "1";
         строкаКоманды.Представление = "Сравнение сайт 1с";
         строкаКоманды.ПоказыватьОповещение = Истина;
         строкаКоманды.Использование = "ОткрытиеФормы";
         
       
         РегистрационныеДанные.Вставить("Команды", тзКоманд);
         
         
         Возврат РегистрационныеДанные;
         
     КонецФункции

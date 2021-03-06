﻿Функция СведенияОВнешнейОбработке() Экспорт
	
	РегистрационныеДанные = Новый Структура;
	
	РегистрационныеДанные.Вставить("БезопасныйРежим",Ложь);
	РегистрационныеДанные.Вставить("Вид", "ДополнительнаяОбработка");
	РегистрационныеДанные.Вставить("Наименование", "Назначение ид битрикс");
	РегистрационныеДанные.Вставить("Версия", "2.6.7.15");
	РегистрационныеДанные.Вставить("Информация", "Назначение ид битрикс");
	РегистрационныеДанные.Вставить("Назначение", РегистрационныеДанные.Наименование);
	
	ТЗКоманд = Новый ТаблицаЗначений;
	ТЗКоманд.Колонки.Добавить("Идентификатор");
	ТЗКоманд.Колонки.Добавить("Представление");
	ТЗКоманд.Колонки.Добавить("Модификатор");
	ТЗКоманд.Колонки.Добавить("ПоказыватьОповещение");
	ТЗКоманд.Колонки.Добавить("Использование");
	
	СтрокаКоманды = тзКоманд.Добавить();
	СтрокаКоманды.Идентификатор        = Новый УникальныйИдентификатор;
	СтрокаКоманды.Представление        = РегистрационныеДанные.Наименование;
	СтрокаКоманды.ПоказыватьОповещение = Истина;
	СтрокаКоманды.Использование        = "ОткрытиеФормы";
 	
	РегистрационныеДанные.Вставить("Команды", ТЗКоманд);  	
	
	Возврат РегистрационныеДанные;
	
КонецФункции

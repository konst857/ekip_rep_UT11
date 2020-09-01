#language: ru
@tree

Функционал: Загрузка приходной накладной из таблицы

Как Менеджер по закупкам
Я хочу загружать приходные накладные из табличного документа,
Чтобы ускорить процесс ввода первичных документов в базу

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Загрузка прихода 100 шт. одного товара, с идентификацией по арт. характеристики

	Дано Создаем приходную накладную, указываем поставщика и склад
	Когда я нажимаю кнопку "заполнить из файла по арт. характеристики"
	Тогда открываетеся табличное поле, содержащее следующие колонки
	"Артикул, Артикул характеристики, Цена закупки, Цена продажи, Количество, Номер ГТД, Страна Происхождения" 
	Когда я заполняю колонку "Артикул характеристики" или "Артикул"
	И когда указываю цену продажи 5000 в колонке "Цена продажи"
	И когда я указываю цену закупки 2000 в колонке "Цена закупки"
	И когда я указываю количество 100 в колонке "Количество"
	И нажимаю кнопку "Далее"
	Тогда происходит поиск характеристики и соотв. ей товара по доп. реквизиту характеристики "Артикул"
	или реквизиту "Артикул" номенклатуры
	И открывается форма с результатами поиска 
	Когда я нажимаю кнопку "установить цены продажи"
	Тогда создается документ установки цен для найденного товара с ценой равной 5000
	И Когда я нажимаю кнопку "перенести и закрыть"
	Тогда открывается форма приходной накладной с найденной характеристикой и соотв. ей товаром
	И количеством равным 100
	И суммой равной 200000
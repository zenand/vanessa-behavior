# language: ru

@IgnoreOn82Builds
@IgnoreOnOFBuilds



Функционал: Проверка редактирования поля ТЧ

Как разработчик
Я хочу чтобы поля ТЧ редактировались корректно
Чтобы генератор фич из воздуха создавал корректный текст Gherkin

Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий


Сценарий: Проверка изменения реквизита ТЧ

	Когда я удаляю все элементы Справочника "Справочник1"
	Когда я создаю fixtures по макету "Макет"
	
	Когда В панели разделов я выбираю "Основная"
	И     В панели функций я выбираю "Справочник1"
	Тогда открылось окно "Справочник1"
	И     В форме "Справочник1" в ТЧ "Список" я выбираю текущую строку
	Тогда открылось окно "Тестовый Элемент * (Справочник1)"
	И     В открытой форме я нажимаю на кнопку открытия поля с заголовком "Реквизит2"
	Тогда открылось окно "ТестовыйЭлемент21 (Справочник2)"
	И     В открытой форме я нажимаю на кнопку с заголовком "Записать и закрыть"
	Тогда открылось окно "Тестовый Элемент * (Справочник1)"
	И     В открытой форме я нажимаю на кнопку с заголовком "Записать и закрыть"

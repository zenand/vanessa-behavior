# language: ru

@IgnoreOn82Builds
@IgnoreOnOFBuilds



Функционал: Проверка парсинга фичи когда есть тег tree и используется иерархия в секции Контекст

Как разработчик
Я хочу чтобы корректно происходил парсинг фичи с включенным тегом tree, когда используется иерархия шагов в секции Контекст
Чтобы я мог иcпользовать этот тег в своих фичах

Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий


Сценарий: Проверка парсинга фичи, когда используется вертикальная черта
	Когда Я открываю VanessaBehavior в режиме TestClient
	И В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ФичаДляПроверкиРаботСекцииСценарий_Тег_tree"
	И В открытой форме я перехожу к закладке с заголовком "Библиотеки"
	И В открытой форме я нажимаю на кнопку с именем "КаталогиБиблиотекДобавить"
	И я добавляю в библиотеки строку с стандартной библиотекой "Libraries"
	И В открытой форме я нажимаю на кнопку "Перезагрузить сценарии"
	И Пауза 10
	И В открытой форме я нажимаю на кнопку "Выполнить сценарии"
	И Пауза 5
	И     таблица формы с именем "ДеревоТестов" стала равной:
		| 'Снипет'                                                                            |
		| ''                                                                                  |
		| ''                                                                                  |
		| ''                                                                                  |
		| 'ЯРазвернулВсеВеткиДереваVB()'                                                      |
		| 'ПользователюИБВключитьРоль(Парам01,Парам02)'                                       |
		| ''                                                                                  |
		| ''                                                                                  |
		| 'ЯОткрылСеансTestClientОтИмениСПаролемИлиПодключаюУжеСуществующий(Парам01,Парам02)' |
		| 'ОткрылосьОкно(Парам01)'                                                            |
		| ''                                                                                  |
		| ''                                                                                  |
		| 'ЯОткрылСеансTestClientОтИмениСПаролемИлиПодключаюУжеСуществующий(Парам01,Парам02)' |
		| 'ВПанелиРазделовЯВыбираю(Парам01)'                                                  |
	
	
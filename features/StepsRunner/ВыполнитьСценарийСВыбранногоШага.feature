﻿# language: ru

@IgnoreOnOFBuilds

Функционал: Проверка выполнения сценария с выбранного шага
	Как Разработчик
	Я Хочу чтобы я мог выполнить сецнарий с произвольного шага

	Сценарий: Выполнение одного сценария по одному шагу контекста

		Когда я открыл форму VanessaBehavoir в режиме самотестирования
		И я загрузил специальную тестовую фичу "ОдинСценарийШагКонтекста"
		И Пауза 1
		И я установил специальную служебную экспортную переменную СлужебнаяПеременная у открытого VanessaBehavoir равной 0
		И в тестируемом экземпляре я установил текущую строку дерева 5
		И в тестируемом экземпляре я нажал на кнопку "ВыполнитьОдинШаг"
		И Пауза 2
		И в тестируемом экземпляре в переменной КонтекстСохраняемый значение служебной переменной равно 1

	Сценарий: Выполнение одного сценария по одному шагу структура сценария

		Когда я открыл форму VanessaBehavoir в режиме самотестирования
		И я загрузил специальную тестовую фичу "ОдинСценарийСтруктураСценарияСПродолжением"
		И Пауза 1
		И я установил специальную служебную экспортную переменную СлужебнаяПеременная у открытого VanessaBehavoir равной 0
		И в тестируемом экземпляре я установил текущую строку дерева 15
		И в тестируемом экземпляре я нажал на кнопку "ВыполнитьОдинШаг"
		И Пауза 2
		И в тестируемом экземпляре я установил текущую строку дерева 16
		И в тестируемом экземпляре я выполнил команду установить брейкпоинт
		И в тестируемом экземпляре я нажал на кнопку "ВыполнитьОдинШаг"
		И Пауза 2
		И в тестируемом экземпляре в переменной КонтекстСохраняемый значение служебной переменной равно 2

	Сценарий: Выполнение одного сценария структуры сценария с выбранного шага с продолжением

		Когда я открыл форму VanessaBehavoir в режиме самотестирования
		И я загрузил специальную тестовую фичу "ОдинСценарийСтруктураСценарияСПродолжением"
		И Пауза 1
		И я установил специальную служебную экспортную переменную СлужебнаяПеременная у открытого VanessaBehavoir равной 0
		И в тестируемом экземпляре я установил флаг "ВыполнятьШагиАссинхронно" в "Ложь"
		И в тестируемом экземпляре я установил текущую строку дерева 15
		И я прервал выполнение шагов в хост системе и я нажал на кнопку "ВыполнитьДанныйСценарийСТекущегоШагаСПродолжением"
		И Я продолжил выполнение шагов в хост системе
		И в тестируемом экземпляре в переменной КонтекстСохраняемый значение служебной переменной равно 7

	Сценарий: Выполнение одного сценария структуры сценария с выбранного шага

		Когда я открыл форму VanessaBehavoir в режиме самотестирования
		И я загрузил специальную тестовую фичу "ПроверкаВыполнитьОдинСценарийСтруктураСценария"
		И Пауза 1
		И я установил специальную служебную экспортную переменную СлужебнаяПеременная у открытого VanessaBehavoir равной 0
		И в тестируемом экземпляре я установил флаг "ВыполнятьШагиАссинхронно" в "Ложь"
		И в тестируемом экземпляре я установил текущую строку дерева 15
		И я прервал выполнение шагов в хост системе и я нажал на кнопку "ВыполнитьДанныйСценарийСТекущегоШага"
		И Я продолжил выполнение шагов в хост системе
		И в тестируемом экземпляре в переменной КонтекстСохраняемый значение служебной переменной равно 3

	Сценарий: Выполнение одного сценария структуры сценария

		Когда я открыл форму VanessaBehavoir в режиме самотестирования
		И я загрузил специальную тестовую фичу "ПроверкаВыполнитьОдинСценарийСтруктураСценария"
		И Пауза 1
		И я установил специальную служебную экспортную переменную СлужебнаяПеременная у открытого VanessaBehavoir равной 0
		И в тестируемом экземпляре я установил флаг "ВыполнятьШагиАссинхронно" в "Ложь"
		И в тестируемом экземпляре я установил текущую строку дерева 15
		И я прервал выполнение шагов в хост системе и я нажал на кнопку "ВыполнитьВыделенныйСценарий"
		И Я продолжил выполнение шагов в хост системе
		И в тестируемом экземпляре в переменной КонтекстСохраняемый значение служебной переменной равно 4

	Сценарий: Выполнение одного сценария с произвольного шага c продолжением когда первый шаг находится в экспортном сценарии

		Когда я открыл форму VanessaBehavoir в режиме самотестирования
		И я загрузил специальную тестовую фичу "ПроверкаВыполнитьСценарийСПроизвольногоШагаСПродолжениемЭкспортныйСценарий"
		И Пауза 1
		И я установил специальную служебную экспортную переменную СлужебнаяПеременная у открытого VanessaBehavoir равной 0
		И в тестируемом экземпляре я установил текущую строку дерева 5
		И я прервал выполнение шагов в хост системе и я нажал на кнопку "ВыполнитьДанныйСценарийСТекущегоШагаСПродолжением"
		Тогда в тестируемом экземпляре выполнился сценарий
		И Я продолжил выполнение шагов в хост системе
		И в тестируемом экземпляре в переменной КонтекстСохраняемый значение служебной переменной равно 6

	
	Сценарий: Выполнение одного сценария по одному шагу

		Когда я открыл форму VanessaBehavoir в режиме самотестирования
		И я загрузил специальную тестовую фичу "ПроверкаВыполнитьСценарийПоОдномуШагу"
		И Пауза 1
		И я установил специальную служебную экспортную переменную СлужебнаяПеременная у открытого VanessaBehavoir равной 0
		И в тестируемом экземпляре я установил текущую строку дерева 6
		И в тестируемом экземпляре я нажал на кнопку "ВыполнитьОдинШаг"
		И Пауза 2
		И в тестируемом экземпляре я установил текущую строку дерева 7
		И в тестируемом экземпляре я выполнил команду установить брейкпоинт
		И в тестируемом экземпляре я нажал на кнопку "ВыполнитьОдинШаг"
		И Пауза 2
		И в тестируемом экземпляре в переменной КонтекстСохраняемый значение служебной переменной равно 2

	Сценарий: Выполнение одного сценария до брейкпоинта

		Когда я открыл форму VanessaBehavoir в режиме самотестирования
		И я загрузил специальную тестовую фичу "ПроверкаВыполнитьСценарийДоБрейкпоинта"
		И Пауза 1
		И я установил специальную служебную экспортную переменную СлужебнаяПеременная у открытого VanessaBehavoir равной 0
		И в тестируемом экземпляре я установил текущую строку дерева 5
		И в тестируемом экземпляре я выполнил команду установить брейкпоинт
		И в тестируемом экземпляре я нажал на кнопку "ВыполнитьСценарии"
		И Пауза 10
		И в тестируемом экземпляре в переменной КонтекстСохраняемый значение служебной переменной равно 1

	Сценарий: Выполнение одного сценария с произвольного шага c продолжением

		Когда я открыл форму VanessaBehavoir в режиме самотестирования
		И я загрузил специальную тестовую фичу "ПроверкаВыполнитьСценарийСПроизвольногоШагаСПродолжением"
		И Пауза 1
		И я установил специальную служебную экспортную переменную СлужебнаяПеременная у открытого VanessaBehavoir равной 0
		И в тестируемом экземпляре я установил текущую строку дерева 5
		И я прервал выполнение шагов в хост системе и я нажал на кнопку "ВыполнитьДанныйСценарийСТекущегоШагаСПродолжением"
		Тогда в тестируемом экземпляре выполнился сценарий
		И Я продолжил выполнение шагов в хост системе
		И в тестируемом экземпляре в переменной КонтекстСохраняемый значение служебной переменной равно 4


	Сценарий: Выполнение одного сценария с произвольного шага

		Когда я открыл форму VanessaBehavoir в режиме самотестирования
		И я загрузил специальную тестовую фичу "ПроверкаВыполнитьСценарийСПроизвольногоШага"
		И Пауза 1
		И я установил специальную служебную экспортную переменную СлужебнаяПеременная у открытого VanessaBehavoir равной 0
		И в тестируемом экземпляре я установил текущую строку дерева 5
		И я прервал выполнение шагов в хост системе и я нажал на кнопку "ВыполнитьДанныйСценарийСТекущегоШага"
		Тогда в тестируемом экземпляре выполнился сценарий
		И Я продолжил выполнение шагов в хост системе
		И в тестируемом экземпляре в переменной КонтекстСохраняемый значение служебной переменной равно 2

	Сценарий: Выполнение сценария со второго шага когда не все шаги реализованны

		Когда я открыл форму VanessaBehavoir в режиме самотестирования
		И я загрузил специальную тестовую фичу "ПроверкаВыполнитьСценарийСВыбранногоШагаВторойШагНеРеализован"
		И Пауза 1
		И я установил специальную служебную экспортную переменную СлужебнаяПеременная у открытого VanessaBehavoir равной 0
		И в форме открытого VanessaBehavoir я установил флаг объекта "СохранятьКонтекстыПередВыполнениемШагов"
		И я прервал выполнение шагов в хост системе и я нажал на кнопку "ВыполнитьСценарии"
		Тогда в тестируемом экземпляре выполнился сценарий
		И Я продолжил выполнение шагов в хост системе
		И в форме открытого VanessaBehavoir я установил второму шагу первого сценария флаг "ВыполнятьСценарийСЭтогоШага"
		И Пауза 1
		И я прервал выполнение шагов в хост системе и я нажал на кнопку "ВыполнитьСценарии"
		И в тестируемом экземпляре в переменной КонтекстСохраняемый значение служебной переменной равно 1

 
 
 
	Сценарий: Выполнение сценария со второго шага когда все шаги реализованны

		Когда я открыл форму VanessaBehavoir в режиме самотестирования
		И я загрузил специальную тестовую фичу "ПроверкаВыполнитьСценарийСВыбранногоШага"
		И Пауза 1
		И я установил специальную служебную экспортную переменную СлужебнаяПеременная у открытого VanessaBehavoir равной 0
		И в форме открытого VanessaBehavoir я установил флаг объекта "СохранятьКонтекстыПередВыполнениемШагов"
		И я прервал выполнение шагов в хост системе и я нажал на кнопку "ВыполнитьСценарии"
		Тогда в тестируемом экземпляре выполнился сценарий
		И Я продолжил выполнение шагов в хост системе
		И в форме открытого VanessaBehavoir я установил второму шагу первого сценария флаг "ВыполнятьСценарийСЭтогоШага"
		И Пауза 1
		И я прервал выполнение шагов в хост системе и я нажал на кнопку "ВыполнитьСценарии"
		Тогда в тестируемом экземпляре выполнился сценарий
		И в тестируемом экземпляре в переменной КонтекстСохраняемый значение служебной переменной равно 3
		И значение служебной экспортной переменной у открытого VanessaBehavoir равно 5

﻿# encoding: utf-8
# language: ru

@IgnoreOnCIMainBuild

Функционал: Загрузка feature-файла в vanessa-behavior
	Как Разработчик
	Хочу Иметь возможность загрузить feature-файл в обработку vanessa-behavior
	Чтобы Вести разработку по bdd

Сценарий: Открытие 1C
	Дано Я запускаю 1С в режиме клиента тестирвания

Сценарий: Открытие обработки
	Дано Я в запущеном экземпляре 1С в режиме клиента тесторования открываю обработку vanessa-behavior
	
Сценарий: Загрузка feature-файла
	Дано Я выполняю действия для загрузки feature-файла
	
Сценарий: Закрытие 1С
	Дано Я закрываю запущенный в режиме клиент тестирования экземпляр 1С
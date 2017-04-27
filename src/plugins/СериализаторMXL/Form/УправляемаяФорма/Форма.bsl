﻿

// { Plugin interface
&НаКлиенте
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Возврат ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов);
КонецФункции

&НаСервере
Функция ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов)
	Возврат Объект().ОписаниеПлагина(ВозможныеТипыПлагинов);
КонецФункции
// } Plugin interface

// { Методы генерации тестовых данных

&НаКлиенте
Функция СоздатьДанныеПоТабличномуДокументу(ТабличныйДокумент, РежимыЗагрузкиИлиИмяКолонкиЗамещения = Неопределено, ИмяКолонкиЗамещения = Неопределено, ВозвращатьДанные = Истина) Экспорт
	Данные = СоздатьДанныеПоТабличномуДокументуСервер(ТабличныйДокумент, РежимыЗагрузкиИлиИмяКолонкиЗамещения, ИмяКолонкиЗамещения, ВозвращатьДанные);
	Возврат Данные;
КонецФункции

// удаляет созданные элементы (Справочники, Документы, Пользователи ИБ), регистры сведений не чистит - есть тесты
&НаКлиенте
Функция УдалитьСозданныеДанные(Данные) Экспорт
	КоличествоУдаленных = УдалитьСозданныеДанныеСервер(Данные);
	Возврат КоличествоУдаленных;
КонецФункции

&НаСервере
Функция СоздатьДанныеПоТабличномуДокументуСервер(ТабличныйДокумент, РежимыЗагрузкиИлиИмяКолонкиЗамещения, ИмяКолонкиЗамещения, ВозвращатьДанные)
	Данные = Объект().СоздатьДанныеПоТабличномуДокументу(ТабличныйДокумент, РежимыЗагрузкиИлиИмяКолонкиЗамещения, ИмяКолонкиЗамещения);
	// В данных могут быть какие-нибудь данные, например, наборы записей регистров, которые нельзя передать на клиент
	Если ВозвращатьДанные = Истина Тогда
		Для каждого Элем Из Данные Цикл
			Стр = Строка(Элем.Значение);
			Если Найти(Стр,"РегистрСведенийНаборЗаписей") > 0 Тогда
				ИмяРС = Сред(Стр,29);
				Данные[Элем.Ключ] = ПолучитьКлючиЗаписиРСПоНаборуЗаписейРС(Элем.Значение,ИмяРС);
			КонецЕсли;	 
		КонецЦикла;
		
		Возврат Данные;
	Иначе
		Возврат Неопределено;
	КонецЕсли;	
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьКлючиЗаписиРСПоНаборуЗаписейРС(НаборЗаписей, ИмяРС)
	Результат = Новый Массив;
	
	Периодический        = Не (Метаданные.РегистрыСведений[ИмяРС].ПериодичностьРегистраСведений = Метаданные.СвойстваОбъектов.ПериодичностьРегистраСведений.Непериодический);
	ПодчиненРегистратору = (Метаданные.РегистрыСведений[ИмяРС].РежимЗаписи = Метаданные.СвойстваОбъектов.РежимЗаписиРегистра.ПодчинениеРегистратору);
	
	МассивИзмерений = Новый Массив;
	Для каждого Измерение Из Метаданные.РегистрыСведений[ИмяРС].Измерения Цикл
		МассивИзмерений.Добавить(Измерение.Имя);
	КонецЦикла;
	
	Для каждого Запись Из НаборЗаписей Цикл
		ЗначениеКлюча = Новый Структура;
		
		Если ПодчиненРегистратору Тогда
			ЗначениеКлюча.Вставить("Регистратор",Запись.Регистратор);
		КонецЕсли;	 
		Если Периодический Тогда
			ЗначениеКлюча.Вставить("Период",Запись.Период);
		КонецЕсли;	 
		
		Для каждого Измерение Из МассивИзмерений Цикл
			ЗначениеКлюча.Вставить(Измерение,Запись[Измерение]);
		КонецЦикла;
		
		
		ПараметрыКонструктора = Новый Массив();      
		ПараметрыКонструктора.Добавить(ЗначениеКлюча);      
		КлючЗаписи =  Новый("РегистрСведенийКлючЗаписи." + ИмяРС, ПараметрыКонструктора);		
		
		Результат.Добавить(КлючЗаписи);
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции	

&НаСервере
Функция УдалитьСозданныеДанныеСервер(Знач Данные)
	Возврат Объект().УдалитьСозданныеДанные(Данные);
КонецФункции

//}

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ ТаблицаДанных

&НаКлиенте
Процедура ТаблицаДанныхСсылкаПриИзменении(Элемент)
	ТаблицаДанныхСсылкаПриИзмененииСервер(Элементы.ТаблицаДанных.ТекущаяСтрока);
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура СоздатьМакетДанных(Команда)
	ПанельИсточников = Элементы.ГруппаСтраницы;
	Если ПанельИсточников.ТекущаяСтраница = ПанельИсточников.ПодчиненныеЭлементы.ГруппаМетаданные Тогда
		КоманднаяПанель1СоздатьМакетДанныхПоМетаданным();
	ИначеЕсли ПанельИсточников.ТекущаяСтраница = ПанельИсточников.ПодчиненныеЭлементы.ГруппаТаблицаДанных Тогда
		КоманднаяПанель1СоздатьМакетДанныхПоТаблицеДанных();
	ИначеЕсли ПанельИсточников.ТекущаяСтраница = ПанельИсточников.ПодчиненныеЭлементы.ГруппаПользователиИБ Тогда
		КоманднаяПанель1СоздатьМакетДанныхДляПользователейИБ();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КоманднаяПанель1СоздатьМакетДанныхПоТаблицеДанных()
	Если ПроверитьЗаполнение() Тогда
		НовыйМакет = СоздатьМакетДанныхПоТаблицеДанныхСервер();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КоманднаяПанель1СоздатьМакетДанныхПоМетаданным()
	
	СохранитьОтображениеДерева(Объект.ДеревоМетаданных.ПолучитьЭлементы());
	НовыйМакет = СоздатьМакетДанныхПоМетаданнымСервер();
	ВосстановитьОтображениеДерева(Объект.ДеревоМетаданных.ПолучитьЭлементы());
	
КонецПроцедуры

&НаКлиенте
Процедура КоманднаяПанель1СоздатьМакетДанныхДляПользователейИБ()
	
	МассивИменПользователей = Новый Массив;
	Для Каждого ИдентификаторСтроки Из Элементы.ПользователиИнфБазы.ВыделенныеСтроки Цикл
		Строка = Объект.ПользователиИБ.НайтиПоИдентификатору(ИдентификаторСтроки);
		МассивИменПользователей.Добавить(Строка.Имя);
	КонецЦикла;
	НовыйМакет = СоздатьМакетДанныхПоПользователямИБСервер(МассивИменПользователей);
	
КонецПроцедуры

&НаКлиенте
Процедура ПротестироватьЗагрузкуМакета(Команда)
	ПроверитьЗагрузкуМакетаСервер(Макет);
КонецПроцедуры

&НаКлиенте
Процедура СохранитьМакетДанныхВФайл(Команда)
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогВыбораФайла.ПолноеИмяФайла = "";
	ДиалогВыбораФайла.Фильтр = "Табличный документ (*.mxl)|*.mxl|Все файлы (*.*)|*.*";
	ДиалогВыбораФайла.Заголовок = "Выберите файл";
	Если Не ДиалогВыбораФайла.Выбрать() Тогда
		Возврат;
	КонецЕсли;
	
	Макет.Записать(ДиалогВыбораФайла.ПолноеИмяФайла);
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьТаблицуДанных(Команда)
	Объект.ТаблицаДанных.Очистить();
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Функция Объект()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции

&НаСервере
Процедура ТаблицаДанныхСсылкаПриИзмененииСервер(ИдентификаторСтрокиДанных)
	ЭлементДанных = Объект.ТаблицаДанных.НайтиПоИдентификатору(ИдентификаторСтрокиДанных);
	Объект().ПриИзмененииСсылки(ЭлементДанных);
КонецПроцедуры

&НаСервере
Функция СоздатьМакетДанныхПоТаблицеДанныхСервер()
	Возврат Объект().СоздатьМакетДанныхПоТаблицеДанных(Макет);
КонецФункции

&НаСервере
Функция СоздатьМакетДанныхПоМетаданнымСервер()
	
	ОбъектНаСервере = Объект();
	ЗаполнитьДеревоМетаданныхНаСервере(ОбъектНаСервере);
	НовыйМакет = ОбъектНаСервере.СоздатьМакетДанныхПоМетаданным(Макет);
	ЗначениеВРеквизитФормы(ОбъектНаСервере.ДеревоМетаданных, "Объект.ДеревоМетаданных");
	
	Возврат НовыйМакет;
	
КонецФункции

Функция СоздатьМакетДанныхПоПользователямИБСервер(МассивИменПользователей)
	Возврат Объект().СоздатьМакетДанныхПоПользователямИБ(Макет, МассивИменПользователей);
КонецФункции

&НаСервере
Процедура ПроверитьЗагрузкуМакетаСервер(ТабличныйДокумент)
	Объект().ПроверитьЗагрузкуМакета(ТабличныйДокумент);
КонецПроцедуры




&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбъектНаСервере = Объект();
	ЭтаФорма.Заголовок = ОбъектНаСервере.ЗаголовокФормы();
	
	ОбъектНаСервере.НачальнаяИнициализация();
	ЗначениеВРеквизитФормы(ОбъектНаСервере.ДеревоМетаданных, "Объект.ДеревоМетаданных");
	ЗначениеВРеквизитФормы(ОбъектНаСервере.ПользователиИБ, "Объект.ПользователиИБ");

	ОбъектНаСервере.СписокВыбора_РежимПоиска(Элементы.ТаблицаДанныхРежимПоиска.СписокВыбора);
	ОбъектНаСервере.СписокВыбора_РежимСоздания(Элементы.ТаблицаДанныхРежимСоздания.СписокВыбора);
	
	Объект.ВыгружатьСсылку = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПересчитатьВыгружаемыеПоСсылке(Команда)
	
	Состояние(Нстр("ru = 'Выполняется поиск объектов метаданных, которые могут быть выгружены по ссылкам...'"));
	СохранитьОтображениеДерева(Объект.ДеревоМетаданных.ПолучитьЭлементы());
	ПересчитатьВыгружаемыеПоСсылкеНаСервере();
	ВосстановитьОтображениеДерева(Объект.ДеревоМетаданных.ПолучитьЭлементы());
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьОтображениеДерева(СтрокиДерева)
	
	Для Каждого Строка Из СтрокиДерева Цикл
		
		ИдентификаторСтроки=Строка.ПолучитьИдентификатор();
		Строка.Развернут = Элементы.ДеревоМетаданных.Развернут(ИдентификаторСтроки);
		
		СохранитьОтображениеДерева(Строка.ПолучитьЭлементы());
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ВосстановитьОтображениеДерева(СтрокиДерева)
	
	Для Каждого Строка Из СтрокиДерева Цикл
		
		ИдентификаторСтроки=Строка.ПолучитьИдентификатор();
		Если Строка.Развернут Тогда
			Элементы.ДеревоМетаданных.Развернуть(ИдентификаторСтроки);
		КонецЕсли;
		
		ВосстановитьОтображениеДерева(Строка.ПолучитьЭлементы());
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ПересчитатьВыгружаемыеПоСсылкеНаСервере()
	
	ОбъектНаСервере = Объект();
	ЗаполнитьДеревоМетаданныхНаСервере(ОбъектНаСервере);
	ОбъектНаСервере.СоставВыгрузки(Истина);
	ЗначениеВРеквизитФормы(ОбъектНаСервере.ДеревоМетаданных, "Объект.ДеревоМетаданных");
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоМетаданныхНаСервере(ОбъектНаСервере)
	
	ДеревоМетаданных = РеквизитФормыВЗначение("Объект.ДеревоМетаданных");
	
	ОбъектНаСервере.НачальнаяИнициализация();
	
	ПроставитьПометкиВыгружаемыхДанных(ОбъектНаСервере.ДеревоМетаданных.Строки, ДеревоМетаданных.Строки);
	
КонецПроцедуры

&НаСервере
Процедура ПроставитьПометкиВыгружаемыхДанных(СтрокиИсходногоДерева, СтрокиЗаменяемогоДерева)
	
	КолонкаВыгружать = СтрокиЗаменяемогоДерева.ВыгрузитьКолонку("Выгружать");
	СтрокиИсходногоДерева.ЗагрузитьКолонку(КолонкаВыгружать, "Выгружать");
	
	КолонкаВыгружатьПриНеобходимости = СтрокиЗаменяемогоДерева.ВыгрузитьКолонку("ВыгружатьПриНеобходимости");
	СтрокиИсходногоДерева.ЗагрузитьКолонку(КолонкаВыгружатьПриНеобходимости, "ВыгружатьПриНеобходимости");
	
	КолонкаРазвернут = СтрокиЗаменяемогоДерева.ВыгрузитьКолонку("Развернут");
	СтрокиИсходногоДерева.ЗагрузитьКолонку(КолонкаРазвернут, "Развернут");
	
	КолонкаНастройкиКомпоновщика = СтрокиЗаменяемогоДерева.ВыгрузитьКолонку("НастройкиКомпоновщика");
	СтрокиИсходногоДерева.ЗагрузитьКолонку(КолонкаНастройкиКомпоновщика, "НастройкиКомпоновщика");
	
	КолонкаИспользоватьОтбор = СтрокиЗаменяемогоДерева.ВыгрузитьКолонку("ИспользоватьОтбор");
	СтрокиИсходногоДерева.ЗагрузитьКолонку(КолонкаИспользоватьОтбор, "ИспользоватьОтбор");
	
	Для Каждого СтрокаИсходногоДерева Из СтрокиИсходногоДерева Цикл
		
		ИндексСтроки = СтрокиИсходногоДерева.Индекс(СтрокаИсходногоДерева);
		СтрокаИзменяемогоДерева = СтрокиЗаменяемогоДерева.Получить(ИндексСтроки);
		
		ПроставитьПометкиВыгружаемыхДанных(СтрокаИсходногоДерева.Строки, СтрокаИзменяемогоДерева.Строки);
		
	КонецЦикла;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ ДеревоМетаданных

&НаКлиенте
Процедура ДеревоМетаданныхВыгружатьПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ДеревоМетаданных.ТекущиеДанные;
	
	Если ТекущиеДанные.Выгружать = 2 Тогда
		ТекущиеДанные.Выгружать = 0;
	КонецЕсли;
	
	УстановитьПометкиПодчиненных(ТекущиеДанные, "Выгружать");
	УстановитьПометкиРодителей(ТекущиеДанные, "Выгружать");
	
	УровеньВыгрузкиПриИзменении(Элемент);	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоМетаданныхВыгружатьПриНеобходимостиПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ДеревоМетаданных.ТекущиеДанные;
	
	Если ТекущиеДанные.ВыгружатьПриНеобходимости = 2 Тогда
		ТекущиеДанные.ВыгружатьПриНеобходимости = 0;
	КонецЕсли;
	
	УстановитьПометкиПодчиненных(ТекущиеДанные, "ВыгружатьПриНеобходимости");
	УстановитьПометкиРодителей(ТекущиеДанные, "ВыгружатьПриНеобходимости");
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПометкиПодчиненных(ТекСтрока, ИмяФлажка)
	
	Подчиненные = ТекСтрока.ПолучитьЭлементы();
	
	Если Подчиненные.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого Строка из Подчиненные Цикл
		
		Строка[ИмяФлажка] = ТекСтрока[ИмяФлажка];
		
		УстановитьПометкиПодчиненных(Строка, ИмяФлажка);
		
	КонецЦикла;
		
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПометкиРодителей(ТекСтрока, ИмяФлажка)
	
	Родитель = ТекСтрока.ПолучитьРодителя();
	Если Родитель = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	ТекСостояние = Родитель[ИмяФлажка];
	
	НайденыВключенные  = Ложь;
	НайденыВыключенные = Ложь;
	
	Для Каждого Строка из Родитель.ПолучитьЭлементы() Цикл
		Если Строка[ИмяФлажка] = 0 Тогда
			НайденыВыключенные = Истина;
		ИначеЕсли Строка[ИмяФлажка] = 1
			ИЛИ Строка[ИмяФлажка] = 2 Тогда
			НайденыВключенные  = Истина;
		КонецЕсли; 
		Если НайденыВключенные И НайденыВыключенные Тогда
			Прервать;
		КонецЕсли; 
	КонецЦикла;
	
	Если НайденыВключенные И НайденыВыключенные Тогда
		Включить = 2;
	ИначеЕсли НайденыВключенные И (Не НайденыВыключенные) Тогда
		Включить = 1;
	ИначеЕсли (Не НайденыВключенные) И НайденыВыключенные Тогда
		Включить = 0;
	ИначеЕсли (Не НайденыВключенные) И (Не НайденыВыключенные) Тогда
		Включить = 2;
	КонецЕсли;
	
	Если Включить = ТекСостояние Тогда
		Возврат;
	Иначе
		Родитель[ИмяФлажка] = Включить;
		УстановитьПометкиРодителей(Родитель, ИмяФлажка);
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоМетаданныхПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("ДеревоМетаданныхПриАктивизацииСтрокиОбработкаОжидания", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоМетаданныхПриАктивизацииСтрокиОбработкаОжидания()
	
	ТекущаяСтрока = Элементы.ДеревоМетаданных.ТекущаяСтрока;
	Если ТекущаяСтрока = ДеревоМетаданныхПредыдущаяСтрока Тогда
		Возврат;
	КонецЕсли;
	ДеревоМетаданныхПредыдущаяСтрока = ТекущаяСтрока;
	
	НастроитьКомпоновщик();
	
КонецПроцедуры

// Служит для настройки построителя при отборе данных
//
// Параметры:
//
&НаКлиенте
Процедура НастроитьКомпоновщик()
	
	ТекущаяСтрока = Элементы.ДеревоМетаданных.ТекущиеДанные;
	
	Если ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ОпределитьПоСтрокеДереваДоступенПостроитель(ТекущаяСтрока) Тогда
		
		ДоступностьКомпоновщика = ЛОЖЬ;
		УдалитьОтборыКомпоновщика(Объект.КомпоновщикНастроекКомпоновкиДанных);
		
	Иначе
		
		Попытка
			
			НастроитьКомпоновщикНаСервере(Элементы.ДеревоМетаданных.ТекущаяСтрока);
			
			ДоступностьКомпоновщика = Истина;
			
		Исключение
			ДоступностьКомпоновщика = ЛОЖЬ;
			УдалитьОтборыКомпоновщика(Объект.КомпоновщикНастроекКомпоновкиДанных);
		КонецПопытки;
		
	КонецЕсли;
	
	Элементы.КомпоновщикОтбор.Доступность = ДоступностьКомпоновщика;
	//Элементы.КоманднаяПанельКомпоновщикОтбор.Доступность = ДоступностьКомпоновщика;
	
КонецПроцедуры

&НаКлиенте
Функция ОпределитьПоСтрокеДереваДоступенПостроитель(СтрокаДерева)
	
	Если СтрокаДерева.ПолучитьЭлементы().Количество() > 0 Тогда
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура УдалитьОтборыКомпоновщика(Компоновщик)
	
	Компоновщик.Настройки.Отбор.Элементы.Очистить();
	
КонецПроцедуры

&НаСервере
Процедура НастроитьКомпоновщикНаСервере(ТекущаяСтрока)
	
	СтрокаДерева = Объект.ДеревоМетаданных.НайтиПоИдентификатору(ТекущаяСтрока);
	СхемаКомпоновкиДанных = Объект().ПодготовитьКомпоновщикДляВыгрузки(СтрокаДерева);
	АдресСхемы = ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, УникальныйИдентификатор);
	Объект.КомпоновщикНастроекКомпоновкиДанных.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресСхемы));
	Объект.КомпоновщикНастроекКомпоновкиДанных.ЗагрузитьНастройки(СхемаКомпоновкиДанных.НастройкиПоУмолчанию);
	
КонецПроцедуры // НастроитьКомпоновщикНаСервере()

&НаКлиенте
Процедура КомпоновщикОтборПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ОбновитьНастройкиПостроителяВТаблицеДляВыгрузки();
	
КонецПроцедуры

&НаКлиенте
Процедура КомпоновщикОтборПослеУдаления(Элемент)
	
	ОбновитьНастройкиПостроителяВТаблицеДляВыгрузки();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьНастройкиПостроителяВТаблицеДляВыгрузки()
	
	ТекущаяСтрока = Элементы.ДеревоМетаданных.ТекущиеДанные;
	Если Объект.КомпоновщикНастроекКомпоновкиДанных.Настройки.Отбор.Элементы.Количество() > 0 Тогда
		
		ТекущаяСтрока.НастройкиКомпоновщика = Объект.КомпоновщикНастроекКомпоновкиДанных.Настройки.Отбор;//Объект.КомпоновщикНастроекКомпоновкиДанных.ПолучитьНастройки();
		ТекущаяСтрока.ИспользоватьОтбор    = ИСТИНА;
		ТекущаяСтрока.Выгружать = Истина;
		
	Иначе
		
		ТекущаяСтрока.НастройкиКомпоновщика = Неопределено;
		ТекущаяСтрока.ИспользоватьОтбор    = ЛОЖЬ;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьРезультатОтбора(Команда)
	
	// показать выбранные записи
	Если Элементы.КомпоновщикОтбор.Доступность <> Истина
		ИЛИ Элементы.ДеревоМетаданных.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТабличныйДокумент = ПолучитьРезультатОтбораНаСервере();
	ТабличныйДокумент.Показать(НСтр("ru = 'Выбранные объекты'"));
	
КонецПроцедуры

&НаСервере
Функция ПолучитьРезультатОтбораНаСервере()
	
	СтрокаДерева = Объект.ДеревоМетаданных.НайтиПоИдентификатору(Элементы.ДеревоМетаданных.ТекущаяСтрока);
	ТабличныйДокумент = Объект().СформироватьОтчетПоОтобраннымДанным(СтрокаДерева);
	
	Возврат ТабличныйДокумент;
	
КонецФункции // ПолучитьРезультатОтбораНаСервере()

&НаКлиенте
Процедура ДополнительныеСвойства(Команда)
	Элементы.ФормаДополнительныеСвойства.Пометка = НЕ Элементы.ФормаДополнительныеСвойства.Пометка;
	Элементы.ДополнительныеСвойства.Видимость = Элементы.ФормаДополнительныеСвойства.Пометка;
КонецПроцедуры

&НаКлиенте
Процедура УровеньВыгрузкиПриИзменении(Элемент)
	Если Объект.УровеньВыгрузки = 0 Тогда
		СтрокаКонфигурации = Объект.ДеревоМетаданных.ПолучитьЭлементы()[0];
		СтрокаКонфигурации.ВыгружатьПриНеобходимости = 1;
		ДеревоМетаданныхВыгружатьПриНеобходимостиПриИзменении(Элемент);
	Иначе
		ПересчитатьВыгружаемыеПоСсылке(Элемент);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	Отказ = (Вопрос("Вы действительно хотите закрыть обработку?", РежимДиалогаВопрос.ДаНет,,,"Подтвердите выход") = КодВозвратаДиалога.Нет);
КонецПроцедуры
﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВТаблицеЯПерехожуКСтрокеСодержащейПодстроки(Парам01,ТабПарам)","ВТаблицеЯПерехожуКСтрокеСодержащейПодстроки","И в таблице ""Таблица"" я перехожу к строке содержащей подстроки" + Символы.ПС + "	|'Наименование'|"  + Символы.ПС + "	|'Товар1'|","Переход к строке таблицы, когда значения колонок заданы не полностью, а подстрокой","UI.Таблицы.Переход к строке");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И в таблице "Таблица" я перехожу к строке содержащей подстроки
//@ВТаблицеЯПерехожуКСтрокеСодержащейПодстроки(Парам01,ТабПарам)
Процедура ВТаблицеЯПерехожуКСтрокеСодержащейПодстроки(ИмяТЧ, ТабПарам) Экспорт
	// Проверим корректность фильтра по значениям колонок.
	Ванесса.ПроверитьРавенство(ТабПарам.Количество(),2,"Строка должна быть описана таблицей с двумя строками.");
	
	ТЧ                = Ванесса.НайтиТЧПоИмени(ИмяТЧ);
	ТаблицаTestclient = Ванесса.ПолучитьЗначениеТестируемаяТаблицаФормы(ТЧ);
	ФильтрПоКолонкам  = ПолучитьОписаниеСтрокиИзТаблицы(ТабПарам);
	
	// Проверим, что все указанные в фильтре колонки существуют в таблице.
	Если ТаблицаTestclient.Количество() > 0 Тогда
		ОписаниеСтроки = ТаблицаTestclient[0];
		
		Для Каждого ЭлементФильтра Из ФильтрПоКолонкам Цикл
			Если ОписаниеСтроки[ЭлементФильтра.Ключ] = Неопределено Тогда
				СтрокаОшибки = Вычислить("СтрШаблон(""В таблице <%1> отсутствует колонка <%2>, указнная в параметрах."", ИмяТЧ, ЭлементФильтра.Ключ)");
				ВызватьИсключение СтрокаОшибки;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	// Переберем строки и найдем ту, которая полностью соответствует фильтру
	ОписаниеПодходящейСтроки = Неопределено;
	Для Каждого ЗначенияСтрокиТаблицы Из ТаблицаTestclient Цикл
		ВсеЗначенияСовпали = Истина;
		Для Каждого ЭлементФильтра Из ФильтрПоКолонкам Цикл
			ЗначениеКолонкиTesClient = ЗначенияСтрокиТаблицы[ЭлементФильтра.Ключ];
			Если ЗначениеКолонкиTesClient = Неопределено
				ИЛИ Найти(ЗначениеКолонкиTesClient, ЭлементФильтра.Значение) = 0 Тогда
				
				ВсеЗначенияСовпали = Ложь;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		
		Если ВсеЗначенияСовпали Тогда
			ОписаниеПодходящейСтроки = ЗначенияСтрокиТаблицы;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если ОписаниеПодходящейСтроки <> Неопределено Тогда
		ПерейтиКСтрокеТаблицы(ИмяТЧ, ОписаниеПодходящейСтроки,ТабПарам);
	Иначе
		ОшибкаПереходВниз  = "";
		ОшибкаПереходВверх = "";
		СтрокаОшибки = ПолучитьОшибкуПерехода(ИмяТЧ,ОшибкаПереходВниз,ОшибкаПереходВверх,ТабПарам);
		ВызватьИсключение СтрокаОшибки;
	КонецЕсли;
	
КонецПроцедуры


///////////////////////////////////////////////////
//Служебные процедуры и функции
///////////////////////////////////////////////////

&НаКлиенте
Функция ПолучитьОписаниеСтрокиИзТаблицы(ТабПарам)
	ОписаниеСтроки = Новый Соответствие();
	
	
	Строка1    = ТабПарам[0];
	Строка2    = ТабПарам[1];
	КолКолонок = Строка1.Количество();
	
	Для Ккк = 1 По КолКолонок Цикл
		Ключ     = Строка1["Кол"+Ккк];
		Значение = Строка2["Кол"+Ккк];
		Если ТипЗнч(Значение) = Тип("Число") Тогда
			Значение = СтрЗаменить(Значение,Символы.НПП,"");
		КонецЕсли;	 
		
		//Сообщить("" + Ключ + ":" + Значение);
		
		ОписаниеСтроки.Вставить(Ключ,Значение);
	КонецЦикла;
	
	Возврат ОписаниеСтроки;
КонецФункции

&НаКлиенте
Процедура ПерейтиКСтрокеТаблицы(ИмяТЧ, ОписаниеСтроки,ТабПарам) Экспорт
	
	ТаблицаСписок = НайтиТЧПоИмени(ИмяТЧ);
	ТаблицаСписок.Активизировать();
	
	СделатьДействияПриЗаписиВидео("толькофрейм");
	
	ОшибкаПереходВниз  = "";
	ОшибкаПереходВверх = "";
		
	ПолучилосьПерейти = СделатьПереход(ТаблицаСписок,ОписаниеСтроки,ОшибкаПереходВниз,ОшибкаПереходВверх);
	Если НЕ ПолучилосьПерейти Тогда
		Попытка
			//Возможно, это  ошибка платформы. Такое бывает с таблицами значений в УФ. Смотри https://github.com/silverbulleters/vanessa-behavior/issues/342
			//Делаем обход проблемы
			ТаблицаСписок.ПерейтиКПервойСтроке();
			ПолучилосьПерейти = СделатьПереход(ТаблицаСписок,ОписаниеСтроки,ОшибкаПереходВниз,ОшибкаПереходВверх);
		Исключение
			Стр = ПолучитьОшибкуПерехода(ИмяТЧ,ОшибкаПереходВниз,ОшибкаПереходВверх,ТабПарам);
			ВызватьИсключение Стр;
		КонецПопытки;	
	КонецЕсли;	 
	
	
	Если НЕ ПолучилосьПерейти Тогда
		Стр = ПолучитьОшибкуПерехода(ИмяТЧ,ОшибкаПереходВниз,ОшибкаПереходВверх,ТабПарам);
		ВызватьИсключение Стр;
	КонецЕсли;	
	
	СделатьДействияПриЗаписиHTML("толькофрейм");
	
КонецПроцедуры

&НаКлиенте
Процедура СделатьДействияПриЗаписиВидео(ПарамСтр = "")
	Ванесса.СделатьДействияПриЗаписиВидео(ПарамСтр);
КонецПроцедуры

&НаКлиенте
Процедура СделатьДействияПриЗаписиHTML(ПарамСтр = "")
	Ванесса.СделатьДействияПриЗаписиHTML(ПарамСтр);
КонецПроцедуры

&НаКлиенте
Функция СделатьПереход(ТаблицаСписок,ОписаниеСтроки,ОшибкаПереходВниз,ОшибкаПереходВверх)
	ПолучилосьПерейти = Ложь;
	Попытка
		ПолучилосьПерейти = ТаблицаСписок.ПерейтиКСтроке(ОписаниеСтроки, Вычислить("НаправлениеПереходаКСтроке.Вниз"));
	Исключение
		ОшибкаПереходВниз = ОписаниеОшибки();
		//Сообщить("" + ОписаниеОшибки());
	КонецПопытки;
	
	
	Если НЕ ПолучилосьПерейти Тогда
		Попытка
			ПолучилосьПерейти = ТаблицаСписок.ПерейтиКСтроке(ОписаниеСтроки, Вычислить("НаправлениеПереходаКСтроке.Вверх"));
		Исключение
			ОшибкаПереходВверх = ОписаниеОшибки();
			//Сообщить("" + ОписаниеОшибки());
		КонецПопытки;
	КонецЕсли;	
	
	Возврат ПолучилосьПерейти;
КонецФункции	

&НаКлиенте
Функция ПолучитьОшибкаНетКолонок(ИмяТЧ,ТабПарам)
	Стр = "Не найдены колонки: ";
	
	Попытка
		Таблица = НайтиТЧПоИмени(ИмяТЧ);
	Исключение
		Возврат ""; 
	КонецПопытки;
	
	Попытка
		КолонкиТаблицы = Таблица.НайтиОбъекты();
	Исключение
		Возврат ""; 
	КонецПопытки;
	
	МассивЗаголовков = Новый Массив;
	Для Каждого Элем Из КолонкиТаблицы Цикл
		МассивЗаголовков.Добавить(Элем.ТекстЗаголовка );
	КонецЦикла;	
	
	БылиОшибки = Ложь;
	
	Для Каждого Элем Из ТабПарам[0] Цикл
		ИскомыйЗаголовокТаблицы = Элем.Значение;
		Если МассивЗаголовков.Найти(ИскомыйЗаголовокТаблицы) = Неопределено Тогда
			Стр = Стр + ИскомыйЗаголовокТаблицы + ", ";
			БылиОшибки = Истина;
		КонецЕсли;	 
	КонецЦикла;		
	
	Если Не БылиОшибки Тогда
		Возврат "";
	КонецЕсли;	 
	
	Если Прав(Стр,2) = ", " Тогда
		Стр = Лев(Стр,СтрДлина(Стр)-2);
	КонецЕсли;	 
	
	Возврат Стр;
КонецФункции	

&НаКлиенте
Процедура ПривестиСтрокиКОднойДлине(ИмяКолонки,ЗначениеКолонки)
	Пока СтрДлина(ИмяКолонки) > СтрДлина(ЗначениеКолонки) Цикл
		ЗначениеКолонки = ЗначениеКолонки + " ";
	КонецЦикла;	
	Пока СтрДлина(ИмяКолонки) < СтрДлина(ЗначениеКолонки) Цикл
		ИмяКолонки = ИмяКолонки + " ";
	КонецЦикла;	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьОшибкуПерехода(ИмяТЧ,ОшибкаПереходВниз,ОшибкаПереходВверх,ТабПарам)
	ОшибкаНетКолонок = ПолучитьОшибкаНетКолонок(ИмяТЧ,ТабПарам);
	
	Стр = "Не удалось перейти к нужной строке в таблице <" + ИмяТЧ + ">. " + ОшибкаНетКолонок + Символы.ПС;
	
	СтрокаИмКолонки = "		| ";
	СтрокаЗначение  = "		| ";
	
	
	Колонки = ТабПарам[0];
	Для Каждого Элем Из Колонки Цикл
		ИмяКолонки      = "'" + Элем.Значение + "'";
		ЗначениеКолонки = "'" + ТабПарам[1][Элем.Ключ] + "'";
		
		ПривестиСтрокиКОднойДлине(ИмяКолонки,ЗначениеКолонки);
		
		СтрокаИмКолонки = СтрокаИмКолонки + ИмяКолонки      + " | ";
		СтрокаЗначение  = СтрокаЗначение  + ЗначениеКолонки + " | ";
	КонецЦикла;	
	
	
	Стр = Стр + СтрокаИмКолонки + Символы.ПС + СтрокаЗначение;
	
	Ванесса.СделатьСообщение(Стр);
	Если ОшибкаПереходВниз <> "" Тогда
		Сообщить("" + ОшибкаПереходВниз);
	КонецЕсли;	 
	Если ОшибкаПереходВверх <> "" Тогда
		Сообщить("" + ОшибкаПереходВверх);
	КонецЕсли;	 
	
	Возврат Стр;
КонецФункции	

&НаКлиенте
Функция НайтиТЧПоИмени(ИмяТЧ,НужнаяФорма = Неопределено)
	Возврат Ванесса.НайтиТЧПоИмени(ИмяТЧ,НужнаяФорма);
КонецФункции


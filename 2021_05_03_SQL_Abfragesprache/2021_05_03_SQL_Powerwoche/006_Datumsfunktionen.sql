-- Datumsfunktionen



/*

		-- Datumsintervalle:

				year, yyyy, yy       ................... Jahr
				quarter, qq, q       ................... Quartal
				month, MM, M         ................... Monat
				week, ww, wk         ................... Woche
				day, dd, d           ................... Tag
				hour, hh             ................... Stunde
				minute, mi, n        ................... Minute
				second, ss, s        ................... Sekunde
				millisecond, ms      ................... Millisekunde
				nanosecond, ns       ................... Nanosekunde


				weekday, dw, w       ................... Wochentag
				dayofyear, dy, y     ................... Tag des Jahres


*/




-- ************************ aktuelles Datum abfragen *********************************

-- datetime (auf mehrere Millisekunden genau)
SELECT GETDATE()


-- datetime2 (auf ~ 100 Nanosekunden genau)
SELECT SYSDATETIME()
-- 2021-05-04 10:08:01.5395949




-- ******************************** DATEADD *******************************************
-- Datumsberechnungen: zum Datum etwas hinzu- oder wegrechnen


SELECT DATEADD(hh, 10, '2021-05-04')
-- 2021-05-04 10:00:00.000

-- Achtung, welche Systemsprache wird verwendet? --> Schreibweise

-- was ist denn die Systemsprache? Im Object Explorer nachschauen oder:
SELECT @@LANGUAGE
-- us_english


SELECT DATEADD(hh, 10, '2021-05-04 10:12')
-- 2021-05-04 20:12:00.000




SELECT DATEADD(hh, 10, GETDATE())
-- 2021-05-04 20:13:34.683


-- wie spät war es vor 10 Stunden
-- mit negativem Vorzeichen:
SELECT DATEADD(hh, -10, GETDATE())
-- 2021-05-04 00:21:05.800




-- *********************************** DATEDIFF ********************************************************

-- Differenz zwischen zwei Daten

SELECT DATEDIFF(dd, '2021-05-03', '2021-05-04') -- 1

-- wie lange noch bis zum nächsten Feiertag?

SELECT DATEDIFF(dd, '2021-05-04', '2021-05-13') -- 9

-- oder mit Getdate:
SELECT DATEDIFF(dd, GETDATE(), '2021-05-13')



-- Achtung: was ist Startdatum, was ist Enddatum
SELECT DATEDIFF(dd, '2021-05-13', GETDATE())  --  -9 (negatives Vorzeichen)




-- *********************************** DATEPART *****************************************
-- Datumsteile ausschneiden

-- Rückgabedatentyp: int


SELECT DATEPART(dd, '2021-05-04')
-- 4


SELECT DATEPART(dw, '2021-05-04')
-- 3  (wieder abhängig von Systemsprache)




SELECT DATEPART(month, '2021-05-04')
-- 5


-- oder:

SELECT YEAR('2021-05-04') -- 2021
SELECT MONTH('2021-05-04') -- 5
SELECT DAY('2021-05-04') -- 4


-- mit DB:

SELECT YEAR(HireDate) AS HireDate
FROM Employees


-- ***************************** DATENAME ***********************************

-- bringt nicht viel:
SELECT DATENAME(dd, '2021-05-04')
-- 4
-- dafür verwenden wir DATEPART



-- macht nur mit den Datumsteilen Sinn, die wir als Text ausschreiben können
SELECT DATENAME(dw, '2021-05-04') -- Tuesday
SELECT DATENAME(month, '2021-05-04') -- May






-- An welchem Wochentag war mein Geburtstag?
SELECT DATENAME(dw, '1981-04-22') -- Wednesday




-- Welches Datum haben wir in 38 Tagen?
SELECT DATEADD(dd, 38, GETDATE())
-- 2021-06-11 11:04:48.537





-- Vor wie vielen Jahren kam der erste Star Wars Film in die Kinos? (25. Mai 1977)

SELECT DATEDIFF(yyyy, '1977-05-25', GETDATE()) -- 44


SELECT DATEDIFF(yyyy, '1977', GETDATE()) -- 44





-- wie alt sind unsere Northwind-Mitarbeiter?
SELECT	  FLOOR(DATEDIFF(dd, BirthDate, GETDATE())/365.25) AS Age
		, BirthDate
FROM Employees



SELECT HireDate
FROM Employees
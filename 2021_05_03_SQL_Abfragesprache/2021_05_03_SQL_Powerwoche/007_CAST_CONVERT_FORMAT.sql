-- CAST, CONVERT, FORMAT


/*

	-- Datentypen:

		-- String-Datentypen:

				char()
				varchar()

				-- Unicode:
				nchar()
				nvarchar()


		-- numerische Datentypen

			-- ganzzahlig
					
					int
						tinyint, smallint, bigint

			-- mit Nachkommastellen

					float
					decimal(10, 2)

					money


		-- Datumsdatentypen

			datetime (auf  ~ 3-4 ms genau)
			datetime2 (auf ~ 100 ns genau)

			date
			time




		boolean/bool      true/false


*/

/*
	
	NULL --> Feld ist leer

	jede mathematische Operation mit NULL führt wieder zu NULL

	> 0
	> NULL --- geht nicht!!!


	= 0
	= NULL --- funktioniert NICHT!!!
	IS NULL  ---> als Text ausschreiben


*/




-- ************************************** CAST *****************************************

SELECT '123' + 3  -- 126
-- implizite Konvertierung findet im Hintergrund statt, damit Rechnen funktioniert!!



SELECT '123.5' + 3
-- Conversion failed when converting the varchar value '123.5' to data type int.



-- aber wir können eine explizite Konvertierung durchführen:

SELECT CAST('123.5' AS float) + 3  -- 126,5


/*

-- Microsoft-Dokumentation zum Thema implizite und explizite Konvertierung:
	https://docs.microsoft.com/de-de/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver15

*/




-- wir können theoretisch auch Datumsdatentypen umwandeln, aber:
-- kein Einfluss aufs Format!

SELECT CAST(SYSDATETIME() AS varchar)  -- 2021-05-04 11:43:06.3637331


SELECT CAST(GETDATE() AS varchar) -- May  4 2021 11:43AM



-- Achtung beim Umwandeln - Zeichenanzahl?
-- sinnlos!
SELECT CAST(SYSDATETIME() AS varchar(3)) -- 202

SELECT CAST(GETDATE() AS varchar(10)) -- May  4 202




-- keine gute Idee:
SELECT CAST('2021-05-04' AS date) -- 2021-05-04
-- Achtung: was wird als Tag, was als Monat interpretiert?


SELECT CAST('04.05.2021' AS date) -- 2021-04-05



-- mit DB:


SELECT CAST(HireDate AS varchar)
FROM Employees
-- May  1 1992 12:00AM


SELECT CAST(HireDate AS date)
FROM Employees

-- kein Einfluss auf Format!





-- **************************************** CONVERT *******************************************
-- wie der Name schon sagt: Konvertierung von Datentypen

-- plus zusätzliche Möglichkeit: Style-Parameter (optional)




-- Syntax etwas anders als bei CAST:



SELECT CONVERT(float, '123.5') + 3 -- 126,5


SELECT CONVERT(varchar, SYSDATETIME()) -- 2021-05-04 11:52:38.1328403


-- Achtung mit Zeichenanzahl:
SELECT CONVERT(varchar(3), SYSDATETIME()) -- 202


-- Style-Parameter für Datum:


SELECT CONVERT(varchar, SYSDATETIME(), 104) -- 04.05.2021


SELECT CONVERT(date, SYSDATETIME(), 104) -- 2021-05-04

/*


	-- Style-Parameter in der Microsoft-Dokumentation:
	
	https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles


*/


SELECT CONVERT(varchar, SYSDATETIME(), 101) AS US
		, CONVERT(varchar, SYSDATETIME(), 103) AS GB
		, CONVERT(varchar, SYSDATETIME(), 104) AS DE







-- ****************************************** FORMAT **************************************
-- Daten in ein bestimmtes Format bringen

-- Ausgabedatentyp: nvarchar

-- optional Culture-Parameter für Datum




SELECT FORMAT(1234567890, '###-###/## ##') -- 123-456/78 90

-- Formatierung von hinten nach vorne... Vorsicht:


SELECT FORMAT(67890, '###-###/## ##') --     -6/78 90

SELECT FORMAT(123456789067890, '###-###/## ##') -- 12345678-906/78 90




-- mit Datum:



SELECT FORMAT(GETDATE(), 'dd.mm.yyyy') -- 04.03.2021
-- Achtung: mm kleingeschrieben wird als Minute interpretiert!!


SELECT FORMAT(GETDATE(), 'DD.MM.YYYY') -- DD.05.YYYY


SELECT FORMAT(GETDATE(), 'dd.MM.yyyy') -- 04.05.2021
-- funktioniert nur, wenn wir MM groß schreiben




-- speziell für Datum:
-- Culture-Parameter


SELECT FORMAT(GETDATE(), 'd', 'de-de') -- 04.05.2021

SELECT FORMAT(GETDATE(), 'd', 'sv') -- 2021-05-04



/*

	-- Microsoft - Dokumentation: Culture-Parameter: 

	https://docs.microsoft.com/de-de/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes


*/




-- mit d kleingeschrieben, dann Datum in Zahlen:


SELECT	  FORMAT(GETDATE(), 'd', 'de-de') AS DE
		, FORMAT(GETDATE(), 'd', 'en-us') AS US
		, FORMAT(GETDATE(), 'd', 'en-gb') AS GB
		, FORMAT(GETDATE(), 'd', 'sv') AS SV




-- mit D großgeschrieben, dann Datum ausgeschrieben:
SELECT	  FORMAT(GETDATE(), 'D', 'de-de') AS DE
		, FORMAT(GETDATE(), 'D', 'en-us') AS US
		, FORMAT(GETDATE(), 'D', 'en-gb') AS GB
		, FORMAT(GETDATE(), 'D', 'sv') AS SV






SELECT	  FORMAT(HireDate, 'D', 'de-de') AS DE
		, FORMAT(HireDate, 'D', 'en-us') AS US
		, FORMAT(HireDate, 'D', 'en-gb') AS GB
		, FORMAT(HireDate, 'D', 'de-at') AS AT
FROM Employees




-- Übungen

-- Differenz zwischen Lieferdatum und Wunschtermin der Bestellungen

SELECT	  DATEDIFF(dd, ShippedDate, RequiredDate)
		, ShippedDate
		, RequiredDate
FROM Orders


-- was ist Start-/was ist Enddatum?

-- wie viele Tage hätten wir noch Zeit gehabt, um fristgerecht zu liefern?
SELECT	  DATEDIFF(dd, ShippedDate, RequiredDate)
		, ShippedDate
		, RequiredDate
FROM Orders


-- was ist die Lieferverzögerung?
SELECT	  DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
		, ShippedDate
		, RequiredDate
FROM Orders



-- nur die ausgeben, die schon gelifert worden sind

SELECT	  DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
		, ShippedDate
		, RequiredDate
FROM Orders
WHERE ShippedDate IS NOT NULL



-- nur die ausgeben, die noch nicht gelifert worden sind

SELECT	  DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
		, ShippedDate
		, RequiredDate
FROM Orders
WHERE ShippedDate IS NULL




-- nach Lieferverzögerung ordnen:
SELECT	  DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
		, ShippedDate
		, RequiredDate
FROM Orders
ORDER BY DATEDIFF(dd, RequiredDate, ShippedDate) -- ASC  -- müssen wir nicht dazuschreiben, ist Default
-- ohne weitere Angabe wird vom kleinsten zum größten Wert geordnet (ascending)



SELECT	  DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
		, ShippedDate
		, RequiredDate
FROM Orders
ORDER BY Lieferverzögerung -- hier dürfen wir das Spaltenalias verwenden (Order By passiert zuletzt)




SELECT	  DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
		, ShippedDate
		, RequiredDate
FROM Orders
ORDER BY Lieferverzögerung DESC -- descending (absteigend) (vom größten zum kleinsten Wert geordnet)




SELECT DATEADD(mi, 60, GETDATE()) -- 2021-05-04 13:39:03.080




-- Informationen zu Mitarbeitern:

-- EmployeeID
-- vollständiger Name (in einer Spalte)
-- Geburtsdatum (ohne Zeitangabe und leserlich)
-- Telefonnummer

SELECT	  EmployeeID
		, FirstName + ' ' + LastName AS FullName
		, FORMAT(BirthDate, 'd', 'de-de') AS BirthDate
		, HomePhone
FROM Employees


-- mit FORMAT und Culture-Parameter
SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, FORMAT(BirthDate, 'd', 'de-de') AS BirthDate
		, HomePhone
FROM Employees



-- mit CONVERT und Style-Parameter
SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, CONVERT(varchar, BirthDate, 104) AS BirthDate
		, HomePhone
FROM Employees




SELECT Region + City
FROM Customers
-- NULL + City = NULL


SELECT CONCAT(Region, '***', City)
FROM Customers
-- ***City


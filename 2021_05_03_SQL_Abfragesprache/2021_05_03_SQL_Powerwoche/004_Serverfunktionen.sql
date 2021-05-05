-- Serverfunktionen


-- ****************************************** Stringfunktionen *********************************************

-- TRIM


SELECT 'Test'


SELECT 'Test     '


SELECT RTRIM('Test     ') -- schneidet Leerzeichen auf der rechten Seite weg

SELECT '     Test'

SELECT LTRIM('     Test') -- schneidet Leerzeichen auf der linken Seite weg


SELECT TRIM('     Test     ') -- schneidet Leerzeichen auf beiden Seiten weg



-- LEN, DATALENGTH
-- wie viele Zeichen enthält ein Eintrag? Wie viel Speicherplatz?

SELECT LEN('Test') -- 4

SELECT LEN('Test     ') -- 4 (Leerzeichen am Ende werden NICHT mitgezählt)

SELECT LEN('     Test') -- 9 (Leerzeichen am Anfang werden mitgezählt)

SELECT LEN('Test Text') -- 9 (Leerzeichen in der Mitte werden mitgezählt)




SELECT DATALENGTH('Test') -- 4


SELECT DATALENGTH('Test     ') -- 9



-- mit DB:
SELECT	  CustomerID
		, CompanyName
		, DATALENGTH(CompanyName) AS [Data Comp]
		, LEN(CompanyName) AS [Len Comp]
		, DATALENGTH(CustomerID) AS [Data ID]
		, LEN(CustomerID) AS [Len ID]
FROM Customers

-- Achtung bei Datalength, wenn in UNICODE gespeichert wird (nchar, nvarchar) --> doppelt so viel wie Zeichen




-- ************************************* REVERSE *************************************


SELECT REVERSE('REITTIER')


SELECT REVERSE('Trug Tim eine so helle Hose nie mit Gurt?')



-- ********************************* Zeichen ausschneiden ******************************
-- LEFT, RIGTH, SUBSTRING


SELECT LEFT('Testtext    ', 4) -- Test  -- 4 Zeichen links ausschneiden
-- verschachteln von Funktionen:
SELECT LEFT(TRIM('Testtext    '), 4) -- Test


SELECT RIGHT('Testtext', 4) -- text -- 4 Zeichen rechts ausschneiden


SELECT SUBSTRING('Testtext', 4, 2) -- tt
-- beginnend bei Stelle 4
-- 2 Zeichen ausschneiden




-- *************************************** STUFF ********************************************
-- etwas einfügen oder ersetzen

-- einfügen:

SELECT STUFF('Testtext', 5, 0, '_Hallo_')
-- beginnend bei Stelle 5
-- 0 Zeichen löschen
-- _Hallo_ einfügen


-- entfernen oder ersetzen:
SELECT STUFF('Testtext', 4, 2, '_Hallo_')
-- beginnend bei Stelle 4
-- 2 Zeichen weglöschen
-- ersetzen mit _Hallo_





-- ************************************** CONCAT ********************************************

SELECT CONCAT('Test', 'text') -- Testtext

SELECT CONCAT('abc', 'def', 'ghi', 'jkl', 'mno', 'pqr', 'stu', 'vwx', 'yz')  -- abcdefghijklmnopqrstuvwxyz


SELECT CONCAT('Ich weiß, ', 'dass ich', ' nichts weiß.') AS Zitat


SELECT CONCAT('James', ' ', 'Bond') AS FullName


-- mit DB:

SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees



SELECT ContactName
FROM Customers


-- die letzten 3 Zeichen der Telefonnummer soll mit xxx ersetzt werden
-- 1234567890   --> 1234567xxx


-- Möglichkeit 1:
SELECT STUFF('1234567890', 8, 3, 'xxx')
-- funktioniert nur mit fixer Anzahl an Zeichen


-- Möglichkeit 2:
SELECT LEFT('1234567890', 7) + 'xxx'

SELECT CONCAT(LEFT('1234567890', 7), 'xxx')
-- funktioniert auch nur mit fixer Anzahl an Zeichen



-- Möglichkeit 3:

-- langsam:

-- wie viele Zeichen sind es insgesamt?
SELECT LEN('1234567890') -- 10


-- wie komme ich auf 8?
-- 10 - 2 = 8


-- einfach einsetzen:
SELECT STUFF('1234567890', LEN('1234567890')-2, 3, 'xxx')
-- funktioniert unabhängig von Anzahl der Zeichen


-- Möglichkeit 4:
--> wie kommen wir auf 7?
-- > 10-3 = 7

SELECT CONCAT(LEFT('1234567890', 10-3), 'xxx')
--> einsetzen:

SELECT CONCAT(LEFT('1234567890', LEN('1234567890')-3), 'xxx')


--> mit DB:


SELECT STUFF(Phone, LEN(Phone)-2, 3, 'xxx') AS Phone
FROM Customers


SELECT CONCAT(LEFT(Phone, LEN(Phone)-3), 'xxx')
FROM Customers




-- Möglichkeit 5:

-- langsam:

-- letzte Stellen unabhängig von der Länge?

SELECT REVERSE('1234567890') -- 0987654321

SELECT STUFF('0987654321', 1, 3, 'xxx') -- xxx7654321

SELECT REVERSE(STUFF('0987654321', 1, 3, 'xxx')) -- 1234567xxx

-- einsetzen:
SELECT REVERSE(STUFF(REVERSE('1234567890'), 1, 3, 'xxx')) -- 1234567xxx


-- mit DB:
SELECT REVERSE(STUFF(REVERSE(Phone), 1, 3, 'xxx'))
FROM Customers






-- ***************************************** REPLICATE *****************************************

SELECT REPLICATE('?', 5) -- ?????


SELECT REPLICATE('x', 3) -- xxx


-- funktioniert auch mit Zeichenfolgen:

SELECT REPLICATE('abc', 3) -- abcabcabc



-- ************************************** Groß-/Kleinschreibung bei Textausgaben ***********************

SELECT UPPER('test') -- TEST

SELECT LOWER('TEST') -- test



SELECT UPPER(FirstName)
FROM Employees





-- ******************************** REPLACE ********************************

SELECT REPLACE('Hallo!', 'a', 'e') -- Hello!


-- mehrere Zeichen ersetzen (verschachteln)

SELECT REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?') -- Hello?


SELECT REPLACE(REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?'), 'H', 'B') -- Bello?


-- Achtung: Replace ersetzt ALLE a mit e:
SELECT REPLACE('Hallotestatexta', 'a', 'e') -- Hellotestetexte




-- ************************************** CHARINDEX ************************************
-- gibt die erste Stelle zurück, an der sich das gesuchte Zeichen (oder Zeichenfolge) befindet


SELECT CHARINDEX('a', 'Leo') -- 0


SELECT CHARINDEX('e', 'Leo') -- 2


SELECT CHARINDEX(' ', 'James Bond') -- 6


-- funktioniert auch mit Sonderzeichen

SELECT CHARINDEX('$', '450$') -- 4

SELECT CHARINDEX('%', '50%') -- 3



-- Zeichenfolge:

SELECT CHARINDEX('schnecke', 'Zuckerschnecke') -- 7






-- wie bekommen wir die Stelle, an der sich das letzte Leerzeichen befindet?
-- Wolfgang Amadeus Mozart
--> Bonus: mit unterschiedlichen langen Namen?



-- langsam:

-- umdrehen:

SELECT REVERSE('Wolfgang Amadeus Mozart') -- trazoM suedamA gnagfloW


-- Stelle Leerzeichen?
SELECT CHARINDEX(' ', 'trazoM suedamA gnagfloW') -- 7


-- wie viele sind es insgesamt?
SELECT LEN('Wolfgang Amadeus Mozart') -- 23

-- Berechnung?
-- 23 - 7 = 16 ... aber richtige Stelle ist 17...!

--> 23 - 7 + 1 = richtige Stelle


-- einsetzen:

SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', REVERSE('Wolfgang Amadeus Mozart')) + 1 -- 17



-- unabhängig von Anzahl Zeichen:
SELECT LEN('Georg Friedrich Händel') - CHARINDEX(' ', REVERSE('Georg Friedrich Händel')) + 1 -- 16



-- Möglichkeit 2:
select charindex(' ', 'Georg Friedrich Händel') + charindex(' ',right('Georg Friedrich Händel',len('Georg Friedrich Händel')-charindex(' ', 'Georg Friedrich Händel')))





-- 1234567890  --> *******890
-- zuerst mit 1234567890
-- dann unabhängig von Länge mit Phone aus Customers-Tabelle
-- nur letzte 3 Zeichen anzeigen, andere mit * ersetzen 



-- langsam:

-- Teil 1:

SELECT STUFF('1234567890', 1, 7, '*******')



-- mehrere Zeichen einfügen:
SELECT REPLICATE('*', 7)


-- wie viele Zeichen gibt es insgesamt:
SELECT LEN('1234567890') -- 10


-- Replicate einsetzen:

SELECT STUFF('1234567890', 1, 7, REPLICATE('*', 7))


-- wie kommen wir auf 7?
-- 10 - 3 = 7
-- LEN('1234567890') - 3 = gewünschte Anzahl

--> einfügen:
SELECT STUFF('1234567890', 1, LEN('1234567890') - 3, REPLICATE('*', LEN('1234567890') - 3))


--> mit DB:

SELECT STUFF(Phone, 1, LEN(Phone) - 3, REPLICATE('*', LEN(Phone) - 3))
		, Phone
FROM Customers






-- andere Möglichkeit:
-- letzte 3 Zeichen ausschneiden:
SELECT RIGHT('1234567890', 3)  -- 890

SELECT CONCAT('*******', 890) -- *******890

SELECT CONCAT(REPLICATE('*', 7), RIGHT('1234567890', 3))


SELECT CONCAT(REPLICATE('*', LEN('1234567890') - 3), RIGHT('1234567890', 3))

--> mit DB: Phone einsetzen
SELECT CONCAT(REPLICATE('*', LEN(Phone) - 3), RIGHT(Phone, 3))
FROM Customers








-- mathematische Funktionen

SELECT PI() -- 3,14159265358979


SELECT SQUARE(5) -- 25

SELECT SQRT(25) -- 5  (sqrt = square root = Wurzel ziehen)


-- runden:

SELECT ROUND(3.14159265358979, 2) -- 3.14000000000000

SELECT FLOOR(3.9265358979) -- 3

SELECT CEILING(3.14159265358979) -- 4


-- einfache Abfragen


-- immer überprüfen, ob wir in der richtigen Datenbank sind!




USE Northwind;
GO  -- Batch Delimiter


-- ***************************************** Tabellenabfragen **********************************************

-- Sternchen = alle Spalten
-- keine gute Idee!
-- in der Realität IMMER ALLE Spalten hinschreiben, die ausgegeben werden sollen
-- auch, wenn es sich um alle Spalten handelt!

SELECT *
FROM Employees



-- bestimmte Spalte auswählen
SELECT EmployeeID
FROM Employees


-- mehrere Spalten auswählen
SELECT EmployeeID, FirstName, LastName, HomePhone
FROM Employees



-- Spalten untereinander schreiben zwecks besserer Lesbarkeit
SELECT  EmployeeID, 
		FirstName, 
		LastName,  -- Fehlermeldung wegen Komma
--		HomePhone
FROM Employees



-- Komma in nächste Zeile schreiben
SELECT	  EmployeeID
		, FirstName
		, LastName
--		, HomePhone
FROM Employees




-- Übungen


-- Kontaktinformationen von Kunden
SELECT	  CompanyName
		, ContactName
		, Address
		, PostalCode
		, Phone
FROM Customers


-- Produktinformationen ausgeben
SELECT	  ProductID
		, ProductName
		, UnitPrice
		, UnitsInStock
FROM Products




-- **************************************** ALIAS *******************************************
-- Spaltenüberschriften für Textausgabe vergeben
SELECT	  ProductID AS Produktnummer
		, ProductName AS Produktname
		, UnitPrice AS Preis
		, UnitsInStock
FROM Products


SELECT	  ProductID AS Produktnummer
		, ProductName AS Produktname
		, UnitPrice AS Preis
		, UnitsInStock AS [Anzahl lagernd]  -- wenn Leerzeichen enthalten: in eckige Klammern setzen!
FROM Products



-- AS darf theoretisch weggelassen werden
-- zwecks besserer Lesbarkeit besser stehen lassen!
-- nicht empfehlenswert
SELECT	  ProductID Produktnummer
		, ProductName Produktname
		, UnitPrice Preis
		, UnitsInStock [Anzahl lagernd]
FROM Products







-- ************************************* simple SELECT *******************************************

-- Zahl 
SELECT 123



-- Text
SELECT 'Testtext'

SELECT '123' -- Achtung, das ist jetzt Text!

SELECT '100*3' -- Achtung, das ist jetzt Text

-- SELECT Testtext  -- das wäre ein Spaltenname! 


-- Berechnungen
SELECT 100*3 -- 300


-- mit Abfrage aus der DB
SELECT Freight * 3 AS [Frachtkosten*3]  -- auch hier eckige Klammern notwendig!
		, Freight
FROM Orders


-- auch, wenn die Info aus DB kommt:
SELECT *
FROM [Order Details]



-- Annahme: Freight sind Nettofrachtkosten
-- Annahme: MwSt 19%
-- von allen Bestellungen: Nettofrachtkosten, Bruttofrachtkosten, MwSt

SELECT	  Freight AS Nettofrachtkosten
		, Freight*1.19 AS Bruttofrachtkosten
		, Freight*0.19 AS MwSt
FROM Orders








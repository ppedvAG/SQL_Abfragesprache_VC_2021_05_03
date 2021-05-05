-- WHERE clause; WHERE-Klausel; WHERE-Bedingung
-- Bedingungen, die die Ergebnismenge einschränken




/*

	-- WHERE Operatoren

		
		=, <, >, <=, >=

		!=, <>    ................ darf NICHT diesem Wert entsprechen

			-- wenn möglich, Abfrage positiv formulieren, da schneller als mit NOT
			-- positive Abfrage ist schneller, weil wir uns die Überprüfung im Hintergrund sparen



			-- mehr als eine Bedingung abfragen:

		AND ......... es müssen zwingend ALLE Bedingungen erfüllt sein (a UND b)
		OR .......... es muss mindestens eine Bedingung zutreffen (entweder a oder b oder ab)




*/



-- alle Zeilen, alle Spalten
SELECT *
FROM Customers


-- nur bestimmte Spalten, aber alle Zeilen
SELECT	  CustomerID
		, CompanyName
		, Phone
FROM Customers




-- nur die Kunden aus Deutschland
SELECT *
FROM Customers
WHERE Country = 'Germany'
-- 11 Zeilen



-- * durch gewünschte Spalten ersetzen!
SELECT    CustomerID
		, CompanyName
		, Phone
FROM Customers
WHERE Country = 'Germany'




-- mehrere Bedingungen abfragen
SELECT    CustomerID
		, CompanyName
		, Phone
FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'



-- alle Kunden aus deutschsprachigen Ländern
SELECT    CustomerID
		, CompanyName
		, Phone
		, Country
FROM Customers
WHERE Country = 'Germany' OR Country = 'Austria' OR Country = 'Switzerland'



-- Vergleiche anstellen
SELECT    CustomerID
		, OrderID
		, Freight
--		, ....
FROM Orders
WHERE Freight < 100
-- 643


SELECT    CustomerID
		, OrderID
		, Freight
--		, ....
FROM Orders
WHERE Freight >= 100
-- 187


-- darf NICHT einem bestimmten Wert entsprechen
SELECT    CustomerID
		, OrderID
		, Freight
--		, ....
FROM Orders
WHERE Freight != 148.33



-- alle spanischen und portugiesischen Kunden
SELECT *
FROM Customers
WHERE Country = 'Spain' OR Country = 'Portugal'
-- 7



-- alle Produkte, von denen mehr als 100 vorhanden sind
SELECT *
FROM Products
WHERE UnitsInStock > 100
-- 10




-- ****************************** IN ******************************************

SELECT *
FROM Customers
WHERE Country IN('Germany', 'Austria', 'Switzerland')





-- ******************************************** BETWEEN ***************************************

-- alle Bestellungen mit Frachtkosten >=100 und <= 200
SELECT *
FROM Orders
WHERE Freight >= 100 AND Freight <= 200
-- 114

-- oder kürzer:

SELECT *
FROM Orders
WHERE Freight BETWEEN 100 AND 200
-- 114
-- BETWEEN macht ein >= und <= 




-- alle Produkte mit einer ProduktID zwischen 10 und 15
SELECT *
FROM Products
WHERE ProductID BETWEEN 10 AND 15
-- 6


-- Produkte, die von Anbietern (SupplierID) 2, 7, 15 geliefert werden
SELECT *
FROM Products
WHERE SupplierID IN(2, 7, 15)
-- 12



-- alle Produkte von Anbietern 5, 10, 15; von denen mehr als 10 vorrätig sind und deren Stückpreis unter 100 liegt
SELECT *
FROM Products
WHERE SupplierID IN(5, 10, 15) AND UnitsInStock > 10 AND UnitPrice < 100
-- 6



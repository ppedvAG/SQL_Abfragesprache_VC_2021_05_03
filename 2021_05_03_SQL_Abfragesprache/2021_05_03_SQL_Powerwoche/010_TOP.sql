-- TOP
-- IMMER mit ORDER BY arbeiten
-- Anzahl der ausgegebenen Zeilen einschränken





-- nur die erste Zeile ausgeben

SELECT TOP 1 *
FROM Customers
-- ALFKI



-- WAS ist die erste Zeile?
-- abhängig vom ORDER BY


SELECT TOP 1 *
FROM Customers
ORDER BY CustomerID
-- ALFKI



SELECT TOP 1 *
FROM Customers
ORDER BY Country
-- CACTU


SELECT TOP 1 *
FROM Customers
ORDER BY City
-- DRACD


SELECT TOP 1 *
FROM Customers
ORDER BY Phone
-- MAISD



-- auch das WHERE beeinflusst, was in der ersten Zeile stehen kann
SELECT TOP 1 *
FROM Customers
WHERE Country = 'Austria'
-- ERNSH



SELECT TOP 1 *
FROM Customers
WHERE Country = 'Austria'
ORDER BY CustomerID
-- zufällig auch ERNSH




-- mit Spaltenangabe:

SELECT TOP 1 
			  CustomerID
			, CompanyName
FROM Customers
ORDER BY CustomerID



-- wir können auch nach Spalten ordnen, die im SELECT nicht vorkommen (Sinn? von Fall zu Fall entscheiden!)

SELECT TOP 1 
			  CustomerID
			, CompanyName
FROM Customers
ORDER BY City
-- DRACD



SELECT TOP 1 
			  CustomerID
			, CompanyName
FROM Customers
WHERE Region IS NOT NULL
ORDER BY City
-- RATTC




-- beliebige Zeilenanzahl angeben:
SELECT TOP 10 
			  CustomerID
			, CompanyName
FROM Customers
ORDER BY CustomerID


SELECT TOP 17 
			  CustomerID
			, CompanyName
FROM Customers
ORDER BY CustomerID





-- Prozentsatz der Datenmenge ausgeben mit TOP
-- PERCENT muss ausgeschrieben werden, % funktioniert dafür nicht

SELECT TOP 10 PERCENT *
FROM Customers
ORDER BY CustomerID

-- es wird auf den nächsten ganzzahligen Wert aufgerundet, also: 10





-- wie bekommen wir die letzen 5 Einträge?
SELECT TOP 5 *
FROM Customers
ORDER BY CustomerID DESC



-- ORDER BY
-- nach mehreren Spalten ordnen
SELECT    CustomerID
		, CompanyName
		, Country
		, City
		, Phone
FROM Customers
ORDER BY Country, City, CustomerID



SELECT    CustomerID
		, CompanyName
		, Country
		, City
		, Phone
FROM Customers
ORDER BY Country, City DESC, CustomerID







-- mit TOP-Befehl:
-- Top 10% der Produkte mit den größten Verkaufsmengen (pro Bestellposten, nicht insgesamt)
-- Produktname, Anzahl

SELECT TOP 10 PERCENT
					  o.OrderID
					, od.Quantity
					, p.ProductID
					, p.ProductName
FROM [Order Details] od INNER JOIN Products p ON od.ProductID = p.ProductID INNER JOIN Orders o ON od.OrderID = o.OrderID
ORDER BY Quantity DESC, p.ProductName


-- Mehrfacheinträge ausschließen
SELECT DISTINCT TOP 10 PERCENT
			--		  o.OrderID
					  od.Quantity
					, p.ProductID
					, p.ProductName
FROM [Order Details] od INNER JOIN Products p ON od.ProductID = p.ProductID INNER JOIN Orders o ON od.OrderID = o.OrderID
ORDER BY Quantity DESC, p.ProductName





-- mit TOP-Befehl:

-- was ist das teuerste Produkt?
-- was ist das günstigste Produkt?



SELECT TOP 1 *
FROM Products
ORDER BY UnitPrice DESC
-- Côte de Blaye, 263,50


SELECT TOP 1 *
FROM Products
ORDER BY UnitPrice
-- Geitost, 2,50





-- mit TOP-Befehl!
-- die 3 Mitarbeiter, die schon am längsten im Unternehmen sind
-- Name in einer Spalte
-- Datum ohne Uhrzeit!

-- mit FORMAT
SELECT TOP 3
		  CONCAT(FirstName, ' ', LastName)
		, FORMAT(HireDate, 'd', 'de-de')
FROM Employees
ORDER BY HireDate


---mit CONVERT 
SELECT TOP 3
		  CONCAT(FirstName, ' ', LastName)
		, CONVERT(varchar, HireDate, 104)
FROM Employees
ORDER BY HireDate



-- wie lange sind sie schon dabei?
SELECT TOP 3
		  CONCAT(FirstName, ' ', LastName)
		, FORMAT(HireDate, 'd', 'de-de')
		, DATEDIFF(year, HireDate, GETDATE())
FROM Employees
ORDER BY HireDate


-- oder genauer:
SELECT TOP 3
		  CONCAT(FirstName, ' ', LastName) AS EmpName
		, FORMAT(HireDate, 'd', 'de-de') AS HireDate
		, FLOOR(DATEDIFF(dd, HireDate, GETDATE())/365.25) AS [years in company]
FROM Employees
ORDER BY HireDate







-- WITH TIES

SELECT TOP 17 WITH TIES
			  Freight
			, OrderID
	--		, ....
FROM Orders
ORDER BY Freight



-- Produkte mit größten Verkaufsmengen with ties

SELECT TOP 10 PERCENT
					  o.OrderID
					, od.Quantity
					, p.ProductID
					, p.ProductName
FROM [Order Details] od INNER JOIN Products p ON od.ProductID = p.ProductID INNER JOIN Orders o ON od.OrderID = o.OrderID
ORDER BY Quantity DESC, p.ProductName
-- 216 Zeilen


SELECT TOP 10 PERCENT WITH TIES
					  o.OrderID
					, od.Quantity
					, p.ProductID
					, p.ProductName
FROM [Order Details] od INNER JOIN Products p ON od.ProductID = p.ProductID INNER JOIN Orders o ON od.OrderID = o.OrderID
ORDER BY Quantity DESC, p.ProductName
-- 219





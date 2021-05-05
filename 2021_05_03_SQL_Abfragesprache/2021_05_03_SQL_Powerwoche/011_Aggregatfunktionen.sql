-- Aggregatfunktionen

/*
	COUNT
	AVG
	SUM
	MIN
	MAX


*/

-- in wie vielen Ländern haben wir Kunden?

SELECT Country
FROM Customers
-- 91... so viele wie Kunden


SELECT DISTINCT Country
FROM Customers
-- 21... so viele wie Länder



SELECT COUNT(Country)
FROM Customers
-- 91 wieder so viele, wie es insgesamt Kunden gibt!


-- wie viele UNTERSCHIEDLICHE Länder gibt es?
SELECT COUNT(DISTINCT Country)
FROM Customers
-- 21



-- wie viele Kunden gibt es?
SELECT COUNT(*)
FROM Customers
-- 91

SELECT COUNT(CustomerID)
FROM Customers
-- 91


-- Achtung:
SELECT COUNT(Region)
FROM Customers
-- 31
-- Insgesamt Einträge in der Region-Spalte... viele NULL!




SELECT COUNT(DISTINCT Region)
FROM Customers
-- 18
-- unterschiedliche Regionen



-- wie viele Produkte haben wir insgesamt?
SELECT COUNT(ProductID)
FROM Products
-- 77




-- Durchschnittswert berechnen

SELECT AVG(UnitPrice)  -- average
FROM Products
-- 28,8663



-- Summen bilden
SELECT SUM(Freight)
FROM Orders
-- 64942,69



-- größter/kleinster Wert mit MIN/MAX

-- teuerstes Produkt
SELECT MAX(UnitPrice)
FROM Products
-- 263,50


-- günstigstes Produkt
SELECT MIN(UnitPrice)
FROM Products
-- 2,50




-- bringt nix!!!
SELECT SUM(Freight), OrderID, CustomerID
FROM Orders
GROUP BY OrderID, CustomerID
-- Summe der Frachtkosten pro OrderID = Frachtkosten der jeweiligen Bestellung




-- Frachtkosten pro Kunde
SELECT SUM(Freight), CustomerID
FROM Orders
GROUP BY CustomerID
-- 89 Zeilen (zwei haben noch nichts bestellt)




SELECT SUM(Freight), ShipCountry, ShipCity
FROM Orders
GROUP BY ShipCountry, ShipCity




-- durschnittliche Frachtkosten pro Frachtunternehmen?
SELECT    ShipVia
		, AVG(Freight) AS avgFreight
FROM Orders
GROUP BY ShipVia

-- mit Name Frachtunternehmen:
SELECT    o.ShipVia
		, s.CompanyName
		, AVG(o.Freight) AS avgFreight
FROM Orders o INNER JOIN Shippers s ON o.ShipVia = s.ShipperID
GROUP BY o.ShipVia, s.CompanyName



-- Summe der Bierbestellungen pro Kunde

SELECT	 
		  c.CustomerID
		, c.CompanyName
		, SUM(od.Quantity) AS sumQuantity
		, p.ProductName
FROM Orders o INNER JOIN Customers c on o.CustomerID = c.CustomerID 
				INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
					INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE ProductName LIKE '%bier%' OR ProductName LIKE '%lager%' OR ProductName LIKE '%ale'
GROUP BY c.CustomerID, c.CompanyName, p.ProductName
ORDER BY c.CompanyName DESC

-- welcher Kunde hat am meisten bestellt?
SELECT TOP 1 
		  c.CustomerID
		, c.CompanyName
		, SUM(od.Quantity) AS sumQuantity
		, p.ProductName
FROM Orders o INNER JOIN Customers c on o.CustomerID = c.CustomerID 
				INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
					INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE ProductName LIKE '%bier%' OR ProductName LIKE '%lager%' OR ProductName LIKE '%ale'
GROUP BY c.CustomerID, c.CompanyName, p.ProductName
ORDER BY sumQuantity DESC
-- SAVEA





-- Summe der Frachtkosten pro Kunde im jeweiligen Land
-- aus dem Jahr 1996
-- mit Spaltenüberschrift
-- wer hat am wenigsten Frachtkosten bezahlt? (aufsteigend geordnet)

-- CustomerID, CompanyName, Summe Frachtkosten, Country


SELECT	  SUM(Freight) AS SumFreight
		, c.CustomerID
		, c.CompanyName
		, c.Country
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(OrderDate) = 1996
GROUP BY c.CustomerID, c.CompanyName, c.Country
ORDER BY SumFreight
-- 67








-- ********************************* HAVING ******************************************




-- Länder, in denen wir mehr als 5 Kunden haben

-- erste Idee:
SELECT COUNT(CustomerID)
		, Country
FROM Customers
WHERE COUNT(CustomerID) > 5 -- falsch!
GROUP BY Country
-- funktioniert NICHT!


-- > HAVING
SELECT COUNT(CustomerID)
		, Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5


-- größte Anzahl zuerst
SELECT COUNT(CustomerID) AS CountCustomers
		, Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5
ORDER BY CountCustomers DESC
-- 5 Zeilen




-- alle Angestellten, die mehr als 70 Bestellungen bearbeitet haben
-- inklusive Name
-- wie viele Bestellungen

-- langsam:

-- Angestellte?

SELECT CONCAT(FirstName, ' ', Lastname)
FROM Employees

-- wie viele Bestellungen gibt es insgesamt?
SELECT COUNT(OrderID)
FROM Orders

-->
-- wie viele Bestellungen pro Angestellter?

SELECT	  COUNT(OrderID)
		, EmployeeID
FROM Orders
GROUP BY EmployeeID





SELECT	  COUNT(OrderID) AS CountOrders
		, e.EmployeeID
		, CONCAT(e.FirstName, ' ', e.Lastname) AS EmpName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE COUNT(OrderID) > 70 -- funktioniert NICHT mit WHERE!!!!
GROUP BY e.EmployeeID, e.FirstName, e.LastName


-->
SELECT	  COUNT(OrderID) AS CountOrders
		, e.EmployeeID
		, CONCAT(e.FirstName, ' ', e.Lastname) AS EmpName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(OrderID) > 70 


-- wer hat denn die meisten bearbeitet?
SELECT	  COUNT(OrderID) AS CountOrders
		, e.EmployeeID
		, CONCAT(e.FirstName, ' ', e.Lastname) AS EmpName
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(OrderID) > 70 
ORDER BY CountOrders DESC









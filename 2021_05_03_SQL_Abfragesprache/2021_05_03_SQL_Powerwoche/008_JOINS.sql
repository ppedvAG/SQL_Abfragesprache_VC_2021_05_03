-- JOINS


-- Informationen aus mehreren Tabellen abfragen



-- INNER JOIN


-- OUTER JOIN 
			-- (LEFT JOIN oder RIGHT JOIN)





-- ************************************* INNER JOIN *********************************************


SELECT *
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID


-- bestimmte Spalten auswählen
SELECT	  OrderID
		, CustomerID -- Ambiguous column name 'CustomerID'.
		, Address
		, City
		, Country
		, OrderDate
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID


-- wenn Spaltenname mehrfach vorkommt, MÜSSEN wir dazuschreiben, aus welcher Tabelle
SELECT	  OrderID
		, Customers.CustomerID
		, Address
		, City
		, Country
		, OrderDate
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID



-- bei den anderen SOLLTEN wir dazuschreiben, aus welcher Tabelle
SELECT	  Orders.OrderID
		, Customers.CustomerID
		, Customers.Address
		, Customers.City
		, Customers.Country
		, Orders.OrderDate
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID



-- bisschen kürzere Schreibweise
SELECT	  o.OrderID
		, c.CustomerID
		, c.Address
		, c.City
		, c.Country
		, o.OrderDate
FROM Customers AS c INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID




-- bisschen kürzere Schreibweise
-- wir dürfen AS weglassen

SELECT	  o.OrderID
		, c.CustomerID
		, c.Address
		, c.City
		, c.Country
		, o.OrderDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID



-- mit WHERE
-- nur Kunden aus Deutschland

SELECT	  o.OrderID
		, c.CustomerID
		, c.Address
		, c.City
		, c.Country
		, o.OrderDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE Country = 'Germany'





-- alle Kunden aus Brasilien und deren Frachtkosten
-- höchste Frachtkosten zuerst
SELECT	  c.CustomerID
		, c.CompanyName
		, o.Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE Country = 'Brazil'
ORDER BY Freight DESC




-- Alle Anbieter (Supplier), die Sauce verkaufen
-- CompanyName, ProductName
-- Ansprechperson, Tel,...
-- Achtung: wie heißen die Produkte? Mehrere Möglichkeiten?

SELECT	  s.CompanyName
		, s.ContactName
		, s.Phone
		, p.ProductName
FROM Suppliers AS s INNER JOIN Products AS p ON p.SupplierID = s.SupplierID
WHERE p.ProductName LIKE '%sauce%'


-- gibts noch andere Saucen?
SELECT	  s.CompanyName
		, s.ContactName
		, s.Phone
		, p.ProductName
FROM Suppliers AS s INNER JOIN Products AS p ON p.SupplierID = s.SupplierID
WHERE p.ProductName LIKE '%sauce%' OR p.ProductName LIKE N'%soße%'




-- Angenommen, es gab Beschwerden bei Bestellungen
-- Bestellnr. 10251, 10280, 10990, 11000
-- Welche/r Angestellte/r hat die Bestellungen bearbeitet?
-- OrderID, Angestellte(r) Name

SELECT	  o.OrderID
		, e.EmployeeID
		, CONCAT(e.FirstName, ' ', e.LastName) AS FullName
FROM Orders o INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID
WHERE o.OrderID IN(10251, 10280, 10990, 11000)






-- mehr als eine Tabelle miteinander verjoinen:

SELECT	  c.CompanyName  AS Kunde
		, o.OrderID AS Bestellung
		, s.CompanyName AS Frachtunternehmen
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID 
					INNER JOIN Suppliers s ON s.SupplierID = o.ShipVia


-- voriges Beispiel, aber mit Kunden
SELECT	  o.OrderID
		, e.EmployeeID
		, CONCAT(e.FirstName, ' ', e.LastName) AS FullName
		, c.CompanyName AS Customer
FROM Orders o INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID 
				INNER JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderID IN(10251, 10280, 10990, 11000)



-- welche Kunden haben Chai-Tee gekauft und wie viel (pro Bestellung)
-- Achtung: Name?
-- OrderID, CustomerID, CompanyName, ProductName, Quantity

SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, p.ProductName
		, od.Quantity
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID 
				INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
					INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductName LIKE '%chai%'


-- Pause!
SELECT DATEADD(mi, 15, GETDATE()) -- 2021-05-04 15:51:22.780



-- ******************************** OUTER JOIN *****************************************


-- RIGHT JOIN 
SELECT	  o.OrderID
		, c.CustomerID
		, c.Address
		, c.City
		, c.Country
		, o.OrderDate
FROM Customers c RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID
-- 830




-- LEFT JOIN 
SELECT	  o.OrderID
		, c.CustomerID
		, c.Address
		, c.City
		, c.Country
		, o.OrderDate
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
-- 832





-- welche Kunden haben noch nichts bestellt??

-- mit INNER JOIN??
-- FALSCH!
SELECT	  o.OrderID
		, c.CustomerID
		, c.Address
		, c.City
		, c.Country
		, o.OrderDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
-- mit is null --> keine!



-- RIGHT JOIN??
-- in unserem Fall: falsch
SELECT	  o.OrderID
		, c.CustomerID
		, c.Address
		, c.City
		, c.Country
		, o.OrderDate
FROM Customers c RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
-- mit is null --> keine!


-- LEFT JOIN!
SELECT	  o.OrderID
		, c.CustomerID
		, c.Address
		, c.City
		, c.Country
		, o.OrderDate
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
-- 2 Kunden haben noch nichts bestellt
--> ALLE Informationen von Kunden, auch von denen, die noch nichts bestellt haben (und daher nicht in der Orders-Tabelle aufscheinen)


-- hier ist es nicht mehr egal, aus welcher Tabelle die Information zu CustomerID kommt:

SELECT	  o.OrderID
		, o.CustomerID -- die noch nichts bestellt haben, stehen in Orders-Tabelle nicht drin!!
		, c.Address
		, c.City
		, c.Country
		, o.OrderDate
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
-- in der CustomerID steht NULL!



-- funktioniert es noch, wenn wir Orders und Customers tauschen?
-- ja, mit anderem outer join!
SELECT	  o.OrderID
		, c.CustomerID
		, c.Address
		, c.City
		, c.Country
		, o.OrderDate
FROM Orders o RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID




-- Sonderfälle: SELF JOIN

/*

		-- Liste von Mitfahrgelegenheiten...

			Leo  -  Hugo
			Leo  - Fritz
			Hugo - Leo
			Hugo - Fritz
			Fritz - Leo
			Fritz - Hugo


*/

-- Name1  City1  Name2  Kontrollfeld (City2)

--  Leo   Wien    Hugo     Wien



-- erste Idee:

SELECT ContactName
		, City
		, ContactName
		, City
FROM Customers 
-- falsch! Jeder steht neben dem eigenen Namen.


-- Self Join:
-- Tabelle mit sich selbst verjoinen (wir tun so, als gäbe es eine zweite Tabelle)

SELECT	  c1.ContactName
		, c1.City
		, c2.ContactName
		, c2.City
FROM Customers c1 INNER JOIN Customers c2 ON c1.City = c2.City
-- 2. Sonderfall: wir verknüpfen über City! (nicht über Schlüsselfelder)

-- wenn die nicht neben sich selbst stehen sollen:
SELECT	  c1.ContactName
		, c1.City
		, c2.ContactName
--		, c2.City -- Kontrollfeld
FROM Customers c1 INNER JOIN Customers c2 ON c1.City = c2.City
WHERE c1.CustomerID != c2.CustomerID
ORDER BY City



-- Wer ist der Chef von wem?

--  Name Angestellter    EmpID      Name Chef      ChefId(Kontrollfeld)

SELECT	  emp.LastName
		, emp.EmployeeID
		, boss.LastName
		, boss.EmployeeID
FROM Employees emp INNER JOIN Employees boss ON emp.ReportsTo = boss.EmployeeID



-- wenn wir wollen, dass der Chef selbst auch dabei steht (oder alle, die keinen Chef haben)
SELECT	  emp.LastName
		, emp.EmployeeID
		, boss.LastName
		, boss.EmployeeID
FROM Employees emp LEFT JOIN Employees boss ON emp.ReportsTo = boss.EmployeeID





SELECT	  CONCAT(emp.FirstName, ' ', emp.LastName) AS EmpName
		, emp.EmployeeID
		, CONCAT(boss.FirstName, ' ', boss.LastName) AS BossName
		, boss.EmployeeID
FROM Employees emp INNER JOIN Employees boss ON emp.ReportsTo = boss.EmployeeID
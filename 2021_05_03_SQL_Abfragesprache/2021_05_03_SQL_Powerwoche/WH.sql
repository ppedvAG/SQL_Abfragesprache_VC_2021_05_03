-- Wiederholung




-- SELECT	  Spaltenname1 AS Spaltenüberschrift
--		, Spaltenname2
-- FROM Employees
-- WHERE Bedingung = 123




-- alle Employees, mit ID 5-8, deren Name ein a enthält

SELECT *
FROM Employees
WHERE EmployeeID BETWEEN 5 AND 8 AND LastName LIKE '%a%'


-- sp_help Employees

-- select * from AdventureWorks2019.information_schema.columns



-- alle Kunden (CompanyName), die mit a, b oder c oder e, f oder g enden
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c]' OR CompanyName LIKE '%[e-g]'


-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%a' OR CompanyName LIKE '%b' OR CompanyName LIKE '%c' OR CompanyName LIKE '%e' OR CompanyName LIKE '%f' OR CompanyName LIKE '%g'


-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[abcefg]'




-- alle Produkte, die mit coffee enden
SELECT *
FROM Products
WHERE ProductName LIKE '%coffee'


-- alle Produkte, die ein 'ost' im Namen haben
SELECT *
FROM Products
WHERE ProductName LIKE '%ost%'
-- Achtung: Zeichenfolgen --> kommt genau das heraus, was ich mir vorgestellt habe? Wenn wir "Osten" (Himmelsrichtung) gemeint haben, dann nicht... KlOSTerbier, ROSTbratwurst...







-- Bestellungen, bei denen Bier verkauft wurde
-- Welcher Kunde (CompanyName)?
-- Wieviel? (pro Bestellung)
-- Welches Bier? (Name)

-- Produktname kann "Bier" oder "Lager" enthalten oder mit "Ale" enden


SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, od.Quantity
		, p.ProductName
FROM Orders o INNER JOIN Customers c on o.CustomerID = c.CustomerID 
				INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
					INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE ProductName LIKE '%bier%' OR ProductName LIKE '%lager%' OR ProductName LIKE '%ale'




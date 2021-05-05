-- Sichten (VIEWS)




CREATE VIEW v_Test01
AS
SELECT CustomerID, CompanyName
FROM Customers


SELECT CustomerID
FROM v_Test01
WHERE CustomerID LIKE 'A%'


CREATE VIEW v_Rechnungen01
AS
SELECT c.CustomerID
		, c.CompanyName
		, o.OrderID
		, o.OrderDate
		, od.Quantity
		, p.ProductID
		, p.ProductName
		, p.UnitPrice
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID 
					INNER JOIN [Order Details] od ON o.OrderID = od.OrderID 
						INNER JOIN Products p ON od.ProductID = p.ProductID






SELECT CustomerID, OrderDate, ProductName
FROM v_Rechnungen01










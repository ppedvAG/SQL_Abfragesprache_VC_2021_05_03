-- SET-Operatoren

/*

	UNION, UNION ALL, INTERSECT, EXCEPT

*/




-- ************************************* UNION ********************************

SELECT 'Testtext1'
UNION
SELECT 'Testtext2'




-- Achtung: gleiche Anzahl an Spalten!
SELECT 'Testtext1', 'Testtext3'
UNION
SELECT 'Testtext2'
-- All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.


-- das funktioniert:
SELECT 'Testtext1', 'Testtext3'
UNION
SELECT 'Testtext2', 'Testtext4'



-- Achtung: gleiche Datentypen!
SELECT 'Testtext1', 'Testtext3'
UNION
SELECT 'Testtext2', 123
-- Conversion failed when converting the varchar value 'Testtext3' to data type int.



-- wir dürfen Spalten mit NULL auffüllen
-- Sinn? Von Fall zu Fall überlegen!
SELECT 'Testtext1', 'Testtext3'
UNION
SELECT 'Testtext2', NULL




-- explizit konvertieren ist erlaubt:
SELECT 'Testtext1', 'Testtext3'
UNION
SELECT 'Testtext2', CAST(123 AS varchar(10))



-- CustomerID/EmployeeID  -- ContactName/LastName


-- funktioniert NICHT:
SELECT CustomerID, ContactName
FROM Customers
UNION
SELECT EmployeeID, LastName
FROM Employees
-- Conversion failed when converting the nvarchar value 'ALFKI' to data type int.



-- explizit konvertieren:
SELECT CustomerID AS ID, ContactName AS Name
FROM Customers
UNION
SELECT CAST(EmployeeID AS nvarchar(30)), LastName
FROM Employees
ORDER BY ID



-- CONCAT funktioniert:
SELECT CustomerID AS ID, ContactName AS Name
FROM Customers
UNION
SELECT CAST(EmployeeID AS nvarchar(30)), CONCAT(FirstName, ' ', LastName)
FROM Employees
ORDER BY ID





-- möglich, aber Sinn? (Von Fall zu Fall entscheiden)
SELECT CustomerID AS ID, ContactName AS Name
FROM Customers
UNION
SELECT 'blabla', CONCAT(FirstName, ' ', LastName)
FROM Employees
ORDER BY ID




-- Achtung:

SELECT 'Testtext', 123
UNION
SELECT 'Testtext', 123
-- UNION macht auch ein DISTINCT







-- UNION ALL
-- wenn wir Mehrfacheinträge ausgeben möchten:
SELECT 'Testtext', 123
UNION ALL
SELECT 'Testtext', 123






-- ******************************** INTERSECT *********************************

SELECT 'Testtext'
INTERSECT
SELECT 'Testtext'
-- Testtext



CREATE TABLE #a (id int)

CREATE TABLE #b (id int)


INSERT INTO #a (id) VALUES (1), (NULL), (2), (1)

INSERT INTO #b (id) VALUES (1), (NULL), (3), (1)


-- UNION:
SELECT id
FROM #a
UNION
SELECT id
FROM #b
-- NULL, 1, 2, 3



-- UNION ALL:
SELECT id
FROM #a
UNION ALL
SELECT id
FROM #b
-- 1, NULL, 2, 1, 1, NULL, 3, 1



-- INTERSECT:

SELECT id
FROM #a
INTERSECT
SELECT id
FROM #b
-- NULL, 1



-- EXCEPT:
SELECT id
FROM #a
EXCEPT
SELECT id
FROM #b
-- 2

SELECT id
FROM #b
EXCEPT
SELECT id
FROM #a
-- 3




-- ******************************* im Unterschied dazu - was machen JOINS?? *****************

-- INNER JOIN
SELECT a.id
FROM #a a INNER JOIN #b b ON a.id = b.id
-- 1, 1, 1, 1


-- LEFT JOIN
SELECT a.id
FROM #a a LEFT JOIN #b b ON a.id = b.id
-- 1, 1, NULL, 2, 1, 1



-- RIGHT JOIN
SELECT a.id
FROM #a a RIGHT JOIN #b b ON a.id = b.id
-- 1, 1, NULL, NULL, 1, 1
-- WARUUM? Wo ist mein 3?



SELECT b.id
FROM #a a RIGHT JOIN #b b ON a.id = b.id
-- 1, 1, NULL, 3, 1, 1
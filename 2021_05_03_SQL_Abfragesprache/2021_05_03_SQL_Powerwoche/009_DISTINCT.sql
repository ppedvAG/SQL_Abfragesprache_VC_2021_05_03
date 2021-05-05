-- DISTINCT
-- mit Distinct Mehrfachausgaben verhindern



-- alle L�nder, in denen wir Kunden haben


-- erste Idee:

SELECT Country
FROM Customers
-- falsch
-- so viele Eintr�ge, wie es insgesamt Kunden gibt


-- mit DISTINCT!
SELECT DISTINCT Country
FROM Customers
-- 21 verschiedene L�nder




-- DISTINCT gilt f�r ALLE Spalten im SELECT


SELECT DISTINCT Country, CustomerID
FROM Customers
-- wieder 91, so viele, wie Kunden




SELECT DISTINCT Country, City
FROM Customers
-- 69 (so viele wie Cities)




-- mit ORDER BY:
SELECT DISTINCT Country, City
FROM Customers
ORDER BY Country



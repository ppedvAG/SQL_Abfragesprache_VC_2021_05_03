-- Wildcards


/*

		% ....................... steht für beliebig viele unbekannte Zeichen (0 - ?)
		_ ....................... steht für GENAU EIN unbekanntes Zeichen
		[] ...................... steht für GENAU EIN unbekanntes Zeichen aus einem definierten Wertebereich

		|  ...................... OR innerhalb der eckigen Klammern
		^  ...................... NOT innerhalb der eckigen Klammern


*/








-- ******************************************** % **********************************************
-- beliebig viele unbekannte Zeichen gesucht


SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALF%'


/*
	-- mögliche Ergebnisse:

			ALF
			ALFXX
			ALFKI

*/



-- Land, das mit A beginnt
SELECT *
FROM Customers
WHERE Country LIKE 'A%'



-- Customer, der mit MI
SELECT *
FROM Customers
WHERE CustomerID LIKE '%MI'
-- COMMI



-- kann Zeichenfolge enthalten:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%kiste%'





-- ******************************************  _  *******************************************
-- Suche nach genau 1 unbekannten Zeichen

-- Annahme: letzte Stelle der Telefonnummer ist Durchwahl für unterschiedliche Kontaktpersonen innerhalb eines Unternehmens (Abteilungen, ...)
SELECT *
FROM Customers
WHERE Phone LIKE '(5) 555-472_'




-- **************************************** [] ***********************************************
-- Wertebereich abfragen


-- Kunden, die a oder b oder c

SELECT *
FROM Customers
WHERE CustomerID LIKE 'A%' OR CustomerID LIKE 'B%' OR CustomerID LIKE 'C%'


-- oder kürzer:
SELECT *
FROM Customers
WHERE CustomerID LIKE '[a-c]%'



-- wenn nicht zusammenhängend:
-- a, f oder m
SELECT *
FROM Customers
WHERE CustomerID LIKE '[afm]%'




-- wie müssten wir nach einem Kunden suchen, dessen CustomerID mit afm beginnt?
SELECT *
FROM Customers
WHERE CustomerID LIKE 'afm%'
-- in unserem Fall kein Ergebnis




-- Suche nach CompanyName mit %-Zeichen im Namen?

SELECT *
FROM Customers
WHERE CompanyName LIKE '%[%]%' -- eckige Klammern, denn %-Zeichen hat eine andere Bedeutung


-- mit Escape-Character:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%!%%' ESCAPE '!'




-- Hochkomma ist Sonderfall
SELECT *
FROM Customers
WHERE CompanyName LIKE '%''%'  -- Ausnahme! 2x '' schreiben, sonst Fehler!




-- alle Kunden, die mit a beginnen und mit e enden?


SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%' AND CompanyName LIKE '%e'

-- oder kürzer:
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%e'



-- ********************************* oder in [ ] ******************************************************
-- alle Kunden (CompanyName), die mit a, b oder c oder e, f oder g enden


SELECT *
FROM Customers
WHERE CompanyName LIKE '%a' OR CompanyName LIKE '%b' OR CompanyName LIKE '%c' OR CompanyName LIKE '%e' OR CompanyName LIKE '%f' OR CompanyName LIKE '%g'


-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c]' OR CompanyName LIKE '%[e-g]'



-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[abcefg]'


-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c | e-f]'



-- alle Produkte, die ein 'ost' im Namen haben
SELECT *
FROM Products
WHERE ProductName LIKE '%ost%'
-- Achtung: Zeichenfolgen --> kommt genau das heraus, was ich mir vorgestellt habe? Wenn wir "Osten" (Himmelsrichtung) gemeint haben, dann nicht... KlOSTerbier, ROSTbratwurst...




-- alle Produkte, deren Name mit D-L beginnt und mit a, b, c, d oder m, n, o endet
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND (ProductName LIKE '%[a-d]' OR ProductName LIKE '%[m-o]')
-- Achtung: Klammern setzen! (Sonst "gewinnt" das AND vor dem OR)


-- oder:
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND ProductName LIKE '%[abcd | mno]'


-- oder:
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%[a-d | m-o]'



-- alle Kunden, deren Companyname mit d, e oder f beginnt, der letzte Buchstabe ist ein L und der DRITTLETZTE Buchstabe ist ein D
SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%d_l'

/*

	-- mögliche Ergebnisse:

			edel
			fidel
			ddxl
			dxxxxxxxxxxxxxxxxxxxxxxdxl


			Ernst Handel (Northwind DB)
			e........d.l
					   			 		  
*/


-- ************************************** NOT in [] ********************************
-- alle, die NICHT mit a-c beginnen

SELECT *
FROM Customers
WHERE CompanyName LIKE '[^a-c]%'


-- positiv formuliert:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-z]%'

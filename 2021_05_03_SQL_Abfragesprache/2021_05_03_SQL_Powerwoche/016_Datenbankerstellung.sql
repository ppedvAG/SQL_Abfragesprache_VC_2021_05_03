-- Datenbankerstellung


CREATE DATABASE Test

USE Test



CREATE TABLE Orders (
						OrderID int PRIMARY KEY,
						CustomerID int,
						OrderDate date,
						Freight money
						-- ....
					 )



CREATE TABLE Customers (
							CustomerID int PRIMARY KEY,
							CompanyName nvarchar(30),
							City nvarchar(30)
							-- .....
						)




ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)





CREATE TABLE Produkte (
							ProduktID int identity PRIMARY KEY,
							ProduktName nvarchar(30),
							Preis money
							--......
					   )


-- identity macht auch ein NOT NULL und ein UNIQUE

-- drop table Produkte
-- identity beginnt bei 1 zu zählen und zählt jeweils 1 weiter
-- identity(1000, 10) --> wir beginnen bei 1000 zu zählen und zählen jeweils 10 weiter


-- nicht so gut!!!
INSERT INTO Produkte
VALUES ('Spaghetti', 1.99)

-- ID NIE händisch eingeben!




-- Achtung:
INSERT INTO Produkte
VALUES (1.99, 'Spaghetti')
-- Cannot convert a char value to money. The char value has incorrect syntax.


-- besser:
INSERT INTO Produkte(Preis, ProduktName)
VALUES (1.99, 'Spaghetti')
-- dazuschreiben, in welche Spalten welche Informationen kommen!!!



-- mehrere Informationen einfügen:
INSERT INTO Produkte(Preis, ProduktName)
VALUES  (1.99, 'Spaghetti'),
		(4.99, 'Profiterols'),
		(5.99, 'Tiramisu'),
		(3.99, 'Limoncello'),
		(2.99, 'Biscotti')





-- Werte verändern mit UPDATE
-- IMMER mit WHERE einschränken
-- sonst wird der Preis für ALLE vergeben!!
UPDATE Produkte
SET Preis = 5.89
WHERE ProduktID = 5



-- Werte rauslöschen mit DELETE
-- ACHTUNG: DELETE FROM Produkte ohne WHERE löscht GESAMTEN Inhalt der Tabelle
DELETE FROM Produkte
WHERE ProduktID = 3


DELETE FROM Produkte
WHERE ProduktID IN(4, 9)


SELECT *
FROM Produkte




-- Tabelle selbst verändern mit ALTER TABLE

ALTER TABLE Produkte
ALTER COLUMN ProduktName nvarchar(50)




ALTER TABLE Produkte
ADD Email nvarchar(50)



-- ups, leider Fehler passiert, Email-Spalte soll nicht in Produkte-Tabelle:
ALTER TABLE Produkte
DROP COLUMN Email










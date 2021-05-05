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
-- identity beginnt bei 1 zu z�hlen und z�hlt jeweils 1 weiter
-- identity(1000, 10) --> wir beginnen bei 1000 zu z�hlen und z�hlen jeweils 10 weiter


-- nicht so gut!!!
INSERT INTO Produkte
VALUES ('Spaghetti', 1.99)

-- ID NIE h�ndisch eingeben!




-- Achtung:
INSERT INTO Produkte
VALUES (1.99, 'Spaghetti')
-- Cannot convert a char value to money. The char value has incorrect syntax.


-- besser:
INSERT INTO Produkte(Preis, ProduktName)
VALUES (1.99, 'Spaghetti')
-- dazuschreiben, in welche Spalten welche Informationen kommen!!!



-- mehrere Informationen einf�gen:
INSERT INTO Produkte(Preis, ProduktName)
VALUES  (1.99, 'Spaghetti'),
		(4.99, 'Profiterols'),
		(5.99, 'Tiramisu'),
		(3.99, 'Limoncello'),
		(2.99, 'Biscotti')





-- Werte ver�ndern mit UPDATE
-- IMMER mit WHERE einschr�nken
-- sonst wird der Preis f�r ALLE vergeben!!
UPDATE Produkte
SET Preis = 5.89
WHERE ProduktID = 5



-- Werte rausl�schen mit DELETE
-- ACHTUNG: DELETE FROM Produkte ohne WHERE l�scht GESAMTEN Inhalt der Tabelle
DELETE FROM Produkte
WHERE ProduktID = 3


DELETE FROM Produkte
WHERE ProduktID IN(4, 9)


SELECT *
FROM Produkte




-- Tabelle selbst ver�ndern mit ALTER TABLE

ALTER TABLE Produkte
ALTER COLUMN ProduktName nvarchar(50)




ALTER TABLE Produkte
ADD Email nvarchar(50)



-- ups, leider Fehler passiert, Email-Spalte soll nicht in Produkte-Tabelle:
ALTER TABLE Produkte
DROP COLUMN Email










-- Procedure (Prozedur)



/*
	
	-- Variablen
			
			@variablenname

		-- Datentyp?

		-- existiert nur, so lange der Batch läuft
		-- Zugriff nur innerhalb der Session, in der sie erstellt wurde


		DECLARE @varname AS Datentyp



*/


-- Bsp. Variable:

DECLARE @test AS int 


SET @test = 100


SELECT @test





CREATE PROC p_Customers_Country_Test @Country nvarchar(30)
AS
SELECT *
FROM Customers
WHERE Country = @Country
GO


EXEC p_Customers_Country_Test 'Brazil'




CREATE PROC p_Customer_Info @Country nvarchar(30), @City nvarchar(30)
AS
SELECT *
FROM Customers
WHERE Country = @Country AND City = @City
GO


EXEC p_Customer_Info 'Germany', 'Berlin'


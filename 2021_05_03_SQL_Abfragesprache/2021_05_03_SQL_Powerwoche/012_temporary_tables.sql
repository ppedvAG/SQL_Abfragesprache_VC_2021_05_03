-- tempor�re Tabellen (temporary tables)



/*

		-- lokale tempor�re Tabellen
			existieren nur in der aktuellen Session
				#tablename


		-- globale tempor�re Tabellen
			Zugriff auch aus anderen Sessions
				##tablename


			Lebensdauer: so lange, wie die Verbindung/Session besteht

*/




SELECT CustomerID, Freight
INTO #t1
FROM Orders


SELECT *
FROM #t1


SELECT OrderID, OrderDate
INTO ##t1
FROM Orders



SELECT *
FROM ##t1
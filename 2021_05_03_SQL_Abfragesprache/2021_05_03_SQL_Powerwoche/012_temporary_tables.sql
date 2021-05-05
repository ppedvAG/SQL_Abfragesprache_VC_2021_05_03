-- temporäre Tabellen (temporary tables)



/*

		-- lokale temporäre Tabellen
			existieren nur in der aktuellen Session
				#tablename


		-- globale temporäre Tabellen
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
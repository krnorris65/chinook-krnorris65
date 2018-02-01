SELECT t.Name AS "Song", TOTAL(il.Quantity) AS "Times Purchased"
	FROM  InvoiceLine il, Track t
	WHERE il.TrackId = t.TrackId
	GROUP BY t.Name
	ORDER BY "Times Purchased" DESC
	LIMIT 5
;

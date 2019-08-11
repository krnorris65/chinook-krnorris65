SELECT x.Song AS "Song" , MAX(x.Num) AS "Times Purchased"
FROM (	
	SELECT t.Name AS Song, TOTAL(il.Quantity) AS Num, i.InvoiceDate
	FROM Invoice i, InvoiceLine il, Track t
	WHERE il.InvoiceId = i.InvoiceId
	AND il.TrackId = t.TrackId
	AND i.InvoiceDate BETWEEN "2013-01-01" AND "2013-12-31"
	GROUP BY t.Name
	) x;


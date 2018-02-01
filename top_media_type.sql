SELECT x.media AS "Media Type", MAX(x.num) AS "Amount of Media Sold"
	FROM (SELECT m.Name AS media, TOTAL(il.Quantity) AS num
	FROM MediaType m, Track t, InvoiceLine il
	WHERE t.MediaTypeId = m.MediaTypeId
	AND t.TrackId = il.TrackId
	GROUP BY m.Name
	) x;
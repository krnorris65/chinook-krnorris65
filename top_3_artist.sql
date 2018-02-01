SELECT a.Name, TOTAL(il.Quantity) AS "Tracks Sold"
FROM Artist a, Album b, Track t, InvoiceLine il
WHERE b.ArtistId = a.ArtistId
AND t.AlbumId = b.AlbumId
AND t.TrackId = il.TrackId
GROUP BY a.Name
ORDER BY "Tracks Sold" DESC
LIMIT 3;
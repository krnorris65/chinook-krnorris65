SELECT i.InvoiceId, t.Name AS "Track Name", a.Name AS "Artist Name"
FROM InvoiceLine i, Track t, Album b, Artist a
WHERE i.TrackId = t.TrackId
AND t.AlbumId = b.AlbumId
AND b.ArtistId = a.ArtistId;
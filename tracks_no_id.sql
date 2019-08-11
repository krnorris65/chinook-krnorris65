SELECT t.Name AS "Track", a.Title AS "Album", g.Name AS "Genre", m.Name AS "Media Type"
FROM Track t, Album a, MediaType m, Genre g
WHERE t.AlbumId = a.AlbumId
AND t.MediaTypeId = m.MediaTypeId
AND t.GenreId = g.GenreId
ORDER BY a.Title, t.Name;
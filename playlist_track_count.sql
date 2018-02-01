SELECT p.Name, COUNT(pt.PlaylistId) AS "Number of Tracks"
FROM Playlist p
LEFT JOIN PlaylistTrack pt
ON p.PlaylistId = pt.PlaylistId
LEFT JOIN Track t
ON pt.TrackId = t.TrackId
GROUP BY p.Name;
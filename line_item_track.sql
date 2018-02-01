SELECT i.InvoiceId, t.Name AS "Track Name"
FROM InvoiceLine i, Track t
WHERE i.TrackId = t.TrackId;
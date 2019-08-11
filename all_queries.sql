-- 1. non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT FirstName || " " || LastName AS "Full Name", CustomerId, Country
FROM Customer
WHERE Country != "USA";

-- 2. brazil_customers.sql: Provide a query only showing the Customers from Brazil.
SELECT FirstName || " " || LastName AS "Full Name", Country
FROM Customer
WHERE Country = "Brazil";

-- 3. brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT c.FirstName || " " || c.LastName AS "Full Name", i.InvoiceId, i.InvoiceDate, i.BillingCountry
FROM Customer c, Invoice i
WHERE c.CustomerId = i.CustomerId
AND c.Country = "Brazil";

-- 4. sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.
SELECT FirstName || " " || LastName AS "Full Name", Title
FROM Employee
WHERE Title  = "Sales Support Agent";

-- 5. unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry
FROM Invoice;

-- 6. sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT e.FirstName || " " || e.LastName AS "Sales Agent", i.InvoiceId
FROM Employee e, Customer c, Invoice i
WHERE c.SupportRepId = e.EmployeeId
AND i.CustomerId = c.CustomerId
AND e.Title  = "Sales Support Agent"
ORDER BY e.LastName, e.FirstName;

-- 7. invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT i.InvoiceId, c.FirstName || " " || c.LastName AS "Customer Name", i.[Total], i.BillingCountry, e.FirstName || " " || e.LastName AS "Sales Agent"
FROM Invoice i, Customer c, Employee e
WHERE i.CustomerId = c.CustomerId
AND c.SupportRepId = e.EmployeeId
ORDER BY 
	c.LastName ASC, 
	c.FirstName ASC, 
	i.InvoiceId ASC;

-- 8. total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?
SELECT COUNT(*) AS "Total Number of Invoices"
FROM Invoice
WHERE InvoiceDate BETWEEN "2009-01-01" AND "2009-12-31";

SELECT COUNT(*) AS "Total Number of Invoices"
FROM Invoice
WHERE InvoiceDate BETWEEN "2011-01-01" AND "2011-12-31";

-- alternate way
SELECT COUNT(i.InvoiceId) AS "Total Number of Invoices", strftime('%Y', i.InvoiceDate) InvoiceYear
FROM Invoice i
WHERE InvoiceYear = '2009'
OR InvoiceYear = '2011'
GROUP BY InvoiceYear;

-- 9. total_sales_{year}.sql: What are the respective total sales for each of those years?
SELECT TOTAL(Total) AS "Total Sales"
FROM Invoice
WHERE InvoiceDate BETWEEN "2009-01-01" AND "2009-12-31";

SELECT TOTAL([Total]) AS "Total Sales"
FROM Invoice
WHERE InvoiceDate BETWEEN "2011-01-01" AND "2011-12-31";

-- 10. invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT COUNT(*) AS "Line Items for Invoice 37"
FROM InvoiceLine
WHERE InvoiceId = 37;

-- 11. line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
SELECT InvoiceId, COUNT(*) AS "Line Items"
FROM InvoiceLine
GROUP BY InvoiceId;

-- 12. line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.
SELECT i.InvoiceId, t.Name AS "Track Name"
FROM InvoiceLine i, Track t
WHERE i.TrackId = t.TrackId;

-- 13. line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT i.InvoiceId, t.Name AS "Track Name", a.Name AS "Artist Name"
FROM InvoiceLine i, Track t, Album b, Artist a
WHERE i.TrackId = t.TrackId
AND t.AlbumId = b.AlbumId
AND b.ArtistId = a.ArtistId;

-- 14. country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT BillingCountry AS "Country", COUNT(*) AS "Total Invoices"
FROM Invoice
GROUP BY BillingCountry
ORDER BY BillingCountry;

-- 15. playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.
SELECT p.Name, COUNT(pt.PlaylistId) AS "Number of Tracks"
FROM Playlist p
LEFT JOIN PlaylistTrack pt
ON p.PlaylistId = pt.PlaylistId
LEFT JOIN Track t
ON pt.TrackId = t.TrackId
GROUP BY p.Name;

-- 16. tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.
SELECT t.Name AS "Track", a.Title AS "Album", g.Name AS "Genre", m.Name AS "Media Type"
FROM Track t, Album a, MediaType m, Genre g
WHERE t.AlbumId = a.AlbumId
AND t.MediaTypeId = m.MediaTypeId
AND t.GenreId = g.GenreId
ORDER BY a.Title, t.Name;

-- 17. invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT i.InvoiceId AS "Invoice", COUNT(l.InvoiceId) AS "Line Items"
FROM Invoice i,  InvoiceLine l
WHERE i.InvoiceId = l.InvoiceId
GROUP BY i.InvoiceId;

-- 18. sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.
SELECT e.FirstName || " " || e.LastName AS "Sales Agent", printf("%.2f",TOTAL(i.Total)) AS "Total Sales"
FROM Employee e, Customer c, Invoice i
WHERE e.EmployeeId = c.SupportRepId
AND c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId;

-- 19. top_2009_agent.sql: Which sales agent made the most in sales in 2009?
SELECT 
	x.agent AS "Sales Agent", 
	MAX(x.top) AS "Top 2009 Sales"
FROM 
	(SELECT e.FirstName || " " || e.LastName AS agent, SUM(i.Total) AS top 
		FROM Employee e, Customer c, Invoice i
		WHERE e.EmployeeId = c.SupportRepId
		AND c.CustomerId = i.CustomerId
		AND i.InvoiceDate BETWEEN "2009-01-01" AND "2009-12-31"
		GROUP BY e.EmployeeId) x;

-- 20. top_agent.sql: Which sales agent made the most in sales over all?
SELECT x.agent AS "Sales Agent", MAX(x.top) AS "Top Overall Sales"
	FROM (SELECT e.FirstName || " " || e.LastName AS agent, printf("%.2f", TOTAL(i.Total)) AS top 
		FROM Employee e, Customer c, Invoice i
		WHERE e.EmployeeId = c.SupportRepId
		AND c.CustomerId = i.CustomerId
		GROUP BY e.EmployeeId) x;

-- 21. sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.
SELECT e.FirstName || " " || e.LastName AS "Sales Agent", COUNT(c.SupportRepId) AS "Customer Count"
FROM Employee e, Customer c
WHERE c.SupportRepId = e.EmployeeId
GROUP BY e.EmployeeId;

-- 22. sales_per_country.sql: Provide a query that shows the total sales per country.
SELECT i.BillingCountry AS "Country", printf("%.2f", TOTAL(i.Total)) AS "Total Sales"
FROM Invoice i
GROUP BY i.BillingCountry;

-- 23. top_country.sql: Which country's customers spent the most?
SELECT x.country AS "Country:", printf("%.2f", MAX(x.sales)) AS "Top Sales"
FROM ( SELECT i.BillingCountry AS country, TOTAL(i.Total) AS sales
	FROM Invoice i
	GROUP BY i.BillingCountry) x;

-- 24. top_2013_track.sql: Provide a query that shows the most purchased track of 2013.
SELECT x.Song AS "Song" , MAX(x.Num) AS "Times Purchased"
FROM (	
	SELECT t.Name AS Song, TOTAL(il.Quantity) AS Num, i.InvoiceDate
	FROM Invoice i, InvoiceLine il, Track t
	WHERE il.InvoiceId = i.InvoiceId
	AND il.TrackId = t.TrackId
	AND i.InvoiceDate BETWEEN "2013-01-01" AND "2013-12-31"
	GROUP BY t.Name
	) x;

-- 25. top_5_tracks.sql: Provide a query that shows the top 5 most purchased songs.
SELECT t.Name AS "Song", TOTAL(il.Quantity) AS "Times Purchased"
	FROM  InvoiceLine il, Track t
	WHERE il.TrackId = t.TrackId
	GROUP BY t.Name
	ORDER BY "Times Purchased" DESC
	LIMIT 5;

-- 26. top_3_artists.sql: Provide a query that shows the top 3 best selling artists.
SELECT a.Name, TOTAL(il.Quantity) AS "Tracks Sold"
FROM Artist a, Album b, Track t, InvoiceLine il
WHERE b.ArtistId = a.ArtistId
AND t.AlbumId = b.AlbumId
AND t.TrackId = il.TrackId
GROUP BY a.Name
ORDER BY "Tracks Sold" DESC
LIMIT 3;

-- 27. top_media_type.sql: Provide a query that shows the most purchased Media Type.
SELECT x.media AS "Media Type", MAX(x.num) AS "Amount of Media Sold"
	FROM (SELECT m.Name AS media, TOTAL(il.Quantity) AS num
	FROM MediaType m, Track t, InvoiceLine il
	WHERE t.MediaTypeId = m.MediaTypeId
	AND t.TrackId = il.TrackId
	GROUP BY m.Name
	) x;
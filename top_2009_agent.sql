SELECT 
	x.agent AS "Sales Agent", 
	MAX(x.top) AS "Top 2009 Sales"
FROM 
	(SELECT e.FirstName || " " || e.LastName AS agent, SUM(i.Total) AS top 
		FROM Employee e, Customer c, Invoice i
		WHERE e.EmployeeId = c.SupportRepId
		AND c.CustomerId = i.CustomerId
		AND i.InvoiceDate BETWEEN "2009-01-01" AND "2009-12-31"
		GROUP BY e.EmployeeId) x
;


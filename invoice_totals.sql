SELECT i.InvoiceId, c.FirstName || " " || c.LastName AS "Customer Name", i.[Total], i.BillingCountry, e.FirstName || " " || e.LastName AS "Sales Agent"
FROM Invoice i, Customer c, Employee e
WHERE i.CustomerId = c.CustomerId
AND c.SupportRepId = e.EmployeeId
ORDER BY 
	c.LastName ASC, 
	c.FirstName ASC, 
	i.InvoiceId ASC;


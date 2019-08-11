SELECT e.FirstName || " " || e.LastName AS "Sales Agent", i.InvoiceId
FROM Employee e, Customer c, Invoice i
WHERE c.SupportRepId = e.EmployeeId
AND i.CustomerId = c.CustomerId
AND e.Title  = "Sales Support Agent"
ORDER BY e.LastName, e.FirstName;


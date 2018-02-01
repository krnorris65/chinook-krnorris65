SELECT e.FirstName || " " || e.LastName AS "Sales Agent", printf("%.2f",TOTAL(i.Total)) AS "Total Sales"
FROM Employee e, Customer c, Invoice i
WHERE e.EmployeeId = c.SupportRepId
AND c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId;
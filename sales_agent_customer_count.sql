SELECT e.FirstName || " " || e.LastName AS "Sales Agent", COUNT(c.SupportRepId) AS "Customer Count"
FROM Employee e, Customer c
WHERE c.SupportRepId = e.EmployeeId
GROUP BY e.EmployeeId;
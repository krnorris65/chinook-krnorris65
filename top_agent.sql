SELECT x.agent AS "Sales Agent", MAX(x.top) AS "Top Overall Sales"
	FROM (SELECT e.FirstName || " " || e.LastName AS agent, printf("%.2f", TOTAL(i.Total)) AS top 
		FROM Employee e, Customer c, Invoice i
		WHERE e.EmployeeId = c.SupportRepId
		AND c.CustomerId = i.CustomerId
		GROUP BY e.EmployeeId) x
;
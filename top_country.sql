SELECT x.country AS "Country:", printf("%.2f", MAX(x.sales)) AS "Top Sales"
FROM ( SELECT i.BillingCountry AS country, TOTAL(i.Total) AS sales
	FROM Invoice i
	GROUP BY i.BillingCountry) x
;
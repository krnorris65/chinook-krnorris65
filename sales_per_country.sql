SELECT i.BillingCountry AS "Country", printf("%.2f", TOTAL(i.Total)) AS "Total Sales"
FROM Invoice i
GROUP BY i.BillingCountry;
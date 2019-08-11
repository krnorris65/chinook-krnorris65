SELECT BillingCountry AS "Country", COUNT(*) AS "Total Invoices"
FROM Invoice
GROUP BY BillingCountry
ORDER BY BillingCountry;
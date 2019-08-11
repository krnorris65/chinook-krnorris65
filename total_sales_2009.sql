SELECT TOTAL(Total) AS "Total Sales"
FROM Invoice
WHERE InvoiceDate BETWEEN "2009-01-01" AND "2009-12-31";



SELECT SUM(i.Total) AS "Total Number of Invoices", strftime('%Y', i.InvoiceDate) InvoiceYear
FROM Invoice i
WHERE InvoiceYear = '2009'
OR InvoiceYear = '2011'
GROUP BY InvoiceYear;

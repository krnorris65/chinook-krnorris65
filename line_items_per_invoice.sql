SELECT InvoiceId, COUNT(*) AS "Line Items"
FROM InvoiceLine
GROUP BY InvoiceId;
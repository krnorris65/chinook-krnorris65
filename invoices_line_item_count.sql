SELECT i.InvoiceId AS "Invoice", COUNT(l.InvoiceId) AS "Line Items"
FROM Invoice i,  InvoiceLine l
WHERE i.InvoiceId = l.InvoiceId
GROUP BY i.InvoiceId;
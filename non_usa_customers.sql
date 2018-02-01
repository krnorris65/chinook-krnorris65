SELECT FirstName || " " || LastName AS "Full Name", CustomerId, Country
FROM Customer
WHERE Country != "USA";

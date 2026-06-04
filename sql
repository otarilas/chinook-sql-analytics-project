Chinook General Informations with SQL Queries

1: All columns from the Genre table:

SELECT *
FROM Genre

2: Only the genre names from the Genre table: 

SELECT Name
FROM Genre

3: All columns from Track:

SELECT *
FROM Track

4: Customers from Germany:

SELECT FirstName, LastName, Country
FROM Customer
WHERE Country = "Germany"

5: All invoices from 2012:

SELECT InvoiceId, InvoiceDate
FROM Invoice
WHERE STRFTIME('%Y', InvoiceDate ) = '2012'

6: Counting the amount of Invoices from the USA:

SELECT count(*) as billingCountry_USA
FROM Invoice
WHERE BillingCountry = 'USA'

7: The 10 most expensive Invoices:

SELECT InvoiceId,Total
FROM Invoice
ORDER BY Total DESC
LIMIT 10

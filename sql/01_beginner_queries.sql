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

8: Counting how many track each genre has:

SELECT g.Name as GENRE_Name , count(t.TrackId)
FROM Track t
JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY GENRE_Name

9: Schowing each artist and the amount of albums they have:

SELECT DISTINCT ar.Name as Artist_Name, COUNT(al.AlbumId) as Album_Amount
FROM Artist ar
JOIN Album al
ON ar.ArtistId = al.ArtistId 
GROUP BY Artist_Name

10: The total invoice amount per billing country:

SELECT BillingCountry, SUM(Total)
FROM Invoice
GROUP BY BillingCountry

11: Finding the top 10 longest tracks:

SELECT g.Name, t.Name as Track_Name, CAST(t.Milliseconds / 60000 as Integer) as Playing_Minutes
FROM Genre g
JOIN Track t
ON g.GenreId = t.GenreId 
ORDER BY Playing_Minutes  DESC
LIMIT 10

12: Find all tracks by the artist "AC/DC":

SELECT  ar.Name, t.Name as Track_Name, a.Title as Album_Title
FROM Track t
JOIN Album a
ON t.AlbumId = a.AlbumId
JOIN Artist ar
ON a.ArtistId = ar.ArtistId
WHERE ar.Name = "AC/CD"

13: Find the most sold track:

SELECT g.Name, t.Name as Track_Name, SUM(i.Quantity) as AmountOFSoldTracks
FROM Genre g
JOIN Track t
ON g.GenreId = t.GenreId
JOIN InvoiceLine i
ON t.TrackId = i.TrackId
GROUP BY t.TrackId
ORDER BY AmountOFSoldTracks DESC
LIMIT 1;

14: Which Tracks were sold the most in each Country?

WITH CountryTrackSales AS (
SELECT i.BillingCountry, t.TrackId, t.Name, sum(il.Quantity) as Quantity
FROM Track t
JOIN InvoiceLine il
ON t.TrackId = il.TrackId
JOIN Invoice i
ON i.InvoiceId  = il.InvoiceId
GROUP BY i.BillingCountry, t.TrackId, t.Name
),
RankedTracks AS (
	SELECT BillingCountry, TrackId, Name, Quantity,
	RANK() OVER (
		PARTITION BY BillingCountry
		ORDER BY Quantity DESC 
	) AS Track_Rank
	FROM CountryTrackSales
)
SELECT
	BillingCountry, TrackId, Name, Quantity
FROM RankedTracks
WHERE Track_Rank = 1
ORDER BY BillingCountry;
Select JSON_ARRAY (
JSON_OBJECT ('id':c.CustomerID , 'name':c.CustomerName , 'alt':AlternateContactPersonID ABSENT ON NULL))
FROM Sales.Customers c
WHERE c.CustomerID in (2, 150, 801)

SELECT distinct TOP (3) JSON_OBJECT ('id':c.CustomerID , 'name':c.CustomerName , 'alt':AlternateContactPersonID ABSENT ON NULL)as customer
FROM Sales.Customers c
INNER JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
INNER JOIN Sales.OrderLines d on d.OrderID = o.OrderID
WHERE o.CustomerID = 2 AND YEAR(o.OrderDate) = 2016
FOR JSON aUTO
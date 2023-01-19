SELECT 
      c.CustomerID 
      , c.CustomerName 
      , c.CustomerName AS orderlist
FROM Sales.Customers c
INNER JOIN 
SELECT TOP (3) 
      c.CustomerID AS 'customer.id'
      , c.CustomerName AS 'customer.name'
      , o.OrderID AS 'customer.order.id'
      , o.OrderDate AS 'customer.order.orderdate'

FROM Sales.Customers c
INNER JOIN Sales.Orders o ON c.CustomerID = o.CustomerID

WHERE o.CustomerID = 2 AND YEAR(o.OrderDate) = 2016
FOR JSON PATH


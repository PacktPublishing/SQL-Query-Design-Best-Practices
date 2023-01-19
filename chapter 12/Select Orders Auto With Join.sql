
SELECT TOP (3) 
      c.CustomerID as customer.id
      , c.CustomerName as customer.name
     , o.OrderID as customer.order.id
      , o.OrderDate as customer.order.orderdate
FROM Sales.Customers c
INNER JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
WHERE o.CustomerID = 2 AND YEAR(o.OrderDate) = 2016
FOR JSON PATH
;

SELECT TOP (3) 
      c.CustomerID
      , c.CustomerName
      , o.OrderDate
      , o.OrderID
FROM Sales.Customers c
INNER JOIN Sales.Orders o  ON c.CustomerID = o.CustomerID
WHERE o.CustomerID = 2 AND YEAR(o.OrderDate) = 2016
FOR JSON AUTO
;

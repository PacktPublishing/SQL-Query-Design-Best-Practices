SELECT TOP (3) 
      c.CustomerID AS 'customer.id'
      , c.CustomerName AS 'customer.name'
      , o.OrderID AS 'customer.order.id'
      , o.OrderDate AS 'customer.order.orderdate'
      , d.OrderLineID AS 'customer.order.orderline.id'
      , d.StockItemID AS 'customer.order.orderline.stockitemid'
      , d.Description AS 'customer.order.orderline.description'
      , d.Quantity AS 'customer.order.orderline.quantity'
      , d.UnitPrice AS 'customer.order.orderline.unitprice'
FROM Sales.Customers c
INNER JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
INNER JOIN Sales.OrderLines d on d.OrderID = o.OrderID
WHERE o.CustomerID = 2 AND YEAR(o.OrderDate) = 2016
FOR JSON PATH
;

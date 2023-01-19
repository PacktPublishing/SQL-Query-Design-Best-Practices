INSERT INTO dbo.CustomerOrders
  (CustomerID, CustomerName, CustomerOrderHistory)
(
SELECT c.CustomerID 
, c.CustomerName 
, (SELECT o.OrderID AS 'order.id'
  , o.OrderDate AS 'order.orderdate'
  , o.CustomerID AS 'order.customerid'
  , (SELECT d.OrderLineID AS 'orderline.id'
    , d.OrderID AS 'orderline.orderid'
    , d.StockItemID AS 'orderline.stockitemid'
    , d.Description AS 'orderline.description'
    , d.Quantity AS 'orderline.quantity'
    , d.UnitPrice AS 'orderline.unitprice'
    FROM Sales.OrderLines d 
    WHERE d.OrderID = o.OrderID
    FOR JSON PATH
    ) as 'order.lines'
  FROM Sales.Orders o 
  WHERE c.CustomerID = o.CustomerID AND YEAR(o.OrderDate) = 2016
  FOR JSON PATH, ROOT('orders') 
  ) AS Orders
FROM Sales.Customers c
);

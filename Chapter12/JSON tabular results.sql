
SELECT o.CustomerID, o.CustomerName ,r.OrderID, r.OrderDate,
cast (JSON_VALUE (CustomerOrderHistory, '$.orders[0].order.orderdate')as date) as CustomerSince
FROM dbo.CustomerOrders o
CROSS APPLY OPENJSON (o.CustomerOrderHistory, '$.orders')
WITH (OrderID INT '$.order.id'
,OrderDate DATE '$.order.orderdate') AS r
WHERE o.CustomerID BETWEEN 1 AND 10;


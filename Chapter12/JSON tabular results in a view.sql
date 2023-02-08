IF EXISTS(SELECT 1 FROM sys.views WHERE name ='V_CustomerOrderHistory')
DROP VIEW dbo.V_CustomerOrderHistory;
GO
CREATE VIEW dbo.V_CustomerOrderHistory AS (
SELECT o.CustomerID, o.CustomerName ,r.OrderID, r.OrderDate,
cast (JSON_VALUE (CustomerOrderHistory, '$.orders[0].order.orderdate')as date) as CustomerSince
FROM dbo.CustomerOrders o
CROSS APPLY OPENJSON (o.CustomerOrderHistory, '$.orders')
WITH (OrderID INT '$.order.id'
,OrderDate DATE '$.order.orderdate') AS r
WHERE o.CustomerID BETWEEN 1 AND 10);
GO

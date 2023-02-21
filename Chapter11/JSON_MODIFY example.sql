SELECT TOP (1) JSON_MODIFY(CustomerOrderHistory,'$.orders[0].order.orderdate','2017-01-01') FROM dbo.CustomerOrders;

UPDATE dbo.CustomerOrders SET CustomerOrderHistory = JSON_MODIFY(CustomerOrderHistory, '$.orders[0].order.orderdate', '2017-01-01') WHERE CustomerID = 100;

SELECT * FROM dbo.CustomerOrders WHERE CustomerID = 100;

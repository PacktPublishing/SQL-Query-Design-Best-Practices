SELECT TOP (1) JSON_PATH_EXISTS(CustomerOrderHistory, '$.orders[0].order.lines[0].orderline.id') FROM dbo.CustomerOrders;

SELECT TOP (1) JSON_PATH_EXISTS(CustomerOrderHistory, '$.orders[0].order.lines[0].orderline.customerid') FROM dbo.CustomerOrders;
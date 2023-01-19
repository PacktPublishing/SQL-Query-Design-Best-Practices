SELECT TOP (1) JSON_QUERY(CustomerOrderHistory) FROM dbo.CustomerOrders; 

SELECT TOP (1) JSON_QUERY(CustomerOrderHistory, '$.orders[0].order.lines') FROM dbo.CustomerOrders; 

SELECT TOP (1) JSON_QUERY(CustomerOrderHistory,'lax $.orders[0].order.lines[0].orderline.id') FROM dbo.CustomerOrders;

SELECT TOP (1) JSON_QUERY(CustomerOrderHistory,'strict $.orders[0].order.lines[0].orderline.id') FROM dbo.CustomerOrders;

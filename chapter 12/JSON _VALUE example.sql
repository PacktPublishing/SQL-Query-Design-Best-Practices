SELECT TOP (1) JSON_VALUE(CustomerOrderHistory,'$.orders[0].order.lines[0].orderline.description') FROM dbo.CustomerOrders;


        SELECT o.[Order Year],
               o.[Order Month],
		o.Customers,
		o.orders,
		count(b.[WWI Backorder]) as [total backorders],
		count(distinct b.[customer]) as [impacted customers]
  FROM [WideWorldImportersDW].[dbo].[v_Backorders] b,
  [WideWorldImportersDW].[dbo].[v_orders] o
  where b.[Order Year] = o.[Order Year]
  and b.[Order Month] = o.[Order Month]
  group by o.[Order Year],
           o.[Order Month],
		   o.Customers,
		   o.orders
  order by o.[Order Year],
           o.[Order Month];

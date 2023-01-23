SELECT Year([Order Date Key]) as [Order Year],
       Month([Order Date Key]) as [Order Month],
	  COUNT(distinct [Customer Key]) as [Impacted Customers],
	  COUNT(distinct [Stock Item Key]) as [Backorder Items],
	  COUNT([WWI Backorder ID]) as [Number of backorders],
	  fo.orders,
      fo.Customers
FROM [WideWorldImportersDW].[Fact].[Order] o,
     (select  Year([Order Date Key]) as [Order Year],
              Month([Order Date Key]) as [Order Month],
              COUNT (distinct [Order Key]) as [orders],
              COUNT (distinct [customer Key]) as [Customers]
      FROM [WideWorldImportersDW].[Fact].[Order]
	 GROUP BY Year([Order Date Key]),
               Month([Order Date Key])) as fo
WHERE [WWI Backorder ID] IS NOT NULL
AND year(o.[Order Date Key]) = fo.[Order Year]
AND month(o.[Order Date Key]) = fo.[Order Month]
GROUP BY Year([Order Date Key]),
         Month([Order Date Key]),
	   fo.orders,
	   fo.Customers
ORDER BY Year([Order Date Key]),
         Month([Order Date Key]);

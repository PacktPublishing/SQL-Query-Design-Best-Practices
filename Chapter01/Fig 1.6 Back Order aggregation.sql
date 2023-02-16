SELECT Year([Order Date Key]) as "Order Year",
       Month([Order Date Key]) as "Order Month",
	 COUNT([WWI Backorder ID]) as "Number of backorders",   
	 COUNT(distinct [Customer Key]) as "Impacted Customers",
	 COUNT([Order Key]) as "Number of orders"    
FROM [WideWorldImportersDW].[Fact].[Order]
WHERE [WWI Backorder ID] IS NOT NULL
GROUP BY Year([Order Date Key]),
         Month([Order Date Key])
ORDER BY Year([Order Date Key]),
         Month([Order Date Key]);

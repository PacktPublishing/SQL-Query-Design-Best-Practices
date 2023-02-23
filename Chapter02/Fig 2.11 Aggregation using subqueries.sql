SELECT YEAR([Invoice Date Key]) as [Invoice Year]
      ,MONTH([Invoice Date Key]) as [Invoice Month]
	  ,COUNT([Customer Key]) as [# of Customers with Orders]
	  ,d.[# of Customers] as [# of Customers Received Orders]
FROM [WideWorldImportersDW].[Fact].[Sale],
    (SELECT YEAR([Delivery Date Key]) as [Delivery Year]
	       ,MONTH([Delivery Date Key]) as [Deliver Month]
		   ,COUNT([Customer Key]) as [# of Customers]
	FROM [WideWorldImportersDW].[Fact].[Sale]
	GROUP BY YEAR([Delivery Date Key])
	        ,MONTH([Delivery Date Key])) d
WHERE YEAR([Invoice Date Key]) = d.[Delivery Year]
AND MONTH([Invoice Date Key]) = d.[Deliver Month]
GROUP BY YEAR([Invoice Date Key])
        ,MONTH([Invoice Date Key])
		,[# of Customers]
ORDER BY YEAR([Invoice Date Key])
        ,MONTH([Invoice Date Key]);

SELECT TOP(3) [Order Key] 
			  ,[WWI Order ID] 
			  ,[Total Excluding Tax] 
			  ,CASE 
				WHEN [Total Excluding Tax] >= 1500 THEN 'Extra Large' 
				WHEN [Total Excluding Tax] >= 500 AND [Total Excluding Tax] < 1500 THEN 'Large' 
				WHEN [Total Excluding Tax] >= 100 AND [Total Excluding Tax] < 500 THEN 'Medium' 
				ELSE  'Small' 
			  END AS [Sales Size]   
FROM [Fact].[Order] 
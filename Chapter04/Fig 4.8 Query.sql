SELECT TOP(20) [Customer Key]
			  ,[Customer Total Spending]
			  ,[Spending Group]
FROM ( 
		SELECT [Customer Key]
		      ,SUM([Total Excluding Tax]) AS [Customer Total Spending]
			  ,CASE 
				  WHEN SUM([Total Excluding Tax]) >= 150000 THEN 'High'
				  WHEN SUM([Total Excluding Tax]) >= 10000 AND SUM([Total Excluding Tax]) < 150000 THEN 'Medium' 
				  ELSE 'Low' 
			   END AS [Spending Group] 
		FROM [Fact].[Transaction] 
		WHERE [Customer Key] <> 0 
		GROUP BY [Customer Key] 
	) AS CustomerGroup 
WHERE [Spending Group] = 'High'
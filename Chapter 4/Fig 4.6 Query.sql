SELECT TOP(20) [Customer Key]
			  ,SUM([Total Excluding Tax]) AS [Customer Total Spending]
FROM [Fact].[Transaction]
WHERE [Customer Key] <> 0
GROUP BY [Customer Key]
HAVING
	CASE 
		WHEN SUM([Total Excluding Tax]) >= 150000 THEN 'High' 
		WHEN SUM([Total Excluding Tax]) >= 10000 AND SUM([Total Excluding Tax]) < 150000 THEN 'Medium' 
		ELSE 'Low'
	END = 'High'
ORDER BY [Customer Total Spending] ASC 
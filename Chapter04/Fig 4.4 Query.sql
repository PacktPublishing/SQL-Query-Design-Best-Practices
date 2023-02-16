SELECT [Employee Key]
	   ,[Employee]
	   ,[Preferred Name]
FROM [Dimension].[Employee]
WHERE [Valid To] >= getdate()
 AND [Employee Key] <> 0
ORDER BY 
	CASE WHEN [Preferred Name] LIKE 'H%' OR [Preferred Name] LIKE 'K%' THEN 1 
		 WHEN [Preferred Name] LIKE 'A%' THEN 2
		 WHEN [Preferred Name] LIKE 'D%' OR [Preferred Name] LIKE 'P%' THEN 3
		 ELSE 4
		 END ASC
	,[Employee] ASC 
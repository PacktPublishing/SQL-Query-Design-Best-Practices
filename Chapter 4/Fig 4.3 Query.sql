SELECT TOP (1000) [Employee Key]
				  ,[WWI Employee ID]
				  ,[Employee]
				  ,[Is Salesperson]
FROM [Dimension].[Employee]
WHERE [Valid To] >= getdate() 
AND [Employee Key] <> 0 
ORDER BY 
	CASE WHEN [Is Salesperson] = 0 THEN [Employee Key] END ASC 
   ,CASE WHEN [Is Salesperson] = 1 THEN [WWI Employee ID] END DESC
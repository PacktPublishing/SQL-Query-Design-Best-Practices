SELECT [Transaction Key]
	  ,[WWI Invoice ID]
	  ,ISNULL([WWI Invoice ID],'0') AS [WWIInvoiceID]
FROM [Fact].[Transaction]
WHERE [Transaction Key] IN (40,41,42,43) 
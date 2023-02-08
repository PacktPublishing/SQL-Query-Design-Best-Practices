SELECT [Transaction Key] AS [TransactionKey]
	  ,[WWI Invoice ID] AS [WWIInvoiceID]
	  ,[WWI Customer Transaction ID] AS [WWICustomerTransactionID]
	  ,'00000' + CAST([Transaction Key] AS VARCHAR(3)) + COALESCE(CAST([WWI Invoice ID] AS VARCHAR(3)),'00') + CAST([WWI Customer Transaction ID] AS VARCHAR(3)) AS  [WWI ID]
	  ,'00000' + CAST([Transaction Key] AS VARCHAR(3)) + CAST([WWI Invoice ID] AS VARCHAR(3)) + CAST([WWI Customer Transaction ID] AS VARCHAR(3)) AS [WWI ID with NULL]
FROM [Fact].[Transaction]
WHERE [Transaction Key] IN (40,41,42,43) 
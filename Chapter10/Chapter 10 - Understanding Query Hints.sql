/*
Query 1: Here is the query to return all cities where CityID is either less than or equal to 10. 
*/

SELECT *  FROM [WideWorldImporters].[Application].[Cities] WHERE CityID <= 10 ;

/*
Query 2: Now, if another user, say TestUser runs query to update the [LatestRecordedPopulation] to 450 here: 
*/


BEGIN TRAN  

UPDATE  [WideWorldImporters].[Application].[Cities]    

SET [LatestRecordedPopulation] = 450  

WHERE [CityID] < = 10 AND [CityName] = 'Abbott' ;

/*
Query 3: Now update the same query by ran by the user RamBabuSingh, SP_ID 89 with NOLOCK table hint here: 
*/


SELECT *  FROM [WideWorldImporters].[Application].[Cities] WITH (NOLOCK) WHERE CityID < = 10 ;

/*
Query 4: Referenced example is to use FORCESEEK to force index seek 
*/
SELECT [OrderID] 

      ,[CustomerID] 

      ,[SalespersonPersonID] 

      ,[PickedByPersonID] 

      ,[ContactPersonID] 

      ,[BackorderOrderID] 

      ,[OrderDate] 

      ,[ExpectedDeliveryDate] 

      ,[CustomerPurchaseOrderNumber] 

      ,[IsUndersupplyBackordered] 

      ,[Comments] 

      ,[DeliveryInstructions] 

      ,[InternalComments] 

      ,[PickingCompletedWhen] 

      ,[LastEditedBy] 

      ,[LastEditedWhen] 

  FROM [WideWorldImporters].[Sales].[Orders] (FORCESEEK ) WHERE [OrderID] > 10369 ;
/*
Query 5: Referenced example is to use FORCESCAN  to force index seek 
*/
SELECT [OrderID] 

      ,[CustomerID] 

      ,[SalespersonPersonID] 

      ,[PickedByPersonID] 

      ,[ContactPersonID] 

      ,[BackorderOrderID] 

      ,[OrderDate] 

      ,[ExpectedDeliveryDate] 

      ,[CustomerPurchaseOrderNumber] 

      ,[IsUndersupplyBackordered] 

      ,[Comments] 

      ,[DeliveryInstructions] 

      ,[InternalComments] 

      ,[PickingCompletedWhen] 

      ,[LastEditedBy] 

      ,[LastEditedWhen] 

  FROM [WideWorldImporters].[Sales].[Orders] (FORCESCAN) WHERE [OrderID] > 10369 ;

/*
Query 6: Referenced example to get count of records from Invoice and InvoiceSales tables
*/

SELECT COUNT(*) InvoiceCounts FROM [WideWorldImporters].[Sales].[Invoices] AS SI ;

SELECT COUNT(*) InvoiceLinesCount FROM  [WideWorldImporters].Sales.InvoiceLines AS SIL ;

/*
Query 7: Example query to use loop join on Invoice and InvoiceLines tables:
*/
SELECT   

CAST(SI.InvoiceDate AS date) AS [InvoiceDateKey],   

CAST(SI.ConfirmedDeliveryTime AS date) AS [DeliveryDateKey],   

SI.InvoiceID AS [Invoice ID],   

SIL.[Description],   

SIL.Quantity,   

SIL.UnitPrice AS [UnitPrice],   

SIL.TaxRate AS [TaxRate],   

SIL.ExtendedPrice - SIL.TaxAmount AS [TotalExcludingTax],   

SIL.TaxAmount AS [TaxAmount],   

SIL.LineProfit AS Profit,   

SIL.ExtendedPrice AS [TotalIncludingTax],   

SI.CustomerID AS [WWICustomerID],   

SI.BillToCustomerID AS [WWIBillToCustomerID],   

SIL.StockItemID AS [WWIStockItemID],   

SI.SalespersonPersonID AS [WWISalepersonID],   

CASE WHEN SIL.LastEditedWhen > SI.LastEditedWhen  

THEN SIL.LastEditedWhen  

ELSE SI.LastEditedWhen  

END AS [LastModifiedWhen]   

FROM [WideWorldImporters].[Sales].[Invoices] AS SI   

INNER LOOP JOIN [WideWorldImporters].Sales.InvoiceLines AS SIL    

ON SI.InvoiceID = SIL.InvoiceID ;

/*
Query 8: Example query for HASH JOIN 
*/
SELECT   

CAST(SI.InvoiceDate AS date) AS [InvoiceDateKey],   

CAST(SI.ConfirmedDeliveryTime AS date) AS [DeliveryDateKey],   

SI.InvoiceID AS [Invoice ID],   

SIL.[Description],   

SIL.Quantity,   

SIL.UnitPrice AS [UnitPrice],   

SIL.TaxRate AS [TaxRate],   

SIL.ExtendedPrice - SIL.TaxAmount AS [TotalExcludingTax],   

SIL.TaxAmount AS [TaxAmount],   

SIL.LineProfit AS Profit,   

SIL.ExtendedPrice AS [TotalIncludingTax],   

SI.CustomerID AS [WWICustomerID],   

SI.BillToCustomerID AS [WWIBillToCustomerID],   

SIL.StockItemID AS [WWIStockItemID],   

SI.SalespersonPersonID AS [WWISalepersonID],   

CASE WHEN SIL.LastEditedWhen > SI.LastEditedWhen  

THEN SIL.LastEditedWhen  

ELSE SI.LastEditedWhen  

END AS [LastModifiedWhen]   

FROM [WideWorldImporters].[Sales].[Invoices] AS SI   

LEFT HASH JOIN [WideWorldImporters].Sales.InvoiceLines AS SIL    

ON SI.InvoiceID = SIL.InvoiceID ;

/*
Query 9: Example query for MERGE JOIN 
*/
SELECT   

CAST(SI.InvoiceDate AS date) AS [InvoiceDateKey],   

CAST(SI.ConfirmedDeliveryTime AS date) AS [DeliveryDateKey],   

SI.InvoiceID AS [Invoice ID],   

SIL.[Description],   

SIL.Quantity,   

SIL.UnitPrice AS [UnitPrice],   

SIL.TaxRate AS [TaxRate],   

SIL.ExtendedPrice - SIL.TaxAmount AS [TotalExcludingTax],   

SIL.TaxAmount AS [TaxAmount],   

SIL.LineProfit AS Profit,   

SIL.ExtendedPrice AS [TotalIncludingTax],   

SI.CustomerID AS [WWICustomerID],   

SI.BillToCustomerID AS [WWIBillToCustomerID],   

SIL.StockItemID AS [WWIStockItemID],   

SI.SalespersonPersonID AS [WWISalepersonID],   

CASE WHEN SIL.LastEditedWhen > SI.LastEditedWhen  

THEN SIL.LastEditedWhen  

ELSE SI.LastEditedWhen  

END AS [LastModifiedWhen]   

FROM [WideWorldImporters].[Sales].[Invoices] AS SI   

INNER MERGE JOIN [WideWorldImporters].Sales.InvoiceLines AS SIL    

ON SI.InvoiceID = SIL.InvoiceID ;

/*
Query 10:Example query for RECOMPILE query hint
*/

SELECT [OrderID] 

      ,[CustomerID] 

      ,[SalespersonPersonID] 

      ,[PickedByPersonID] 

      ,[ContactPersonID] 

      ,[BackorderOrderID] 

      ,[OrderDate] 

      ,[ExpectedDeliveryDate] 

      ,[CustomerPurchaseOrderNumber] 

      ,[IsUndersupplyBackordered] 

      ,[Comments] 

      ,[DeliveryInstructions] 

      ,[InternalComments] 

      ,[PickingCompletedWhen] 

     FROM [WideWorldImporters].[Sales].[Orders]  

WHERE [OrderID] > 10369 

OPTION (RECOMPILE) ;

/*
Query 11:Example query for KEEPFIXED PLAN query hint
*/

SELECT [OrderID] 

      ,[CustomerID] 

      ,[SalespersonPersonID] 

      ,[PickedByPersonID] 

      ,[ContactPersonID] 

      ,[BackorderOrderID] 

      ,[OrderDate] 

      ,[ExpectedDeliveryDate] 

      ,[CustomerPurchaseOrderNumber] 

      ,[IsUndersupplyBackordered] 

      ,[Comments] 

      ,[DeliveryInstructions] 

      ,[InternalComments] 

      ,[PickingCompletedWhen] 

 FROM [WideWorldImporters].[Sales].[Orders]  

WHERE [OrderID] > 10369 

OPTION (KEEPFIXED PLAN) ;

/*
Query 12:Example query for QUERYTRACEON query hint
*/
SELECT [OrderID] 

      ,[CustomerID] 

      ,[SalespersonPersonID] 

      ,[PickedByPersonID] 

      ,[ContactPersonID] 

      ,[BackorderOrderID] 

      ,[OrderDate] 

      ,[ExpectedDeliveryDate] 

      ,[CustomerPurchaseOrderNumber] 

      ,[IsUndersupplyBackordered] 

      ,[Comments] 

      ,[DeliveryInstructions] 

      ,[InternalComments] 

      ,[PickingCompletedWhen] 

      ,[LastEditedBy] 

      ,[LastEditedWhen] 

  FROM [WideWorldImporters].[Sales].[Orders]   

WHERE [OrderID] > 10369 

OPTION (QUERYTRACEON 8649) ;

/*
Query 13:Example query for USE HINT('') query hint
*/
SELECT [OrderID] 

      ,[CustomerID] 

      ,[SalespersonPersonID] 

      ,[PickedByPersonID] 

      ,[ContactPersonID] 

      ,[BackorderOrderID] 

      ,[OrderDate] 

      ,[ExpectedDeliveryDate] 

      ,[CustomerPurchaseOrderNumber] 

      ,[IsUndersupplyBackordered] 

      ,[Comments] 

      ,[DeliveryInstructions] 

      ,[InternalComments] 

      ,[PickingCompletedWhen] 

      ,[LastEditedBy] 

      ,[LastEditedWhen] 

  FROM [WideWorldImporters].[Sales].[Orders]  

WHERE [OrderID] > 10369  

OPTION(USE HINT('ENABLE_PARALLEL_PLAN_PREFERENCE')) ;

/*
Query 14:Example query for MAXDOP query hint
*/
SELECT [OrderID] 

      ,[CustomerID] 

      ,[SalespersonPersonID] 

      ,[PickedByPersonID] 

      ,[ContactPersonID] 

      ,[BackorderOrderID] 

      ,[OrderDate] 

      ,[ExpectedDeliveryDate] 

      ,[CustomerPurchaseOrderNumber] 

      ,[IsUndersupplyBackordered] 

      ,[Comments] 

      ,[DeliveryInstructions] 

      ,[InternalComments] 

      ,[PickingCompletedWhen] 

      ,[LastEditedBy] 

      ,[LastEditedWhen] 

  FROM [WideWorldImporters].[Sales].[Orders]  

WHERE [OrderID] > 10369 ;

/*
Query 15:Example query for OPTIMIZE FOR query hint
*/

CREATE PROCEDURE GetOrder 

@OrderID INT 

AS 

SELECT [OrderID] 

      ,[CustomerID] 

      ,[SalespersonPersonID] 

      ,[PickedByPersonID] 

      ,[ContactPersonID] 

      ,[BackorderOrderID] 

      ,[OrderDate] 

      ,[ExpectedDeliveryDate] 

      ,[CustomerPurchaseOrderNumber] 

      ,[IsUndersupplyBackordered] 

      ,[Comments] 

      ,[DeliveryInstructions] 

      ,[InternalComments] 

      ,[PickingCompletedWhen] 

      ,[LastEditedBy] 

      ,[LastEditedWhen] 

  FROM [WideWorldImporters].[Sales].[Orders]  

WHERE [OrderID] = @OrderID 

OPTION (OPTIMIZE FOR (@OrderID = 10369)) ;

/*
Query 16:Example query for OPTIMIZE FOR UNKNOWN query hint
*/

CREATE PROCEDURE GetInvoices 

@CustomerID INT 

AS 

SELECT  [InvoiceID] 

      ,[CustomerID] 

      ,[BillToCustomerID] 

      ,[OrderID] 

      ,[DeliveryMethodID] 

      ,[ContactPersonID] 

      ,[AccountsPersonID] 

      ,[SalespersonPersonID] 

      ,[PackedByPersonID] 

      ,[InvoiceDate] 

      ,[CustomerPurchaseOrderNumber] 

      ,[IsCreditNote] 

      ,[CreditNoteReason] 

      ,[Comments] 

      ,[DeliveryInstructions] 

      ,[InternalComments] 

      ,[TotalDryItems] 

      ,[TotalChillerItems] 

      ,[DeliveryRun] 

      ,[RunPosition] 

      ,[ReturnedDeliveryData] 

      ,[ConfirmedDeliveryTime] 

      ,[ConfirmedReceivedBy] 

      ,[LastEditedBy] 

      ,[LastEditedWhen] 

  FROM [WideWorldImporters].[Sales].[Invoices] 

  WHERE [CustomerID] = @CustomerID 

  OPTION(OPTIMIZE FOR UNKNOWN ) ;

/*
Query 17:Example query for ROBUST PLAN query hint
*/
SELECT  [InvoiceID] 

      ,[CustomerID] 

      ,[BillToCustomerID] 

      ,[OrderID] 

      ,[DeliveryMethodID] 

      ,[ContactPersonID] 

      ,[AccountsPersonID] 

      ,[SalespersonPersonID] 

      ,[PackedByPersonID] 

      ,[InvoiceDate] 

      ,[CustomerPurchaseOrderNumber] 

      ,[IsCreditNote] 

      ,[CreditNoteReason] 

      ,[Comments] 

      ,[DeliveryInstructions] 

      ,[InternalComments] 

      ,[TotalDryItems] 

      ,[TotalChillerItems] 

      ,[DeliveryRun] 

      ,[RunPosition] 

      ,[ReturnedDeliveryData] 

      ,[ConfirmedDeliveryTime] 

      ,[ConfirmedReceivedBy] 

      ,[LastEditedBy] 

      ,[LastEditedWhen] 

  FROM [WideWorldImporters].[Sales].[Invoices] 

  WHERE [CustomerID] = 1000 

  OPTION(ROBUST PLAN) ;
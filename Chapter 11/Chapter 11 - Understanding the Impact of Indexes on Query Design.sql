
/*
Query 1: example of creating an Index on [Fact].[Sale] table at [Customer Key] column
*/

CREATE INDEX [IX_Fact_Sale_CustomerKey] ON [Fact].[Sale] 

( 

[Customer Key] ASC 

) ;

/*
Query 2: example of droping an Index on [Fact].[Sale] table at [Customer Key] column, we created above
*/

DROP INDEX [IX_Fact_Sale_CustomerKey] ON [Fact].[Sale] ;

/*
Query 3: example of renaming an Index 
*/

EXEC sp_rename  N'[Fact].[Sale].[IX_Fact_Sale_Customer_Key]', N'[Fact].[Sale].[IX_Fact_Sale_CustomerKey]', N'INDEX'; 

/*
Query 4: example of modifying an Index using drop and create
*/

DROP INDEX [IX_Fact_Sale_CustomerKey] ON [Fact].[Sale] ;

CREATE INDEX [IX_Fact_Sale_BillToCustomerKey] ON [Fact].[Sale] 

( 

[Bill To Customer Key] ASC, 

[Customer Key] ASC 

) ;

/*
Query 5: example of modifying an Index ALTER INDEX
*/
ALTER INDEX [IX_Fact_Sale_BillToCustomerKey] ON [Fact].[Sale]  

SET ( ALLOW_PAGE_LOCKS = ON, 

STATISTICS_NORECOMPUTE = ON, 

    IGNORE_DUP_KEY = ON 

) ;

/*
Query 6: example of creating CLUSTERED INDEX 
*/

CREATE CLUSTERED INDEX [Fact_Sale_CityKey] ON [Fact].[Sale]  

( 

[Sale Key] ASC 

) ;

/*
Query 7: example of creating NONCLUSTERED INDEX 
*/

CREATE NONCLUSTERED INDEX [IX_Fact_Sale_InvoiceDateKey] ON [Fact].[Sale] 

( 

[Invoice Date Key] ASC 

) ;

/*
Query 8: example of creating UNIQUE INDEX 
*/

 CREATE UNIQUE INDEX [AK_DimensionCity_CityKey] ON [Dimension].[City] 

(  

[City Key] ASC  

) ;
/*
Query 9: example of creating filtered INDEX 
*/

CREATE NONCLUSTERED INDEX [FI_Integration_Order_WWI_Order_ID] ON [Fact].[Order] 

( 

[WWI Order ID] ASC 

) 

WHERE [Order Date Key] >= '2016-01-01'  

AND [Order Date Key] <= '2016-12-31' ;

/*
Query 10: example of creating covering INDEX 
*/
--QUERY to be COVERED 
SELECT [City Key] 

      ,[Customer Key] 

      ,[Salesperson Key] 

      ,AVG([Quantity]) [Avg Quantity] 

      , AVG([Unit Price]) [Avg Unit Price]       

     , SUM([Profit]) TotalProfit 

FROM [Fact].[Sale]  

WHERE [Invoice Date Key] BETWEEN '2013-01-01' AND '2016-01-03'  

GROUP BY [City Key] 

      ,[Customer Key] 

      ,[Salesperson Key] ;
-- CREATE covering INDEX

CREATE NONCLUSTERED INDEX [IX_Fact_Sale_InvoiceDateKey] ON [Fact].[Sale]  

 (  

 	[Invoice Date Key] ASC  

 )  

INCLUDE ([City Key]  

       ,[Customer Key]  

       ,[Salesperson Key]  

       ,[Quantity] 

       ,[Unit Price]        

     ,[Profit] 

  ) ;

/*
Query 11: example of CTE used to compare performance before and after index created 
*/

--start of CTE queries  

;with   

ISODates as (  

SELECT distinct [Date],[ISO Week Number] as [ISOWeekNumber]  

  FROM [Dimension].[Date])  

--separate multiple CTEs with comma  

,DryTotalQuery as (  

SELECT [Invoice Date Key] as DryInvoiceDateKey  

      ,Sum([Total Dry Items]) as DailyTotalDry  

  FROM [Fact].[Sale]  

  WHERE [Invoice Date Key] between '2013-01-01' and '2016-01-03' and [Total Dry Items] <> 0  

  GROUP BY [Invoice Date Key])  

  --separate multiple CTEs with comma  

,ChillerTotalQuery as (  

SELECT [Invoice Date Key] as ChillerInvoiceDateKey  

       ,Sum([Total Chiller Items]) as DailyTotalChiller  

  FROM [Fact].[Sale]  

  WHERE [Invoice Date Key] between '2013-01-01' and '2016-01-03' and [Total Chiller Items] = 0  

  GROUP BY [Invoice Date Key])  

  --end of CTEs  

  --Query selecting from CTEs:  

  SELECT   

   [Date]  

  ,[ISOWeekNumber]  

  ,ISNULL(DailyTotalDry,0) as DailyTotalDry  

  ,ISNULL(DailyTotalChiller,0) as DailyTotalChiller  

  ,ISNULL(DailyTotalDry,0) + ISNULL(DailyTotalChiller,0) as TotalDailyItems  

  FROM ISODates d  

  LEFT OUTER JOIN DryTotalQuery dtq on d.[Date] = dtq.DryInvoiceDateKey  

 LEFT OUTER JOIN ChillerTotalQuery ctq on d.[Date] = ctq.ChillerInvoiceDateKey  

  WHERE d.[Date] between '2013-01-01' and '2016-01-03' 

  ORDER BY [Date] ;

/*
Query 12: query to get list of fragemented indexes with fragmentation in the WideWorldImportersDW databases
*/

SELECT OBJECT_NAME(IND.OBJECT_ID) AS [Table Name], 

IND.NAME AS [Index Name], PS.INDEX_TYPE_DESC AS [Index Type], 

PS.AVG_FRAGMENTATION_IN_PERCENT [Avg Fragementation] 

FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(), NULL, NULL, NULL, NULL) PS 

INNER JOIN SYS.INDEXES IND 

ON IND.OBJECT_ID = PS.OBJECT_ID 

AND IND.INDEX_ID = PS.INDEX_ID 

WHERE PS.AVG_FRAGMENTATION_IN_PERCENT > 0 

ORDER BY PS.AVG_FRAGMENTATION_IN_PERCENT DESC ;

/*
Query 13: example of rebuilding index on a table
*/

-- rebuild FK_Fact_Sale_City_Key index on the [Fact].[Sale] table 

ALTER INDEX FK_Fact_Sale_City_Key ON [Fact].[Sale] REBUILD; 

--To rebuild all indexes on [Fact].[Sale] table, use below the following statement: 

ALTER INDEX ALL ON [Fact].[Sale] REBUILD; 


/*
Query 14: example of reorganize index on a table
*/

--example to reorganize FK_Fact_Purchase_Date_Key index: 

ALTER INDEX FK_Fact_Purchase_Date_Key ON [Fact].[Purchase] REORGANIZE; 

--To reorganize all indexes on [Fact].[Purchase] table, use below statement: 

ALTER INDEX ALL ON [Fact].[Purchase] REORGANIZE; 

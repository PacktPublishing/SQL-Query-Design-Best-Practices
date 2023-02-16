SELECT *
FROM 
OPENROWSET (
    BULK 'https://ledatalake.dfs.core.windows.net/datawarehouse/Suppliers.csv'
    , FORMAT = 'CSV'
    , PARSER_VERSION = '2.0'
) AS [SuppliersCSV]


-- HEADER ROW = true
SELECT *
FROM 
OPENROWSET (
    BULK 'https://ledatalake.dfs.core.windows.net/datawarehouse/Suppliers.csv'
    , FORMAT = 'CSV'
    , PARSER_VERSION = '2.0'
    , HEADER_ROW = TRUE
) AS [SuppliersCSV]


SELECT *
FROM 
OPENROWSET (
    BULK 'https://ledatalake.blob.core.windows.net/datawarehouse/PurchaseOrders.csv'
    , FORMAT = 'CSV'
    , PARSER_VERSION = '2.0'
    , HEADER_ROW = TRUE
) AS [PurchaseOrdersCSV]

SELECT 
    [SuppliersCSV].SupplierID
    , [SuppliersCSV].SupplierName
    , [PurchaseOrdersCSV].OrderDate
    , [PurchaseOrdersCSV].LastEditedBy
FROM 
    OPENROWSET (
        BULK 'https://ledatalake.dfs.core.windows.net/datawarehouse/Suppliers.csv'
        , FORMAT = 'CSV'
        , PARSER_VERSION = '2.0'
        , HEADER_ROW = TRUE
    ) AS [SuppliersCSV] 
    INNER JOIN 
        (SELECT *
        FROM 
        OPENROWSET (
            BULK 'https://ledatalake.blob.core.windows.net/datawarehouse/PurchaseOrders.csv'
            , FORMAT = 'CSV'
            , PARSER_VERSION = '2.0'
            , HEADER_ROW = TRUE
        ) AS [PurchaseOrdersCSV]) AS [PurchaseOrdersCSV]
    ON [SuppliersCSV].SupplierID = [PurchaseOrdersCSV].SupplierID
WHERE [SuppliersCSV].SupplierID = '10';


-- WITH option
SELECT *
FROM 
OPENROWSET (
    BULK 'https://ledatalake.dfs.core.windows.net/datawarehouse/Suppliers.csv'
    , FORMAT = 'CSV'
    , PARSER_VERSION = '2.0'
    , HEADER_ROW = TRUE
) 
WITH (
    [SupplierID] INT
    , [SupplierName] VARCHAR (100)
    , [DeliveryCityID] INT
    , [PostalCityID] INT
)
AS [SuppliersCSV]


-- EXTERNAL TABLES
-- DROP DATABASE ExternalTableDBDemo;


-- Create a demo database on serverless SQL pool
CREATE DATABASE ExternalTableDBDemo;

USE [ExternalTableDBDemo];

-- Create a database master key if you don't have one, you can replace password with your own
CREATE MASTER KEY ENCRYPTION BY PASSWORD='3XternalTbls12345!';

-- Create a database scoped credential
CREATE DATABASE SCOPED CREDENTIAL ExternalTblsCred
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = 'QLYMgmSXMklt%2FI1U6DcVrQixnUBGs%3D';

-- Create a database external data source
CREATE EXTERNAL DATA SOURCE ExternalTblsDS WITH (
    LOCATION = 'https://ledatalake.dfs.core.windows.net/datawarehouse',
    CREDENTIAL = ExternalTblsCred
);



-- Create file format for Suppliers.csv
CREATE EXTERNAL FILE FORMAT SuppliersFF
WITH
(  
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR = ','
        , PARSER_VERSION = '1.0'
        , FIRST_ROW = 2
        , ENCODING = 'UTF8'
    )
);



--DROP EXTERNAL TABLE SuppliersExternalTbl;

CREATE EXTERNAL TABLE SuppliersExternalTbl
(
    [SupplierID] INT
    , [SupplierName] VARCHAR (100)
    , [DeliveryCityID] INT
    , [PostalCityID] INT
)  
WITH (
    LOCATION = 'Suppliers.csv',
    DATA_SOURCE = ExternalTblsDS,  
    FILE_FORMAT = SuppliersFF
)
GO


SELECT TOP 10 * FROM SuppliersExternalTbl;







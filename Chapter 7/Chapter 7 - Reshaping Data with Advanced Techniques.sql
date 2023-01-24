--------------------------------------------------------------
-- Get Total Purchase Orders by Supplier and Delivery Method
--------------------------------------------------------------
USE [WideWorldImporters-Standard]
GO

SELECT 
	[SupplierID]
	, COUNT([PurchaseOrderID]) AS CTPurchaseOrder
FROM 
	[Purchasing].[PurchaseOrders]
GROUP BY
	[SupplierID];


--------------------------------------------------------------
-- Using PIVOT operator, produce pivot table with Suppliers 
--------------------------------------------------------------
USE [WideWorldImporters-Standard]
GO

SELECT 
	'Total Purchase Orders' AS TotalPurchaseOrders
	, [1] AS SalesPer1, [2] AS SalesPer2, [4] AS SalesPer3
	, [5] AS SalesPer4, [7] AS SalesPer5, [10] AS SalesPer6
	, [12] AS SalesPer7
FROM
(
	SELECT 
		[SupplierID]
		, [PurchaseOrderID]
	FROM 
		[Purchasing].[PurchaseOrders]
) AS SrcTbl
PIVOT
(
	COUNT([PurchaseOrderID])
	FOR [SupplierID] IN ([1], [2], [4], [5], [7], [10], [12])
) AS PvtTbl;



--------------------------------------------------------------
-- Complex PIVOT operator, map Supplier name to Supplier Master
--------------------------------------------------------------
USE [WideWorldImporters-Standard]
GO

SELECT 
	'Total Purchase Orders' AS TotalPurchaseOrders
	, [A Datum Corporation]
	, [Contoso, Ltd.]
	, [Fabrikam, Inc.]
	, [Graphic Design Institute]
	, [Litware, Inc.]
	, [Northwind Electric Cars]
	, [The Phone Company]

FROM
(
	SELECT DISTINCT
		SP.SupplierName
		, PO.[PurchaseOrderID]
	FROM 
		[Purchasing].[PurchaseOrders] PO INNER JOIN [Purchasing].[Suppliers] SP
			ON PO.SupplierID = SP.SupplierID
) AS SrcTbl
PIVOT
(
	COUNT([PurchaseOrderID])
	FOR SupplierName IN (
		[A Datum Corporation]
		, [Contoso, Ltd.]
		, [Fabrikam, Inc.]
		, [Graphic Design Institute]
		, [Litware, Inc.]
		, [Northwind Electric Cars]
		, [The Phone Company]
	)
) AS PvtTbl;


--------------------------------------------------------------
-- Dynamic column names in a PIVOT operation
--------------------------------------------------------------
USE [WideWorldImporters-Standard]
GO

DECLARE 
	@pvtColumns NVARCHAR(MAX) = '',
	@sql		NVARCHAR(MAX) = '';

SELECT 
	@pvtColumns = @pvtColumns + ', ' + QUOTENAME(Cols.SupplierName)
FROM 
	(
		SELECT DISTINCT SP.SupplierName
		FROM [Purchasing].[PurchaseOrders] PO 
			INNER JOIN [Purchasing].[Suppliers] SP ON PO.SupplierID = SP.SupplierID
	) Cols;

-- remove first comma from the list
SET @pvtColumns = SUBSTRING(@pvtColumns, 3, LEN(@pvtColumns));

-- dynamic PIVOT query
SET @sql = 
	'
	SELECT 
		''Total Purchase Orders'' AS TotalPurchaseOrders,
		' + @pvtColumns + '

	FROM
	(
		SELECT DISTINCT
			SP.SupplierName
			, PO.[PurchaseOrderID]
		FROM 
			[Purchasing].[PurchaseOrders] PO INNER JOIN [Purchasing].[Suppliers] SP
				ON PO.SupplierID = SP.SupplierID
	) AS SrcTbl
	PIVOT
	(
		COUNT([PurchaseOrderID])
		FOR SupplierName IN (
			' + @pvtColumns + '
		)
	) AS PvtTbl;
	';

-- execute the dynamic sql statement
EXECUTE sp_executesql @sql;


--------------------------------------------------------------
-- Create sample table for UNPIVOT operator testing 
--------------------------------------------------------------
--DROP TABLE pvtSupplierPurchaseOrder;

-- Create the table and insert values as portrayed in the previous example.  
CREATE TABLE pvtSupplierPurchaseOrder (
	TotalPurchaseOrders VARCHAR(25)
	, [A Datum Corporation] INT
	, [Contoso, Ltd.] INT
	, [Fabrikam, Inc.] INT
	, [Graphic Design Institute] INT
	, [Litware, Inc.] INT
	, [Northwind Electric Cars] INT
	, [The Phone Company] INT
	);  
GO

INSERT INTO pvtSupplierPurchaseOrder VALUES ('Total Purchase Orders', 5, 1, 1055, 13, 985, 10, 5);  
GO  

SELECT * FROM [pvtSupplierPurchaseOrder]


--------------------------------------------------------------
-- Using UNPIVOT, produce Suppliers rows from column values
--------------------------------------------------------------

SELECT TotalPurchaseOrders, Suppliers, PurchaseOrder
FROM   
   (SELECT TotalPurchaseOrders
		, [A Datum Corporation]
		, [Contoso, Ltd.]
		, [Fabrikam, Inc.]
		, [Graphic Design Institute]
		, [Litware, Inc.]
		, [Northwind Electric Cars]
		, [The Phone Company]
   FROM pvtSupplierPurchaseOrder) p  
UNPIVOT  
   (PurchaseOrder FOR Suppliers IN   
      ([A Datum Corporation]
		, [Contoso, Ltd.]
		, [Fabrikam, Inc.]
		, [Graphic Design Institute]
		, [Litware, Inc.]
		, [Northwind Electric Cars]
		, [The Phone Company])  
)AS unpvt;  
GO  


--------------------------------------------------------------
-- Create a new table for Hierarchy data example
--------------------------------------------------------------
-- DROP TABLE Sales.EmployeeOrganization;

CREATE TABLE Sales.EmployeeOrganization
(  
   EmpNode hierarchyid PRIMARY KEY CLUSTERED,  
   EmpLevel AS EmpNode.GetLevel(),  
   EmpID int UNIQUE NOT NULL,  
   EmpName nvarchar(25) NOT NULL, 
   EmpTitle nvarchar(25) NOT NULL
) ;  
GO

--------------------------------------------------------------
-- Add John has Manager in the organization
--------------------------------------------------------------
INSERT Sales.EmployeeOrganization (EmpNode, EmpID, EmpName, EmpTitle)  
VALUES (hierarchyid::GetRoot(), 0, 'John', 'Manager') ;  
GO

SELECT EmpNode, EmpNode.ToString() AS Text_EmpNode, EmpLevel, EmpID, EmpName, EmpTitle   
FROM Sales.EmployeeOrganization;
GO

--------------------------------------------------------------
-- Adding subordinate nodes under root node - John
--------------------------------------------------------------
DECLARE @vEmpNode hierarchyid, @mx hierarchyid;

SELECT @vEmpNode = EmpNode FROM Sales.EmployeeOrganization WHERE EmpID = '0';

-- Add Jim
SELECT @mx = max(EmpNode) FROM Sales.EmployeeOrganization WHERE EmpNode.GetAncestor(1) = @vEmpNode;

INSERT Sales.EmployeeOrganization (EmpNode, EmpID, EmpName, EmpTitle)  
      VALUES(@vEmpNode.GetDescendant(@mx, NULL), '17', 'Jim', 'Assistant Manager');

-- Add Kim
SELECT @mx = max(EmpNode) FROM Sales.EmployeeOrganization WHERE EmpNode.GetAncestor(1) = @vEmpNode;

INSERT Sales.EmployeeOrganization (EmpNode, EmpID, EmpName, EmpTitle)  
      VALUES(@vEmpNode.GetDescendant(@mx, NULL), '24', 'Kim', 'Assistant Manager');

GO

--------------------------------------------------------------
-- Adding subordinate nodes under root node - Jim
--------------------------------------------------------------
DECLARE @vEmpNode hierarchyid, @mx hierarchyid;

SELECT @vEmpNode = EmpNode FROM Sales.EmployeeOrganization WHERE EmpID = '17';

-- Add Jack
SELECT @mx = max(EmpNode) FROM Sales.EmployeeOrganization WHERE EmpNode.GetAncestor(1) = @vEmpNode;

INSERT Sales.EmployeeOrganization (EmpNode, EmpID, EmpName, EmpTitle)  
      VALUES(@vEmpNode.GetDescendant(@mx, NULL), '32', 'Jack', 'Team Member');

-- Add Frank
SELECT @mx = max(EmpNode) FROM Sales.EmployeeOrganization WHERE EmpNode.GetAncestor(1) = @vEmpNode;

INSERT Sales.EmployeeOrganization (EmpNode, EmpID, EmpName, EmpTitle)  
      VALUES(@vEmpNode.GetDescendant(@mx, NULL), '25', 'Frank', 'Team Member');

GO
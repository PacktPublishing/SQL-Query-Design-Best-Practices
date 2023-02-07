-- Create an Employee table.
CREATE TABLE dbo.Employee
(
EmployeeID SMALLINT NOT NULL,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(40) NOT NULL,
Title NVARCHAR(50) NOT NULL,
ManagerID SMALLINT NULL,
CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC),
CONSTRAINT FK_Employee_ManagerID_EmployeeID FOREIGN KEY (ManagerID) REFERENCES dbo.Employee (EmployeeID)
);

-- Populate the table with values.
INSERT INTO dbo.Employee VALUES
(1, N'Jennifer', N'Sanchez', N'Chief Executive Officer', NULL)
,(273, N'Brianna', N'Walker', N'Vice President of Sales', 1)
,(274, N'Stephanie', N'Miller', N'West US Sales Manager', 273)
,(275, N'Blythe', N'Martinez', N'Sales Representative', 274)
,(276, N'Linda', N'Mitchell', N'Sales Representative', 274)
,(285, N'Syed', N'Abbas', N'East US Sales Manager', 273)
,(286, N'Lynn', N'Tsoflias', N'Sales Representative', 285)
,(16, N'Melissa', N'Bradley', N'Human Resources Manager', 1)
,(23, N'Mary', N'Gibson', N'HR Specialist', 16);

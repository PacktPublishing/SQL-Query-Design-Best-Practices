WITH DirectReports AS
(
    SELECT ManagerID, EmployeeID, Title, cast('' as nvarchar(50)) as ManagerTitle, 0 AS EmployeeLevel
    FROM dbo.Employee
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.ManagerID, e.EmployeeID, e.Title, cast(d.Title as nvarchar(50)) as ManagerTitle, EmployeeLevel + 1
    FROM dbo.Employee AS e
        INNER JOIN DirectReports AS d
        ON e.ManagerID = d.EmployeeID
)
SELECT ManagerID, EmployeeID, Title, ManagerTitle, EmployeeLevel
FROM DirectReports
ORDER BY ManagerID;
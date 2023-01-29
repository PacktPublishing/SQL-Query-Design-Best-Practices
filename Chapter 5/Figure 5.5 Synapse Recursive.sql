-- Query to find out emplyee and manager heirarchy

SELECT EmployeeID,FirstName,LastName,Title,ManagerID, NULL as ManagerTitle, 0 as Level FROM dbo.Employee e WHERE ManagerID IS NULL
UNION ALL
SELECT e.EmployeeID,e.FirstName,e.LastName,e.Title,e.ManagerID, m.Title, Level+1 as Level FROM dbo.Employee e
INNER JOIN (SELECT EmployeeID,FirstName,LastName,Title,ManagerID, 0 as Level FROM dbo.Employee e WHERE ManagerID IS NULL) m ON e.ManagerID = m.EmployeeID
WHERE e.ManagerID IS NOT NULL
UNION ALL
select e.EmployeeID,e.FirstName,e.LastName,e.Title,e.ManagerID, m2.Title, Level+1 as Level FROM dbo.Employee e
INNER JOIN (
SELECT e.EmployeeID,e.FirstName,e.LastName,e.Title,e.ManagerID, Level+1 as Level FROM dbo.Employee e
INNER JOIN (SELECT EmployeeID,FirstName,LastName,Title,ManagerID, 0 as Level FROM dbo.Employee e WHERE ManagerID IS NULL) m1 ON e.ManagerID = m1.EmployeeID
WHERE e.ManagerID IS NOT NULL) m2 ON e.ManagerID = m2.EmployeeID
WHERE e.ManagerID IS NOT NULL
UNION ALL
SELECT e.EmployeeID,e.FirstName,e.LastName,e.Title,e.ManagerID, m3.Title, Level+1 as Level FROM dbo.Employee e
INNER JOIN (select e.EmployeeID,e.FirstName,e.LastName,e.Title,e.ManagerID, Level+1 as Level FROM dbo.Employee e
INNER JOIN (
SELECT e.EmployeeID,e.FirstName,e.LastName,e.Title,e.ManagerID, Level+1 as Level FROM dbo.Employee e
INNER JOIN (SELECT EmployeeID,FirstName,LastName,Title,ManagerID, 0 as Level FROM dbo.Employee e WHERE ManagerID IS NULL) m1 ON e.ManagerID = m1.EmployeeID
WHERE e.ManagerID IS NOT NULL) m2 ON e.ManagerID = m2.EmployeeID
WHERE e.ManagerID IS NOT NULL) m3 ON e.ManagerID = m3.EmployeeID WHERE e.ManagerID IS NOT NULL;
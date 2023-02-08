UPDATE [Dimension].[City] 
SET [Sales Territory] =
	CASE
		WHEN [State Province] = 'New York' THEN 'Mideast' 
		WHEN [State Province] = 'Illinois' THEN 'Great Lakes'
		WHEN [State Province] = 'Missouri' THEN 'Plains'
    END
WHERE [State Province] IN ('New York', 'Illinois', 'Missouri') 
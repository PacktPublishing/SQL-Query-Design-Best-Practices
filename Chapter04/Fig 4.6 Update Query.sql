UPDATE [Dimension].[City] 
SET [Sales Territory] =
	CASE
		WHEN [State Province] = 'New York' THEN 'Eastcoast' 
		WHEN [State Province] = 'Illinois' THEN 'Midwest'
		WHEN [State Province] = 'Missouri' THEN 'Midwest'
    END
WHERE [State Province] IN ('New York', 'Illinois', 'Missouri') 
SELECT Table_name as [Table] , 
       Column_name as [Column] , 
       Table_catalog as [Database], 
       table_schema as [Schema]  
FROM   information_schema.columns
WHERE  table_schema = 'Fact'
ORDER BY Table_name, Column_name;


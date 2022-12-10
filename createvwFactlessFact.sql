--Create external dimension table
ALTER VIEW vwFactlessFact
AS 
SELECT
     DimKey
    ,cast([date] AS date) AS [Date]
    ,policy_number AS [Policy Number]
    ,[status] AS [Status]
FROM 
    OPENROWSET(
        BULK 'gold/factless_fact/',
        DATA_SOURCE = 'ds_fscustransdevnorthcent',
        FORMAT = 'DELTA'
    ) AS [result]



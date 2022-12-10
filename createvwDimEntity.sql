--Create external dimension table
ALTER VIEW vwDimEntity
AS 
SELECT
     DimKey
    ,agency_number AS [Agency Number]
    ,insured AS [Insured]
    ,company AS [Company]
FROM 
    OPENROWSET(
        BULK 'gold/dim_entity/',
        DATA_SOURCE = 'ds_fscustransdevnorthcent',
        FORMAT = 'DELTA'
    ) AS [result]
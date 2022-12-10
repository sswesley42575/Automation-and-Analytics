-- Create File format for schema, designate data source, create table with name,field,data type
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'ds_fscustransdevnorthcent') 
	CREATE EXTERNAL DATA SOURCE [ds_fscustransdevnorthcent] 
	WITH (
		LOCATION = 'abfss://fscustransdevnorthcent@stcustransdevnorthcent.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE [CombineData] (
	[agency_number] nvarchar(100),
	[insured] nvarchar(100),
	[company] nvarchar(100),
	[date] nvarchar(100),
	[policy_number] nvarchar(100),
	[status] nvarchar(100)
	)
	WITH (
	LOCATION = 'silver/Combined/**',
	DATA_SOURCE = [ds_fscustransdevnorthcent],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO

SELECT TOP 100 * FROM [dbo].[CombineData]
GO
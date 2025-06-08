IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[SourceObject]') AND type in (N'U'))
DROP TABLE [Control].[SourceObject]
GO
CREATE TABLE [Control].[SourceObject](
	[Id] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](256) NULL,
	[SchemaName] [nvarchar](64) NULL,
	[ObjectName] [nvarchar](64) NULL
) ON [PRIMARY] 
GO
ALTER TABLE [Control].[SourceObject] ADD PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[SinkObject]') AND type in (N'U'))
DROP TABLE [Control].[SinkObject]
GO
CREATE TABLE [Control].[SinkObject](
	[Id] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](256) NULL,
	[SchemaName] [nvarchar](64) NULL,
	[ObjectName] [nvarchar](64) NULL
) ON [PRIMARY] 
GO
ALTER TABLE [Control].[SinkObject] ADD PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


DECLARE @ObjectMetadata NVARCHAR(max)  = N'[
    {
        "Name": "SalesLT.Address",
        "SchemaName": "SalesLT",
        "ObjectName": "Address"
    },
    {
        "Name": "SalesLT.Customer",
        "SchemaName": "SalesLT",
        "ObjectName": "Customer"
    },
    {
        "Name": "SalesLT.CustomerAddress",
        "SchemaName": "SalesLT",
        "ObjectName": "CustomerAddress"
    }
]'

INSERT INTO [Control].[SourceObject] (
    [Name],
    [SchemaName],
    [ObjectName])
SELECT * FROM OPENJSON(@ObjectMetadata)
    WITH ([Name] [nvarchar](256),
    [SchemaName] [varchar](64),
    [ObjectName] [nvarchar](64))


INSERT INTO [Control].[SinkObject] (
    [Name],
    [SchemaName],
    [ObjectName])
SELECT * FROM OPENJSON(@ObjectMetadata)
    WITH ([Name] [nvarchar](256),
    [SchemaName] [varchar](64),
    [ObjectName] [nvarchar](64))
GO
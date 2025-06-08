/****** Object:  Schema [Control].[SourceObject] ******/
/*
This script creates the SourceObject table in the Control schema.
It is used to store metadata about sink objects in data integration tasks.
The Name collumn is used to identify the object and is currently a concatenation <Schema Name>.<Object Name>.
Other details have yet to be defined.
*/
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


/****** Object:  Table [Control].[SinkObject] ******/
/*
This script creates the SinkObject table in the Control schema.
It is used to store metadata about sink objects in data integration tasks.
The Name collumn is used to identify the object and is currently a concatenation <Schema Name>.<Object Name>.
Other details have yet to be defined.
*/
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


/****** Object:  Table [Control].[ColumnMapping] ******/
/*
This script creates the ColumnMapping table in the Control schema.
It is used to map source columns to target columns in data integration tasks.
The table includes columns for the mapping ID, source and target column names, types, physical types, and an ordinal value to maintain the order of the mappings.
The types and physical types are necessary for use with the TabularTranslator in Azure Data Factory or Synapse pipelines.
The MappingId is used to associate the column mapping with a specific data integration task.
*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[ColumnMapping]') AND type in (N'U'))
DROP TABLE [Control].[ColumnMapping]
GO
CREATE TABLE [Control].[ColumnMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SourceColumn] [nvarchar](64) NOT NULL,
    [SourceType] [nvarchar](64) NOT NULL,
    [SourcePhysicalType] [nvarchar](64) NOT NULL,
	[TargetColumn] [nvarchar](64) NOT NULL,
    [TargetType] [nvarchar](64) NOT NULL,
    [TargetPhysicalType] [nvarchar](64) NOT NULL,
    [MappingId] [int] NOT NULL,
    [Ordinal] [int] NOT NULL
) ON [PRIMARY] 
GO
ALTER TABLE [Control].[ColumnMapping] ADD PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


/*
Test data to be inserted into the Satalite tables.
*/
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



DECLARE @CA_MappingMetadata NVARCHAR(max)  = N'[
    {
        "source": {
            "name": "CustomerID",
            "type": "Int32",
            "physicalType": "int"
        },
        "sink": {
            "name": "CustomerID",
            "type": "Int32",
            "physicalType": "int"
        }
    },
    {
        "source": {
            "name": "AddressID",
            "type": "Int32",
            "physicalType": "int"
        },
        "sink": {
            "name": "AddressID",
            "type": "Int32",
            "physicalType": "int"
        }
    },
    {
        "source": {
            "name": "AddressType",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "AddressType",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "rowguid",
            "type": "Guid",
            "physicalType": "uniqueidentifier"
        },
        "sink": {
            "name": "rowguid",
            "type": "Guid",
            "physicalType": "uniqueidentifier"
        }
    },
    {
        "source": {
            "name": "ModifiedDate",
            "type": "DateTime",
            "physicalType": "datetime"
        },
        "sink": {
            "name": "ModifiedDate",
            "type": "DateTime",
            "physicalType": "datetime2"
        }
    }
]'

DECLARE @C_MappingMetadata NVARCHAR(max)  = N'[
    {
        "source": {
            "name": "CustomerID",
            "type": "Int32",
            "physicalType": "int"
        },
        "sink": {
            "name": "CustomerID",
            "type": "Int32",
            "physicalType": "int"
        }
    },
    {
        "source": {
            "name": "NameStyle",
            "type": "Boolean",
            "physicalType": "bit"
        },
        "sink": {
            "name": "NameStyle",
            "type": "Boolean",
            "physicalType": "bit"
        }
    },
    {
        "source": {
            "name": "Title",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "Title",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "FirstName",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "FirstName",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "MiddleName",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "MiddleName",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "LastName",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "LastName",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "PasswordSalt",
            "type": "String",
            "physicalType": "varchar"
        },
        "sink": {
            "name": "PasswordSalt",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "rowguid",
            "type": "Guid",
            "physicalType": "uniqueidentifier"
        },
        "sink": {
            "name": "rowguid",
            "type": "Guid",
            "physicalType": "uniqueidentifier"
        }
    },
    {
        "source": {
            "name": "ModifiedDate",
            "type": "DateTime",
            "physicalType": "datetime"
        },
        "sink": {
            "name": "ModifiedDate",
            "type": "DateTime",
            "physicalType": "datetime2"
        }
    },
    {
        "source": {
            "name": "Suffix",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "Suffix",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "CompanyName",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "CompanyName",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "SalesPerson",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "SalesPerson",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "EmailAddress",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "EmailAddress",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "Phone",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "Phone",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "PasswordHash",
            "type": "String",
            "physicalType": "varchar"
        },
        "sink": {
            "name": "PasswordHash",
            "type": "String",
            "physicalType": "nvarchar"
        }
    }
]'

DECLARE @A_MappingMetadata NVARCHAR(max)  = N'[
    {
        "source": {
            "name": "AddressID",
            "type": "Int32",
            "physicalType": "int"
        },
        "sink": {
            "name": "AddressID",
            "type": "Int32",
            "physicalType": "int"
        }
    },
    {
        "source": {
            "name": "AddressLine1",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "AddressLine1",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "AddressLine2",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "AddressLine2",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "City",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "City",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "StateProvince",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "StateProvince",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "CountryRegion",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "CountryRegion",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "PostalCode",
            "type": "String",
            "physicalType": "nvarchar"
        },
        "sink": {
            "name": "PostalCode",
            "type": "String",
            "physicalType": "nvarchar"
        }
    },
    {
        "source": {
            "name": "rowguid",
            "type": "Guid",
            "physicalType": "uniqueidentifier"
        },
        "sink": {
            "name": "rowguid",
            "type": "Guid",
            "physicalType": "uniqueidentifier"
        }
    },
    {
        "source": {
            "name": "ModifiedDate",
            "type": "DateTime",
            "physicalType": "datetime"
        },
        "sink": {
            "name": "ModifiedDate",
            "type": "DateTime",
            "physicalType": "datetime2"
        }
    }
]'

INSERT INTO [Control].[ColumnMapping] (
    [SourceColumn],
    [SourceType],
    [SourcePhysicalType],
	[TargetColumn],
    [TargetType],
    [TargetPhysicalType],
    [MappingId],
    [Ordinal])
SELECT
    *,
    1,
    0
FROM OPENJSON(@A_MappingMetadata)
WITH (
    [SourceColumn] [nvarchar](64) '$.source.name',
    [SourceType] [nvarchar](64) '$.source.type',
    [SourcePhysicalType] [nvarchar](64) '$.source.physicalType',
    [TargetColumn] [nvarchar](64) '$.sink.name',
    [TargetType] [nvarchar](64) '$.sink.type',
    [TargetPhysicalType] [nvarchar](64) '$.sink.physicalType'
)
UNION ALL
SELECT
    *,
    2,
    0
FROM OPENJSON(@C_MappingMetadata)
WITH (
    [SourceColumn] [nvarchar](64) '$.source.name',
    [SourceType] [nvarchar](64) '$.source.type',
    [SourcePhysicalType] [nvarchar](64) '$.source.physicalType',
    [TargetColumn] [nvarchar](64) '$.sink.name',
    [TargetType] [nvarchar](64) '$.sink.type',
    [TargetPhysicalType] [nvarchar](64) '$.sink.physicalType'
)
UNION ALL
SELECT
    *,
    3,
    0
FROM OPENJSON(@CA_MappingMetadata)
WITH (
    [SourceColumn] [nvarchar](64) '$.source.name',
    [SourceType] [nvarchar](64) '$.source.type',
    [SourcePhysicalType] [nvarchar](64) '$.source.physicalType',
    [TargetColumn] [nvarchar](64) '$.sink.name',
    [TargetType] [nvarchar](64) '$.sink.type',
    [TargetPhysicalType] [nvarchar](64) '$.sink.physicalType'
)
GO

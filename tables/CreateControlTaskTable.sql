
--  CREATE SCHEMA Control
-- GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[Task]') AND type in (N'U'))
DROP TABLE [Control].[Task]
GO
CREATE TABLE [Control].[Task](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	-- [SourceObjectSettings] [nvarchar](max) NULL,
	[SourceObjectId] [int],
	[SourceConnectionSettingsName] [varchar](max) NULL,
	[CopySourceSettings] [nvarchar](max) NULL,
	-- [SinkObjectSettings] [nvarchar](max) NULL,
	[SinkObjectId] [int],
	[SinkConnectionSettingsName] [varchar](max) NULL,
	[CopySinkSettings] [nvarchar](max) NULL,
	[CopyActivitySettings] [nvarchar](max) NULL,
	[TopLevelPipelineName] [varchar](max) NULL,
	[TriggerName] [nvarchar](max) NULL,
	[DataLoadingBehaviorSettings] [nvarchar](max) NULL,
	-- [TaskId] [int] NULL,
    [GroupId] [int] NULL,
	[CopyEnabled] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Control].[Task] ADD PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/*
        "SourceObjectSettings": {
            "schema": "SalesLT",
            "table": "Address"
        },
        "SinkObjectSettings": {
            "schema": "SalesLT",
            "table": "Address"
        },
        "TaskId": 0,
*/

DECLARE @TaskMetadata NVARCHAR(max)  = N'[
    {

        "SourceName": "SalesLT.Address",
        "SinkName": "SalesLT.Address",
        "CopySourceSettings": {
            "isolationLevel": "ReadCommitted",
            "partitionOption": "None",
            "sqlReaderQuery": null,
            "partitionLowerBound": null,
            "partitionUpperBound": null,
            "partitionColumnName": null,
            "partitionNames": null
        },
        "CopySinkSettings": {
            "preCopyScript": null,
            "tableOption": "autoCreate",
            "writeBehavior": "upsert",
            "sqlWriterUseTableLock": false,
            "writeBatchSize": 1024,
            "maxConcurrentConnections": 8,
            "disableMetricsCollection": false,
            "upsertSettings": {
                "useTempDB": true,
                "keys": [
                    "AddressID"
                ]
            }
        },
        "CopyActivitySettings": {
            "translator": {
                "type": "TabularTranslator",
                "mappings": [
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
                ],
                "typeConversion": true,
                "typeConversionSettings": {
                    "allowDataTruncation": true,
                    "treatBooleanAsNumber": false
                }
            }
        },
        "TopLevelPipelineName": "Ingestion_L1",
        "TriggerName": [
            "Sandbox",
            "Manual"
        ],
        "DataLoadingBehaviorSettings": {
            "dataLoadingBehavior": "DeltaLoad",
            "watermarkColumnName": "ModifiedDate",
            "watermarkColumnType": "DateTime",
            "watermarkColumnStartValue": "2006-06-01T00:00:00.000Z"
        },
        "GroupId": 0,
        "CopyEnabled": 1
    },
    {
        "SourceName": "SalesLT.Customer",
        "SinkName": "SalesLT.Customer",
        "CopySourceSettings": {
            "isolationLevel": null,
            "partitionOption": "None",
            "sqlReaderQuery": "select * from [SalesLT].[Customer]",
            "partitionLowerBound": null,
            "partitionUpperBound": null,
            "partitionColumnName": null,
            "partitionNames": null
        },
        "CopySinkSettings": {
            "preCopyScript": null,
            "tableOption": "autoCreate",
            "writeBehavior": "insert",
            "sqlWriterUseTableLock": false,
            "writeBatchSize": 1024,
            "maxConcurrentConnections": 8,
            "disableMetricsCollection": false,
            "upsertSettings": null
        },
        "CopyActivitySettings": {
            "translator": {
                "type": "TabularTranslator",
                "mappings": [
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
                ],
                "typeConversion": true,
                "typeConversionSettings": {
                    "allowDataTruncation": true,
                    "treatBooleanAsNumber": false
                }
            }
        },
        "TopLevelPipelineName": "Ingestion_L1",
        "TriggerName": [
            "Sandbox",
            "Manual"
        ],
        "DataLoadingBehaviorSettings": {
            "dataLoadingBehavior": "FullLoad",
            "watermarkColumnName": null,
            "watermarkColumnType": null,
            "watermarkColumnStartValue": null
        },
        "GroupId": 0,
        "CopyEnabled": 1
    },
    {
        "SourceName": "SalesLT.CustomerAddress",
        "SinkName": "SalesLT.CustomerAddress",
        "CopySourceSettings": {
            "isolationLevel": null,
            "partitionOption": "None",
            "sqlReaderQuery": null,
            "partitionLowerBound": null,
            "partitionUpperBound": null,
            "partitionColumnName": null,
            "partitionNames": null
        },
        "CopySinkSettings": {
            "preCopyScript": null,
            "tableOption": "autoCreate",
            "writeBehavior": "upsert",
            "sqlWriterUseTableLock": false,
            "writeBatchSize": 1024,
            "maxConcurrentConnections": 8,
            "disableMetricsCollection": false,
            "upsertSettings": {
                "useTempDB": true,
                "keys": [
                    "CustomerID",
                    "AddressID"
                ]
            }
        },
        "CopyActivitySettings": {
            "translator": {
                "type": "TabularTranslator",
                "mappings": [
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
                ],
                "typeConversion": true,
                "typeConversionSettings": {
                    "allowDataTruncation": true,
                    "treatBooleanAsNumber": false
                }
            }
        },
        "TopLevelPipelineName": "Ingestion_L1",
        "TriggerName": [
            "Sandbox",
            "Manual"
        ],
        "DataLoadingBehaviorSettings": {
            "dataLoadingBehavior": "DeltaLoad",
            "watermarkColumnName": "ModifiedDate",
            "watermarkColumnType": "DateTime",
            "watermarkColumnStartValue": "2006-06-01T00:00:00.000Z"
        },
        "GroupId": 0,
        "CopyEnabled": 1
    }
]';


INSERT INTO [Control].[Task] (
    -- [SourceObjectSettings],    
    [SourceObjectId],
    [SourceConnectionSettingsName],
    [CopySourceSettings],
    -- [SinkObjectSettings],
    [SinkObjectId],
    [SinkConnectionSettingsName],
    [CopySinkSettings],
    [CopyActivitySettings],
    [TopLevelPipelineName],
    [TriggerName],
    [DataLoadingBehaviorSettings],
    -- [TaskId],
    [GroupId],
    [CopyEnabled])
SELECT
    -- TaskData.[SourceObjectSettings],    
    SrcO.Id,
    TaskData.[SourceConnectionSettingsName],
    TaskData.[CopySourceSettings],
    -- TaskData.[SinkObjectSettings],
     SnkO.Id,
    TaskData.[SinkConnectionSettingsName],
    TaskData.[CopySinkSettings],
    TaskData.[CopyActivitySettings],
    TaskData.[TopLevelPipelineName],
    TaskData.[TriggerName],
    TaskData.[DataLoadingBehaviorSettings],
    -- TaskData.[TaskId],
    TaskData.[GroupId],
    TaskData.[CopyEnabled]

FROM OPENJSON(@TaskMetadata)
WITH (
    -- [SourceObjectSettings] [nvarchar](max) AS JSON,
    [SourceName][nvarchar](64),
    [SourceConnectionSettingsName] [varchar](max),
    [CopySourceSettings] [nvarchar](max) AS JSON,
    -- [SinkObjectSettings] [nvarchar](max) AS JSON,
    [SinkName][nvarchar](64),    
    [SinkConnectionSettingsName] [varchar](max),
    [CopySinkSettings] [nvarchar](max) AS JSON,
    [CopyActivitySettings] [nvarchar](max) AS JSON,
    [TopLevelPipelineName] [varchar](max),
    [TriggerName] [nvarchar](max) AS JSON,
    [DataLoadingBehaviorSettings] [nvarchar](max) AS JSON,
    -- [TaskId] [int],
    [GroupId] [int],
    [CopyEnabled] [bit]
) AS TaskData
LEFT JOIN [Control].[SourceObject] AS SrcO ON SrcO.[Name] = TaskData.[SourceName]
LEFT JOIN [Control].[SinkObject] AS SnkO ON SnkO.[Name] = TaskData.[SinkName]

GO
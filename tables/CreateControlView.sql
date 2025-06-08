
DROP VIEW [Control].[Task_VW]
GO
CREATE VIEW [Control].[Task_VW] AS
SELECT 
T.*,
SrcO.SchemaName AS SourceSchemaName,
SrcO.ObjectName AS SourceObjectName,
SnkO.SchemaName AS SinkSchemaName,
SnkO.ObjectName AS SinkObjectName
FROM [Control].[Task] T
LEFT JOIN [Control].[SourceObject] SrcO ON T.SourceObjectId = SrcO.Id
LEFT JOIN [Control].[SinkObject] SnkO ON T.SinkObjectId = SnkO.Id
GO
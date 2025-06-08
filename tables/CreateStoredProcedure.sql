SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


DROP PROCEDURE IF EXISTS [Control].[UpdateWatermarkColumnValue]
GO
/****** Object: StoredProcedure [Control].[UpdateWatermarkColumnValue] ******/
CREATE PROCEDURE [Control].[UpdateWatermarkColumnValue]
    @watermarkColumnStartValue nvarchar(max),
    @Id [int]
AS
    UPDATE [Control].[Task]
    SET [DataLoadingBehaviorSettings]=JSON_MODIFY([DataLoadingBehaviorSettings],'$.watermarkColumnStartValue', @watermarkColumnStartValue) WHERE Id = @Id
GO


DROP PROCEDURE IF EXISTS [Control].[InsertTaskStatus]
GO
/****** Object: StoredProcedure [Control].[InsertTaskStatus] ******/
CREATE PROCEDURE [Control].[InsertTaskStatus]
    @TaskId [int],
    @Status [int],
    @ErrorMessage nvarchar(max)
AS
    INSERT INTO [Control].[TaskStatus] VALUES (@TaskId, @Status, @ErrorMessage, (GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Singapore Standard Time'))
GO


DROP PROCEDURE IF EXISTS [Control].[GetColumnMapping]
GO
CREATE PROCEDURE [Control].[GetColumnMapping]
  @MappingId [int] 
AS
BEGIN
    DECLARE @JSON_CONSTRUCT varchar(MAX) = '{ "type": "TabularTranslator", "mappings": {X} }';
    DECLARE @JSON_MAPPING VARCHAR(MAX);

    SET @JSON_MAPPING = (
        Select 
        CM.SourceColumn as 'source.name',
        CM.SourceType as 'source.type',
        CM.SourcePhysicalType as 'source.physicalType',
        CM.TargetColumn as 'sink.name',
        CM.TargetType as 'sink.type',
        CM.TargetPhysicalType as 'sink.physicalType'
        from Control.ColumnMapping AS CM
        WHERE CM.MappingId = @MappingId
        FOR JSON PATH
    );

    SELECT REPLACE(@JSON_CONSTRUCT, '{X}', @JSON_MAPPING) AS JSON_OUTPUT;
END
GO
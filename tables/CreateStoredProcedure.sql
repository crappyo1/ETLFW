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



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[TaskStatus]') AND type in (N'U'))
DELETE FROM [Control].[TaskStatus]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[SalesLT].[CustomerAddress]') AND type in (N'U'))
DROP TABLE [SalesLT].[CustomerAddress]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[SalesLT].[Customer]') AND type in (N'U'))
DROP TABLE [SalesLT].[Customer]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[SalesLT].[Address]') AND type in (N'U'))
DROP TABLE [SalesLT].[Address]
GO

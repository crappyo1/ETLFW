SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Control].[TaskStatus]') AND type in (N'U'))
DROP TABLE [Control].[TaskStatus]
GO
CREATE TABLE [Control].[TaskStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[ErrorMessage] [nvarchar](max) NOT NULL,
	[CreatedOn] [datetime2](7) NOT NULL CONSTRAINT [DF_TaskStatus_CreatedOn] DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Control].[TaskStatus] ADD  CONSTRAINT [PK_TaskStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [Control].[TaskStatus] ADD  CONSTRAINT [DEFAULT_TaskStatus_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [Control].[TaskStatus] ADD  CONSTRAINT [DEFAULT_TaskStatus_ErrorMessage]  DEFAULT ('') FOR [ErrorMessage]
GO
-- ALTER TABLE [Control].[TaskStatus]  WITH CHECK ADD  CONSTRAINT [FK_TaskStatus_Task] FOREIGN KEY([TaskId])
-- REFERENCES [Control].[Task] ([Id])
-- GO
-- ALTER TABLE [Control].[TaskStatus] CHECK CONSTRAINT [FK_TaskStatus_Task]
-- GO

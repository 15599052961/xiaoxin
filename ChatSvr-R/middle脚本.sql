USE [ConfigDb]
GO
/****** Object:  User [millionserver]    Script Date: 08/12/2015 09:34:33 ******/
CREATE USER [millionserver] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[DbConfigTable]    Script Date: 08/12/2015 09:34:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DbConfigTable](
	[DbConfigID] [int] IDENTITY(1,1) NOT NULL,
	[dbip] [varchar](15) NOT NULL,
	[dbport] [int] NOT NULL,
	[dbName] [varchar](500) NOT NULL,
	[dbAccountName] [varchar](50) NOT NULL,
	[dbAccountPwd] [varchar](20) NOT NULL,
	[perfectUserCount] [int] NOT NULL,
	[createTime] [datetime] NOT NULL,
	[description] [nvarchar](500) NULL,
 CONSTRAINT [PK_DbConfig] PRIMARY KEY CLUSTERED 
(
	[DbConfigID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库ip' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DbConfigTable', @level2type=N'COLUMN',@level2name=N'dbip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库端口号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DbConfigTable', @level2type=N'COLUMN',@level2name=N'dbport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库名称,如果有多个数据库，则每个数据库名称用[英文逗号分开，以逗号结尾，如[a,b,c,d,]]，每个数据库的用户名和密码请保持一致并且所有的数据库在同一ip所在的电脑上' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DbConfigTable', @level2type=N'COLUMN',@level2name=N'dbName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库账户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DbConfigTable', @level2type=N'COLUMN',@level2name=N'dbAccountName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库账户密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DbConfigTable', @level2type=N'COLUMN',@level2name=N'dbAccountPwd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'该数据库的理想用户数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DbConfigTable', @level2type=N'COLUMN',@level2name=N'perfectUserCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'此条信息的创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DbConfigTable', @level2type=N'COLUMN',@level2name=N'createTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DbConfigTable', @level2type=N'COLUMN',@level2name=N'description'
GO

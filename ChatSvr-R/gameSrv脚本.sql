USE [xiaoxin]
GO
/****** Object:  Table [dbo].[TB_SERVER]    Script Date: 08/12/2015 09:37:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SERVER](
	[IDX] [int] IDENTITY(1,1) NOT NULL,
	[REGISTER_DATE] [datetime] NOT NULL,
	[NAME] [nvarchar](50) NOT NULL,
	[DESCRIPTION] [nvarchar](200) NULL,
	[STATUS] [tinyint] NOT NULL,
	[APPLY] [tinyint] NOT NULL,
	[IPADDRESS] [varchar](15) NOT NULL,
	[Number] [varchar](10) NULL,
	[SERVICER] [smallint] NOT NULL,
 CONSTRAINT [PK_TB_SERVER] PRIMARY KEY CLUSTERED 
(
	[IDX] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고유번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SERVER', @level2type=N'COLUMN',@level2name=N'IDX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SERVER', @level2type=N'COLUMN',@level2name=N'REGISTER_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버이름' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SERVER', @level2type=N'COLUMN',@level2name=N'NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'설명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SERVER', @level2type=N'COLUMN',@level2name=N'DESCRIPTION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상태 (0준비/1원활/2보통/3혼잡)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SERVER', @level2type=N'COLUMN',@level2name=N'STATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'적용여부 (0 사용중, 1 사용중지)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SERVER', @level2type=N'COLUMN',@level2name=N'APPLY'
GO
/****** Object:  Table [dbo].[TB_MATRIX]    Script Date: 08/12/2015 09:37:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_MATRIX](
	[IDX] [int] IDENTITY(1,1) NOT NULL,
	[SERVER_NUM] [int] NOT NULL,
	[CHANNEL_NUM] [int] NOT NULL,
 CONSTRAINT [PK_TB_MATRIX] PRIMARY KEY CLUSTERED 
(
	[IDX] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_LOGIN]    Script Date: 08/12/2015 09:37:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_LOGIN](
	[IDX] [int] IDENTITY(1,1) NOT NULL,
	[LAST_DATE] [datetime] NOT NULL,
	[SERVER_NUM] [int] NOT NULL,
	[CHANNEL_NUM] [int] NOT NULL,
	[CHARACTER_IDX] [int] NOT NULL,
	[INETNUM] [varchar](20) NOT NULL,
 CONSTRAINT [PK_TB_LOGIN_1] PRIMARY KEY CLUSTERED 
(
	[IDX] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TB_CHANNEL]    Script Date: 08/12/2015 09:37:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_CHANNEL](
	[IDX] [int] IDENTITY(1,1) NOT NULL,
	[REGISTER_DATE] [datetime] NOT NULL,
	[SERVER_NUM] [int] NOT NULL,
	[CHANNEL_NUM] [int] NOT NULL,
	[INETNUM] [varchar](20) NOT NULL,
	[IPV4] [bigint] NULL,
	[PORT] [smallint] NOT NULL,
	[STATUS] [tinyint] NOT NULL,
 CONSTRAINT [PK_TB_CHANNEL] PRIMARY KEY CLUSTERED 
(
	[IDX] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'고유번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CHANNEL', @level2type=N'COLUMN',@level2name=N'IDX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CHANNEL', @level2type=N'COLUMN',@level2name=N'REGISTER_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'서버번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CHANNEL', @level2type=N'COLUMN',@level2name=N'SERVER_NUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'채널번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CHANNEL', @level2type=N'COLUMN',@level2name=N'CHANNEL_NUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IP주소(IPv4)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CHANNEL', @level2type=N'COLUMN',@level2name=N'INETNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IP주소(IPv4)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CHANNEL', @level2type=N'COLUMN',@level2name=N'IPV4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'상태 (0준비/1원활/2보통/3혼잡)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CHANNEL', @level2type=N'COLUMN',@level2name=N'STATUS'
GO
/****** Object:  Table [dbo].[mc_version]    Script Date: 08/12/2015 09:37:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_version](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[verCode] [int] NOT NULL,
	[apkurl] [varchar](50) NULL,
	[updateDate] [datetime] NOT NULL,
	[verContent] [varchar](1000) NULL,
	[remark] [varchar](500) NULL,
 CONSTRAINT [PK_MC_VERSION] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_version', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'版本号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_version', @level2type=N'COLUMN',@level2name=N'verCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'路径名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_version', @level2type=N'COLUMN',@level2name=N'apkurl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_version', @level2type=N'COLUMN',@level2name=N'updateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_version', @level2type=N'COLUMN',@level2name=N'verContent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_version', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'版本信息表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_version'
GO
/****** Object:  Table [dbo].[mc_user]    Script Date: 08/12/2015 09:37:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_user](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[loginID] [varchar](11) NOT NULL,
	[password] [varchar](20) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[sex] [int] NULL,
	[roleType] [int] NOT NULL,
	[roleName] [varchar](30) NOT NULL,
	[classid] [int] NULL,
	[status] [int] NOT NULL,
	[email] [varchar](30) NULL,
	[url] [varchar](100) NULL,
	[addUID] [int] NULL,
	[addDate] [datetime] NULL,
	[updateUID] [int] NULL,
	[updateDate] [datetime] NULL,
	[remark] [varchar](500) NULL,
 CONSTRAINT [PK_MC_USER] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户id/校信号(主键)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'userID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机登录账号(unique)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'loginID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'性别(1男，2女)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'sex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色类型(1老师，2家长，3学生)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'roleType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色称谓(如:爸爸/妈妈/爷爷)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'roleName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级id(只有角色为学生时有效)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'classid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态(1not regilster，0禁用,2正常以及注册)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'头像路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'addUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'updateUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'updateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户信息表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_user'
GO
/****** Object:  StoredProcedure [dbo].[GP_SHUTDOWN]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************
 *<
	FILE: GP_SHUTDOWN.SQL

	DESCRIPTION:

	CREATED BY:

	HISTORY:

 *>	Copyright (c) 2007, All Rights Reserved.
 **********************************************************************/

CREATE PROCEDURE [dbo].[GP_SHUTDOWN]
	(@CHANNEL_NUM				[int]	
	,@REMOVE_COOLTIME_COUNT		[int]OUTPUT	
	,@REMOVE_STALL_SELL_COUNT	[int]OUTPUT)	

AS

SET NOCOUNT ON
GO
/****** Object:  StoredProcedure [dbo].[GP_ModifyChildName]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		oiooooio
-- Create date: 2014-3-22 11:18:24
-- Description:	根据用户@userIdx以及用户类型@userType修改孩子@childIdx名称为@userNewName
-- =============================================
CREATE PROCEDURE [dbo].[GP_ModifyChildName]
	-- Add the parameters for the stored procedure here
	(@userIdx		int
	,@userType		int
	,@childIdx		int
	,@userNewName	varchar(100)
	,@ret			int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	set @ret = 0;

END
GO
/****** Object:  StoredProcedure [dbo].[GP_VersionInfo]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		oiooooio
-- Create date: 2014-3-23 11:45:49
-- Description:	根据当前版本@currentVersion获取新版本@newVersion的内容@updateContent，以及@url，更新时间@updateTime
				/*
				不管有没有新版本，则必须给@newVersion一个值，用于在程序中判断有没有新版本要发给客户端
				@ret：
					0：成功
					1：失败
				*/
-- =============================================
CREATE PROCEDURE [dbo].[GP_VersionInfo]
	-- Add the parameters for the stored procedure here
	(@currentVersion		int
	,@newVersion			int output
	,@ret					int output
	,@url					varchar(50) output
	,@updateTime			varchar(31) output
	,@updateContent			varchar(1000) output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select @newVersion = 2, @ret = 0, @url='http://baidu.com', @updateTime='2014-12-41 12:12:00', @updateContent='null'
END
GO
/****** Object:  Table [dbo].[mc_area]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mc_area](
	[areaID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[parentID] [int] NULL,
	[ipaddress] [nvarchar](50) NULL,
	[status] [int] NULL,
	[fareaid] [int] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK_MC_AREA] PRIMARY KEY CLUSTERED 
(
	[areaID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [AK_KEY_2_MC_AREA] UNIQUE NONCLUSTERED 
(
	[areaID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'区域号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_area', @level2type=N'COLUMN',@level2name=N'areaID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'区域名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_area', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父区域号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_area', @level2type=N'COLUMN',@level2name=N'parentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'区域IP地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_area', @level2type=N'COLUMN',@level2name=N'ipaddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态(1正常，0禁用)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_area', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父区域号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_area', @level2type=N'COLUMN',@level2name=N'fareaid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_area', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分区域管理：省-市-县' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_area'
GO
/****** Object:  Table [dbo].[mc_role_power]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_role_power](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[roleName] [varchar](50) NULL,
	[roleId] [varchar](50) NULL,
	[powerName] [varchar](50) NULL,
	[powerId] [varchar](50) NULL,
	[funAction] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[temp] [varchar](100) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mc_role]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_role](
	[roleId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[roleName] [varchar](50) NULL,
	[powerid] [numeric](18, 0) NULL,
	[state] [numeric](18, 0) NULL,
	[action] [varchar](50) NULL,
	[temp] [varchar](50) NULL,
	[temp1] [numeric](18, 0) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mc_power1]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_power1](
	[powerId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[powerName] [varchar](50) NULL,
	[parentID] [numeric](18, 0) NULL,
	[temp] [varchar](50) NULL,
	[temp1] [numeric](18, 0) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mc_power]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_power](
	[powerId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[powerName] [varchar](50) NULL,
	[parentID] [varchar](50) NULL,
	[temp] [varchar](50) NULL,
	[temp1] [int] NULL,
	[temp2] [varchar](100) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mc_suggestion]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_suggestion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[suggestion] [varchar](1000) NULL,
	[addUid] [int] NULL,
	[addDate] [datetime] NULL,
	[remark] [varchar](500) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_suggestion', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'反馈意见' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_suggestion', @level2type=N'COLUMN',@level2name=N'suggestion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'反馈人id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_suggestion', @level2type=N'COLUMN',@level2name=N'addUid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'反馈时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_suggestion', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_suggestion', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'意见反馈表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_suggestion'
GO
/****** Object:  Table [dbo].[mc_subject]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_subject](
	[subID] [int] IDENTITY(1,1) NOT NULL,
	[subName] [varchar](50) NOT NULL,
	[subType] [int] NOT NULL,
	[status] [int] NOT NULL,
	[addUID] [int] NULL,
	[addDate] [datetime] NULL,
	[updateUID] [int] NULL,
	[updateDate] [datetime] NULL,
	[remark] [varchar](500) NULL,
 CONSTRAINT [PK_MC_SUBJECT] PRIMARY KEY CLUSTERED 
(
	[subID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'科目id(主键)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_subject', @level2type=N'COLUMN',@level2name=N'subID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'科目名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_subject', @level2type=N'COLUMN',@level2name=N'subName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'科目类型(主科目1，副科目)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_subject', @level2type=N'COLUMN',@level2name=N'subType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态(1正常，0禁用)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_subject', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_subject', @level2type=N'COLUMN',@level2name=N'addUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_subject', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_subject', @level2type=N'COLUMN',@level2name=N'updateUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_subject', @level2type=N'COLUMN',@level2name=N'updateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_subject', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'科目信息表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_subject'
GO
/****** Object:  Table [dbo].[mc_offlineMes]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_offlineMes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[mesType] [int] NOT NULL,
	[msID] [int] NULL,
	[acceptUid] [int] NULL,
	[sendUid] [int] NULL,
	[contentType] [int] NULL,
	[offContent] [nvarchar](max) NULL,
	[conLength] [int] NULL,
	[sendDate] [datetime] NOT NULL,
	[url] [varchar](100) NULL,
	[remark] [varchar](500) NULL,
 CONSTRAINT [PK_MC_OFFLINEMES] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_offlineMes', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息类型（1作业/通知，2聊天记录，3好友添加）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_offlineMes', @level2type=N'COLUMN',@level2name=N'mesType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息id（关联消息表id）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_offlineMes', @level2type=N'COLUMN',@level2name=N'msID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'接收人id（关联人员表）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_offlineMes', @level2type=N'COLUMN',@level2name=N'acceptUid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发送人id（关联人员表）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_offlineMes', @level2type=N'COLUMN',@level2name=N'sendUid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'content tpye(text/image/voice)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_offlineMes', @level2type=N'COLUMN',@level2name=N'contentType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'离线内容(文字/表情信息)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_offlineMes', @level2type=N'COLUMN',@level2name=N'offContent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容长度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_offlineMes', @level2type=N'COLUMN',@level2name=N'conLength'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发送时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_offlineMes', @level2type=N'COLUMN',@level2name=N'sendDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'离线附件路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_offlineMes', @level2type=N'COLUMN',@level2name=N'url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_offlineMes', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'离线消息表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_offlineMes'
GO
/****** Object:  Table [dbo].[mc_news]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_news](
	[newsId] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](200) NOT NULL,
	[areaID] [int] NULL,
	[lasteditdate] [date] NULL,
	[newsContent] [nvarchar](max) NULL,
	[create_date] [date] NOT NULL,
	[title_pic_url] [varchar](100) NULL,
	[author] [varchar](20) NULL,
	[f_newsid] [int] NOT NULL,
	[flag] [int] NULL,
	[release] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_news', @level2type=N'COLUMN',@level2name=N'newsId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_news', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地区ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_news', @level2type=N'COLUMN',@level2name=N'areaID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章最后编辑时期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_news', @level2type=N'COLUMN',@level2name=N'lasteditdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_news', @level2type=N'COLUMN',@level2name=N'newsContent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_news', @level2type=N'COLUMN',@level2name=N'create_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻封面' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_news', @level2type=N'COLUMN',@level2name=N'title_pic_url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'作者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_news', @level2type=N'COLUMN',@level2name=N'author'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父一级新闻的id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_news', @level2type=N'COLUMN',@level2name=N'f_newsid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标示（1正常，0删除）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_news', @level2type=N'COLUMN',@level2name=N'flag'
GO
/****** Object:  Table [dbo].[mc_message]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_message](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[msType] [int] NOT NULL,
	[userID] [int] NOT NULL,
	[classIDs] [varchar](60) NOT NULL,
	[contentType] [int] NULL,
	[content] [nvarchar](max) NOT NULL,
	[conLength] [int] NULL,
	[status] [int] NOT NULL,
	[addUID] [int] NOT NULL,
	[addDate] [datetime] NOT NULL,
	[updateUID] [int] NULL,
	[updateDate] [datetime] NULL,
	[remark] [varchar](500) NULL,
 CONSTRAINT [PK_MC_MESSAGE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息id(主键)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息类型(1校信资讯，2作业，3通知)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'msType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理用户表或管理员表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'userID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发布对象，可多个对象(如：班级1，班级2)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'classIDs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容类型（文字：1，图片：2，语音：3）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'contentType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容长度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'conLength'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态(1暂存，2已发布，0禁用)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'addUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'updateUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'updateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_message'
GO
/****** Object:  Table [dbo].[mc_menu]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_menu](
	[menu_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[menu_name] [varchar](50) NULL,
	[menu_leve] [varchar](50) NULL,
	[menu_url] [varchar](50) NULL,
	[fmenu_id] [varchar](50) NULL,
	[use_flag] [varchar](50) NULL,
	[sort_flag] [nchar](10) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mc_groupShield]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_groupShield](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NULL,
	[classID] [int] NULL,
	[remark] [varchar](500) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_groupShield', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_groupShield', @level2type=N'COLUMN',@level2name=N'userID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'群号(班级id)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_groupShield', @level2type=N'COLUMN',@level2name=N'classID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_groupShield', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息屏蔽表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_groupShield'
GO
/****** Object:  Table [dbo].[mc_group_func]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_group_func](
	[GROUP_ID] [varchar](20) NOT NULL,
	[FUNC_ID] [varchar](20) NOT NULL,
	[GROUP_FUNC_REMARK] [varchar](255) NULL,
	[GROUP_FUNC_CREATE_BY] [varchar](20) NULL,
	[GROUP_FUNC_CREATE_datetime] [datetime] NULL,
	[GROUP_FUNC_UPdatetime_BY] [varchar](20) NULL,
	[GROUP_FUNC_UPdatetime_datetime] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mc_group]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_group](
	[gIndex] [int] NOT NULL,
	[groupid] [int] NULL,
	[gname] [varchar](50) NULL,
	[userid] [int] NULL,
 CONSTRAINT [PK_dbo.mc.group] PRIMARY KEY CLUSTERED 
(
	[gIndex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'序列号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_group', @level2type=N'COLUMN',@level2name=N'gIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'群ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_group', @level2type=N'COLUMN',@level2name=N'groupid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'群名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_group', @level2type=N'COLUMN',@level2name=N'gname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'群成员ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_group', @level2type=N'COLUMN',@level2name=N'userid'
GO
/****** Object:  Table [dbo].[mc_friend_rel]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_friend_rel](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[friendID] [int] NOT NULL,
	[remarkName] [varchar](100) NULL,
	[classID] [int] NULL,
	[addUID] [int] NULL,
	[addDate] [datetime] NULL,
	[remark] [varchar](500) NULL,
 CONSTRAINT [PK_MC_FRIEND_REL] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_friend_rel', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户id(关联用户表)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_friend_rel', @level2type=N'COLUMN',@level2name=N'userID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户id(关联用户表)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_friend_rel', @level2type=N'COLUMN',@level2name=N'friendID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'好友备注名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_friend_rel', @level2type=N'COLUMN',@level2name=N'remarkName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级id(关联班级表)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_friend_rel', @level2type=N'COLUMN',@level2name=N'classID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_friend_rel', @level2type=N'COLUMN',@level2name=N'addUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_friend_rel', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_friend_rel', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'朋友(通讯录)表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_friend_rel'
GO
/****** Object:  Table [dbo].[mc_CountOnlineUsers]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mc_CountOnlineUsers](
	[CountOnlineUsers] [int] NOT NULL,
	[UserIdx] [int] NOT NULL,
	[LastOnlineTime] [datetime] NULL,
	[OnlineCount] [int] NULL,
 CONSTRAINT [PK_CountOnlineUsers] PRIMARY KEY CLUSTERED 
(
	[CountOnlineUsers] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GP_INIT]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************
 *<
	FILE: GP_INIT.SQL

	DESCRIPTION:

	CREATED BY:

	HISTORY:

 *>	Copyright (c) 2008, All Rights Reserved.
 **********************************************************************/

CREATE PROCEDURE [dbo].[GP_INIT]
	(@CHANNEL_NUM				[int]		
	,@REMOVE_COOLTIME_COUNT		[int]OUTPUT	
	,@REMOVE_STALL_SELL_COUNT	[int]OUTPUT)	

AS

SET NOCOUNT ON
GO
/****** Object:  Table [dbo].[mc_student]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_student](
	[id] [int] NOT NULL,
	[userID] [int] NOT NULL,
	[entrance_year] [int] NULL,
	[telphone] [varchar](20) NULL,
	[device_serial] [varchar](255) NULL,
	[birthday] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mc_teacher]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_teacher](
	[id] [int] NOT NULL,
	[birthday] [date] NULL,
	[education] [varchar](50) NULL,
	[political] [varchar](50) NULL,
	[userID] [int] NULL,
	[address] [varchar](255) NULL,
	[telphone] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[mc_school]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_school](
	[schoolID] [int] IDENTITY(1,1) NOT NULL,
	[schoolCode] [varchar](20) NULL,
	[schoolName] [varchar](200) NULL,
	[speciality] [varchar](50) NULL,
	[schooladdress] [varchar](500) NULL,
	[schoolmaster] [varchar](200) NULL,
	[linktel] [varchar](200) NULL,
	[areaID] [int] NOT NULL,
	[createDate] [datetime] NULL,
	[status] [int] NULL,
	[addUID] [int] NULL,
	[addDate] [datetime] NULL,
	[updateUID] [int] NULL,
	[updateDate] [datetime] NULL,
	[remark] [varchar](500) NULL,
 CONSTRAINT [PK_MC_SCHOOL] PRIMARY KEY CLUSTERED 
(
	[schoolID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校id(主键)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'schoolID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校编号(省份+00000000)，扩展字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'schoolCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'schoolName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学制' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'speciality'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'schooladdress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'责任人/校长/法人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'schoolmaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'linktel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属区域，区域表外键关联' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'areaID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'建校时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'createDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态(1正常，0禁用)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'addUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'updateUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'updateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校信息表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_school'
GO
/****** Object:  StoredProcedure [dbo].[GP_GetOfflineMsg]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		oiooooio
-- Create date: 2014-3-26 08:52:53
-- Description:	根据用户ID和消息ID获取离线消息
-- =============================================
CREATE PROCEDURE [dbo].[GP_GetOfflineMsg] 
	-- Add the parameters for the stored procedure here
	(@userIdx		int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT 
       [conLength]
	  ,[mesType]
      ,isnull([msID] ,0)
      ,[url]
      ,[sendUid]
      ,[contentType]
      ,[offContent]
      ,[sendDate]
  FROM [xiaoxin].[dbo].[mc_offlineMes] where acceptUid=@userIdx order by id asc


END
GO
/****** Object:  StoredProcedure [dbo].[GP_GetNewsTrends]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	获取最近三十条资讯动态 	@ret: 0:获取成功 1:获取失败
-- =============================================
CREATE PROCEDURE [dbo].[GP_GetNewsTrends]
				(	
					@ret			int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	set @ret = 0
	select top 30 newsId, title, areaID, title_pic_url, create_date, f_newsid from mc_news order by newsId desc	

END
GO
/****** Object:  StoredProcedure [dbo].[GP_GetNewsOrThendsList]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		oiooooio
-- Create date: 2014-3-22 14:25:35
-- Description:	获取最近的30条资讯信息
--				最新的30条咨询ID,以及对应的类型
-- =============================================
CREATE PROCEDURE [dbo].[GP_GetNewsOrThendsList]
	-- Add the parameters for the stored procedure here
	(@userIdx		int
	,@type			int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	/*
	@type value:
		eXXN_NEWS   = 1,/// 资讯
		eXXN_TRENDS = 2,/// 作业
		eXXN_NOTICE = 3,/// 通知
		eXXN_T_N	= 4,/// 作业/通知
		eXXN_ALL	= 5,/// 作业/通知/资讯
		
	[msType]
		消息类型(1校信资讯，2作业，3通知)
	*/
	
	if @type = 5
		select top 30 id, msType from mc_message order by id desc
		
	else if @type = 1
		select top 30 id, msType from mc_message where msType=1 order by id desc
		
	else if @type = 2
		select top 30 id, msType from mc_message where msType=2 order by id desc

	else if @type = 3
		select top 30 id, msType from mc_message where msType=3 order by id desc
		
	else if @type = 4
		select top 30 id, msType from mc_message where msType=2 or msType=3 order by id desc

END
GO
/****** Object:  StoredProcedure [dbo].[GP_GETMAILADDR]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	忘记密码处理,传入参数:手机号,验证码,email和retvalue做返回用
-- =============================================
CREATE PROCEDURE [dbo].[GP_GETMAILADDR]
					(
						@phone		[varchar](11)
						,@vercode	[varchar](4) 
						,@email		[varchar](30)	OUTPUT 
						,@retvalue	[int]			OUTPUT 
					)

AS
declare @ishave int
declare @ishave1 int

BEGIN
	SET NOCOUNT ON;
	
	select @ishave = count(*) from mc_user where loginID = @phone
	IF @ishave = 0
		BEGIN
			set @retvalue = -1
		END
	ELSE 
		BEGIN
			update mc_user
			set remark = @vercode where loginID = @phone---保存验证码
			set @email = (select email from mc_user where loginID = @phone)--返回邮件地址
			set @retvalue = 0
		END
END
GO
/****** Object:  StoredProcedure [dbo].[GP_GetGroupMemberList]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	根据用户@userIdx和群@groupIdx获取群的成员列表， 基本信息包括：成员id，成员类型，成员名称，成员头像
-- =============================================
CREATE PROCEDURE [dbo].[GP_GetGroupMemberList]
	-- Add the parameters for the stored procedure here
	(@userIdx		int
	,@groupIdx		int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @tmpGroup	int
	
	select userID, roleType, name, url from mc_user --where @userIdx=userID and @groupIdx = ?
	--select * from mc_user where userID=@userIdx and 1
	
END
GO
/****** Object:  StoredProcedure [dbo].[GP_GetGroupMemberID]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GP_GetGroupMemberID]
	-- Add the parameters for the stored procedure here
	(@groupIdx		int
	,@ret			int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	set	@ret = 0
	
	
	select userid from mc_group where groupid=@groupIdx

    
END
GO
/****** Object:  StoredProcedure [dbo].[GP_GetGroupListnew]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GP_GetGroupListnew]
	-- Add the parameters for the stored procedure here
	(@userIdx		int
	,@userType		int
	,@ret			int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	set	@ret = 0
	
	
	select distinct groupid,gname from mc_group where userid=@userIdx

  --  if @userType = 1	--老师
  --  begin
		--select c.classID, c.className from mc_teacher_class_rel as tc, mc_class as c where tc.teacherID=@userIdx and tc.classID=c.classID
  --  end
  --  else if @userType = 2	--家长
  --  begin
		--select c.classID, c.className from mc_parent_student_rel as ps, mc_class as c, mc_user as u 
		--where ps.parentID=@userIdx and ps.studentID=u.userID and u.classid=c.classID order by c.classID desc
  --  end
  --  else
  --  begin
		----避免程序获取数据错误
		--select null, null
		--set	@ret = 1
  --  end
    
END
GO
/****** Object:  StoredProcedure [dbo].[GP_MATRIX_SELECT]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************
 *<
	FILE: GP_MATRIX_SELECT.SQL

	DESCRIPTION:

	CREATED BY: 곽철중

	HISTORY:

 *>	Copyright (c) 2008, All Rights Reserved.
 **********************************************************************/

CREATE PROCEDURE [dbo].[GP_MATRIX_SELECT]
	(@MAX_SERVER	[int]OUTPUT,	--최대 서버번호
	 @MAX_CHANNEL	[int]OUTPUT)	--최대 채널번호

AS

SET NOCOUNT ON -- 영향받은 행의 갯수를 반환하지 않는다.

SELECT @MAX_SERVER=MAX([SERVER_NUM])
      ,@MAX_CHANNEL=MAX([CHANNEL_NUM])
  FROM [dbo].[TB_MATRIX]
GO
/****** Object:  StoredProcedure [dbo].[GP_MATRIX_CREATE]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************
 *<
	FILE: GP_MATRIX_CREATE.SQL

	DESCRIPTION: 매트릭스 테이블 생성

	CREATED BY: 곽철중

	HISTORY: Created	02/08/07	SQLServer2000
			 Modified	02/26/07	SQLServer2005

 *>	Copyright (c) 2007, All Rights Reserved.
 **********************************************************************/

CREATE PROCEDURE [dbo].[GP_MATRIX_CREATE]
	(@MAX_SERVER	[int]			--최대 서버번호
	,@MAX_CHANNEL	[int]			--최대 채널번호
	,@RETVALUE		[int]OUTPUT)	--반환값

AS

SET NOCOUNT ON -- 영향받은 행의 갯수를 반환하지 않는다.

DECLARE @ERRORCODE	[int]
DECLARE @ROWCOUNT	[int]

DECLARE @SERVER		[int]
DECLARE @CHANNEL	[int]

SET @SERVER  = 1
SET @CHANNEL = 1

--TRUNCATE TABLE [dbo].[TB_MATRIX]

WHILE (@SERVER <= @MAX_SERVER)
	BEGIN
		WHILE (@CHANNEL <= @MAX_CHANNEL)
			BEGIN
				IF NOT EXISTS (SELECT * FROM [dbo].[TB_MATRIX] WHERE [SERVER_NUM]=@SERVER AND [CHANNEL_NUM]=@CHANNEL)
					BEGIN
						INSERT [dbo].[TB_MATRIX]
							  ([SERVER_NUM]
							  ,[CHANNEL_NUM])
						VALUES(@SERVER
							  ,@CHANNEL)

						SELECT @ERRORCODE = @@ERROR, @ROWCOUNT = @@ROWCOUNT

						IF @ERRORCODE <> 0 OR @ROWCOUNT <> 1
							BEGIN
								SET @RETVALUE = -1	--Unknown Error
								RETURN @ERRORCODE
							END
					END
 
				SET @CHANNEL = @CHANNEL + 1
			END
		SET @CHANNEL = 1
		SET @SERVER  = @SERVER + 1
	END

SET @RETVALUE = 0	-- 생성성공.
GO
/****** Object:  StoredProcedure [dbo].[GP_Login]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		oiooooio
-- Create date: 2014-3-15 14:42:04
-- Description:	login
-- =============================================
CREATE PROCEDURE [dbo].[GP_Login]
	-- Add the parameters for the stored procedure here
	(	@userid		varchar(11)			--用户手机号码
	,	@password	varchar(25)	
	,	@ip			varchar(15)			--用户ip
	,	@svrIP		varchar(15) output	--服务器ip
	,	@userType	int	output			--用户类型：家长/老师/学生
	,	@userIdx	int output			--用户id
	,	@loginIdx	int output			--用户登陆idx，也就是LOGIN表的主键id
	,	@ret		int output			--结果
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/*
	说明：
	@userIdx：
		用户主键id
	
	@ret：
		返回值
		用户不存在：2
		密码错误：	1
		成功：		0
	*/
	
	set @ret = 1
	
	--用户手机号密码验证
	if not exists (select * from mc_user where loginID=@userid and @password=password and status=2)
	begin
		set @ret = 1
		return
	end
	
	--获取用户id/类型
	select	@userIdx=userID, @userType=roleType from mc_user where loginID=@userid and @password=password and status=2
	
	--如果在login表里已存在此用户登陆信息，则删除
	if exists (select * from TB_LOGIN where @userIdx=CHARACTER_IDX)
	begin
		delete TB_LOGIN where @userIdx=CHARACTER_IDX 
	end
	
	--插入用户信息
	INSERT INTO [xiaoxin].[dbo].[TB_LOGIN]
           ([LAST_DATE]
           ,[SERVER_NUM]
           ,[CHANNEL_NUM]
           ,[CHARACTER_IDX]
           ,[INETNUM])
     VALUES
           (GETDATE()
           ,14601
           ,1
           ,@userIdx
           ,@ip)
	
	--获取用户的LOGIN表里的主键id返回给服务器使用
	select @loginIdx=IDX from TB_LOGIN where @userIdx=CHARACTER_IDX
	select @svrIP=IPADDRESS from TB_SERVER

	set @ret = 0
	
END
GO
/****** Object:  StoredProcedure [dbo].[GP_InsertOffLineMessagenew]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	把离线消息插入到表,每个人的离线消息最大支持500条
				/*
				@ret:
					0:插入成功
					1:插入失败
					2:该用户离线消息已达到最大条数
					3:目标不是发送方好友
					4:发送方不是目标好友
				*/
-- =============================================
CREATE PROCEDURE [dbo].[GP_InsertOffLineMessagenew]
	-- Add the parameters for the stored procedure here
	(@senderIdx			int		--发送人id
	,@receiverIdx		int		--接收人id
	,@messageType		int		--消息类型（1作业/通知，2聊天记录，3好友添加）
	,@messageid			int		--用作群ID
	,@contentType		int		--content tpye(1:text/2:image/3:voice)
	,@contentLen		int		--内容（@content）长度
	,@content			nvarchar(max)	--离线内容(文字/表情信息)
	,@headUrl			varchar(100) --发送方的头像url
	,@ret				int output)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	set @ret = 1;
	
	/*
	检查相互是不是好友
		3:目标不是发送方好友
		4:发送方不是目标好友
	*/
	--if @messageType != 3
	--begin
	--	if exists (select * from mc_friend_rel where userID = @senderIdx and friendID = @receiverIdx)
	--	begin
	--		if not exists (select * from mc_friend_rel where userID = @receiverIdx and friendID = @senderIdx)
	--		begin
	--			set @ret = 04
	--			return
	--		end
	--	end
	--	else
	--	begin
	--		set @ret = 03
	--		return
	--	end
	--end
	
	declare @tmpMaxCount	int
	select @tmpMaxCount=COUNT(*) from mc_offlineMes where acceptUid=@receiverIdx
	
	if @tmpMaxCount >= 500
	begin
		set @ret = 2
		return
	end
	else
	begin
		INSERT INTO [xiaoxin].[dbo].[mc_offlineMes]
			   ([mesType]
			   ,[msID]
			   ,[acceptUid]
			   ,[sendUid]
			   ,[contentType]
			   ,[offContent]
			   ,[conLength]
			   ,[url]
			   ,[sendDate])
		 VALUES
			   (@messageType
			   ,@messageid
			   ,@receiverIdx
			   ,@senderIdx
			   ,@contentType
			   ,@content
			   ,@contentLen
			   ,@headUrl
			   ,GETDATE())

		set @ret = 0;
	end

END
GO
/****** Object:  StoredProcedure [dbo].[GP_InsertOffLineMessage]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	把离线消息插入到表,每个人的离线消息最大支持500条
				/*
				@ret:
					0:插入成功
					1:插入失败
					2:该用户离线消息已达到最大条数
					3:目标不是发送方好友
					4:发送方不是目标好友
				*/
-- =============================================
CREATE PROCEDURE [dbo].[GP_InsertOffLineMessage]
	-- Add the parameters for the stored procedure here
	(@senderIdx			int		--发送人id
	,@receiverIdx		int		--接收人id
	,@messageType		int		--消息类型（1作业/通知，2聊天记录，3好友添加）
	,@contentType		int		--content tpye(1:text/2:image/3:voice)
	,@contentLen		int		--内容（@content）长度
	,@content			nvarchar(max)	--离线内容(文字/表情信息)
	,@headUrl			varchar(100) --发送方的头像url
	,@ret				int output)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	set @ret = 1;
	
	/*
	检查相互是不是好友
		3:目标不是发送方好友
		4:发送方不是目标好友
	*/
	--if @messageType != 3
	--begin
	--	if exists (select * from mc_friend_rel where userID = @senderIdx and friendID = @receiverIdx)
	--	begin
	--		if not exists (select * from mc_friend_rel where userID = @receiverIdx and friendID = @senderIdx)
	--		begin
	--			set @ret = 04
	--			return
	--		end
	--	end
	--	else
	--	begin
	--		set @ret = 03
	--		return
	--	end
	--end
	
	declare @tmpMaxCount	int
	select @tmpMaxCount=COUNT(*) from mc_offlineMes where acceptUid=@receiverIdx
	
	if @tmpMaxCount >= 500
	begin
		set @ret = 2
		return
	end
	else
	begin
		INSERT INTO [xiaoxin].[dbo].[mc_offlineMes]
			   ([mesType]
			   ,[acceptUid]
			   ,[sendUid]
			   ,[contentType]
			   ,[offContent]
			   ,[conLength]
			   ,[url]
			   ,[sendDate])
		 VALUES
			   (@messageType
			   ,@receiverIdx
			   ,@senderIdx
			   ,@contentType
			   ,@content
			   ,@contentLen
			   ,@headUrl
			   ,GETDATE())

		set @ret = 0;
	end

END
GO
/****** Object:  StoredProcedure [dbo].[GP_GETAreaInfo]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[GP_GETAreaInfo]
	-- Add the parameters for the stored procedure here
WITH EXECUTE AS CALLER
AS	

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 查询省市信息
	select a1.areaID proID,a1.name proName,a2.areaID cityID ,a2.name cityName 
	from mc_area a1 right join mc_area a2
	on a1.areaID = a2.fareaid
	where a1.fareaid=1 
	order by a1.name asc;

END
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[GP_DelOffLineMsg]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GP_DelOffLineMsg]
	-- Add the parameters for the stored procedure here
	(@userIdx int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DELETE FROM [xiaoxin].[dbo].[mc_offlineMes]
      WHERE acceptUid=@userIdx

END
GO
/****** Object:  StoredProcedure [dbo].[GP_DeleteGroup]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GP_DeleteGroup]
	-- Add the parameters for the stored procedure here
	(@groupid		int
	,@ret		int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/*
	删除一个群
	*/
	set @ret = 1;
	
	delete mc_group where groupid=@groupid
	
	if @@ERROR=0
		begin
			set @ret = 0;
		end

END
GO
/****** Object:  StoredProcedure [dbo].[GP_DeleteFriend]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GP_DeleteFriend]
	-- Add the parameters for the stored procedure here
	(@idx		int
	,@targetIdx int
	,@ret		int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/*
	好友删除
	把 @targetIdx 从自己（idx）的好友列表里删除
	*/
	set @ret = 1;
	
	delete mc_friend_rel where userID=@idx and friendID=@targetIdx
	
	set @ret = 0;

END
GO
/****** Object:  StoredProcedure [dbo].[GP_CountOnlineUsers]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	统计用户上线量，分2种。1种是，用户每天的上线次数都要被统计，此值统计用户每天的总上线次数，该字段为OnlineCount
--				统计用户某天有没有上线，只需要通过时间字段LastOnlineTime检查有没有该用户即可，通过该时间字段来为用户每天插入一条数据
-- =============================================
CREATE PROCEDURE [dbo].[GP_CountOnlineUsers]
	(@userIdx int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @tmpOnlineTime datetime ;
	declare @tmpOnlineCount int;
	
	set @tmpOnlineTime = null;
	set @tmpOnlineCount = 0;
	
	-- ============================================= --
	select @tmpOnlineTime = dbo.mc_CountOnlineUsers.LastOnlineTime, @tmpOnlineCount = OnlineCount from dbo.mc_CountOnlineUsers where UserIdx = @userIdx;
	
	if @tmpOnlineTime = null
	begin
	--insert a new row if it is the second day
	FLAG_SECOND_DAY_INSERT:
		--not found row
		INSERT INTO [xiaoxin].[dbo].[mc_CountOnlineUsers]
           ([UserIdx]
           ,[LastOnlineTime]
           ,[OnlineCount])
		VALUES
           (@userIdx, GETDATE(), 1);
           
        --done
        return;
	end
	else
	begin
		--have found row, it represents the user have been online before now.
		declare @tmpExistDate datetime,
				@tmpNowDate datetime;
				
		select @tmpExistDate = convert(varchar(10), @tmpOnlineTime, 101);
		select @tmpNowDate = convert(varchar(10), GETDATE(), 101);
		
		if @tmpExistDate = @tmpNowDate
		begin
			--it represents the operation do by user on today. only update user online count and add 1
			update dbo.mc_CountOnlineUsers set OnlineCount=@tmpOnlineCount+1, LastOnlineTime = GETDATE() where UserIdx = @userIdx
			
			--done
			return;
		end
		else
		begin
			goto FLAG_SECOND_DAY_INSERT;
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[GP_CONCURRENT_USER]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/**********************************************************************
 *<
	FILE: GP_CONCURRENT_USER.SQL

	DESCRIPTION:

	CREATED BY:

	HISTORY:

 *>	Copyright (c) 2008, All Rights Reserved.
 **********************************************************************/

create PROCEDURE [dbo].[GP_CONCURRENT_USER]
	(@SERVER_IDX	[int],			--서버번호
	 @VALUE			[int]OUTPUT)	--반환값

AS

SET NOCOUNT ON -- 영향받은 행의 갯수를 반환하지 않는다.

SELECT @VALUE=COUNT(IDX)
  FROM [dbo].[TB_LOGIN]
 WHERE [SERVER_NUM]=@SERVER_IDX
GO
/****** Object:  StoredProcedure [dbo].[GP_CheckNewsTrends]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	获取最近三十条资讯动态 	@maxNewsIdx传入服务器的最大资讯id		
--										@ret: 0:有新动态 1:无新动态
-- =============================================
CREATE PROCEDURE [dbo].[GP_CheckNewsTrends]
				(
					@maxNewsIdx		int
					,@ret			int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	if not exists (select * from mc_news)
	begin
		--空表
		set @ret = 1
		return
	end

    declare @tmpSqlNewsIdx	int;
	declare @tmpCount		int
    select	@tmpSqlNewsIdx	= MAX(newsId) from mc_news
    set		@tmpCount		= @tmpSqlNewsIdx - @maxNewsIdx;
    
    IF @tmpCount <= 0
    BEGIN
		set @ret = 1	--无新资讯
    END
    ELSE
    BEGIN
		if @tmpCount > 30
			set @tmpCount = 30
		
		set @ret = 0	--有新资讯	
		select top (@tmpCount) newsId, title, areaID, title_pic_url, create_date, f_newsid from mc_news order by newsId desc	
    END
    
END
GO
/****** Object:  StoredProcedure [dbo].[GP_CHECKISBOTHFRIEND]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	传入用户idx，目标idx，@retvalue
-- =============================================
CREATE PROCEDURE [dbo].[GP_CHECKISBOTHFRIEND]
				(@useidx		[bigint]				
				,@targetidx		[bigint]	
				,@retvalue		[int]		OUTPUT
				)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	set @retvalue = 0
	
	-- 互为好友返回1
	if exists ( (select * from mc_friend_rel where userID=@useidx and friendID=@targetidx) ) 
		and exists ( (select * from mc_friend_rel where userID=@targetidx and friendID=@useidx) )
	begin
		set @retvalue = 1
	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[GP_CheckClassTrends]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: 2014-3-29 14:14:02
-- Description:	获取最近三十条班级动态
				/*
				@ret:
					0:有新动态
					1:无新动态
				*/
-- =============================================
CREATE PROCEDURE [dbo].[GP_CheckClassTrends]
	(@maxLargeTrendIdx		int
	,@ret					int output)
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    /*
		msType!=1:	不要资讯
		status=2:	发布状态
    */
    
    declare @tmpSqlLargestTrendIdx		int;
    
    select @tmpSqlLargestTrendIdx = MAX(id) from mc_message where msType!=1 and status=2;
    
    if @tmpSqlLargestTrendIdx is null or @tmpSqlLargestTrendIdx=@maxLargeTrendIdx
    begin
		/*无新动态*/
		set @ret = 1
		return
    end
    
	set @ret = 0
	
	declare @tmpCount	int
	set		@tmpCount = @tmpSqlLargestTrendIdx-@maxLargeTrendIdx;
	if @tmpCount < 0
		set @tmpCount = 0
	
	select top (@tmpCount) id, msType, classIDs from mc_message where msType!=1 and status=2 order by id desc	
END
GO
/****** Object:  StoredProcedure [dbo].[GP_CHANNEL_UPDATE]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************
 *<
	FILE: GP_CHANNEL_UPDATE.SQL

	DESCRIPTION: 게임서버(채널) 업데이트

	CREATED BY: 곽철중

	HISTORY: Created	01/31/07	SQLServer2000
			 Modified	02/26/07	SQLServer2005

 *>	Copyright (c) 2007, All Rights Reserved.
 **********************************************************************/

CREATE PROCEDURE [dbo].[GP_CHANNEL_UPDATE]
	(@SERVER_NUM 	[int],		--서버번호
	 @CHANNEL_NUM	[int],		--채널번호
	 @STATUS 		[tinyint],		--상태(0원활/1보통/2혼잡)
	 @RETVALUE		[int]OUTPUT)	--반환값

AS

UPDATE [dbo].[TB_CHANNEL]
   SET [STATUS]=@STATUS
 WHERE [SERVER_NUM]=@SERVER_NUM
   AND [CHANNEL_NUM]=@CHANNEL_NUM

IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	BEGIN
		SET @RETVALUE = 1 --알수없는 오류.
	END
ELSE
	BEGIN
		SET @RETVALUE = 0 --업데이트 성공.
	END
GO
/****** Object:  StoredProcedure [dbo].[GP_CHANNEL_CHECK]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************
 *<
	FILE: GP_CHANNEL_CHECK.SQL

	DESCRIPTION: 게임서버등록(채널등록)

	CREATED BY: 곽철중

	HISTORY: 01/31/07 Created

 *>	Copyright (c) 2007, All Rights Reserved.
 **********************************************************************/

CREATE PROCEDURE [dbo].[GP_CHANNEL_CHECK]
	(@SERVER_NUM	[int]					--서버번호
	,@SERVER_NAME	[varchar](50)OUTPUT		--서버이름
	,@SERVER_DESC	[varchar](200)OUTPUT	--서버설명
	,@CHANNEL_NUM	[int]OUTPUT				--채널번호
	,@INETNUM	 	[varchar](20)			--채널IP주소(IPv4)
	,@IPV4          [bigint]					--채널IP주소(IPv4)
	,@PORT          [smallint]              --PORT
	,@RETVALUE		[int]OUTPUT)			--반환값

AS

SET NOCOUNT ON -- 영향받은 행의 갯수를 반환하지 않는다.

SELECT @SERVER_NAME=[NAME]
	  ,@SERVER_DESC=[DESCRIPTION]
  FROM [dbo].[TB_SERVER]
 WHERE [IDX]=@SERVER_NUM

IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	GOTO ERROR1

IF @CHANNEL_NUM <> 0
	BEGIN
		IF EXISTS (SELECT *
				     FROM [dbo].[TB_CHANNEL]
					WHERE [SERVER_NUM]=@SERVER_NUM
					  AND [CHANNEL_NUM]=@CHANNEL_NUM)
			GOTO ERROR2
	END
ELSE
	BEGIN
		SELECT TOP 1 @CHANNEL_NUM=[CHANNEL_NUM]
		  FROM [dbo].[TB_MATRIX] M
		 WHERE [SERVER_NUM]=@SERVER_NUM
		   AND NOT EXISTS (SELECT [CHANNEL_NUM]
							 FROM [dbo].[TB_CHANNEL] S
							WHERE (M.SERVER_NUM=S.SERVER_NUM)
							  AND (M.CHANNEL_NUM=S.CHANNEL_NUM))
		 ORDER BY [CHANNEL_NUM] ASC

		IF @CHANNEL_NUM = 0
			GOTO ERROR3
	END

INSERT INTO [dbo].[TB_CHANNEL]
	([SERVER_NUM]
	,[CHANNEL_NUM]
	,[INETNUM]
	,[IPV4]
	,[PORT])
VALUES
	(@SERVER_NUM
	,@CHANNEL_NUM
	,@INETNUM
	,@IPV4
	,@PORT)

IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	GOTO ERROR4

--등록성공.
SET @RETVALUE = 0
RETURN

ERROR1: --등록실패 - 등록안된 서버번호 사용.
	SET @RETVALUE = 1
	RETURN

ERROR2: --등록실패 - 이미 사용중 채널번호.
	SET @RETVALUE = 2
	RETURN

ERROR3: --등록실패 - TB_MATRIX 테이블 오류.
	SET @RETVALUE = 3
	RETURN

ERROR4: --등록실패 - 알수없는 오류.
	SET @RETVALUE = 4
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[GP_CHANGEPASSWORD]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	传入用户id和旧密码，验证码，email和retvalue是为了返回
-- =============================================
CREATE PROCEDURE [dbo].[GP_CHANGEPASSWORD]
				(
					@useridx	[bigint]
					,@password	[varchar](25)
					,@vercode	[varchar](4)
					,@email		[varchar](30)	OUTPUT
					,@retvalue	[int]			OUTPUT
				)
AS
declare @ishave int
declare @ishave1 int

BEGIN
	SET NOCOUNT ON;
	
	select @ishave = count(*) from mc_user where userID = @useridx
	IF @ishave = 0
		BEGIN
			set @retvalue = 1
		END
	ELSE
		BEGIN
			select @ishave1 = count(*) from mc_user where [password] = @password and userID = @useridx
			IF @ishave1 = 0
				BEGIN
					set @retvalue = 2
				END
			ELSE 
				BEGIN
					update mc_user
					SET remark = @vercode ---保存验证码
					set @email = (select email from mc_user where userID = @useridx)---返回email
					set @retvalue = 0
				END
		END
END
GO
/****** Object:  StoredProcedure [dbo].[GP_CHANGEMAILADDR]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	传入用户id，新的邮箱地址，返回值
-- =============================================
CREATE PROCEDURE [dbo].[GP_CHANGEMAILADDR]
						(
							@useridx	[bigint]
							,@mailaddr	[varchar](30)
							,@vercode	[varchar](4)
							,@retvalue	[int]	OUTPUT
						)
AS
BEGIN
declare @ishave int
	SET NOCOUNT ON;

	update mc_user
	set email = @mailaddr,remark = @vercode where userID = @useridx
	
	select @ishave = count(*) from mc_user where @mailaddr = email and userID = @useridx
	IF @ishave = 1
	BEGIN
		set @retvalue = 0
	END
END
GO
/****** Object:  StoredProcedure [dbo].[GP_ADDFRIEND]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GP_ADDFRIEND]
				(@ownidx	[bigint]				
				,@reqidx	[bigint]	
				,@retvalue	[int]		OUTPUT
				)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	set @retvalue = 1
	
	if not exists (select * from mc_friend_rel where userID=@ownidx and friendID=@reqidx)
	begin
		INSERT INTO mc_friend_rel ([userID], [friendID], [addDate] ) VALUES (@ownidx, @reqidx, GETDATE()) 
	end
	
	if not exists (select * from mc_friend_rel where userID=@reqidx and friendID=@ownidx)
	begin
		INSERT INTO mc_friend_rel ([userID], [friendID], [addDate] ) VALUES (@reqidx, @ownidx, GETDATE()) 
	end
	
	set @retvalue = 0 
END
GO
/****** Object:  StoredProcedure [dbo].[GP_GetCource]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GP_GetCource]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT subID, subName from mc_subject
END
GO
/****** Object:  StoredProcedure [dbo].[GP_GetContacts]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GP_GetContacts]
	-- Add the parameters for the stored procedure here
	(@userIdx		int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    /*
    获取通讯录列表
    获取每个人的详细信息：
		人员id，手机号，姓名，类型，头像，备注
    */
    declare	@tmpCount int
    
    
    

 --   --先取出行数
 --   select @tmpCount = COUNT(u.userID)
	--from mc_user u, mc_friend_rel r
	--where u.userID = r.friendID
	--and r.userID = @userIdx
    
 --   --在取值
 --   select @tmpCount, u.userID,u.loginID,u.name,u.roleType,u.url,u.remark 
	--from mc_user u, mc_friend_rel r
	--where u.userID = r.friendID
	--and r.userID = @userIdx
	--order by u.userID desc
	
	
	--修改，去掉好友的属性 
	select @tmpCount = COUNT(u.userID) from mc_user u 
	
	select  @tmpCount, u.userID,u.loginID,u.name,u.roleType,u.url,u.remark from mc_user u  order by u.userID desc
	
END
GO
/****** Object:  StoredProcedure [dbo].[GP_GetClassTrends]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================     
CREATE PROCEDURE [dbo].[GP_GetClassTrends]
	-- Add the parameters for the stored procedure here
	(@userIdx		int
	,@trends		int
	,@issueUserIdx	int output
	,@type			int output
	,@headImg		varchar(100) output
	,@issueTime		varchar(31) output
	,@issueContent	varchar(2000) output
	,@userName		varchar(100) output
	,@ret			int output)
AS	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	set @ret = 1;
	
	select	@issueUserIdx=msg.userID, 
			@type=msg.msType, 
			@headImg=u.url, 
			@issueTime=CONVERT(varchar, msg.addDate, 120), 
			@issueContent=msg.content,
			@userName = u.name
		from mc_message as msg, mc_user as u where id=@trends and u.userID=msg.userID and msg.status=2 and msg.msType!=1 
	
	
	set @ret = 0;
	
END
GO
/****** Object:  Table [dbo].[mc_sub_teacher_rel]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_sub_teacher_rel](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subID] [int] NOT NULL,
	[teacherID] [int] NULL,
	[subTeacher] [varchar](100) NULL,
	[addUID] [int] NULL,
	[addDate] [datetime] NULL,
	[remark] [varchar](500) NULL,
 CONSTRAINT [PK_MC_SUB_TEACHER_REL] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_sub_teacher_rel', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'科目id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_sub_teacher_rel', @level2type=N'COLUMN',@level2name=N'subID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'老师id（用户表）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_sub_teacher_rel', @level2type=N'COLUMN',@level2name=N'teacherID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'科目老师(如：数学老师)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_sub_teacher_rel', @level2type=N'COLUMN',@level2name=N'subTeacher'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_sub_teacher_rel', @level2type=N'COLUMN',@level2name=N'addUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_sub_teacher_rel', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_sub_teacher_rel', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'科目_老师关系表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_sub_teacher_rel'
GO
/****** Object:  Table [dbo].[mc_parent_student_rel]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_parent_student_rel](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parentID] [int] NULL,
	[studentID] [int] NOT NULL,
	[stdParent] [varchar](50) NOT NULL,
	[addUID] [int] NULL,
	[addDate] [datetime] NULL,
	[remark] [varchar](500) NULL,
 CONSTRAINT [PK_MC_PARENT_STDUENT_REL] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_parent_student_rel', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'家长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_parent_student_rel', @level2type=N'COLUMN',@level2name=N'parentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学生id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_parent_student_rel', @level2type=N'COLUMN',@level2name=N'studentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学生家长(如：小明妈妈)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_parent_student_rel', @level2type=N'COLUMN',@level2name=N'stdParent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_parent_student_rel', @level2type=N'COLUMN',@level2name=N'addUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_parent_student_rel', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_parent_student_rel', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'家长_学生关系表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_parent_student_rel'
GO
/****** Object:  Table [dbo].[mc_administrator]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_administrator](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[loginName] [varchar](20) NOT NULL,
	[password] [varchar](40) NOT NULL,
	[areaID] [int] NOT NULL,
	[addDate] [datetime] NULL,
	[addUID] [int] NULL,
	[updateUID] [int] NULL,
	[updateDate] [datetime] NULL,
	[adminLevel] [int] NOT NULL,
	[linkMan] [varchar](30) NULL,
	[linktel] [varchar](30) NULL,
	[email] [varchar](50) NULL,
	[remark] [varchar](500) NULL,
 CONSTRAINT [PK_MC_ADMINISTRATOR] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'loginName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'区域ID,与区域表主键关联' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'areaID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'addUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'updateUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'updateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员级别（1为超级管理员，2为区域管理员）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'adminLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系人姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'linkMan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'linktel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_administrator', @level2type=N'COLUMN',@level2name=N'remark'
GO
/****** Object:  StoredProcedure [dbo].[GP_USER_UPDATE_PHOTO_URL]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************
 *<
	FILE: GP_USER_UPDATE_PHOTO_URL.SQL

	DESCRIPTION:

	CREATED BY:

	HISTORY:

 *>	Copyright (c) 2007, All Rights Reserved.
 **********************************************************************/
 
 CREATE PROCEDURE [dbo].[GP_USER_UPDATE_PHOTO_URL]
				(@IDX				[int]
				,@PHOTO_URL			[nvarchar](100)	-- 공지내용
				,@RETVALUE			[int]OUTPUT)		
        
AS

-- 
SET NOCOUNT ON
DECLARE @ERRORCODE		[int]
DECLARE @ROWCOUNT		[int]

-- 
UPDATE [dbo].[MC_USER]
   SET [URL]    = @PHOTO_URL
 WHERE [USERID] = @IDX

IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	SET @RETVALUE = 1						-- 
ELSE
	SET @RETVALUE = 0						--
GO
/****** Object:  StoredProcedure [dbo].[GP_USER_INSERT_SUGGESTION]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************
 *<
	FILE: GP_USER_INSERT_SUGGESTION.SQL

	DESCRIPTION:

	CREATED BY:

	HISTORY:

 *>	Copyright (c) 2007, All Rights Reserved.
 **********************************************************************/
 
 CREATE PROCEDURE [dbo].[GP_USER_INSERT_SUGGESTION]
				(@IDX				[int]
				,@SUGGESTION		[varchar](1000)
				,@RETVALUE			[int]OUTPUT)		
        
AS

-- 
SET NOCOUNT ON
DECLARE @ERRORCODE		[int]
DECLARE @ROWCOUNT		[int]

-- 
IF EXISTS ( SELECT * FROM [dbo].[mc_user] WHERE [userID] = @IDX )
	BEGIN
		INSERT [dbo].[mc_suggestion]
		([suggestion]
		,[addUid]
		,[addDate]
		)
		VALUES
		(@SUGGESTION
		,@IDX
		,GETDATE()
		)
		
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			SET @RETVALUE = 1						-- 
		ELSE
			SET @RETVALUE = 0						-- 
	END
ELSE
	SET @RETVALUE = 1
GO
/****** Object:  StoredProcedure [dbo].[GP_USER_INSERT_CLASSTREND]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************
 *<
	FILE: GP_USER_INSERT_CLASSTREND.SQL

	DESCRIPTION:

	CREATED BY:

	HISTORY:

 *>	Copyright (c) 2007, All Rights Reserved.
 **********************************************************************/
 
 CREATE PROCEDURE [dbo].[GP_USER_INSERT_CLASSTREND]
				(@IDX				[int]
				,@MSGTYPE			[int]
				,@CLASSIDX			[varchar](60)
				,@CONTENTLEN		[int]
				,@CONTENT			[nvarchar](max)	-- 
				,@RETVALUE			[int]OUTPUT)		
        
AS

-- 
SET NOCOUNT ON
DECLARE @ERRORCODE		[int]
DECLARE @ROWCOUNT		[int]

-- 
IF EXISTS ( SELECT * FROM [dbo].[mc_user] WHERE [userID] = @IDX AND [roleType] = 1 )
	BEGIN
		INSERT [dbo].[mc_message]
		([userID]
		,[msType]
		,[classIDs]
		,[contentType]
		,[content]
		,[conLength]
		,[status]
		,[addUID]
		,[addDate]
		)
		VALUES
		(@IDX
		,@MSGTYPE
		,@CLASSIDX
		,1	-- 都是文字
		,@CONTENT
		,@CONTENTLEN
		,2	-- 都是已发布
		,@IDX
		,GETDATE()
		)
		
		IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
			SET @RETVALUE = 1						-- 
		ELSE
			SET @RETVALUE = 0						-- 
	END
ELSE
	SET @RETVALUE = 1
GO
/****** Object:  StoredProcedure [dbo].[GP_ModifyName]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GP_ModifyName]
	-- Add the parameters for the stored procedure here
	(@userIdx		int
	,@userType		int
	,@userNewName	varchar(100)
	,@ret			int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	set	@ret = 1;
	update mc_user set name=@userNewName where userID=@userIdx and roleType=@userType
	set	@ret = 0;
	
END
GO
/****** Object:  StoredProcedure [dbo].[GP_ShieldGroup]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		oiooooio
-- Create date: 2014-3-23 09:58:56
-- Description:	根据用户@userIdx屏蔽群@groupIdx
				/*
				@ret
					0：成功
					1：失败
				*/
-- =============================================
CREATE PROCEDURE [dbo].[GP_ShieldGroup]
	-- Add the parameters for the stored procedure here
	(@userIdx		int
	,@groupIdx		int
	,@operator		int
	,@ret			int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--#define MACRO_SHIELDGROUP			1	//屏蔽群
	--#define MACRO_UNSHIEDGROUP		2	//解除群屏蔽

	set	@ret = 1

	if @operator = 2
	begin
		delete mc_groupShield where userID = @userIdx and classID = @groupIdx
		set @ret = 0
		return
	end
	
	else if @operator = 1
	begin
		if not exists (select * from mc_groupShield where userID = @userIdx and classID = @groupIdx)
		BEGIN
			insert into mc_groupShield(userID, classID) values(@userIdx, @groupIdx)
		END
		
		set @ret = 0;
	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[GP_SERVERDOWN]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************
 *<
	FILE: GP_SERVERDOWN.SQL

	DESCRIPTION: 게임서버 다운

	CREATED BY: 곽철중

	HISTORY: Created	01/17/07	SQLServer2000
			 Modified	02/26/07	SQLServer2005

 *>	Copyright (c) 2007, All Rights Reserved.
 **********************************************************************/

CREATE PROCEDURE [dbo].[GP_SERVERDOWN]
	(@SERVER_NUM	[int],	--서버번호
	 @CHANNEL_NUM	[int])	--채널번호

AS

SET NOCOUNT ON -- 영향받은 행의 갯수를 반환하지 않는다.

DELETE [dbo].[TB_CHANNEL]
 WHERE [SERVER_NUM]=@SERVER_NUM
   AND [CHANNEL_NUM]=@CHANNEL_NUM
GO
/****** Object:  StoredProcedure [dbo].[GP_SERVER_LIST]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************
 *<
	FILE: GP_SERVER_LIST.SQL

	DESCRIPTION: 로그인

	CREATED BY: 곽철중

	HISTORY: Created	03/29/07

 *>	Copyright (c) 2007, All Rights Reserved.
 **********************************************************************/

CREATE PROCEDURE [dbo].[GP_SERVER_LIST]

AS

SET NOCOUNT ON -- 영향받은 행의 갯수를 반환하지 않는다.

SELECT [IDX]
	  ,[NAME]
	  ,[DESCRIPTION]
	  ,[STATUS]
	  ,[SERVICER]
	  ,[IPADDRESS]
  FROM [dbo].[TB_SERVER]
 WHERE [APPLY] = 0
 ORDER BY [IDX] ASC
GO
/****** Object:  StoredProcedure [dbo].[GP_ModifyParentChildRelationship]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		oiooooio
-- Create date: 2014-3-23 10:37:42
-- Description:	通过用户@userIdx和孩子@childIdx修改parent-child之间的关系为@relationship
--				@relationship为{L"爸爸", L"妈妈", L"爷爷", L"奶奶"};
-- =============================================
CREATE PROCEDURE [dbo].[GP_ModifyParentChildRelationship]
	-- Add the parameters for the stored procedure here
	(@userIdx		int
	,@childIdx		int
	,@relationship	varchar(2)
	,@ret			int output)
AS
BEGIN

	declare @ishave int
	
	SET NOCOUNT ON;
	
	select @ishave = COUNT(*) from mc_parent_student_rel where parentID = @userIdx and studentID = @childIdx
	IF @ishave > 0
	BEGIN 
		update mc_parent_student_rel
		set stdParent = @relationship where @userIdx = parentID and @childIdx = studentID
	END
	ELSE 
	BEGIN
		INSERT into mc_parent_student_rel(parentID,studentID,stdParent) values(@userIdx,@childIdx,@relationship)
	END
	
	set @ret = 0;
END
GO
/****** Object:  StoredProcedure [dbo].[GP_ModifyCourse]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		oiooooio
-- Create date: 2014年3月22日10:38:04
-- Description:	根据用户@userIdx和用户@userType修改用户所教的课程为@newCourseId列表
-- =============================================
CREATE PROCEDURE [dbo].[GP_ModifyCourse]
	-- Add the parameters for the stored procedure here
	(@userIdx		int
	,@userType		int
	,@newCourseId1	int
	,@newCourseId2	int
	,@newCourseId3	int
	,@newCourseId4	int
	,@newCourseId5	int
	,@ret			int output
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	set @ret = 1;
	
	if exists (select * from mc_user where userID=@userIdx and roleType=@userType)
	begin
		delete from mc_sub_teacher_rel where @userIdx = teacherID 
		declare @tmpSubject	varchar(100)
		
		if @newCourseId1 > 0
		begin	
			select @tmpSubject=subName+'老师' from mc_subject where subID=@newCourseId1
			insert into mc_sub_teacher_rel(subID,teacherID,subTeacher, addDate) values(@newCourseId1, @userIdx, @tmpSubject, GETDATE()) 
		end
		if @newCourseId2 > 0
		begin
			select @tmpSubject=subName+'老师' from mc_subject where subID=@newCourseId2
			insert into mc_sub_teacher_rel(subID,teacherID,subTeacher, addDate) values(@newCourseId2, @userIdx, @tmpSubject, GETDATE()) 
		end
		if @newCourseId3 > 0
		begin
			select @tmpSubject=subName+'老师' from mc_subject where subID=@newCourseId3
			insert into mc_sub_teacher_rel(subID,teacherID,subTeacher, addDate) values(@newCourseId3, @userIdx, @tmpSubject, GETDATE()) 
		end
		if @newCourseId4 > 0
		begin
			select @tmpSubject=subName+'老师' from mc_subject where subID=@newCourseId4
			insert into mc_sub_teacher_rel(subID,teacherID,subTeacher, addDate) values(@newCourseId4, @userIdx, @tmpSubject, GETDATE()) 
		end
		if @newCourseId5 > 0
		begin
			select @tmpSubject=subName+'老师' from mc_subject where subID=@newCourseId5
			insert into mc_sub_teacher_rel(subID,teacherID,subTeacher, addDate) values(@newCourseId5, @userIdx, @tmpSubject, GETDATE()) 
		end
		set @ret = 0;
	end
END
GO
/****** Object:  StoredProcedure [dbo].[GP_ModifyChildClass]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	修改孩子班级，通过家长@userIdx找到孩子@childIdx然后修改孩子的班级为@newClassId
-- =============================================
CREATE PROCEDURE [dbo].[GP_ModifyChildClass] 
	-- Add the parameters for the stored procedure here
	(@userIdx		int
	,@childIdx		int
	,@newClassId	int
	,@oldClassId	int output
	,@ret			int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	set @ret = 1;
	
	--目前一个家长就绑定一个孩子
	select @childIdx = studentID from mc_parent_student_rel where parentID = @userIdx
	
	if @childIdx > 0
	begin
		select @oldClassId = classid from mc_user where userID = @childIdx
		update mc_user set classid=@newClassId where userID=@childIdx
		set @ret = 0;
	end
	
END
GO
/****** Object:  Table [dbo].[mc_class]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mc_class](
	[classID] [int] IDENTITY(1,1) NOT NULL,
	[className] [varchar](30) NOT NULL,
	[classType] [int] NULL,
	[schoolID] [int] NOT NULL,
	[status] [int] NULL,
	[addUID] [int] NULL,
	[addDate] [datetime] NULL,
	[updateUID] [int] NULL,
	[updateDate] [datetime] NULL,
	[remark] [varchar](500) NULL,
 CONSTRAINT [PK__mc_class__B0303427336AA144] PRIMARY KEY CLUSTERED 
(
	[classID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级id(主键)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_class', @level2type=N'COLUMN',@level2name=N'classID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级名称(如：三年二班)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_class', @level2type=N'COLUMN',@level2name=N'className'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级类型（0普通班，1强化班等）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_class', @level2type=N'COLUMN',@level2name=N'classType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学校id(关联学校表)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_class', @level2type=N'COLUMN',@level2name=N'schoolID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态(1正常，0禁用)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_class', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_class', @level2type=N'COLUMN',@level2name=N'addUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_class', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_class', @level2type=N'COLUMN',@level2name=N'updateUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_class', @level2type=N'COLUMN',@level2name=N'updateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_class', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级信息表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_class'
GO
/****** Object:  StoredProcedure [dbo].[GP_GetClassList]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	获取班级列表
-- =============================================
CREATE PROCEDURE [dbo].[GP_GetClassList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

        
    select classID, className from mc_class;
   
END
GO
/****** Object:  StoredProcedure [dbo].[GP_GetChildClassInfo]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	根据用户@userIdx和用户类型@userType获取孩子的班级信息，包含的有：孩子id，孩子名称，班级id，班级名称
-- =============================================
CREATE PROCEDURE [dbo].[GP_GetChildClassInfo]
	-- Add the parameters for the stored procedure here
	(@userIdx		int
	,@userType		int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	if exists (select * from mc_user where userID=@userIdx and roleType=@userType and status=2)
	begin
		select userID, name, u.classid, c.className from mc_user u, mc_class c  where userID=(select studentID from mc_parent_student_rel where parentID=@userIdx)
		and c.classID = u.classid
	end

END
GO
/****** Object:  Table [dbo].[mc_teacher_class_rel]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mc_teacher_class_rel](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[teacherID] [int] NULL,
	[classID] [int] NULL,
	[addUID] [int] NULL,
	[addDate] [datetime] NULL,
	[remark] [int] NULL,
 CONSTRAINT [PK_MC_TEACHER_CLASS_REL] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主键id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_teacher_class_rel', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'老师id（用户表）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_teacher_class_rel', @level2type=N'COLUMN',@level2name=N'teacherID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级id(班级表主键)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_teacher_class_rel', @level2type=N'COLUMN',@level2name=N'classID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_teacher_class_rel', @level2type=N'COLUMN',@level2name=N'addUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_teacher_class_rel', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_teacher_class_rel', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'老师_班级关系表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mc_teacher_class_rel'
GO
/****** Object:  StoredProcedure [dbo].[GP_UserVerify]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GP_UserVerify]
	-- Add the parameters for the stored procedure here
	(@type		tinyint			--类型：家长/老师
	,@password	varchar(25)
	,@tel		varchar(11)
	,@email		varchar(30)
	,@name		varchar(100)
	,@addr1		int				--一级地址
	,@addr2		int				--二级~
	,@class		int				--所在（所教）班级
	,@external1	int				--扩展参数1
	,@ret		int output
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	/*
	说明：
	@external1:
		如果类型为老师（1），则此值为课程
		如果类型为家长（2），则此值为家长和孩子的关系
		如果类型为学生（3）
	
	@ret
		返回值
		00：	验证（注册）成功
		01：	验证（注册）失败
		02:		验证（注册）失败，邮箱重复
	*/

	
	set @ret = 1
	
	if exists (select * from mc_user where loginID=@tel and status=2)
	begin
		--该用户已注册
		return
	end
	
	if exists (select * from mc_user where email=@email)
	begin
		--验证（注册）失败，邮箱重复
		set @ret = 2
		return
	end

	if @type = 1 --角色为老师
	BEGIN
	if exists(select u.userID from mc_user u,mc_teacher_class_rel r,mc_class c,mc_school s
			where u.userID = r.teacherID and r.classID = c.classID 
					and c.schoolID = s.schoolID 
					and u.loginID = @tel and u.name = @name and c.classID = @class)
	begin
		update mc_user set status=2, password=@password, email=@email, updateDate=GETDATE() where loginID=@tel
		set @ret = 00;
	end
	else  
	set @ret = 01;

	end	
	else if @type = 2	--角色为家长
	begin
	if exists(select par.userID from mc_user u ,mc_parent_student_rel r,mc_class c,mc_user par,mc_school s,mc_area a
			where u.userID = r.studentID and u.classid = c.classID and par.userID = r.parentID
				and c.schoolID = s.schoolID and s.areaID = a.areaID
				and par.loginID = @tel and u.name = @name and c.classID = @class
				and a.areaID = @addr2 and a.fareaid= @addr1)
	begin
		update mc_user set status=2, password=@password, email=@email, updateDate=GETDATE() where loginID=@tel
		set @ret = 00;
	end
	else  
	set @ret = 01;
	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[GP_MODIFY_TEACHER_CLASS]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	教师修改所教班级
-- =============================================
CREATE PROCEDURE [dbo].[GP_MODIFY_TEACHER_CLASS] 
	-- Add the parameters for the stored procedure here
	(@USER_INDEX	[int]
	,@USER_TYPE		[int]
	,@CLASS_IDX_01	[int]
	,@CLASS_IDX_02	[int]
	,@CLASS_IDX_03	[int]
	,@CLASS_IDX_04	[int]
	,@CLASS_IDX_05	[int]
	,@RETVALUE		[int] output)
AS

SET NOCOUNT ON
DECLARE @ERRORCODE		[int]
DECLARE @ROWCOUNT		[int]


BEGIN TRAN

IF NOT EXISTS ( SELECT * FROM [dbo].[mc_user] WHERE [userID] = @USER_INDEX AND [roleType] = @USER_TYPE )
	GOTO ROLLBACK_TRAN
	
DELETE  [dbo].[mc_teacher_class_rel] 
WHERE   [teacherID] = @USER_INDEX

-- 第一个
if @CLASS_IDX_01 > 0
begin
	INSERT  [dbo].[mc_teacher_class_rel]
			([classID]
			,[teacherID]
			,[addUID]
			,[addDate]
			)
	VALUES  (@CLASS_IDX_01
			,@USER_INDEX
			,@USER_INDEX
			,GETDATE()
			)
IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	GOTO ROLLBACK_TRAN
	end
	
-- 第二个
if @CLASS_IDX_02 > 0
begin
	INSERT  [dbo].[mc_teacher_class_rel]
			([classID]
			,[teacherID]
			,[addUID]
			,[addDate]
			)
	VALUES  (@CLASS_IDX_02
			,@USER_INDEX
			,@USER_INDEX
			,GETDATE()
			)
	IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	GOTO ROLLBACK_TRAN
	end
	
-- 第三个
if @CLASS_IDX_03 > 0
begin
	INSERT  [dbo].[mc_teacher_class_rel]
			([classID]
			,[teacherID]
			,[addUID]
			,[addDate]
			)
	VALUES  (@CLASS_IDX_03
			,@USER_INDEX
			,@USER_INDEX
			,GETDATE()
			)
IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	GOTO ROLLBACK_TRAN
	end
	
-- 第四个
if @CLASS_IDX_04 > 0
begin
	INSERT  [dbo].[mc_teacher_class_rel]
			([classID]
			,[teacherID]
			,[addUID]
			,[addDate]
			)
	VALUES  (@CLASS_IDX_04
			,@USER_INDEX
			,@USER_INDEX
			,GETDATE()
			)
IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	GOTO ROLLBACK_TRAN
	end
	
-- 第五个
if @CLASS_IDX_05 > 0
begin
	INSERT  [dbo].[mc_teacher_class_rel]
			([classID]
			,[teacherID]
			,[addUID]
			,[addDate]
			)
	VALUES  (@CLASS_IDX_05
			,@USER_INDEX
			,@USER_INDEX
			,GETDATE()
			)
IF @@ERROR <> 0 OR @@ROWCOUNT <> 1
	GOTO ROLLBACK_TRAN
	end
	
COMMIT TRAN
SET @RETVALUE = 0					
RETURN

ROLLBACK_TRAN:
	ROLLBACK TRAN
	SET @RETVALUE = 1					
RETURN
GO
/****** Object:  StoredProcedure [dbo].[GP_GETTEACHERCLASSINFO]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	根据用户@userIdx获取老师的班级信息，包含的有：班级id，班级名称
-- =============================================

CREATE PROCEDURE [dbo].[GP_GETTEACHERCLASSINFO]
				(@useridx	[bigint]					
				,@retvalue	[int]		OUTPUT
				)
AS
BEGIN
	SET NOCOUNT ON;

	set @retvalue = 1
	
	select	c.classID, c.className from mc_user as u, mc_class as c, mc_teacher_class_rel as tc 
			where u.roleType=1 and u.userID=tc.teacherID and c.classID =tc.classID and u.userID = @useridx;
	
	set @retvalue = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GP_GetPersonalInfo]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	根据用户@userIdx或者用户@userTel获取用户的地址（一级+二级地址）/学校名称/学校编号/班级名称
-- Description NEW: 根据用户Idx或者用户Tel、用户姓名 获取用户信息
-- 用户信息顺序：用户id,用户电话,姓名,性别,用户类型,用户辈分（rolename）,用户头像，用户地址，学校名称，学校编号，邮箱，班级名称（多个）
-- =============================================
CREATE PROCEDURE [dbo].[GP_GetPersonalInfo]
	-- Add the parameters for the stored procedure here
	(@userIdx			int
	,@userTel			varchar(11)
	,@ret				int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @roleType int;
	
	set @ret = 1
	
	IF @userIdx <> 0	--用户idx有效
	BEGIN
		--select userID,loginID,name,sex,roleType,roleName,url from mc_user where userID = @userIdx
		select @roleType = roleType from mc_user where userID = @userIdx
		--roleType :1为老师，2为家长，3为学生；
		SET @ret = 0
		if @roleType=1
		--校信id，手机号码(登录账号)，真实姓名，性别，角色类型，角色名称，用户头像，缺省值，所在城市，所在学校名称，学校编号,邮箱,所在班级
		select u.userID,u.loginID,u.name,u.sex,u.roleType,u.roleName,u.url,'' as stdParent,area.cityName,s.schoolName,s.schoolCode,u.email,c.className
			from mc_user u,mc_teacher_class_rel r,mc_class c,mc_school s,
				(select a2.areaID cityID ,a1.name + a2.name cityName 
				from mc_area a1 right join mc_area a2
				on a1.areaID = a2.fareaid
				where a1.fareaid=1) area
					where  r.classID = c.classID
						and c.schoolID = s.schoolID
						and area.cityID = s.areaID
						and u.userID = r.teacherID
						and r.teacherID = @userIdx
		else if @roleType=2
		--校信id，手机号码(登录账号)，真实姓名，性别，角色类型，角色名称，用户头像，xx学生家长，所在城市，所在学校，学校编号,邮箱,所在班级
		select par.userID,par.loginID,par.name,par.sex,par.roleType,par.roleName,par.url,r.stdParent, area.cityName,s.schoolName,s.schoolCode,par.email,c.className 
			from mc_user u ,mc_parent_student_rel r,mc_class c,mc_user par,mc_school s,
			(select a2.areaID cityID ,a1.name + a2.name cityName 
			from mc_area a1 right join mc_area a2
			on a1.areaID = a2.fareaid where a1.fareaid=1) area
				where r.studentID = u.userID
				and u.classid = c.classID
				and c.schoolID = s.schoolID
				and area.cityID = s.areaID
				and par.userID = r.parentID
				and r.parentID= @userIdx

	END
	ELSE IF LEN(@userTel) = 11	--用户电话有效
	BEGIN
		--select userID,loginID,name,sex,roleType,roleName,url from mc_user where loginID = @userTel
		select @roleType = roleType from mc_user where loginID = @userTel
		--roleType :1为老师，2为家长，3为学生；
		SET @ret = 0
		if @roleType=1
		--校信id，手机号码(登录账号)，真实姓名，性别，角色类型，角色名称，用户头像，缺省值，所在城市，所在学校名称，学校编号,邮箱,所在班级
		select u.userID,u.loginID,u.name,u.sex,u.roleType,u.roleName,u.url,'' as stdParent,area.cityName,s.schoolName,s.schoolCode,u.email,c.className
			from mc_user u,mc_teacher_class_rel r,mc_class c,mc_school s,
				(select a2.areaID cityID ,a1.name + a2.name cityName 
				from mc_area a1 right join mc_area a2
				on a1.areaID = a2.fareaid
				where a1.fareaid=1) area
					where  r.classID = c.classID
						and c.schoolID = s.schoolID
						and area.cityID = s.areaID
						and u.userID = r.teacherID
						and u.loginID= @userTel
		else if @roleType=2
		--校信id，手机号码(登录账号)，真实姓名，性别，角色类型，角色名称，用户头像，xx学生家长，所在城市，所在学校，学校编号,邮箱,所在班级
		select par.userID,par.loginID,par.name,par.sex,par.roleType,par.roleName,par.url,r.stdParent, area.cityName,s.schoolName,s.schoolCode,par.email,c.className 
			from mc_user u ,mc_parent_student_rel r,mc_class c,mc_user par,mc_school s,
			(select a2.areaID cityID ,a1.name + a2.name cityName 
			from mc_area a1 right join mc_area a2
			on a1.areaID = a2.fareaid where a1.fareaid=1) area
				where r.studentID = u.userID
				and u.classid = c.classID
				and c.schoolID = s.schoolID
				and area.cityID = s.areaID
				and par.userID = r.parentID
				and par.loginID= @userTel
	END
	ELSE
	BEGIN
		SET @ret = -1
	END
END
GO
/****** Object:  StoredProcedure [dbo].[GP_DELORADDTEACHERCLASS]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	删除老师的某个班级--传入老师idx和班级idx和用户类型
-- =============================================
CREATE PROCEDURE [dbo].[GP_DELORADDTEACHERCLASS]
				(@useridx	[bigint]	
				,@classidx	[int]	
				,@sign		[int]			
				,@retvalue	[int]		OUTPUT
				)
AS

declare @ishave int
BEGIN

	SET NOCOUNT ON;
	select @ishave = count(*) from mc_teacher_class_rel where @useridx = teacherID AND classID = @classidx
	
	IF @sign = 1
	BEGIN
		IF @ishave > 0 
		BEGIN 
			delete from mc_teacher_class_rel where @useridx = teacherID AND classID = @classidx
		END
	END
	ELSE IF @sign = 2
	BEGIN
		IF @ishave = 0
		BEGIN
			INSERT INTO mc_teacher_class_rel (teacherID,classID) VALUES (@useridx,@classidx)
		END
	END
	set @retvalue = 0
END
GO
/****** Object:  StoredProcedure [dbo].[GP_GetGroupList]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GP_GetGroupList]
	-- Add the parameters for the stored procedure here
	(@userIdx		int
	,@userType		int
	,@ret			int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	set	@ret = 0

    if @userType = 1	--老师
    begin
		select c.classID, c.className from mc_teacher_class_rel as tc, mc_class as c where tc.teacherID=@userIdx and tc.classID=c.classID
    end
    else if @userType = 2	--家长
    begin
		select c.classID, c.className from mc_parent_student_rel as ps, mc_class as c, mc_user as u 
		where ps.parentID=@userIdx and ps.studentID=u.userID and u.classid=c.classID order by c.classID desc
    end
    else
    begin
		--避免程序获取数据错误
		select null, null
		set	@ret = 1
    end
    
END
GO
/****** Object:  StoredProcedure [dbo].[GP_ChatVerify]    Script Date: 08/12/2015 09:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	当用户连接到主服务器后，需要进行的一次验证，主要验证手机号码和idx是否对应，如果不对应则表示当前用户不对
-- =============================================
CREATE PROCEDURE [dbo].[GP_ChatVerify]
	-- Add the parameters for the stored procedure here
	(@userIdx	int
	,@userType	int
	,@tel		varchar(11)
	,@ret		int output)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	/*
	返回值
	@ret
		00：	成功，手机号和useridx匹配
		01：	失败，手机号和useridx不匹配
	*/
	
	set @ret = 0
		
	/*
	userID=@userIdx:用户id
	roleType=@userType:用户类型
	loginID = @tel:用户电话
	status=1:正常使用以及注册完毕状态
	*/
	if exists (select * from mc_user where userID=@userIdx and roleType=@userType and loginID = @tel and status=2 )
	begin		
		if @userType = 2 --家长
			begin
				select s.areaID, c.classid from mc_user as u, mc_school as s, mc_parent_student_rel as ps, mc_class as c
				where ps.parentID=@userIdx and u.userID=ps.studentID and u.classid = c.classID and c.schoolID = s.schoolID
			end
		else if @userType = 1 --老师
			begin
				select s.areaID, c.classid from mc_user as u, mc_school as s, mc_teacher_class_rel as tc, mc_class as c
				where u.userID = @userIdx and tc.teacherID = u.userID and tc.classID = c.classID and c.schoolID = s.schoolID
			end	
		else
		begin
			set @ret = 1;
			/*防止没有数据返回导致程序获取数据失败导致错误*/
			select null, null
		end
		
		if @ret = 0
		--统计用户上线次数
		begin 
			EXEC [dbo].[GP_CountOnlineUsers]
				 @userIdx = @userIdx
		end
		
		return;
	end
END
GO
/****** Object:  Default [DF_TB_SERVER_REGISTER_DATE]    Script Date: 08/12/2015 09:37:06 ******/
ALTER TABLE [dbo].[TB_SERVER] ADD  CONSTRAINT [DF_TB_SERVER_REGISTER_DATE]  DEFAULT (getdate()) FOR [REGISTER_DATE]
GO
/****** Object:  Default [DF_TB_SERVER_STATUS]    Script Date: 08/12/2015 09:37:06 ******/
ALTER TABLE [dbo].[TB_SERVER] ADD  CONSTRAINT [DF_TB_SERVER_STATUS]  DEFAULT ((0)) FOR [STATUS]
GO
/****** Object:  Default [DF_TB_SERVER_APPLY]    Script Date: 08/12/2015 09:37:06 ******/
ALTER TABLE [dbo].[TB_SERVER] ADD  CONSTRAINT [DF_TB_SERVER_APPLY]  DEFAULT ((0)) FOR [APPLY]
GO
/****** Object:  Default [DF__TB_SERVER__SERVI__1273C1CD]    Script Date: 08/12/2015 09:37:06 ******/
ALTER TABLE [dbo].[TB_SERVER] ADD  DEFAULT ((0)) FOR [SERVICER]
GO
/****** Object:  Default [DF_TB_CHANNEL_REGISTER_DATE]    Script Date: 08/12/2015 09:37:06 ******/
ALTER TABLE [dbo].[TB_CHANNEL] ADD  CONSTRAINT [DF_TB_CHANNEL_REGISTER_DATE]  DEFAULT (getdate()) FOR [REGISTER_DATE]
GO
/****** Object:  Default [DF_TB_CHANNEL_SERVER_NUM]    Script Date: 08/12/2015 09:37:06 ******/
ALTER TABLE [dbo].[TB_CHANNEL] ADD  CONSTRAINT [DF_TB_CHANNEL_SERVER_NUM]  DEFAULT ((0)) FOR [SERVER_NUM]
GO
/****** Object:  Default [DF_TB_CHANNEL_CHANNEL_NUM]    Script Date: 08/12/2015 09:37:06 ******/
ALTER TABLE [dbo].[TB_CHANNEL] ADD  CONSTRAINT [DF_TB_CHANNEL_CHANNEL_NUM]  DEFAULT ((0)) FOR [CHANNEL_NUM]
GO
/****** Object:  Default [DF_TB_CHANNEL_IPV4]    Script Date: 08/12/2015 09:37:06 ******/
ALTER TABLE [dbo].[TB_CHANNEL] ADD  CONSTRAINT [DF_TB_CHANNEL_IPV4]  DEFAULT ((0)) FOR [IPV4]
GO
/****** Object:  Default [DF_TB_CHANNEL_PORT]    Script Date: 08/12/2015 09:37:06 ******/
ALTER TABLE [dbo].[TB_CHANNEL] ADD  CONSTRAINT [DF_TB_CHANNEL_PORT]  DEFAULT ((0)) FOR [PORT]
GO
/****** Object:  Default [DF_TB_CHANNEL_STATUS]    Script Date: 08/12/2015 09:37:06 ******/
ALTER TABLE [dbo].[TB_CHANNEL] ADD  CONSTRAINT [DF_TB_CHANNEL_STATUS]  DEFAULT ((0)) FOR [STATUS]
GO
/****** Object:  ForeignKey [FK345F8996BF8F5001]    Script Date: 08/12/2015 09:37:08 ******/
ALTER TABLE [dbo].[mc_area]  WITH NOCHECK ADD  CONSTRAINT [FK345F8996BF8F5001] FOREIGN KEY([fareaid])
REFERENCES [dbo].[mc_area] ([areaID])
GO
ALTER TABLE [dbo].[mc_area] NOCHECK CONSTRAINT [FK345F8996BF8F5001]
GO
/****** Object:  ForeignKey [FK_teacher_to_user]    Script Date: 08/12/2015 09:37:08 ******/
ALTER TABLE [dbo].[mc_teacher]  WITH NOCHECK ADD  CONSTRAINT [FK_teacher_to_user] FOREIGN KEY([userID])
REFERENCES [dbo].[mc_user] ([userID])
GO
ALTER TABLE [dbo].[mc_teacher] CHECK CONSTRAINT [FK_teacher_to_user]
GO
/****** Object:  ForeignKey [FK_MC_SCHOO_REFERENCE_MC_AREA]    Script Date: 08/12/2015 09:37:08 ******/
ALTER TABLE [dbo].[mc_school]  WITH NOCHECK ADD  CONSTRAINT [FK_MC_SCHOO_REFERENCE_MC_AREA] FOREIGN KEY([areaID])
REFERENCES [dbo].[mc_area] ([areaID])
GO
ALTER TABLE [dbo].[mc_school] NOCHECK CONSTRAINT [FK_MC_SCHOO_REFERENCE_MC_AREA]
GO
/****** Object:  ForeignKey [mc_sub_teacher_foreignKey_subID]    Script Date: 08/12/2015 09:37:08 ******/
ALTER TABLE [dbo].[mc_sub_teacher_rel]  WITH CHECK ADD  CONSTRAINT [mc_sub_teacher_foreignKey_subID] FOREIGN KEY([subID])
REFERENCES [dbo].[mc_subject] ([subID])
GO
ALTER TABLE [dbo].[mc_sub_teacher_rel] CHECK CONSTRAINT [mc_sub_teacher_foreignKey_subID]
GO
/****** Object:  ForeignKey [mc_sub_teacher_foreignKey_teacherID]    Script Date: 08/12/2015 09:37:08 ******/
ALTER TABLE [dbo].[mc_sub_teacher_rel]  WITH CHECK ADD  CONSTRAINT [mc_sub_teacher_foreignKey_teacherID] FOREIGN KEY([teacherID])
REFERENCES [dbo].[mc_user] ([userID])
GO
ALTER TABLE [dbo].[mc_sub_teacher_rel] CHECK CONSTRAINT [mc_sub_teacher_foreignKey_teacherID]
GO
/****** Object:  ForeignKey [FK_Student_Parent_parentID]    Script Date: 08/12/2015 09:37:08 ******/
ALTER TABLE [dbo].[mc_parent_student_rel]  WITH CHECK ADD  CONSTRAINT [FK_Student_Parent_parentID] FOREIGN KEY([parentID])
REFERENCES [dbo].[mc_user] ([userID])
GO
ALTER TABLE [dbo].[mc_parent_student_rel] CHECK CONSTRAINT [FK_Student_Parent_parentID]
GO
/****** Object:  ForeignKey [FK_Student_Parent_userID123]    Script Date: 08/12/2015 09:37:08 ******/
ALTER TABLE [dbo].[mc_parent_student_rel]  WITH CHECK ADD  CONSTRAINT [FK_Student_Parent_userID123] FOREIGN KEY([studentID])
REFERENCES [dbo].[mc_user] ([userID])
GO
ALTER TABLE [dbo].[mc_parent_student_rel] CHECK CONSTRAINT [FK_Student_Parent_userID123]
GO
/****** Object:  ForeignKey [FK_MC_ADMIN_REFERENCE_MC_AREA]    Script Date: 08/12/2015 09:37:08 ******/
ALTER TABLE [dbo].[mc_administrator]  WITH NOCHECK ADD  CONSTRAINT [FK_MC_ADMIN_REFERENCE_MC_AREA] FOREIGN KEY([areaID])
REFERENCES [dbo].[mc_area] ([areaID])
GO
ALTER TABLE [dbo].[mc_administrator] NOCHECK CONSTRAINT [FK_MC_ADMIN_REFERENCE_MC_AREA]
GO
/****** Object:  ForeignKey [FK_MC_CLASS_REFERENCE_MC_SCHOO]    Script Date: 08/12/2015 09:37:08 ******/
ALTER TABLE [dbo].[mc_class]  WITH NOCHECK ADD  CONSTRAINT [FK_MC_CLASS_REFERENCE_MC_SCHOO] FOREIGN KEY([schoolID])
REFERENCES [dbo].[mc_school] ([schoolID])
GO
ALTER TABLE [dbo].[mc_class] CHECK CONSTRAINT [FK_MC_CLASS_REFERENCE_MC_SCHOO]
GO
/****** Object:  ForeignKey [mc_teacher_class_foreignKey_class]    Script Date: 08/12/2015 09:37:08 ******/
ALTER TABLE [dbo].[mc_teacher_class_rel]  WITH CHECK ADD  CONSTRAINT [mc_teacher_class_foreignKey_class] FOREIGN KEY([classID])
REFERENCES [dbo].[mc_class] ([classID])
GO
ALTER TABLE [dbo].[mc_teacher_class_rel] CHECK CONSTRAINT [mc_teacher_class_foreignKey_class]
GO
/****** Object:  ForeignKey [mc_teacher_class_foreignKey_subject]    Script Date: 08/12/2015 09:37:08 ******/
ALTER TABLE [dbo].[mc_teacher_class_rel]  WITH CHECK ADD  CONSTRAINT [mc_teacher_class_foreignKey_subject] FOREIGN KEY([remark])
REFERENCES [dbo].[mc_subject] ([subID])
GO
ALTER TABLE [dbo].[mc_teacher_class_rel] CHECK CONSTRAINT [mc_teacher_class_foreignKey_subject]
GO
/****** Object:  ForeignKey [mc_teacher_class_foreignKey_teacher]    Script Date: 08/12/2015 09:37:08 ******/
ALTER TABLE [dbo].[mc_teacher_class_rel]  WITH CHECK ADD  CONSTRAINT [mc_teacher_class_foreignKey_teacher] FOREIGN KEY([teacherID])
REFERENCES [dbo].[mc_user] ([userID])
GO
ALTER TABLE [dbo].[mc_teacher_class_rel] CHECK CONSTRAINT [mc_teacher_class_foreignKey_teacher]
GO

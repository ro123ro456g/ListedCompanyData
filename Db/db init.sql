USE [master]
GO
/****** Object:  Database [ListedCompanyData]    Script Date: 2024/5/27 下午 09:50:12 ******/
CREATE DATABASE [ListedCompanyData]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ListedCompanyData', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ListedCompanyData.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ListedCompanyData_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ListedCompanyData_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ListedCompanyData] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ListedCompanyData].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ListedCompanyData] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ListedCompanyData] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ListedCompanyData] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ListedCompanyData] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ListedCompanyData] SET ARITHABORT OFF 
GO
ALTER DATABASE [ListedCompanyData] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ListedCompanyData] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ListedCompanyData] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ListedCompanyData] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ListedCompanyData] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ListedCompanyData] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ListedCompanyData] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ListedCompanyData] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ListedCompanyData] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ListedCompanyData] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ListedCompanyData] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ListedCompanyData] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ListedCompanyData] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ListedCompanyData] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ListedCompanyData] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ListedCompanyData] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ListedCompanyData] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ListedCompanyData] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ListedCompanyData] SET  MULTI_USER 
GO
ALTER DATABASE [ListedCompanyData] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ListedCompanyData] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ListedCompanyData] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ListedCompanyData] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ListedCompanyData] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ListedCompanyData] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ListedCompanyData] SET QUERY_STORE = OFF
GO
USE [ListedCompanyData]
GO
/****** Object:  Table [dbo].[CompanyBasic]    Script Date: 2024/5/27 下午 09:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyBasic](
	[CompanyId] [varchar](50) NOT NULL,
	[CompanyName] [nvarchar](200) NULL,
	[Noted] [nvarchar](1000) NULL,
	[IndustryCategoryId] [int] NOT NULL,
 CONSTRAINT [PK_CompanyBasic] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyIndustryCategory]    Script Date: 2024/5/27 下午 09:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyIndustryCategory](
	[IndustryCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NULL,
 CONSTRAINT [PK_CompanyIndustryCategory] PRIMARY KEY CLUSTERED 
(
	[IndustryCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SummaryMonthlyIncome]    Script Date: 2024/5/27 下午 09:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SummaryMonthlyIncome](
	[CompanyId] [varchar](6) NOT NULL,
	[DataDatetime] [date] NOT NULL,
	[OperatingIncomeCurrentMonth] [decimal](18, 0) NULL,
	[OperatingIncomeLastMonth] [decimal](18, 0) NULL,
	[OperatingIncomeLastYearCurrentMonth] [decimal](18, 0) NULL,
	[OperatingIncomeComparativeLastMonth] [decimal](12, 7) NULL,
	[OperatingIncomeComparativeLastYearCurrentMonth] [decimal](12, 7) NULL,
	[CumulativeOperatingIncomeCurrentMonth] [decimal](18, 0) NULL,
	[CumulativeOperatingIncomeLastYearCurrentMonth] [decimal](18, 0) NULL,
	[CumulativeOperatingIncomeComparative] [decimal](12, 7) NULL,
	[Note] [nvarchar](1000) NULL,
 CONSTRAINT [PK_SummaryMonthlyIncome] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC,
	[DataDatetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[CompanyBasic] ([CompanyId], [CompanyName], [Noted], [IndustryCategoryId]) VALUES (N'001001', N'測試公司', N'Test', 2)
GO
SET IDENTITY_INSERT [dbo].[CompanyIndustryCategory] ON 
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (2, N'水泥工業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (3, N'食品工業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (4, N'塑膠工業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (5, N'建材營造')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (6, N'汽車工業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (7, N'其他')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (8, N'紡織纖維')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (9, N'運動休閒')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (10, N'電子零組件業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (11, N'電機機械')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (12, N'電器電纜')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (13, N'生技醫療業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (14, N'化學工業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (15, N'玻璃陶瓷')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (16, N'造紙工業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (17, N'鋼鐵工業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (18, N'居家生活')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (19, N'橡膠工業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (20, N'航運業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (21, N'電腦及週邊設備業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (22, N'半導體業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (23, N'其他電子業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (24, N'通信網路業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (25, N'光電業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (26, N'電子通路業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (27, N'資訊服務業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (28, N'貿易百貨')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (29, N'油電燃氣業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (30, N'觀光餐旅')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (31, N'金融保險業')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (32, N'數位雲端')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (33, N'綠能環保')
GO
INSERT [dbo].[CompanyIndustryCategory] ([IndustryCategoryId], [Name]) VALUES (34, N'存託憑證')
GO
SET IDENTITY_INSERT [dbo].[CompanyIndustryCategory] OFF
GO
/****** Object:  StoredProcedure [dbo].[GetSummaryMonthlyIncome]    Script Date: 2024/5/27 下午 09:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetSummaryMonthlyIncome]
    @DataDatetime DATE
AS
BEGIN
	SELECT smi.*, 
		cb.CompanyName,
		cb.IndustryCategoryId,
		cic.Name AS IndustryCategoryName
	FROM [dbo].[SummaryMonthlyIncome] AS smi
	LEFT JOIN [dbo].[CompanyBasic] AS cb
		ON smi.CompanyId = cb.CompanyId
	LEFT JOIN [dbo].[CompanyIndustryCategory] AS cic
		ON cb.IndustryCategoryId = cic.IndustryCategoryId
	WHERE smi.DataDatetime = @DataDatetime
END
GO
/****** Object:  StoredProcedure [dbo].[InsertCompanyBasic]    Script Date: 2024/5/27 下午 09:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[InsertCompanyBasic]
	@CompanyId VARCHAR(6),
    @CompanyName NVARCHAR(200),
    @Noted NVARCHAR(1000),
    @IndustryCategoryId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @IsCategoryExist BIT

	--判斷產業別是否存在 存在才能新增
	SELECT @IsCategoryExist = 1
	FROM [dbo].[CompanyIndustryCategory]
	WHERE IndustryCategoryId = @IndustryCategoryId

	IF @IsCategoryExist = 1
	BEGIN
		INSERT INTO [dbo].[CompanyBasic] 
		(
			[CompanyId], 
			[CompanyName], 
			[Noted], 
			[IndustryCategoryId]
		)
		VALUES 
		(
			@CompanyId, 
			@CompanyName, 
			@Noted, 
			@IndustryCategoryId
		);
		RETURN 1;
	END
	ELSE
		RETURN 0;
END
GO
/****** Object:  StoredProcedure [dbo].[InsertSummaryMonthlyIncome]    Script Date: 2024/5/27 下午 09:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[InsertSummaryMonthlyIncome]
    @CompanyId VARCHAR(6),
    @DataDatetime DATE,
    @OperatingIncomeCurrentMonth DECIMAL(18, 0),
    @OperatingIncomeLastMonth DECIMAL(18, 0),
    @OperatingIncomeLastYearCurrentMonth DECIMAL(18, 0),
    @OperatingIncomeComparativeLastMonth DECIMAL(12, 7),
    @OperatingIncomeComparativeLastYearCurrentMonth DECIMAL(12, 7),
    @CumulativeOperatingIncomeCurrentMonth DECIMAL(18, 0),
    @CumulativeOperatingIncomeLastYearCurrentMonth DECIMAL(18, 0),
    @CumulativeOperatingIncomeComparative DECIMAL(12, 7),
    @Note NVARCHAR(1000)
AS
BEGIN
    SET NOCOUNT ON;
	
	DECLARE @IsCompanyExist BIT

	--判斷公司是否存在
	SELECT @IsCompanyExist = 1
	FROM [dbo].[CompanyBasic]
	WHERE CompanyId = @CompanyId

	IF @IsCompanyExist = 1
	BEGIN
		INSERT INTO [dbo].[SummaryMonthlyIncome]
		(
			CompanyId,
			DataDatetime,
			OperatingIncomeCurrentMonth,
			OperatingIncomeLastMonth,
			OperatingIncomeLastYearCurrentMonth,
			OperatingIncomeComparativeLastMonth,
			OperatingIncomeComparativeLastYearCurrentMonth,
			CumulativeOperatingIncomeCurrentMonth,
			CumulativeOperatingIncomeLastYearCurrentMonth,
			CumulativeOperatingIncomeComparative,
			Note
		)
		VALUES
		(
			@CompanyId,
			@DataDatetime,
			@OperatingIncomeCurrentMonth,
			@OperatingIncomeLastMonth,
			@OperatingIncomeLastYearCurrentMonth,
			@OperatingIncomeComparativeLastMonth,
			@OperatingIncomeComparativeLastYearCurrentMonth,
			@CumulativeOperatingIncomeCurrentMonth,
			@CumulativeOperatingIncomeLastYearCurrentMonth,
			@CumulativeOperatingIncomeComparative,
			@Note
		);
		SELECT 1;
	END
	ELSE
		SELECT 0;
END
GO
USE [master]
GO
ALTER DATABASE [ListedCompanyData] SET  READ_WRITE 
GO

USE [master]
GO
/****** Object:  Database [Dharmesh]    Script Date: 5/27/2022 10:24:40 AM ******/
CREATE DATABASE [Dharmesh]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Dharmesh', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Dharmesh.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Dharmesh_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Dharmesh_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Dharmesh] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Dharmesh].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Dharmesh] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Dharmesh] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Dharmesh] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Dharmesh] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Dharmesh] SET ARITHABORT OFF 
GO
ALTER DATABASE [Dharmesh] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Dharmesh] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Dharmesh] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Dharmesh] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Dharmesh] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Dharmesh] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Dharmesh] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Dharmesh] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Dharmesh] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Dharmesh] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Dharmesh] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Dharmesh] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Dharmesh] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Dharmesh] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Dharmesh] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Dharmesh] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Dharmesh] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Dharmesh] SET RECOVERY FULL 
GO
ALTER DATABASE [Dharmesh] SET  MULTI_USER 
GO
ALTER DATABASE [Dharmesh] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Dharmesh] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Dharmesh] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Dharmesh] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Dharmesh] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Dharmesh', N'ON'
GO
ALTER DATABASE [Dharmesh] SET QUERY_STORE = OFF
GO
USE [Dharmesh]
GO
/****** Object:  Table [dbo].[CompanyMaster]    Script Date: 5/27/2022 10:24:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Status] [smallint] NULL,
 CONSTRAINT [PK_CompanyMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileMaster]    Script Date: 5/27/2022 10:24:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FileContentType] [nvarchar](50) NULL,
	[FileName] [nvarchar](50) NULL,
	[FileContent] [varbinary](max) NULL,
	[CompanyId] [int] NULL,
 CONSTRAINT [PK_FileMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileMaster]  WITH CHECK ADD  CONSTRAINT [FK_FileMaster_CompanyMaster] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[CompanyMaster] ([Id])
GO
ALTER TABLE [dbo].[FileMaster] CHECK CONSTRAINT [FK_FileMaster_CompanyMaster]
GO
/****** Object:  StoredProcedure [dbo].[getCompanyMasterDetails]    Script Date: 5/27/2022 10:24:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getCompanyMasterDetails] 
As
select id, Name, (case when Status = 1 then 'Reject' when 0 =Status  OR Status IS NULL then 'Approve' END) as status  from CompanyMaster
GO
/****** Object:  StoredProcedure [dbo].[insertCompanyAndFileMaster]    Script Date: 5/27/2022 10:24:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[insertCompanyAndFileMaster] 
(
@filename nvarchar(50),
@file varbinary(Max),
@fileContentType nvarchar(50),
@fileNameWithExtension nvarchar(50)
) 
As
SET NOCOUNT ON;
declare @companyId int;
insert into CompanyMaster (Name,Status)
 values(@fileName,null);
 SELECT  @companyId =  SCOPE_IDENTITY();
 select @companyId
 insert into FileMaster (FileContentType,FileName,FileContent,companyId)
 values(@fileContentType,@fileNameWithExtension,@file,@companyId);
 

GO
/****** Object:  StoredProcedure [dbo].[UpdateStatus]    Script Date: 5/27/2022 10:24:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[UpdateStatus] 
(
@CompanyID int,
@Active int
) 
As
update CompanyMaster set status=@Active where Id= @CompanyID
GO
USE [master]
GO
ALTER DATABASE [Dharmesh] SET  READ_WRITE 
GO

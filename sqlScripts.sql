USE [PayrollDB]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 9/12/2021 11:13:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Name] [nvarchar](500) NULL,
	[JobTitleId] [int] NULL,
	[Duration] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobTitle]    Script Date: 9/12/2021 11:13:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobTitle](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[Salary] [decimal](18, 2) NULL,
 CONSTRAINT [PK_JobTitle] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([AutoID], [Code], [Name], [JobTitleId], [Duration]) VALUES (3, N'1', N'dsd', 3, CAST(2.00 AS Decimal(18, 2)))
INSERT [dbo].[Employee] ([AutoID], [Code], [Name], [JobTitleId], [Duration]) VALUES (4, N'2', N'dd', 8, CAST(3.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[JobTitle] ON 

INSERT [dbo].[JobTitle] ([AutoID], [Code], [Description], [Salary]) VALUES (3, N'12', N'manager', CAST(3000.00 AS Decimal(18, 2)))
INSERT [dbo].[JobTitle] ([AutoID], [Code], [Description], [Salary]) VALUES (7, N'11', N'ddf', CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[JobTitle] ([AutoID], [Code], [Description], [Salary]) VALUES (8, N'10', N'ewqe', CAST(200.00 AS Decimal(18, 2)))
INSERT [dbo].[JobTitle] ([AutoID], [Code], [Description], [Salary]) VALUES (9, N'13', N'dfdf', CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[JobTitle] ([AutoID], [Code], [Description], [Salary]) VALUES (11, N'14', N'dfds', CAST(10.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[JobTitle] OFF
GO
/****** Object:  StoredProcedure [dbo].[SP_Employee]    Script Date: 9/12/2021 11:13:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Employee]
@Operation varchar(200)=null,
@AutoID int=null,
@Code varchar(50)=null, 
@Name nvarchar(500)=null,
@Duration decimal(18,2)=null,
@JobTitleID int=null
AS
BEGIN--main
	if @Operation = 'Save'
	begin--Save
	IF EXISTS(select AutoID from Employee where AutoID = @AutoID)
	begin -- exists
		update Employee
		set
			[Code]			= @Code
			,Name	= @Name
			,Duration		= @Duration
			,JobTitleId		= @JobTitleID
		where AutoID = @AutoID;
		select @AutoID;
	end --exists
	else
	begin --not exists
		insert into Employee
			(
			[Code]
			,Name
			,Duration
			,JobTitleId
			)
		values
			(
			@Code
			,@Name
			,@Duration
			,@JobTitleID
			)
		select SCOPE_IDENTITY();
	end--not exists
	end--Save

	else if @Operation = 'Delete'
	begin--delete
		delete from Employee where AutoID=@AutoID
	end--delete
	
	else if @Operation='IsExists'
	begin --isexists
		if ((select code from Employee where code = @Code and AutoID <> @AutoID) = @Code)
		begin
			select 1;
		end
		else
		begin
			select 0;
		end
	end--isexists

	else if @Operation = 'selectAll'
	begin --selectall
		select Employee.*,JobTitle.Description JobTitle from Employee left join JobTitle on Employee.JobTitleId = JobTitle.AutoID order by Employee.AutoID desc
	end--selectall

	else if @Operation = 'selectOne'
	begin--selectOne
		select * from Employee where Code=@Code
	end--selectOne

	else if @Operation = 'Payroll'
	begin--payroll
		declare @no_of_year int;
		declare @salary decimal(18,2);
		declare @wages_per_hr decimal(18,2);
		declare @totalSalary decimal(18,2);
		declare @Basic decimal(18,2);
		declare @Housing decimal(18,2);
		declare @Transport decimal(18,2);
		declare @TaxableAmt decimal(18,2)=0;
		declare @Tax decimal(18,2)=0;
			select @no_of_year = cast(e.Duration as int) , @salary = j.Salary from Employee e
				inner join JobTitle j on e.JobTitleId=j.AutoID
			where e.AutoID = @AutoID
		DECLARE @cnt INT;
		set @cnt = 2;
		set @wages_per_hr = @salary;
		WHILE @cnt <= @no_of_year
		BEGIN
		   SET @cnt = @cnt + 1;
		   set @wages_per_hr = @wages_per_hr + @wages_per_hr * 10 / 100;
		END
		set @totalSalary = @wages_per_hr * @Duration;
		set @Basic = @totalSalary * 64/100;
		set @Housing = @totalSalary * 24/100;
		set @Transport = @totalSalary * 12/100;

		if(@Basic> 1000)
		begin -->1000
			set @TaxableAmt = @Basic-1000;
			set @Tax = @TaxableAmt * 30/100;
		end-->1000
		
		select e.*,j.Code JobCode, j.Description,j.Salary, @totalSalary TotalSalary, @wages_per_hr WagesPerHour, @Duration WorkingHours,
		@Basic BasicSalary, @Housing Housing, @Transport Transport, @TaxableAmt TaxableAmt, @Tax tax		
		from Employee e
				inner join JobTitle j on e.JobTitleId=j.AutoID
			where e.AutoID = @AutoID
	end--payroll
END--main
GO
/****** Object:  StoredProcedure [dbo].[SP_JobTitle]    Script Date: 9/12/2021 11:13:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_JobTitle]
@Operation varchar(200)=null,
@AutoID int=null,
@Code varchar(50)=null, 
@Description nvarchar(500)=null,
@Salary decimal(18,2)=null
AS
BEGIN--main
	if @Operation = 'Save'
	begin--Save
	IF EXISTS(select AutoID from JobTitle where AutoID = @AutoID)
	begin -- exists
		update JobTitle
		set
			[Code]			= @Code
			,[Description]	= @Description
			,[Salary]		= @Salary
		where AutoID = @AutoID;
		select @AutoID;
	end --exists
	else
	begin --not exists
		insert into JobTitle
			(
			[Code]
			,[Description]
			,[Salary]
			)
		values
			(
			@Code
			,@Description
			,@Salary
			)
		select SCOPE_IDENTITY();
	end--not exists
	end--Save
	else if @Operation = 'Delete'
	begin--delete
		delete from JobTitle where AutoID=@AutoID
	end--delete
	else if @Operation='IsExists'
	begin --isexists
		if ((select code from JobTitle where code = @Code and AutoID <> @AutoID) = @Code)
		begin
			select 1;
		end
		else
		begin
			select 0;
		end
	end--isexists
	else if @Operation = 'selectAll'
	begin --selectall
		select * from JobTitle order by AutoID desc
	end--selectall
	else if @Operation = 'selectOne'
	begin--selectOne
		select * from JobTitle where Code=@Code
	end--selectOne
END--main
GO
/****** Object:  StoredProcedure [dbo].[SP_PaySlip]    Script Date: 9/12/2021 11:13:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PaySlip]
@AutoID int=null,
@Duration decimal(18,2)=null
AS
BEGIN--main
		declare @no_of_year int;
		declare @salary decimal(18,2);
		declare @wages_per_hr decimal(18,2);
		declare @totalSalary decimal(18,2);
		declare @Basic decimal(18,2);
		declare @Housing decimal(18,2);
		declare @Transport decimal(18,2);
		declare @TaxableAmt decimal(18,2)=0;
		declare @Tax decimal(18,2)=0;
			select @no_of_year = cast(e.Duration as int) , @salary = j.Salary from Employee e
				inner join JobTitle j on e.JobTitleId=j.AutoID
			where e.AutoID = @AutoID
		DECLARE @cnt INT;
		set @cnt = 2;
		set @wages_per_hr = @salary;
		WHILE @cnt <= @no_of_year
		BEGIN
		   SET @cnt = @cnt + 1;
		   set @wages_per_hr = @wages_per_hr + @wages_per_hr * 10 / 100;
		END
		set @totalSalary = @wages_per_hr * @Duration;
		set @Basic = @totalSalary * 64/100;
		set @Housing = @totalSalary * 24/100;
		set @Transport = @totalSalary * 12/100;

		if(@Basic> 1000)
		begin -->1000
			set @TaxableAmt = @Basic-1000;
			set @Tax = @TaxableAmt * 30/100;
		end-->1000
		
		select e.*,j.Code JobCode, j.Description,j.Salary, @totalSalary TotalSalary, @wages_per_hr WagesPerHour, @Duration WorkingHours,
		@Basic BasicSalary, @Housing Housing, @Transport Transport, @TaxableAmt TaxableAmt, @Tax tax		
		from Employee e
				inner join JobTitle j on e.JobTitleId=j.AutoID
			where e.AutoID = @AutoID
END--main
GO

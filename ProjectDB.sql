USE [ProjectDB]
GO
/****** Object:  Table [dbo].[Encryption]    Script Date: 2025/03/27 09:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Encryption](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[epocString] [varchar](255) NOT NULL,
	[key] [varbinary](max) NOT NULL,
	[iv] [varbinary](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2025/03/27 09:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](255) NOT NULL,
	[UserName] [varchar](255) NOT NULL,
	[UserToken] [text] NOT NULL,
	[Epoc] [varchar](255) NOT NULL,
	[DateTouched] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsersProfile]    Script Date: 2025/03/27 09:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersProfile](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](255) NOT NULL,
	[Usersname] [varchar](255) NOT NULL,
	[Password] [text] NOT NULL,
	[EmailAddress] [varchar](255) NOT NULL,
	[ContactNumber] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [DateTouched]
GO
ALTER TABLE [dbo].[UsersProfile]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
/****** Object:  StoredProcedure [dbo].[DeleteAllUsers]    Script Date: 2025/03/27 09:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteAllUsers]
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM [dbo].[users];
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteUserByUsername]    Script Date: 2025/03/27 09:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUserByUsername]
    @UserId VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM [dbo].[users] WHERE UserId = @UserId;
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 2025/03/27 09:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllUsers]
    @Offset INT,
    @FetchRows INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM [dbo].[users]
	ORDER BY id ASC
	OFFSET @Offset ROWS
    FETCH NEXT @FetchRows ROWS ONLY;
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserByUserId]    Script Date: 2025/03/27 09:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserByUserId]
    @UserId VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[users] WHERE UserId = @UserId;
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserByUserName]    Script Date: 2025/03/27 09:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserByUserName]
    @UserName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[users] WHERE UserName = @UserName;
END

GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 2025/03/27 09:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUser]
	@UserId VARCHAR(50),
    @UserName VARCHAR(50),
    @UserToken VARCHAR(MAX),
    @Epoc VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[users] (UserId, UserName, UserToken, Epoc, DateTouched)
    VALUES (@UserId, @UserName, @UserToken, @Epoc, GETDATE());
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateUserByUserId]    Script Date: 2025/03/27 09:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateUserByUserId]
    @UserId VARCHAR(50),
    @UserName VARCHAR(50),
    @UserToken VARCHAR(MAX),
    @Epoc VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[users]
    SET UserName = @UserName, UserToken = @UserToken, Epoc = @Epoc, DateTouched = GETDATE()
    WHERE UserId = @UserId;
END

GO

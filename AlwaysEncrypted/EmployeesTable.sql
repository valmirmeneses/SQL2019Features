CREATE TABLE [HumanResources].[Employees]
(
    [EmployeeID] [int] IDENTITY(1,1) NOT NULL
    , [SSN] [char](11) NOT NULL
    , [FirstName] [nvarchar](50) NOT NULL
    , [LastName] [nvarchar](50) NOT NULL
    , [Salary] [money] NOT NULL
) ON [PRIMARY];

INSERT INTO [HumanResources].[Employees]
(
    [SSN]
    , [FirstName]
    , [LastName]
    , [Salary]
)
VALUES
(
    '795-73-9838'
    , N'Catherine'
    , N'Abel'
    , $31692
);

INSERT INTO [HumanResources].[Employees]
(
    [SSN]
    , [FirstName]
    , [LastName]
    , [Salary]
)
VALUES
(
    '990-00-6818'
    , N'Kim'
    , N'Abercrombie'
    , $55415
);
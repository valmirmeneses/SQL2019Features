USE [AdventureWorks]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--Create Schema RowLevelSecurity
CREATE OR ALTER FUNCTION RowLevelSecurity.udf_BusinessEntityID (@BusinessEntityID int)
RETURNS TABLE WITH SCHEMABINDING
AS 
RETURN (
	Select 1 Result
    From Sales.SalesOrderHeader as s 
    INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
    INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
    where e.BusinessEntityID=@BusinessEntityID and m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
    UNION
    --- Return all online orders for the VP of Sales when he is online
    Select 1 Result
    From Sales.SalesOrderHeader as s 
    CROSS JOIN [HumanResources].[Employee] e 
    WHERE e.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS  --- If VP of Sales is querying
    AND e.OrganizationLevel=1 ----VP of Sales
    and s.OnlineOrderFlag=1 ---- online orders
	
)

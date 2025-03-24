
Use  AdventureWorks

/*
brian3 - VP of sales
amy0 -  European Sales Manager
jae0 - Sales Representative 
rachel0
ranjit0
*/

Execute as user = 'amy0'
Select e.LoginID
	,Count(*) TotalOrders
	, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
RIGHT JOIN sys.database_principals dp on 'adventure-works\'+dp.name COLLATE SQL_Latin1_General_CP1_CI_AS= m.loginid --- This will filter the users created previously for GB Territory
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
group by  e.LoginID
REVERT

Execute as user = 'amy0'
Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
Where e.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
REVERT

Execute as user = 'jae0'
Select e.LoginID
	,Count(*) TotalOrders
	, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
--INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
--where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
group by  e.LoginID
REVERT

Execute as user = 'amy0'
Select e.LoginID
	,Count(*) TotalOrders
	, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
--where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
group by  e.LoginID
REVERT


Execute as user = 'amy0'
Select m.LoginID
    , e.LoginID
    , s.*
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
INNER JOIN sys.database_principals dp  on 'adventure-works\'+dp.name COLLATE SQL_Latin1_General_CP1_CI_AS= e.loginid --- This will filter the users created previously
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
REVERT

Execute as user = 'jae0'

Select m.LoginID
    , e.LoginID
    , s.*
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
REVERT

Execute as user = 'jae0'
Select e.LoginID, Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
Group by e.LoginID
REVERT

Execute as user = 'brian3'
    Select e.LoginID, Count(*) TotalOrders, Sum(SubTotal) SubTotal
    From Sales.SalesOrderHeader as s 
    CROSS JOIN [HumanResources].[Employee] e 
    WHERE e.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
    AND e.OrganizationLevel=1
    and s.OnlineOrderFlag=1
	Group by e.LoginID
revert

Use  AdventureWorks
Go
Execute as user = 'jae0'
Select e.LoginID, Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
where e.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
Group by e.LoginID
REVERT

Execute as user = 'amy0'
Select e.LoginID
	,Count(*) TotalOrders
	, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
RIGHT JOIN sys.database_principals dp on 'adventure-works\'+dp.name COLLATE SQL_Latin1_General_CP1_CI_AS= m.loginid --- This will filter the users created previously for GB Territory
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
group by  e.LoginID
REVERT

Use  AdventureWorks
Go
Execute as user = 'amy0'
Select e.LoginID
	,Count(*) TotalOrders
	, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1  --- This will bring Amy's team's orders as well as hers
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
group by  e.LoginID WITH ROLLUP
REVERT


Use  AdventureWorks
Go
Execute as user = 'jae0'
Select e.LoginID, Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
where e.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS --- This will filter only the orders for the user
Group by e.LoginID
REVERT

Execute as user = 'amy0'
Select Count(*) TotalOrders
	, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
RIGHT JOIN sys.database_principals dp on 'adventure-works\'+dp.name COLLATE SQL_Latin1_General_CP1_CI_AS= m.loginid --- This will filter the users created previously for GB Territory
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
REVERT

Execute as user = 'amy0'
Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN (
    --- Return order headers belonging to a salesperson or their direct reports
    Select s.SalesOrderID
    From Sales.SalesOrderHeader as s 
    INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
    INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
    where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
    --UNION
    --- Return all online orders for the VP of sales
	/*
    Select s.SalesOrderID
    From Sales.SalesOrderHeader as s 
    CROSS JOIN [HumanResources].[Employee] e 
    WHERE e.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
    AND e.OrganizationLevel=1
    and s.OnlineOrderFlag=1
	*/
) sf
ON sf.SalesOrderID = s.SalesOrderID
REVERT

Execute as user = 'jae0'

Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
CROSS APPLY (
    --- Return order headers belonging to a salesperson or their direct reports
    Select 1 Result
    From Sales.SalesOrderHeader as s 
    INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
    INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
    where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
    UNION
    --- Return all online orders for the VP of sales
    Select 1 Result
    From Sales.SalesOrderHeader as s 
    CROSS JOIN [HumanResources].[Employee] e 
    WHERE e.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
    AND e.OrganizationLevel=1
    and s.OnlineOrderFlag=1
) sf

REVERT

--- Now testing the function 
Execute as user = 'jae0'

Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
CROSS APPLY RowLevelSecurity.udf_BusinessEntityID(s.SalesPersonID  p

REVERT



Execute as user = 'amy0'  --- Jae's manager
Select m.LoginID
    , e.LoginID
    , s.*
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
REVERT

Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
REVERT


Execute as user = 'brian3' --- VP of Sales
Select m.LoginID
    , e.LoginID
    , s.*
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
REVERT

Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
REVERT

Execute as user = 'brian3'

Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN (
    --- Return order headers belonging to a salesperson or their direct reports
    Select s.SalesOrderID
    From Sales.SalesOrderHeader as s 
    INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
    INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
    where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
    UNION
    --- Return all online orders for the VP of sales
    Select s.SalesOrderID
    From Sales.SalesOrderHeader as s 
    CROSS JOIN [HumanResources].[Employee] e 
    WHERE e.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
    AND e.OrganizationLevel=1
    and s.OnlineOrderFlag=1
) sf
ON sf.SalesOrderID = s.SalesOrderID
REVERT
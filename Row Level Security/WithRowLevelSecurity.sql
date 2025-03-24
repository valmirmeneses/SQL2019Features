
Use  AdventureWorks

/*
brian3 - VP of sales
amy0 -  European Sales Manager
jae0 - Sales Representative 
rachel0
ranjit0
*/
Execute as user = 'jae0'

Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
REVERT
Execute as user = 'jae0'

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
CROSS APPLY RowLevelSecurity.udf_BusinessEntityID(s.SalesPersonID)  p
REVERT

Execute as user = 'rachel0'
Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
CROSS APPLY RowLevelSecurity.udf_BusinessEntityID(s.SalesPersonID)  p
REVERT

Execute as user = 'ranjit0'
Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
CROSS APPLY RowLevelSecurity.udf_BusinessEntityID(s.SalesPersonID)  p
REVERT

Execute as user = 'amy0'
Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
CROSS APPLY RowLevelSecurity.udf_BusinessEntityID(s.SalesPersonID)  p
REVERT

Execute as user = 'brian3'
Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
CROSS APPLY RowLevelSecurity.udf_BusinessEntityID(s.SalesPersonID)  p
REVERT

/*
adventure-works\amy0      39          732759.1841
adventure-works\david8    189         3729945.349
adventure-works\garrett1  234         3609447.2148
adventure-works\jae0      348         8503338.6457
adventure-works\jillian0  473         10065803.5404
adventure-works\josé1     271         5926418.3555
adventure-works\linda3    418         10367007.4265
adventure-works\lynn0     109         1421810.9242
adventure-works\michael9  450         9293903.0046
adventure-works\pamela0   95          3325102.5941
adventure-works\rachel0   130         1827066.7118
adventure-works\ranjit0   175         4509888.9311
adventure-works\shu0      242         6427005.554
adventure-works\stephen0  48          1092123.8561
adventure-works\syed0     16          172524.4512
adventure-works\tete0     140         2312545.69
adventure-works\tsvi0     429         7171012.7501
NULL                      3806        80487704.1832
*/
--- Now testing the function 
Execute as user = 'brian3'
Select Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
CROSS APPLY RowLevelSecurity.udf_BusinessEntityID(s.SalesPersonID)  p
REVERT

Execute as user = 'brian3'
Select substring(e.LoginID,1,25) as LoginId
	,Count(*) TotalOrders
	, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1  --- This will bring Amy's team's orders as well as hers
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
group by  e.LoginID WITH ROLLUP

REVERT

Execute as user = 'jae0'
Select e.LoginID
	,Count(*) TotalOrders
	, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1  --- This will bring Amy's team's orders as well as hers
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
group by  e.LoginID WITH ROLLUP
REVERT

Execute as user = 'jae0'
Select  s.SalesPersonID,Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
where s.SalesPersonID=289
group by s.SalesPersonID
REVERT
Execute as user = 'jae0'
	Select 1 Result
    From Sales.SalesOrderHeader as s 
    INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
    INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
    where e.BusinessEntityID=s.SalesPersonID 
	and m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
REVERT
Execute as user = 'amy0'
Select  Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
CROSS APPLY RowLevelSecurity.udf_BusinessEntityID(s.SalesPersonID)  p
REVERT

Execute as user = 'jae0'
Select e.LoginID	,Count(*) TotalOrders 	, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1  --- This will bring Amy's team's orders as well as hers
where m.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
group by  e.LoginID
Select e.LoginID, Count(*) TotalOrders, Sum(SubTotal) SubTotal
From Sales.SalesOrderHeader as s 
INNER JOIN [HumanResources].[Employee] e on (s.SalesPersonID= e.BusinessEntityID)
where e.LoginID='adventure-works\'+User_name() COLLATE SQL_Latin1_General_CP1_CI_AS
Group by e.LoginID
REVERT

Select * from RowLevelSecurity.udf_BusinessEntityID(289)


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
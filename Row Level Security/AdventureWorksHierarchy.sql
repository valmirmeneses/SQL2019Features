Select e.BusinessEntityID
    ,e.JobTitle
    ,e.OrganizationLevel OrgLevel
    ,m.LoginID ManagerLoginID
from [HumanResources].[Employee] e  
INNER JOIN [HumanResources].[Employee] m on e.OrganizationNode.IsDescendantOf(m.OrganizationNode)=1
where e.LoginID='adventure-works\ken0' COLLATE SQL_Latin1_General_CP1_CI_AS
order by e.OrganizationLevel, m.LoginID


SELECT e.[BusinessEntityID]
	  ,e.[LoginID]
      ,e.[OrganizationLevel]
      ,e.[JobTitle]
	  ,m.LoginID as manager
  FROM [AdventureWorks].[HumanResources].[Employee] e
  inner join sys.database_principals dp  on 'adventure-works\'+dp.name COLLATE SQL_Latin1_General_CP1_CI_AS= e.loginid
  Left outer JOIN [HumanResources].[Employee] m on e.OrganizationNode.GetAncestor(1)=m.OrganizationNode
  order by e.[OrganizationLevel], e.LoginID
  


/*
amy0                                                                                                                             287              European Sales Manager                             2                 adventure-works\brian3
jae0                                                                                                                             289              Sales Representative                               3                 adventure-works\amy0
rachel0                                                                                                                          288              Sales Representative                               3                 adventure-works\amy0
ranjit0                                                                                                                          290              Sales Representative                               3                 adventure-works\amy0


*/
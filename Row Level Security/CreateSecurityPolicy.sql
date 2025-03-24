
-- Check if the security policy exists
IF EXISTS (SELECT * FROM sys.security_policies WHERE name = 'secpolBusinessEntityID')
BEGIN
    -- Drop the existing security policy
    DROP SECURITY POLICY secpolBusinessEntityID
END

-- Create or alter the security policy with a filter predicate
CREATE SECURITY POLICY RowLevelSecurity.secpolBusinessEntityID
ADD FILTER PREDICATE RowLevelSecurity.udf_BusinessEntityID(SalesPersonID) ON Sales.SalesOrderHeader
GO

/*
--- Recreate it adding block predicate
DROP SECURITY POLICY RowLevelSecurity.secpolBusinessEntityID
GO
CREATE SECURITY POLICY RowLevelSecurity.secpolBusinessEntityID
ADD FILTER PREDICATE RowLevelSecurity.udf_BusinessEntityID(SalesPersonID) ON Sales.SalesOrderHeader,
ADD BLOCK PREDICATE RowLevelSecurity.udf_BusinessEntityID(SalesPersonID) ON Sales.SalesOrderHeader   ---- NO CRUD
*/

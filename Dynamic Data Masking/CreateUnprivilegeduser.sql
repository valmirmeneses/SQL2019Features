-- Create a login for the user
CREATE LOGIN unprivilegeduser
WITH PASSWORD = 'Unpr1v1l3g3d';

-- Create a user in the AdventureWorks database
USE AdventureWorks;
CREATE USER unprivilegeduser
FOR LOGIN unprivilegeduser;

-- Grant necessary permissions to the user
-- Adjust the permissions as needed for your specific requirements
EXEC sp_addrolemember N'db_datareader', N'unprivilegeduser';
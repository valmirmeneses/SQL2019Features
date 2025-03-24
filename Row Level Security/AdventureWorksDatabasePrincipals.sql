Use  AdventureWorks
go
EXEC sp_configure 'contained database authentication', 1;
RECONFIGURE;
ALTER DATABASE [AdventureWorks] SET CONTAINMENT = PARTIAL WITH NO_WAIT
GO

Use  AdventureWorks
Go
CREATE USER ken0 WITH PASSWORD = 'K3nk3nk3n';
ALTER ROLE db_datareader ADD MEMBER ken0;
ALTER ROLE db_datawriter ADD MEMBER ken0;

CREATE USER brian3 WITH PASSWORD = 'Br1@n3br1@n3';
ALTER ROLE db_datareader ADD MEMBER brian3;
ALTER ROLE db_datawriter ADD MEMBER brian3;

CREATE USER amy0 WITH PASSWORD = 'Am10@m10';
ALTER ROLE db_datareader ADD MEMBER amy0;
ALTER ROLE db_datawriter ADD MEMBER amy0;

CREATE USER jae0 WITH PASSWORD = 'Ja3ja3ja3';
ALTER ROLE db_datareader ADD MEMBER jae0;
ALTER ROLE db_datawriter ADD MEMBER jae0;

CREATE USER rachel0 WITH PASSWORD = 'Rach3lrach3l';
ALTER ROLE db_datareader ADD MEMBER rachel0;
ALTER ROLE db_datawriter ADD MEMBER rachel0;

CREATE USER ranjit0 WITH PASSWORD = 'Ranj1tranj1t';
ALTER ROLE db_datareader ADD MEMBER ranjit0;
ALTER ROLE db_datawriter ADD MEMBER ranjit0;



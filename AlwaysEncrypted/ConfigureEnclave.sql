sp_configure 'column encryption enclave type', 1;  
GO  
RECONFIGURE;  
GO  
USE [master];
GO
SELECT
[value]
, CASE [value] WHEN 0 THEN 'No enclave' WHEN 1 THEN 'VBS' ELSE 'Other' END AS [value_description]
, [value_in_use]
, CASE [value_in_use] WHEN 0 THEN 'No enclave' WHEN 1 THEN 'VBS' ELSE 'Other' END AS [value_in_use_description]
FROM sys.configurations
WHERE [name] = 'column encryption enclave type'; 
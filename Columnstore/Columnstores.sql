USE AdventureWorks
GO
SET STATISTICS IO ON
GO
-- Select Table with regular Index
SELECT ProductID, SUM(UnitPrice) SumUnitPrice, AVG(UnitPrice) AvgUnitPrice,
SUM(OrderQty) SumOrderQty, AVG(OrderQty) AvgOrderQty
FROM [Sales].[BigSalesOrderDetail]
GROUP BY ProductID
ORDER BY ProductID
GO

-- Table 'BigSalesOrderDetail'. Scan count 5, logical reads 346401, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server
-- Create ColumnStore Index
-- DROP INDEX [IX_BigSalesOrderDetail_ColumnStore] ON [Sales].[BigSalesOrderDetail]
CREATE NONCLUSTERED COLUMNSTORE INDEX [IX_BigSalesOrderDetail_ColumnStore]
ON [Sales].[BigSalesOrderDetail]
(UnitPrice, OrderQty, ProductID)
GO
-- Select Table with Columnstore Index
SELECT ProductID, SUM(UnitPrice) SumUnitPrice, AVG(UnitPrice) AvgUnitPrice,
SUM(OrderQty) SumOrderQty, AVG(OrderQty) AvgOrderQty
FROM [Sales].[BigSalesOrderDetail]
GROUP BY ProductID
ORDER BY ProductID
GO
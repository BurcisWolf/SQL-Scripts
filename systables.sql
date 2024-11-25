USE master;
GO
--------------------------------------------
-- INTERESTING System Tables and other stuff
--------------------------------------------

-- The query retrieves all columns and rows from the sys.schemas system view in SQL Server. 
-- This view contains information about all the schemas in the current database
SELECT * FROM sys.schemas

-- The query retrieves all columns and rows from the sys.sysusers system view in SQL Server. 
-- This view contains one row for each user, group, or SQL Server role in the current database
SELECT * FROM sys.sysusers

-- WHO AM I ?
SELECT USER_NAME()

-- The query retrieves all columns and rows from the sys.dm_tran_active_transactions dynamic management view in SQL Server. 
-- This view provides detailed information about active transactions within the SQL Server instance
SELECT * FROM sys.dm_tran_active_transactions	

-- The query retrieves all columns from the sys.dm_tran_current_transaction dynamic management view in SQL Server. 
-- This view returns a single row that displays the state information of the transaction in the current session
SELECT * FROM sys.dm_tran_current_transaction

-- The query retrieves all columns and rows from the sys.dm_tran_session_transactions dynamic management view in SQL Server. 
-- This view provides correlation information for associated transactions and sessions
SELECt * FROM sys.dm_tran_session_transactions	

-- The query retrieves all columns and rows from the sys.dm_tran_database_transactions dynamic management view in SQL Server. 
-- This DMV provides information about transactions at the database leve
SELECT * FROM sys. dm_tran_database_transactions	

-- The query returns the name of the database with database ID 1 in SQL Server.
SELECT DB_NAME(1)

-- The query returns the database ID of the database named 'CS_Sample' in SQL Server.
SELECT DB_ID('CS_Sample') 

-- The query returns the name of the database object with the object ID 32767. 
-- However, this specific object ID is typically associated with a system object in SQL Server.
SELECT OBJECT_NAME(32767)

--The SQL query retrieves information about all currently active lock requests in SQL Server. 
--This query accesses the sys.dm_tran_locks dynamic management view, which provides details on the lock manager resources that are either granted or waiting to be granted
SELECT * FROM sys.dm_tran_locks		

-- The SQL query retrieves information about all tasks currently waiting for resources in SQL Server. 
-- This dynamic management view (DMV) provides detailed insights into the wait queue, helping identify performance bottlenecks and troubleshoot blocking issues
SELECT * FROM sys.dm_os_waiting_tasks

-- The query retrieves information about all processes currently running on a SQL Server instance. This view provides a comprehensive snapshot of system activity, including both user and system processes.
SELECT * FROM sys.sysprocesses 

-- The query retrieves information about all partition schemes defined in a SQL Server database. 
-- The sys.partition_schemes view contains a row for each data space that is a partition scheme, with the type set to "PS" (Partition Scheme).
SELECT * FROM sys.partition_schemes




-- TO DO
SELECT * FROM sys.partition_functions

SELECt * FROM sys.partitions

-- PAGES
DBCC IND ('Tran', 'Aufgabe1_pvt', 1);
DBCC PAGE('CS_Sample',1,401,1) 

-- Scripts
CREATE PROCEDURE ShowTrans
AS 
BEGIN 
SELECT
    [s_tst].[session_id],
    [s_es].[login_name] AS [Login Name],
    DB_NAME (s_tdt.database_id) AS [Database],
    [s_tdt].[database_transaction_begin_time] AS [Begin Time],
    [s_tdt].[database_transaction_log_bytes_used] AS [Log Bytes],
    [s_tdt].[database_transaction_log_bytes_reserved] AS [Log Rsvd],
    [s_est].text AS [Last T-SQL Text],
    [s_eqp].[query_plan] AS [Last Plan]
FROM
    sys.dm_tran_database_transactions [s_tdt]
JOIN sys.dm_tran_session_transactions [s_tst]
	ON [s_tst].[transaction_id] = [s_tdt].[transaction_id]
JOIN sys.dm_exec_sessions [s_es]
	ON [s_es].[session_id] = [s_tst].[session_id]
JOIN sys.dm_exec_connections [s_ec]
	ON [s_ec].[session_id] = [s_tst].[session_id]
LEFT OUTER JOIN sys.dm_exec_requests [s_er]
	ON  [s_er].[session_id] = [s_tst].[session_id]
CROSS APPLY sys.dm_exec_sql_text ([s_ec].[most_recent_sql_handle]) AS [s_est]
OUTER APPLY sys.dm_exec_query_plan ([s_er].[plan_handle]) AS [s_eqp]
ORDER BY [Begin Time] ASC;
END 

GO

-- und testen 
EXEC ShowTrans
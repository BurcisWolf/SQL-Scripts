USE master;
GO

-- INTERESTING System Tables and other stuff

-- SCHEMES in DATABASE
SELECT * FROM sys.schemas

-- USERS in DATABASE
SELECT * FROM sys.sysusers

-- WHO AM I ?
SELECT USER_NAME()


-- NEED TO GO THRU
SELECT * FROM sys.dm_tran_active_transactions		-- transaction_id, name = 'user_transaction'
SELECT * FROM sys.dm_tran_current_transaction		-- transaction_id
SELECt * FROM sys.dm_tran_session_transactions		-- transaction_id, Session_id
SELECT * FROM sys. dm_tran_database_transactions	-- transaction_id, database_id

SELECT DB_NAME(1)
SELECT OBJECT_NAME(32767)

SELECT * FROM sys.dm_tran_locks						-- resource_database_id, request_session_id
SELECT * FROM sys.dm_os_waiting_tasks				-- blocking_session_id

SELECT * FROM sys.sysprocesses 


SELECT * FROM sys.partition_schemes

SELECT * FROM sys.partition_functions

SELECt * FROM sys.partitions

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
----------------------
-- INTERESTING SELECTs
----------------------

-- WHO AM I ?
SELECT USER_NAME();

-- DATE RIGHT NOW
SELECT GETDATE();

-- The query returns the name of the database with database ID 1 in SQL Server.
SELECT DB_NAME(1);

-- The query returns the database ID of the database named 'CS_Sample' in SQL Server.
SELECT DB_ID('CS_Sample');

-- The query returns the name of the database object with the object ID 32767. 
-- However, this specific object ID is typically associated with a system object in SQL Server.
SELECT OBJECT_NAME(32767);

-- Which ID is behind this name
SELECT OBJECT_ID('MeineSicht');

-- The SQL function returns the Transact-SQL source text or definition of the object with the specified object ID (2021582240) in the current database context. 
-- This function is useful for retrieving the full definition of database objects such as stored procedures, functions, views, or triggers
SELECT OBJECT_DEFINITION(770101784);

-- returns the last identity value inserted into an identity column within the current execution scope in SQL Server
SELECT SCOPE_IDENTITY();

-- The SQL statement is used to retrieve the last identity value generated for the specified table, in this case, the Sales.Promotion table.
SELECT IDENT_CURRENT('Sales.Promotion');

-- The SQL command returns the number of active transactions for the current connection
SELECT @@TRANCOUNT

-- The SQL returns the state of the current user transaction in the session. XACT_STATE() is a scalar function that reports one of three possible values
SELECT XACT_STATE();

----------------------------
-- INTERESTING System Tables
----------------------------

-- The SQL query retrieves information about all views in the current database. This command provides detailed metadata for each view
SELECT * FROM sys.views 

-- The SQL query retrieves information about all user-defined, schema-scoped objects within a database
SELECT * FROM sys.objects 

-- The query retrieves all columns and rows from the sys.schemas system view in SQL Server. 
-- This view contains information about all the schemas in the current database
SELECT * FROM sys.schemas

-- The query retrieves all columns and rows from the sys.sysusers system view in SQL Server. 
-- This view contains one row for each user, group, or SQL Server role in the current database
SELECT * FROM sys.sysusers

-- The query retrieves all columns and rows from the sys.sysdepends view in SQL Server. 
-- This view contains dependency information between database objects.
SELECT * FROM sys.sysdepends 

-- The query retrieves detailed metadata about all columns in the current database. 
-- This system view provides a comprehensive list of columns for all user-defined and system-defined tables, views, and other objects that have columns. 
SELECT * FROM sys.all_columns

-- The query retrieves all columns and rows from the sys.dm_tran_active_transactions dynamic management view in SQL Server. 
-- This view provides detailed information about active transactions within the SQL Server instance
SELECT * FROM sys.dm_tran_active_transactions	

-- The query retrieves all columns from the sys.dm_tran_current_transaction dynamic management view in SQL Server. 
-- This view returns a single row that displays the state information of the transaction in the current session
SELECT * FROM sys.dm_tran_current_transaction

-- The query retrieves all columns and rows from the sys.dm_tran_session_transactions dynamic management view in SQL Server. 
-- This view provides correlation information for associated transactions and sessions
SELECT * FROM sys.dm_tran_session_transactions	

-- The query retrieves all columns and rows from the sys.dm_tran_database_transactions dynamic management view in SQL Server. 
-- This DMV provides information about transactions at the database leve
SELECT * FROM sys. dm_tran_database_transactions	

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

-- The query retrieves information about all partitions of tables and most types of indexes in the database. 
SELECT * FROM sys.partitions

-- The query retrieves information about all partition functions in the current database.
SELECT * FROM sys.partition_functions

-- The query retrieves all columns from the sys.trigger_event_types view and orders the results alphabetically by the type_name column. 
-- This view contains information about all events or event groups on which a trigger can fire in SQL Server.
SELECT * FROM sys.trigger_event_types ORDER BY type_name

-- This view contains information about server-level principals, which include: SQL logins, Windows logins, Server roles, Certificates, Asymmetric keys
SELECT * FROM sys.server_principals

-- The SQL query retrieves all columns and rows from the sys.sql_logins catalog view in SQL Server. 
-- This view provides detailed information specifically about SQL Server authentication logins.
SELECT * FROM sys.sql_logins 

-- The SQL query retrieves all columns and rows from the sys.server_role_members catalog view in SQL Server. This view shows the membership of logins in server roles
SELECT * FROM sys.server_role_members

-- The SQL query retrieves all built-in permissions applicable to the SERVER securable class in SQL Server, sorted alphabetically by permission name. 
SELECT * FROM sys.fn_builtin_permissions('SERVER') ORDER BY permission_name;

------------------------
-------- OTHERS --------
------------------------

-- Changing owner of a Database, instead of AdventureWorks2012 we will write the Database we want to change
USE [AdventureWorks2012]            
exec sp_changedbowner 'sa', 'true'

-- Declaring a Variable without initialization
DECLARE @varName int;

-- Declaring a Variable with initialization
DECLARE @varName varchar(20) = 'Hello World';

-- The command will display the definition of the database object named 'MeineSicht' in the current database. 
-- This command is used to view the Transact-SQL source text of various database objects, including views, stored procedures, functions, triggers, and more
EXECUTE sp_helptext 'MeineSicht';

-- The command returns a list of SQL Server fixed server roles along with their descriptions
EXEC sp_helpsrvrole

-- The command returns information about the members of SQL Server fixed server roles. 
-- When executed without parameters, it provides details for all fixed server roles that have at least one member
EXEC sp_helpsrvrolemember

-- The command in SQL Server is used to display the permissions associated with fixed server roles. 
-- When executed, it returns a list of permissions for all fixed server roles or for a specific role if specified. 
EXEC sp_srvrolepermission

-- IS_SRVROLEMEMBER is a SQL Server function that indicates whether a SQL Server login is a member of a specified server role
IF IS_SRVROLEMEMBER('sysadmin') = 1

-------------------------
--------- PAGES ---------
-------------------------

-- The command DBCC TRACEON(3604) is used in SQL Server to enable a specific trace flag that affects how output from certain DBCC 
-- (Database Console Commands) commands is displayed.
DBCC TRACEON(3604)

-- The query is used to obtain a list of pages used by a specific table or index in a SQL Server database. 
DBCC IND ('Tran', 'Aufgabe1_pvt', 1);

-- The command will display information about page 401 in file 1 of the CS_Sample database, with print option 1. 
DBCC PAGE('CS_Sample',1,401,1) 

-------------------------
-------- SCRIPTS --------
-------------------------

-- The SQL statement you provided uses the sys.fn_PhysLocFormatter function in conjunction with the %%physloc%% placeholder 
-- to retrieve the physical location of rows in the dbo.Artikel table.
SELECT 
	sys.fn_PhysLocFormatter(%%physloc%%) AS Location, * 
FROM dbo.Artikel;

-- The SQL command is used in SQL Server to enable the display of advanced configuration options.
EXEC sp_configure 'show advanced options',1
Reconfigure

-- The SQL command enables the xp_cmdshell extended stored procedure in SQL Server
EXEC sp_configure 'xp_cmdshell',1; 
Reconfigure

-- The command is used to remove the internal representation of an XML document in SQL Server and invalidate its document handle
EXEC Sp_xml_removedocument 

-- This SQL query retrieves detailed information about the dependencies of a specific view named 'MeineSicht'. 
-- It joins data from sys.sysdepends and sys.all_columns to show which tables and columns the view depends on. 
SELECT  
	s.id AS [View-ID],
	OBJECT_NAME(s.id) AS [View-Name],
	s.depid AS [Tabellen-ID],
	OBJECT_NAME(s.depid) AS [Tabellenname],
	ac.column_id AS [Spalten ID],
	ac.name AS [Spaltenname]
FROM sys.sysdepends AS s 
INNER JOIN sys.all_columns AS ac 
	ON s.depid = ac.object_id
WHERE 
	s.id = OBJECT_ID('MeineSicht')
	AND s.depnumber = ac.column_id

-- The SQL query you've provided retrieves detailed information about the database files in the current database context in SQL Server.
Select 
	DB_NAME() AS [DatenbankName], 
	Name AS [logischer Name], 
	file_id, 
	physical_name,
	size AS [Größe in Seite], 
	size/8 AS [Anzahl Extents],
	size/128.00 as [Größe in MB],
	((size * 8.0/1024) - (FILEPROPERTY(name, 'SpaceUsed') * 8.0/1024)) As NochFrei
From 
	sys.database_files

-- The SQL query retrieves information about all processes with open transactions, sorted by the most recent batch execution time.
SELECT * FROM sys.sysprocesses 
WHERE open_tran > 0
ORDER BY last_batch DESC

-- This SQL query retrieves information about members of a specific server role named 'Modify_Databases'. 
SELECT 
    roles.name AS RoleName,
    members.name AS MemberName
FROM 
    sys.server_role_members AS srm
INNER JOIN 
    sys.server_principals AS roles ON srm.role_principal_id = roles.principal_id
INNER JOIN 
    sys.server_principals AS members ON srm.member_principal_id = members.principal_id
WHERE 
    roles.name = 'Modify_Databases';

-- The provided SQL query combines information to retrieve detailed information about active transactions and their associated executing requests.
SELECT ec.session_id, tst.is_user_transaction, st.text 
   FROM sys.dm_tran_session_transactions tst 
      INNER JOIN sys.dm_exec_connections ec ON tst.session_id = ec.session_id
      CROSS APPLY sys.dm_exec_sql_text(ec.most_recent_sql_handle) st

-- This SQL query retrieves information about the physical file locations of the system databases in SQL Server.
SELECT name, physical_name AS current_file_location
FROM sys.master_files
WHERE database_id IN (DB_ID('master'), DB_ID('model'), DB_ID('msdb'), DB_ID('tempdb'));


-- This SQL query retrieves and displays the current transaction isolation level for the active session in SQL Server. 
SELECT CASE transaction_isolation_level 
	WHEN 0 THEN 'Unspecified' 
	WHEN 1 THEN 'ReadUncommitted' 
	WHEN 2 THEN 'ReadCommitted' 
	WHEN 3 THEN 'Repeatable' 
	WHEN 4 THEN 'Serializable' 
	WHEN 5 THEN 'Snapshot' 
END 
AS TRANSACTION_ISOLATION_LEVEL 
FROM sys.dm_exec_sessions 
WHERE session_id = @@SPID

-- This SQL query retrieves detailed information about active database transactions, including session details, transaction log usage, and the most recent SQL text and query plan.
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








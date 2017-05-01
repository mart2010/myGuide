--to view all table in all schema
\dt *.*

 --pg_config utility prints configuration parameters of currently installed PostgreSQL
pg_config

-- Check open connections and their activities on 'some-database':
select *
from pg_stat_activity
where datname = 'some-database';

select datname, usename, client_addr, client_port
from pg_stat_activity;

-- check runtime param of the server (alternative to show and set commands)
select name, setting, unit, category, short_desc, min_val, max_val
from pg_settings;



-- Show all tables while inside a specific database (except system-related)
-- these are tracked within pg_catalog schema of postgres database
-- Besides checking tables, we can also check: triggers, views, sequences, check_constraint
select *
from information_schema.tables
where table_schema not in ('information_schema', 'pg_catalog')
--add table_schema in ('') to filter on specifric schemas


-- Getting the size of the database
select pg_database_size(current_database());
select pg_size_pretty(pg_database_size('mydatabase'));

-- for all database
select datname,
       pg_size_pretty(pg_database_size(datname))
from pg_database
order by pg_database_size(datname) desc;

-- .. of a table
select pg_relation_size('tablename');

--for all tables with/without indexes
select tablename,
       pg_size_pretty(pg_relation_size(schemaname||'.'||tablename)) as size,
       pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as total_size
  from pg_tables
 where schemaname = 'MY_SCHEMA_NAME';


-- Find the biggest tables in the database currently connected to
select relname, relpages
from pg_class
order by relpages desc;

--show all user/roles
select * from pg_user;


--Reloading postgreSQL conf files without restarting server
select pg_reload_conf()


-- Getting the data directory path of current database cluster

show data_directory;

--How to redirect the output of query to a file

\o out_to_file.txt
select ....;

--to redirect to std-out
\o

-- to show unused indexes
select
    schemaname || '.' || relname AS table,
    indexrelname AS index,
    pg_size_pretty(pg_relation_size(i.indexrelid)) AS index_size,
    idx_scan as index_scans
from pg_stat_user_indexes ui
    JOIN pg_index i ON ui.indexrelid = i.indexrelid
where NOT indisunique AND idx_scan < 50 AND pg_relation_size(relid) > 1024 * 1024
order by  pg_relation_size(i.indexrelid) / nullif(idx_scan, 0) DESC NULLS FIRST,
    pg_relation_size(i.indexrelid) DESC;



--See current connection info for PG's active session (pid is Linux process associated with session)
select datname, pid, usename, application_name, client_addr, backend_start, query_start, query
from pg_stat_activity;

--Kill a process but leaving user's session open (should spanw a new process)
select pg_cancel_backend(<pid>);

--If necessary (ex. killing the process does not work), use pg_terminate_backend to also close session
select pg_terminate_backend(<pid>);

--to kill all session except current one on specific database:
select pg_terminate_backend(pid)
from pg_stat_activity
where pid != pg_backend_pid()
and datname = 'onedatabase';  --don;t kill connection to other db




----------------------------------------------------------------------------
-----------------------  Postgres SQL's construction ----------------------



--Windows function:
select avg(val) over (partition by ..)) ...
select row_number() over (order by  ..) ...
range, rows, rows between current and 5 following etc.



--CTE (with statement) can be used recursively, for ex. to traverse a tree-like data model
--http://www.postgresonline.com/journal/archives/131-Using-Recursive-Common-table-expressions-to-represent-Tree-structures.html
with recursive tabletree as
(select stmt1 .. from table1 (base condition of recursive call))
 union all
 select stmt2 from table1
 join tabletree (recursive join to tabletree)

--Writable CTE :
--http://www.postgresonline.com/journal/archives/131-Using-Recursive-Common-table-expressions-to-represent-Tree-structures.html


---------Construction Unique to postgres:

--Limit and Offset for managing rows output
select .. from .. limit 10 (limit to 10 rows)
select .. from .. offset 10 (skip the first 10 rows)
select .. from .. limit 3 offset 10 (after skippiong first 10 output the next 3)

--Cast shorthand

select cast('2012-01-01' as date)
--can be replaced by it shorthand form:
select '2010-01-01'::date

--easier when casting mltiple times (in case direct casting is impossible):
select somexml::text::integer

-- ilike for case insensitve:
select name from t where name ilike '%anycase'

-- Returning changes records
update tablex set .... where ...
return fields...
--return can also be used with delete (returning deleted rows..) or insert (useful to return the generated key)

-- Composite type in query
--return a single composite view for all fields in temp as a single object:  (field1val, field2val, "field3val")
select X from temp as X;

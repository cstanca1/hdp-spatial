SQL Server
##### execute DDL.sql on SQL Server instance

SQOOP
##### execute the following command on SQOOP
download sqljdbc4.jar from Microsoft and place in `/usr/hdp/current/sqoop-client/lib`

```
sqoop import-all-tables --connect "jdbc:sqlserver://SERVERNAME;database=TABLENAME" --username username --password password --hive-import --create-hive-table -m 1
```

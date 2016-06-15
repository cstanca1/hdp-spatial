SQL Server
##### execute DDL.sql on SQL Server instance

SQOOP
##### execute the following command on SQOOP
download sql jdbc driver from Microsoft https://www.microsoft.com/en-us/download/details.aspx?id=11774 and place in sqoop client library directory

```
scp sql*.tar.gz root@clusternode:
```
then on the node
```
tar -xvzf sql*.tar.gz 
cd sqljdbc*/enu
cp sqljdbc42.jar /usr/hdp/current/sqoop-client/lib
```

make sure sql jdbc is at least 4.2 as that has support for Java 8

```
sqoop import-all-tables --connect "jdbc:sqlserver://SERVERNAME;database=TABLENAME" --username username --password password --hive-import --create-hive-table -m 1
```

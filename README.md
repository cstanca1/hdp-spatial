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

Create directory for /user/anonymous otherwise get permission denied on write
```
sudo -u hdfs hdfs dfs -mkdir /user/anonymous
sudo -u hdfs hdfs dfs -chown -R anonymous:hdfs /user/anonymous
```
login to beeline to confirm
```
WARNING: Use "yarn jar" to launch YARN applications.
Beeline version 1.2.1000.2.4.2.0-258 by Apache Hive
beeline> !connect jdbc:hive2://r02hn03:10000
Connecting to jdbc:hive2://r02hn03:10000
Enter username for jdbc:hive2://r02hn03:10000:
Enter password for jdbc:hive2://r02hn03:10000:
Connected to: Apache Hive (version 1.2.1000.2.4.2.0-258)
Driver: Hive JDBC (version 1.2.1000.2.4.2.0-258)
Transaction isolation: TRANSACTION_REPEATABLE_READ
0: jdbc:hive2://r02hn03:10000> use default;
No rows affected (0.062 seconds)
0: jdbc:hive2://r02hn03:10000> show tables;
+--------------------------------------------+--+
|                  tab_name                  |
+--------------------------------------------+--+
+--------------------------------------------+--+
25 rows selected (0.066 seconds)
```
to view the DDL created by SQOOP for the Hive tables
```
show create table tablename
```

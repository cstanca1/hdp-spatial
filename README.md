## Objective
The objective of this POC is to demonstrate spatial queries capabilities with HDP 2.4.2 and ESRI libraries for Hive and SparkSQL.

## Pre-requisites
- RHEL 7.2
- Java 1.8
- HDP 2.4.2
- SQL Server 2012 Standard with all objects/data to be migrated to Hive
- ESRI spatial framework for hadoop: https://github.com/Esri/spatial-framework-for-hadoop/blob/master/build.xml
- ESRI geometry API: https://github.com/Esri/geometry-api-java

@TODO: ESRI libraries should be built and deployed before executing the following steps, however, until we receive the needed support from ESRI for HDP 2.4.2 pre-requisites, we proceeded with the next steps to uncover other challenges that may not be due to missing ESRI libraries.

## Approach
- Migrate SQL Server tables/views and data to Hive via Sqoop
- Execute selected queries on Hive and SparkSQL and compare with the same queries results executed on SQL Server
- Once the functionality is a match, scale-up the data and run the same queries and observe performance

## Steps

### Restore from backup a sample database to SQL Server 2012 instance dedicated for this exercise

Note: We preferred to restore from the backup to avoid differences. An alternative is to execute the DDL script (DDL.sql) and load the data from pipe delimited files.

### Migrate SQL Server objects (tables and views) metadata and data to Hive via Sqoop

Before getting started with Sqoop, download sql jdbc driver from Microsoft https://www.microsoft.com/en-us/download/details.aspx?id=11774 (sql jdbc is at least 4.2 as that has support for Java 8), then copy it to the cluster node with sqoop client:

```
scp sql*.tar.gz root@clusternode:
```

Then, extract and place it to sqoop client library directory:
```
tar -xvzf sql*.tar.gz 
cd sqljdbc*/enu
cp sqljdbc42.jar /usr/hdp/current/sqoop-client/lib
```

### Execute sqoop import from SQL Server to Hive:

```
sqoop import-all-tables --connect "jdbc:sqlserver://SERVERNAME;database=TABLENAME" --username username --password password --hive-import --create-hive-table -m 1
```

### Validate that tables are created and populated with data

Before doing that, assuming login with anonymous user, create directory for /user/anonymous otherwise get permission denied on write.
```
sudo -u hdfs hdfs dfs -mkdir /user/anonymous
sudo -u hdfs hdfs dfs -chown -R anonymous:hdfs /user/anonymous
```
Login to beeline to confirm
```
beeline
```
Then, connect to hive instance:
```
beeline> !connect jdbc:hive2://r02hn03:10000
Connecting to jdbc:hive2://r02hn03:10000
Enter username for jdbc:hive2://r02hn03:10000:
Enter password for jdbc:hive2://r02hn03:10000:
Connected to: Apache Hive (version 1.2.1000.2.4.2.0-258)
Driver: Hive JDBC (version 1.2.1000.2.4.2.0-258)
Transaction isolation: TRANSACTION_REPEATABLE_READ
0: jdbc:hive2://r02hn03:10000> use default;
No rows affected (0.062 seconds)
```

List all tables in the current (default) database:
```
0: jdbc:hive2://r02hn03:10000> show tables;
+--------------------------------------------+--+
|                  tab_name                  |
+--------------------------------------------+--+
+--------------------------------------------+--+
25 rows selected (0.066 seconds)
```

To quit beeline type:

```
!q
```
The above result indicates that 25 tables were created. Original tables and views in SQL Server were 177. @TODO: investigate the difference and causes.

###. View the DDL created by SQOOP for the Hive tables
```
show create table tablename
```
###. SQL Server and Hive Gap Analysis

@TODO: compare records for tables needed for the two selected queries (see query09.sql, query10.sql)

8 tables and 1 view is needed for these two queries

policy_exposure
policy_loss_analysis
portfolio
portfolio_analysis

lu_country
lu_geocode_level
site_exposure
site_loss_analysis

vw_pointaccumulation_sp_results

The first four tables were successfully migrated to Hive via Sqoop. They match structure and data.

The following four tables and the view were not successfully migrated. @TODO: investigate cause and fix before anything else.

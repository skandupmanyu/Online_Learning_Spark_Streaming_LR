cd $(dirname $0)

source ../../config.txt

# RUN SQL SCRIPT
mysql -u$MYSQL_USER --password=$MYSQL_PWD < ./sql_scripts/create_database_and_tables.sql 

echo DATABASE CREATED...

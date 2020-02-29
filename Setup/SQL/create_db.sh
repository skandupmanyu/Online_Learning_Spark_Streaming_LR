cd $(dirname $0)

# RUN SQL SCRIPT
mysql -uroot --password="$(cat password_stored.txt)" < ./sql_scripts/create_database_and_tables.sql 

echo DATABASE CREATED...

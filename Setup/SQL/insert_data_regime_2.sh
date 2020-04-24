cd $(dirname $0)

source ../../config.txt

# RUN SQL SCRIPT
mysql -u$MYSQL_USER --password=$MYSQL_PWD < ./sql_scripts/insert_data_regime_2.sql 

echo DATA INSERTED...

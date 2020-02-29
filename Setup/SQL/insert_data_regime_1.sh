cd $(dirname $0)

# RUN SQL SCRIPT
mysql -uroot --password="$(cat password_stored.txt)" < ./sql_scripts/insert_data_regime_1.sql 

echo DATA INSERTED...

cd $(dirname $0)

source ../../config.txt

sed "s/password_placeholder/${MYSQL_PWD}/g" flume-mysql-kafka.conf > flume-mysql-kafka_pwd.conf

cp ./flume_dependencies/* $FLUME_DIR/libexec/lib/ || true

rm ./sql_status_logs/* || true

flume-ng agent \
--conf $FLUME_CONF_DIR \
--conf-file ./flume-mysql-kafka_pwd.conf \
--name a1 -Dflume.root.logger=INFO,console \
-Xmx2g > ../Logs/start-flume.log 2>&1 &

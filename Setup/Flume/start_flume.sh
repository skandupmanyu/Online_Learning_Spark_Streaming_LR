cd $(dirname $0)

source ../../config.txt

cp ./flume_dependencies/* $FLUME_DIR/libexec/lib/ || true

rm ./sql_status_logs/* || true

flume-ng agent \
--conf $FLUME_CONF_DIR \
--conf-file ./flume-mysql-kafka.conf \
--name a1 -Dflume.root.logger=INFO,console \
-Xmx2g > ../Logs/start-flume.log 2>&1 &

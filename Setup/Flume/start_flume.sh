cd $(dirname $0)

rm ./sql_status_logs/*

flume-ng agent \
--conf /usr/local/Cellar/flume/1.9.0/libexec/conf \
--conf-file ./flume-mysql-kafka.conf \
--name a1 -Dflume.root.logger=INFO,console \
-Xmx2g > ../Logs/start-flume.log 2>&1 &
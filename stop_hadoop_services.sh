source ./config.txt

#STOP SERVICES
$KAFKA_DIR/libexec/bin/kafka-server-stop.sh > ./Setup/Logs/kafka-server-stop.log 2>&1 &
$KAFKA_DIR/libexec/bin/zookeeper-server-stop.sh > ./Setup/Logs/zookeeper-server-stop.log 2>&1 &
$HADOOP_DIR/sbin/stop-yarn.sh  > ./Setup/Logs/stop-yarn.log 2>&1 &
$HADOOP_DIR/sbin/stop-dfs.sh > ./Setup/Logs/stop-dfs.log 2>&1 &

kill -9 $(jps | grep 'Kafka' | awk '{print $1}')

echo STOPPED SERVICES...

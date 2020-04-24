source ./config.txt

#START DFS
$HADOOP_DIR/sbin/start-dfs.sh > ./Setup/Logs/start-dfs.log 2>&1 &

#START YARN
$HADOOP_DIR/sbin/start-yarn.sh > ./Setup/Logs/start-yarn.log 2>&1 &

#START ZOOKEEPER
$KAFKA_DIR/libexec/bin/zookeeper-server-start.sh $KAFKA_DIR/libexec/config/zookeeper.properties  > ./Setup/Logs/zookeeper-server-start.log 2>&1 &

#START KAFKA
$KAFKA_DIR/libexec/bin/kafka-server-start.sh $KAFKA_DIR/libexec/config/server.properties > ./Setup/Logs/kafka-server-start.log 2>&1 &

echo STARTED SERVICES..

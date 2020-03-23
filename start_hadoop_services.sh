#START DFS
/usr/local/opt/hadoop/sbin/start-dfs.sh > ./Setup/Logs/start-dfs.log 2>&1 &

#START YARN
/usr/local/opt/hadoop/sbin/start-yarn.sh > ./Setup/Logs/start-yarn.log 2>&1 &

#START ZOOKEEPER
/usr/local/Cellar/kafka/2.4.1/libexec/bin/zookeeper-server-start.sh /usr/local/Cellar/kafka/2.4.1/libexec/config/zookeeper.properties  > ./Setup/Logs/zookeeper-server-start.log 2>&1 &

#START KAFKA
/usr/local/Cellar/kafka/2.4.1/libexec/bin/kafka-server-start.sh /usr/local/Cellar/kafka/2.4.1/libexec/config/server.properties > ./Setup/Logs/kafka-server-start.log 2>&1 &

echo STARTED SERVICES..

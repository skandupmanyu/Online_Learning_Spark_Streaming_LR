#START DFS
/usr/local/opt/hadoop/sbin/start-dfs.sh > ../Logs/start-dfs.log 2>&1 &

#START YARN
/usr/local/opt/hadoop/sbin/start-yarn.sh > ../Logs/start-yarn.log 2>&1 &

#START ZOOKEEPER
/usr/local/Cellar/kafka/2.3.1/libexec/bin/zookeeper-server-start.sh /usr/local/Cellar/kafka/2.3.1/libexec/config/zookeeper.properties  > ../Logs/zookeeper-server-start.log 2>&1 &

#START KAFKA
/usr/local/Cellar/kafka/2.3.1/libexec/bin/kafka-server-start.sh /usr/local/Cellar/kafka/2.3.1/libexec/config/server.properties > ../Logs/kafka-server-start.log 2>&1 &

echo STARTED SERVICES..

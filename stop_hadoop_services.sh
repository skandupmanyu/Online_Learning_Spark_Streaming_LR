#STOP SERVICES
/usr/local/Cellar/kafka/2.4.1/libexec/bin/kafka-server-stop.sh > ./Setup/Logs/kafka-server-stop.log 2>&1 &
/usr/local/Cellar/kafka/2.4.1/libexec/bin/zookeeper-server-stop.sh > ./Setup/Logs/zookeeper-server-stop.log 2>&1 &
/usr/local/opt/hadoop/sbin/stop-yarn.sh  > ./Setup/Logs/stop-yarn.log 2>&1 &
/usr/local/opt/hadoop/sbin/stop-dfs.sh > ./Setup/Logs/stop-dfs.log 2>&1 &

echo STOPPED SERVICES...

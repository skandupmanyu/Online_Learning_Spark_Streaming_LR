#CREATE TOPIC
/usr/local/Cellar/kafka/2.3.1/libexec/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic online_learning_topic

echo TOPIC CREATED..

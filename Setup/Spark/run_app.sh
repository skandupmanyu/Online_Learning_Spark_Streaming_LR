cd $(dirname $0)

cp ../../config.txt .

#RUN APPLICATION
spark-submit \
--class OL.online_learning \
--jars ./App/lib/kafka-clients-2.4.0.jar,./App/lib/mysql-connector-java-8.0.18.jar,./App/lib/spark-sql-kafka-0-10_2.11-2.4.4.jar,./App/lib/spark-streaming-kafka-0-10_2.11-2.4.4.jar \
--files ./config.txt \
./App/target/scala-2.11/online-learning_2.11-1.0.jar > ../Logs/run_app.log 2>&1 &

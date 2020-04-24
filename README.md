# Online Learning for Linear Regression using Spark Streaming

An end to end production pipeline for reading real time streaming data from Mysql to Spark using Flume and Kafka and running a real time streaming regression on Spark, visualizing the results on terminal and writing the output back to MySQL.

## Architecture:

MySQL => Flume => Kafka => Spark => MySQL

![](https://i.ibb.co/HxStSZ7/Architecture.png)

## Output and Visualization
![](https://i.ibb.co/q5SSbbV/1.png)
![](https://i.ibb.co/c6MBj6P/2.png)
![](https://i.ibb.co/fH7HcyN/3.png)
![](https://i.ibb.co/yNWQFfs/4.png)
![](https://i.ibb.co/c8r9315/5.png)
![](https://i.ibb.co/BsCqK9b/6.png)
![](https://i.ibb.co/N2mjKSv/7.png)

## Running Project:
```
sh start_project.sh
```

## Requirements:
- MySQL
- Hadoop
- Flume
- Kafka
- Spark


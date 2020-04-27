package OL{

  import org.apache.spark.SparkContext
  import org.apache.spark.SparkContext._
  import org.apache.spark.SparkConf
  import org.apache.kafka.clients.consumer.ConsumerRecord
  import org.apache.kafka.common.serialization.StringDeserializer
  import org.apache.spark.streaming.kafka010._
  import org.apache.spark.streaming.kafka010.LocationStrategies.PreferConsistent
  import org.apache.spark.streaming.kafka010.ConsumerStrategies.Subscribe
  import java.sql.{Connection,DriverManager,PreparedStatement}
  import org.apache.log4j.Logger
  import org.apache.log4j.Level
  import org.apache.spark.streaming.{Seconds, StreamingContext}
  import org.apache.spark.mllib.linalg.Vectors
  import org.apache.spark.mllib.regression.LabeledPoint
  import org.apache.spark.mllib.regression.StreamingLinearRegressionWithSGD

  object online_learning {

    def main(args: Array[String]) {

      Logger.getLogger("org").setLevel(Level.OFF)
      Logger.getLogger("akka").setLevel(Level.OFF)
     
      val conf = new SparkConf().setAppName("Online Learning")
      val sc = new SparkContext(conf)
      val ssc = new StreamingContext(sc, Seconds(10))

      val kafkaParams = Map[String, Object](
        "bootstrap.servers" -> "localhost:9092",
        "key.deserializer" -> classOf[StringDeserializer],
        "value.deserializer" -> classOf[StringDeserializer],
        "group.id" -> "a",
        "auto.offset.reset" -> "latest",
        "enable.auto.commit" -> (false: java.lang.Boolean)
      )

      val topics = Array("online_learning_topic")
      val stream = KafkaUtils.createDirectStream[String, String](
        ssc,
        PreferConsistent,
        Subscribe[String, String](topics, kafkaParams)
      )

      val make_lp = (line: String) => {
          val l = line.split(",")
          val target = l(2).toDouble
          val features = ("1" +: l.slice(1,2)).map(x => x.toDouble)
          LabeledPoint(target,Vectors.dense(features))
      }

      val training_data = stream.map(record => record.value).map(make_lp).cache()

      val numFeatures = 2
      val model = {
      new StreamingLinearRegressionWithSGD()
      .setStepSize(0.00002)
      .setNumIterations(20)
      .setInitialWeights(Vectors.zeros(numFeatures))
      }

      val pred = model.predictOnValues(training_data.map(lp => (lp.label, lp.features)))
      pred.cache()
      pred.print()

      model.trainOn(training_data)

      val beta0 = {
      model
      .predictOnValues(
        training_data
        .map(lp => (0.0, Vectors.dense(1,0)))
      )
      .reduceByKey((x,y) => x)
      }

      val beta1 = {
      model
      .predictOnValues(
        training_data
        .map(lp => (0.0, Vectors.dense(0,1)))
      )
      .reduceByKey((x,y) => x)
      }

      val betas_joined = beta0.join(beta1)
      val betas = betas_joined.map(l => l._2).cache()

      betas.print()

      val training_data_store = stream.map(record => record.value).map(line => line.split(",")).cache()

      val conf_file = sc.textFile("config.txt").collect()
      val conf_key_value = conf_file.map(x => x.split("="))
      val mysql_user = conf_key_value.find(x => x(0) == "MYSQL_USER").get(1)
      val mysql_pwd = conf_key_value.find(x => x(0) == "MYSQL_PWD").get(1)

      training_data_store.foreachRDD(rdd => {rdd.foreachPartition(partionOfRecords => {
            val url = "jdbc:mysql://localhost:3306/ONLINE_LEARNING_DB?useSSL=false"
            val user = mysql_user
            val password = mysql_pwd
            Class.forName("com.mysql.cj.jdbc.Driver")
            val conn = DriverManager.getConnection(url,user,password)
            conn.setAutoCommit(false)
            val stmt = conn.createStatement()
            partionOfRecords.foreach(record=>{
              stmt.addBatch("insert into training_data(ID,X1,Y) values("+record(0)+","+record(1)+","+record(2)+")")
            })
            stmt.executeBatch()
            conn.commit()
      })})

      pred.foreachRDD(rdd => {rdd.foreachPartition(partionOfRecords => {
            val url = "jdbc:mysql://localhost:3306/ONLINE_LEARNING_DB?useSSL=false"
            val user = mysql_user
            val password = mysql_pwd
            Class.forName("com.mysql.cj.jdbc.Driver")
            val conn = DriverManager.getConnection(url,user,password)
            conn.setAutoCommit(false)
            val stmt = conn.createStatement()
            partionOfRecords.foreach(record=>{
              stmt.addBatch("insert into predictions(Y,PRED) values("+record._1+","+record._2+")")
            })
            stmt.executeBatch()
            conn.commit()
      })})

      betas.foreachRDD(rdd => {rdd.foreachPartition(partionOfRecords => {
            val url = "jdbc:mysql://localhost:3306/ONLINE_LEARNING_DB?useSSL=false"
            val user = mysql_user
            val password = mysql_pwd
            Class.forName("com.mysql.cj.jdbc.Driver")
            val conn = DriverManager.getConnection(url,user,password)
            conn.setAutoCommit(false)
            val stmt = conn.createStatement()
            partionOfRecords.foreach(record=>{
              stmt.addBatch("insert into coefficients(beta0,beta1) values("+record._1+","+record._2+")")
            })
            stmt.executeBatch()
            conn.commit()
      })})

      print("starting ssc")
      ssc.start()
      print("awaiting")
      ssc.awaitTermination()
    }
  }
}

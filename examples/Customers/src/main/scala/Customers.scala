import org.apache.spark.SparkConf
import org.apache.spark.sql.SparkSession

object Customers {

  def main(args: Array[String]): Unit = {
    val conf = new SparkConf().setAppName(Customers.getClass.getName)
    val session = SparkSession.builder().config(conf).getOrCreate()

    val customers = session.read.json("customers.json")
    customers.createOrReplaceTempView("customers")
    
     val firstCityState = session.sql("SELECT first_name, address.city, address.state FROM customers")
     firstCityState.collect().foreach(println)

    // terminate spark context
    session.stop()
  }

}

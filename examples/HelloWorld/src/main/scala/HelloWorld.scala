import org.apache.spark.SparkConf
import org.apache.spark.sql.SparkSession
import scala.collection.immutable.ArraySeq

object HelloWorld {

  def main(args: Array[String]): Unit = {

    // initialise spark context
    val conf = new SparkConf().setAppName(HelloWorld.getClass.getName)
    val session = SparkSession.builder().config(conf).getOrCreate()

    // do stuff
    println("************")
    println("Hello, world!")
    val seq = ArraySeq.unsafeWrapArray(Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
    // def parallelize[T](seq: Seq[T], numSlices: Int = defaultParallelism)
    val rdd = session.sparkContext.parallelize(seq)
    val n = rdd.count()
    println(s"n=$n")
    println("************")

    // terminate spark context
    session.stop()
  }

}

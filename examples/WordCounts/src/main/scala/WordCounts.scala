// see https://stackoverflow.com/questions/53612978/convert-from-javapairrddstring-tuple2integer-integer-to-javapairrddstring

import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.sql.SparkSession

object WordCounts {

  def main(args: Array[String]): Unit = {
    val conf = new SparkConf().setAppName("Spark").setMaster("local")
    conf.set("spark.testing.memory", "5147480000")
    val sc = new SparkContext(conf)

    val inputFile1/*JavaRDD<String>*/ = sc.textFile("target/input1.txt")
    val wordCounts1/*JavaPairRDD<String, Integer> */ = inputFile1
      .flatMap(s => s.split(" "))
      .mapToPair(word => (word, 1))
      .reduceByKey((a, b) => a + b)
    wordCounts1.saveAsTextFile("target/output1.txt")

    val inputFile2/*JavaRDD<String>*/ = sc.textFile("target/input2.txt")
    val wordCounts2/*JavaPairRDD<String, Integer>*/ = inputFile2
      .flatMap(s => s.split(" "))
      .mapToPair(word => (word, 1))
      .reduceByKey((a, b) => a + b)
    wordCounts2.saveAsTextFile("target/output2.txt")

    val joinResult/*JavaPairRDD<String, Tuple2<Integer, Integer>>*/ =
      wordCounts1.join(wordCounts2)
    joinResult.saveAsTextFile("target/outputResult.txt")

    val finalResult/*JavaPairRDD<String, Integer>*/ = joinResult.mapToPair(stringTuple2Tuple2 =>
      if (stringTuple2Tuple2._2._1 < stringTuple2Tuple2._2._1)
        (stringTuple2Tuple2._1, stringTuple2Tuple2._2._1)
      else
        (stringTuple2Tuple2._1, stringTuple2Tuple2._2._2)
    )
    finalResult.saveAsTextFile("target/outputFinal.txt")
  }

}

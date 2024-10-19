// see https://stackoverflow.com/questions/53612978/convert-from-javapairrddstring-tuple2integer-integer-to-javapairrddstring

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.PairFunction;
import org.apache.spark.sql.SparkSession;

import java.util.Arrays;
import scala.Tuple2;

public final class JavaWordCounts {

    public static void main(String[] args) throws Exception {
        SparkConf conf = new SparkConf().setAppName("Spark").setMaster("local");
        conf.set("spark.testing.memory", "5147480000");
        JavaSparkContext sc = new JavaSparkContext(conf);

        JavaRDD<String> inputFile1 = sc.textFile("target/input1.txt");
        JavaPairRDD<String, Integer> wordCounts1 = inputFile1
            .flatMap(s -> Arrays.asList(s.split(" ")).iterator())
            .mapToPair(word -> new Tuple2<>(word, 1))
            .reduceByKey((a, b) -> a + b);
         wordCounts1.saveAsTextFile("target/output1.txt");

        JavaRDD<String> inputFile2 = sc.textFile("target/input2.txt");
        JavaPairRDD<String, Integer> wordCounts2 = inputFile2
            .flatMap(s -> Arrays.asList(s.split(" ")).iterator())
            .mapToPair(word -> new Tuple2<>(word, 1))
            .reduceByKey((a, b) -> a + b);
         wordCounts2.saveAsTextFile("target/output2.txt");

         JavaPairRDD<String, Tuple2<Integer, Integer>> joinResult =
             wordCounts1.join(wordCounts2);
         joinResult.saveAsTextFile("target/outputResult.txt");

         JavaPairRDD<String, Integer> finalResult = joinResult.mapToPair(new PairFunction<Tuple2<String, Tuple2<Integer, Integer>>, String, Integer>() {
             @Override
             public Tuple2<String, Integer> call(Tuple2<String, Tuple2<Integer, Integer>> stringTuple2Tuple2) throws Exception {
                 if (stringTuple2Tuple2._2()._1() < stringTuple2Tuple2._2()._1()) {
                     return new Tuple2<>(stringTuple2Tuple2._1(), stringTuple2Tuple2._2()._1());
                 }
                 else {
                     return new Tuple2<>(stringTuple2Tuple2._1(), stringTuple2Tuple2._2()._2());
                 }
             }
         });
         finalResult.saveAsTextFile("target/outputFinal.txt");
    }

}

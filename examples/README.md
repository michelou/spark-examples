# <span id="top">Spark examples</span> <span style="size:30%;"><a href="../README.md">⬆</a></span>

<table style="font-family:Helvetica,Arial;font-size:14px;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;">
    <a href="https://spark.apache.org/" rel="external"><img style="border:0;width:120px;" src="https://spark.apache.org/images/spark-logo-trademark.png" alt="Dotty project" /></a>
  </td>
  <td style="border:0;padding:0;vertical-align:text-top;">
    Directory <strong><code>examples\</code></strong> contains <a href="https://spark.apache.org/" rel="external">Spark</a> code examples coming from various websites - mostly from the <a href="https://spark.apache.org/" rel="external">Spark project</a>.
  </td>
  </tr>
</table>

## <span id="helloworld">HelloWorld</span>

Command [`build run`](./HelloWorld/build.bat) performs two tasks :
- it creates a fat jar using the sbt script [`build.sbt`](./HelloWorld/build.sbt) from the Scala source file [`HelloWorld.scala`](./HelloWorld/src/main/scala/HelloWorld.scala).
- it execute the [`spark-submit`](https://spark.apache.org/docs/latest/submitting-applications.html) command to launch the Spark application.

<pre style="font-size:80%;">
<b>&gt; <a href="./HelloWorld/build.bat">build</a> -verbose clean run</b>
Delete directory "target"
Create a fat jar
[info] welcome to sbt 1.7.1 (Temurin Java 1.8.0_345)
[...]
[info] set current project to HelloWorld (in build file:/K:/examples/HelloWorld/)
[info] compiling 1 Scala source to K:\examples\HelloWorld\target\scala-2.13\classes ...
[warn] K:\examples\HelloWorld\src\main\scala\HelloWorld.scala:15:53: method copyArrayToImmutableIndexedSeq in class LowPriorityImplicits2 is deprecated (since 2.13.0): Implicit conversions from Array to immutable.IndexedSeq are implemented by copying; Use the more efficient non-copying ArraySeq.unsafeWrapArray or an explicit toIndexedSeq call
[warn]     val rdd = session.sparkContext.parallelize(Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
[warn]                                                     ^
[warn] one warning found
[info] Strategy 'discard' was applied to a file (Run the task at debug level to see details)
[info] Strategy 'rename' was applied to 2 files (Run the task at debug level to see details)
Execute Spark application HelloWorld
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
22/05/27 17:20:05 INFO SparkContext: Running Spark version 3.2.1
[...]
22/05/27 17:20:07 INFO Utils: Successfully started service 'SparkUI' on port 4040.
22/05/27 17:20:07 INFO SparkUI: Bound SparkUI to 0.0.0.0, and started at http://192.168.0.100:4040
22/05/27 17:20:07 INFO SparkContext: Added JAR file:/K:/examples/HelloWorld/target/scala-2.13/HelloWorld-assembly-0.1.0.jar at spark://192.168.0.100:50076/jars/HelloWorld-assembly-0.1.0.jar with timestamp 1653664805164
[...]
************
Hello, world!
22/05/27 17:20:08 INFO SparkContext: Starting job: count at HelloWorld.scala:16
[...]
22/05/27 17:20:09 INFO DAGScheduler: Job 0 finished: count at HelloWorld.scala:16, took 0.827669 s
n=10
************
22/05/27 17:20:09 INFO SparkUI: Stopped Spark web UI at http://192.168.0.100:4040
[...]
22/05/27 17:20:09 INFO SparkContext: Successfully stopped SparkContext
22/05/27 17:20:09 INFO ShutdownHookManager: Shutdown hook called
22/05/27 17:20:09 INFO ShutdownHookManager: Deleting directory %TEMP%\spark-fa798b49-b8a6-4cc2-bda1-70c37e7b488f
22/05/27 17:20:09 INFO ShutdownHookManager: Deleting directory %TEMP%\spark-4959fb8e-afdc-43bc-8748-143e7d29ea16
</pre>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/August 2022* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

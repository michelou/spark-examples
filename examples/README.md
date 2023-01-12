# <span id="top">Spark examples</span> <span style="size:30%;"><a href="../README.md">⬆</a></span>

<table style="font-family:Helvetica,Arial;font-size:14px;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;">
    <a href="https://spark.apache.org/" rel="external"><img style="border:0;width:120px;" src="https://spark.apache.org/images/spark-logo-trademark.png" alt="Spark project" /></a>
  </td>
  <td style="border:0;padding:0;vertical-align:text-top;">
    Directory <strong><code>examples\</code></strong> contains <a href="https://spark.apache.org/" rel="external">Spark</a> code examples coming from various websites - mostly from the <a href="https://spark.apache.org/" rel="external">Spark project</a>.
  </td>
  </tr>
</table>

## <span id="customers">Example `Customers`</span>

Command [`build.bat run`](./Customers/build.bat) performs two tasks :
- it compiles the Scala source file [`Customers.scala`](./Customers/src/main/scala/HelloWorld.scala).
- it creates the fat jar `Customers-assembly-0.1.0.jar` (e.g. adds the Scala 2.13 library).
- it execute the [`spark-submit`](https://spark.apache.org/docs/latest/submitting-applications.html) command to launch the Spark application.

<pre style="font-size:80%;">
build -verbose clean run
Compile 1 Scala source file into directory "target\classes"
Create assembly file "target\Customers-assembly-0.1.0.jar"
Extract class files from "C:\Users\michelou\.m2\repository\org\scala-lang\scala-library\2.13.10\scala-library-2.13.10.jar"
Update assembly file "target\Customers-assembly-0.1.0.jar"
Execute Spark application "Customers"
23/01/12 20:41:53 INFO SparkContext: Running Spark version 3.3.1
[...]
23/01/12 20:42:02 INFO Executor: Running task 0.0 in stage 1.0 (TID 1)
23/01/12 20:42:02 INFO FileScanRDD: Reading File path: file:///K:/examples/Customers/customers.json, range: 0-457, partition values: [empty row]
23/01/12 20:42:02 INFO CodeGenerator: Code generated in 14.676 ms
23/01/12 20:42:02 INFO Executor: Finished task 0.0 in stage 1.0 (TID 1). 1629 bytes result sent to driver
23/01/12 20:42:02 INFO TaskSetManager: Finished task 0.0 in stage 1.0 (TID 1) in 122 ms on 192.168.0.105 (executor driver) (1/1)
23/01/12 20:42:02 INFO TaskSchedulerImpl: Removed TaskSet 1.0, whose tasks have all completed, from pool
23/01/12 20:42:02 INFO DAGScheduler: ResultStage 1 (collect at Customers.scala:14) finished in 0.122 s
23/01/12 20:42:02 INFO DAGScheduler: Job 1 is finished. Cancelling potential speculative or zombie tasks for this job
23/01/12 20:42:02 INFO TaskSchedulerImpl: Killing all running tasks in stage 1: Stage finished
23/01/12 20:42:02 INFO DAGScheduler: Job 1 finished: collect at Customers.scala:14, took 0.132113 s
23/01/12 20:42:02 INFO CodeGenerator: Code generated in 27.579 ms
[James,New Orleans,LA]
[Josephine,Brighton,MI]
[Art,Bridgeport,NJ]
23/01/12 20:42:02 INFO SparkUI: Stopped Spark web UI at http://192.168.0.105:4040
[...]
</pre>

## <span id="helloworld">Example `HelloWorld`</span> [**&#x25B4;**](#top)

Command [`build.bat run`](./HelloWorld/build.bat) performs two tasks :
- it compiles the Scala source file [`HelloWorld.scala`](./HelloWorld/src/main/scala/HelloWorld.scala).
- it creates the fat jar `HelloWorld-assembly-0.1.0.jar` (e.g. adds the Scala 2.13 library).
- it execute the [`spark-submit`](https://spark.apache.org/docs/latest/submitting-applications.html) command to launch the Spark application.

<pre style="font-size:80%;">
<b>&gt; <a href="./HelloWorld/build.bat">build</a> -verbose clean run</b>
Delete directory "target"
Compile 1 Scala source file into directory "target\classes"
Create assembly file "target\HelloWorld-assembly-0.1.0.jar"
Extract class files from "%USERPROFILE%\.m2\repository\org\scala-lang\scala-library\2.13.10\scala-library-2.13.10.jar"
Update assembly file "target\HelloWorld-assembly-0.1.0.jar"
Execute Spark application "Hello World"
23/01/12 20:38:50 INFO SparkContext: Running Spark version 3.3.1
[...]
22/05/27 17:20:07 INFO Utils: Successfully started service 'SparkUI' on port 4040.
22/05/27 17:20:07 INFO SparkUI: Bound SparkUI to 0.0.0.0, and started at http://192.168.0.100:4040
22/05/27 17:20:07 INFO SparkContext: Added JAR file:/K:/examples/HelloWorld/target/scala-2.13/HelloWorld-assembly-0.1.0.jar at spark://192.168.0.100:50076/jars/HelloWorld-assembly-0.1.0.jar with timestamp 1653664805164
[...]
************
Hello, world!
23/01/12 20:38:53 INFO SparkContext: Starting job: count at HelloWorld.scala:19
[...]
23/01/12 20:38:53 INFO DAGScheduler: Job 0 finished: count at HelloWorld.scala:19, took 0.493854 s
n=10
************
23/01/12 20:38:53 INFO SparkUI: Stopped Spark web UI at http://192.168.0.105:4040
[...]
23/01/12 20:38:53 INFO SparkContext: Successfully stopped SparkContext
23/01/12 20:38:53 INFO ShutdownHookManager: Shutdown hook called
23/01/12 20:38:53 INFO ShutdownHookManager: Deleting directory %TEMP%\spark-3a71d274-a5e1-4f9a-bd37-036fc6749f80

23/01/12 20:38:53 INFO ShutdownHookManager: Deleting directory %TEMP%\spark-c6676922-452a-44ba-a79f-56b1418c66ff
</pre>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/January 2023* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

# <span id="top">Spark examples</span> <span style="font-size:90%;">[⬆](../README.md#top)</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;">
    <a href="https://spark.apache.org/" rel="external"><img style="border:0;width:120px;" src="https://spark.apache.org/images/spark-logo-trademark.png" alt="Spark project" /></a>
  </td>
  <td style="border:0;padding:0;vertical-align:text-top;">
    Directory <strong><code>examples\</code></strong> contains <a href="https://spark.apache.org/" rel="external">Spark</a> code examples coming from various websites - mostly from the <a href="https://spark.apache.org/" rel="external">Spark project</a>.
  </td>
  </tr>
</table>

## <span id="customers">`Customers` Example</span>

This example has the following directory structure :

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree" rel="external">tree</a> /f /a . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr" rel="external">findstr</a> /v /b [A-Z]</b>
|   <a href="./Customers/00download.txt">00download.txt</a>
|   <a href="./Customers/baby_names.json">baby_names.json</a>
|   <a href="./Customers/build.bat">build.bat</a>
|   <a href="./Customers/build.sh">build.sh</a>
|   <a href="./Customers/customers.json">customers.json</a>
|   <a href="./Customers/library.properties">library.properties</a>
|   <a href="./Customers/Makefile">Makefile</a>
|   <a href="./Customers/NOTICE">NOTICE</a>
|   <a href="./Customers/pom.xml">pom.xml</a>
\---<b>src</b>
    \---<b>main</b>
        \---<b>scala</b>
                <a href="./Customers/src/main/scala/Customers.scala">Customers.scala</a>
</pre>

Command [`build.bat run`](./Customers/build.bat) performs several tasks :
- it compiles the Scala source file [`Customers.scala`](./Customers/src/main/scala/HelloWorld.scala).
- it creates the fat jar `Customers-assembly-0.1.0.jar` (e.g. adds the Scala 2.13 library).
- it executes the [`spark-submit`](https://spark.apache.org/docs/latest/submitting-applications.html) command to launch the Spark application.

<pre style="font-size:80%;">
<b>&gt; <a href="./Customers/build.bat">build</a> -verbose clean run</b>
Compile 1 Scala source file into directory "target\classes"
Create assembly file "target\Customers-assembly-0.1.0.jar"
Extract class files from "C:\Users\michelou\.m2\repository\org\scala-lang\scala-library\2.13.10\scala-library-2.13.10.jar"
Update assembly file "target\Customers-assembly-0.1.0.jar"
Execute Spark application "Customers"
24/04/12 20:41:53 INFO SparkContext: Running Spark version 3.5.1
[...]
24/04/12 20:42:02 INFO Executor: Running task 0.0 in stage 1.0 (TID 1)
24/04/12 20:42:02 INFO FileScanRDD: Reading File path: file:///K:/examples/Customers/customers.json, range: 0-457, partition values: [empty row]
24/04/12 20:42:02 INFO CodeGenerator: Code generated in 14.676 ms
24/04/12 20:42:02 INFO Executor: Finished task 0.0 in stage 1.0 (TID 1). 1629 bytes result sent to driver
24/04/12 20:42:02 INFO TaskSetManager: Finished task 0.0 in stage 1.0 (TID 1) in 122 ms on 192.168.0.105 (executor driver) (1/1)
24/04/12 20:42:02 INFO TaskSchedulerImpl: Removed TaskSet 1.0, whose tasks have all completed, from pool
24/04/12 20:42:02 INFO DAGScheduler: ResultStage 1 (collect at Customers.scala:14) finished in 0.122 s
24/04/12 20:42:02 INFO DAGScheduler: Job 1 is finished. Cancelling potential speculative or zombie tasks for this job
24/04/12 20:42:02 INFO TaskSchedulerImpl: Killing all running tasks in stage 1: Stage finished
24/04/12 20:42:02 INFO DAGScheduler: Job 1 finished: collect at Customers.scala:14, took 0.132113 s
24/04/12 20:42:02 INFO CodeGenerator: Code generated in 27.579 ms
[James,New Orleans,LA]
[Josephine,Brighton,MI]
[Art,Bridgeport,NJ]
24/04/12 20:42:02 INFO SparkUI: Stopped Spark web UI at http://192.168.0.105:4040
[...]
</pre>

## <span id="helloworld">`HelloWorld` Example</span> [**&#x25B4;**](#top)

This example has the following directory structure :

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree">tree</a> /f /a | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr">findstr</a> /v /b [A-Z]</b>
|   <a href="./HelloWorld/00download.txt">00download.txt</a>
|   <a href="./HelloWorld/build.bat">build.bat</a>
|   <a href="./HelloWorld/build.sbt">build.sbt</a>
|   <a href="./HelloWorld/build.sh">build.sh</a>
|   <a href="./HelloWorld/Makefile">Makefile</a>
+---<b>project</b>
|       <a href="./HelloWorld/project/build.properties">build.properties</a>
|       <a href="./HelloWorld/project/plugins.sbt">plugins.sbt</a>
\---<b>src</b>
    \---<b>main</b>
        \---<b>scala</b>
                <a href="./HelloWorld/src/main/scala/HelloWorld.scala">HelloWorld.scala</a>
</pre>

Command [`build.bat run`](./HelloWorld/build.bat) performs several tasks :
- it compiles the Scala source file [`HelloWorld.scala`](./HelloWorld/src/main/scala/HelloWorld.scala).
- it creates the fat jar `HelloWorld-assembly-0.1.0.jar` (e.g. adds the Scala 2.13 library).
- it executes the [`spark-submit`](https://spark.apache.org/docs/latest/submitting-applications.html) command to launch the Spark application.

<pre style="font-size:80%;">
<b>&gt; <a href="./HelloWorld/build.bat">build</a> -verbose clean run</b>
Delete directory "target"
Compile 1 Scala source file into directory "target\classes"
Create assembly file "target\HelloWorld-assembly-0.1.0.jar"
Extract class files from "%USERPROFILE%\.m2\repository\org\scala-lang\scala-library\2.13.10\scala-library-2.13.10.jar"
Update assembly file "target\HelloWorld-assembly-0.1.0.jar"
Execute Spark application "Hello World"
24/04/12 20:38:50 INFO SparkContext: Running Spark version 3.5.1
[...]
22/05/27 17:20:07 INFO Utils: Successfully started service 'SparkUI' on port 4040.
22/05/27 17:20:07 INFO SparkUI: Bound SparkUI to 0.0.0.0, and started at http://192.168.0.100:4040
22/05/27 17:20:07 INFO SparkContext: Added JAR file:/K:/examples/HelloWorld/target/scala-2.13/HelloWorld-assembly-0.1.0.jar at spark://192.168.0.100:50076/jars/HelloWorld-assembly-0.1.0.jar with timestamp 1653664805164
[...]
************
Hello, world!
24/04/12 20:38:53 INFO SparkContext: Starting job: count at HelloWorld.scala:19
[...]
24/04/12 20:38:53 INFO DAGScheduler: Job 0 finished: count at HelloWorld.scala:19, took 0.493854 s
n=10
************
24/04/12 20:38:53 INFO SparkUI: Stopped Spark web UI at http://192.168.0.105:4040
[...]
24/04/12 20:38:53 INFO SparkContext: Successfully stopped SparkContext
24/04/12 20:38:53 INFO ShutdownHookManager: Shutdown hook called
24/04/12 20:38:53 INFO ShutdownHookManager: Deleting directory %TEMP%\spark-3a71d274-a5e1-4f9a-bd37-036fc6749f80

24/04/12 20:38:53 INFO ShutdownHookManager: Deleting directory %TEMP%\spark-c6676922-452a-44ba-a79f-56b1418c66ff
</pre>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/December 2024* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

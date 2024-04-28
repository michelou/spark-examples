# <span id="top">Spark Setup</span> <span style="size:25%;"><a href="README.md">↩</a></span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:25%;"><a href="https://spark.apache.org/" rel="external"><img src="https://spark.apache.org/images/spark-logo-trademark.png" width="120" alt="Spark project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This document gathers information on the setup of the <a href="https://spark.apache.org/" rel="external">Spark</a> framework.
  </td>
  </tr>
</table>

## <span id="steps">Installation Steps</span>

Spark installation requires two steps on Microsoft Windows :
1) Download archive file `spark-3.5.1-bin-hadoop3.2-scala2.13.tgz` either from the [Spark download page](https://spark.apache.org/downloads.html) or from the [Spark Distribution Directory](https://downloads.apache.org/spark/).
2) Download and install binary files from GitHub repository [`cdarlint/winutils`](https://github.com/cdarlint/winutils).

> **:mag_right:** [Spark][apache_spark] and [Hadoop][apache_hadoop] are two separate Apache projects : Spark uses Hadoop’s client libraries for [HDFS] and [YARN].<br/>
> We give below the actual dependencies between [Spark][apache_spark] and [Hadoop][apache_hadoop] <sup id="anchor_03">[3](#footnote_03)</sup> (as of October 2023): 
>
>   |        |   |    |    |    |    |    |    |
>   |:-------|:--|:---|:---|:---|:---|:---|:---|
>   | [Hadoop][apache_hadoop] | [3.3.0](https://hadoop.apache.org/release/3.3.0.html) | [3.3.1](https://hadoop.apache.org/release/3.3.1.html) | [3.3.2](https://hadoop.apache.org/release/3.3.2.html) | [3.3.3](https://hadoop.apache.org/release/3.3.3.html) | [3.3.4](https://hadoop.apache.org/release/3.3.4.html) | [3.3.5](https://hadoop.apache.org/release/3.3.5.html) | [3.3.6](https://hadoop.apache.org/release/3.3.6.html) |
>   | [Spark][apache_spark] | [3.3.0](https://spark.apache.org/releases/spark-release-3-3-0.html) | [3.3.1](https://spark.apache.org/releases/spark-release-3-3-1.html) | [3.3.2](https://spark.apache.org/releases/spark-release-3-3-2.html) |  -  | [3.4.2](https://spark.apache.org/releases/spark-release-3-4-2.html)<br/>[3.5.0](https://spark.apache.org/releases/spark-release-3-5-0.html)<br/>[3.5.1](https://spark.apache.org/releases/spark-release-3-5-1.html) |  -  | -  |

## <span id="footnotes">Footnotes</span> [**&#x25B4;**](#top)


<span id="footnote_01">[1]</span> **`spark-shell` *session*** [↩](#anchor_01)

<dl><dd>
<pre style="font-size:80%;">
<b>&gt; echo %JAVA_HOME%</b>
C:\opt\jdk-temurin-11.0.22_7
&nbsp;
<b>&gt; %SPARK_HOME%\bin\<a href="https://sparkbyexamples.com/spark/spark-shell-usage-with-examples/">spark-shell</a></b>
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 3.5.1
      /_/

Using Scala version 2.13.8 (OpenJDK 64-Bit Server VM, Java 11.0.22)
[...]
Spark context available as 'sc' (master = local[*], app id = local-1683397418428).
Spark session available as 'spark'.

scala> print(spark.version)
3.5.1
scala> print(<a href="https://hadoop.apache.org/docs/stable/api/org/apache/hadoop/util/VersionInfo.html">org.apache.hadoop.util.VersionInfo</a>.getVersion())
3.3.4
scala> :quit
</pre>

<pre style="font-size:80%;">
<b>&gt; echo <a href="https://spark.apache.org/docs/latest/configuration.html#environment-variables">%PYSPARK_PYTHON%</a></b>
C:\opt\Python-3.10.10\python.exe
&nbsp;
<b>&gt; %SPARK_HOME%\bin\<a href="https://sparkbyexamples.com/pyspark/pyspark-shell-usage-with-examples/">pyspark</a></b>
Python 3.10.10 (tags/v3.10.10:aad5f6a, Feb  7 2023, 17:20:36) [MSC v.1929 64 bit (AMD64)] on win32
[...]
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /__ / .__/\_,_/_/ /_/\_\   version 3.5.1
      /_/

Using Python version 3.10.10 (tags/v3.10.10:aad5f6a, Feb  7 2023 17:20:36)
Spark context Web UI available at http://192.168.0.103:4040
Spark context available as 'sc' (master = local[*], app id = local-1683399374689).
SparkSession available as 'spark'.
>>> print(spark.version)
3.5.1
>>> print(sc._jvm.<a href="https://hadoop.apache.org/docs/stable/api/org/apache/hadoop/util/VersionInfo.html">org.apache.hadoop.util.VersionInfo</a>.getVersion())
3.3.4
>>> exit()
</pre>
</dd></dl>

<!--
<span id="footnote_02">[2]</span> ***Environment*** [↩](#anchor_02)

<dl><dd>
<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/set_1" rel="external">set</a> | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr" rel="external">findstr</a> _HOME</b>
GIT_HOME=C:\opt\Git
HADOOP_HOME=C:\opt\spark-3.5.1-bin-hadoop3-scala2.13
JAVA_HOME=C:\opt\jdk-temurin-11.0.20_8
MAVEN_HOME=C:\opt\apache-maven
PYTHON_HOME=C:\opt\Python-3.10.10
SBT_HOME=C:\opt\sbt
SCALA_HOME=C:\opt\scala-2.13.12
SPARK_HOME=C:\opt\spark-3.5.1-bin-hadoop3-scala2.13
</pre>
</dd></dl>

<span id="footnote_03">[3]</span> **`SparkPi` *demo*** [↩](#anchor_03)

<dl><dd>
<pre style="font-size:80%;">
<b>&gt; %HADOOP_HOME%\bin\run-example org.apache.spark.examples.SparkPi</b>
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
22/01/06 15:23:47 INFO SparkContext: Running Spark version 3.5.1
22/01/06 15:23:47 INFO ResourceUtils: ==============================================================
22/01/06 15:23:47 INFO ResourceUtils: No custom resources configured for spark.driver.
22/01/06 15:23:47 INFO ResourceUtils: ==============================================================
22/01/06 15:23:47 INFO SparkContext: Submitted application: Spark Pi
[...]
22/01/06 15:23:51 INFO DAGScheduler: Job 0 is finished. Cancelling potential speculative or zombie tasks for this job
22/01/06 15:23:51 INFO TaskSchedulerImpl: Killing all running tasks in stage 0: Stage finished
22/01/06 15:23:51 INFO DAGScheduler: Job 0 finished: reduce at SparkPi.scala:38, took 0.727252 s
Pi is roughly 3.1410957054785276
22/01/06 15:23:51 INFO SparkUI: Stopped Spark web UI at http://192.168.0.102:4040
22/01/06 15:23:51 INFO MapOutputTrackerMasterEndpoint: MapOutputTrackerMasterEndpoint stopped!
22/01/06 15:23:51 INFO MemoryStore: MemoryStore cleared
22/01/06 15:23:51 INFO BlockManager: BlockManager stopped
22/01/06 15:23:51 INFO BlockManagerMaster: BlockManagerMaster stopped
22/01/06 15:23:51 INFO OutputCommitCoordinator$OutputCommitCoordinatorEndpoint: OutputCommitCoordinator stopped!
22/01/06 15:23:51 INFO SparkContext: Successfully stopped SparkContext
22/01/06 15:23:51 INFO ShutdownHookManager: Shutdown hook called
22/01/06 15:23:51 INFO ShutdownHookManager: Deleting directory %LOCALAPPDATA%\spark-88e0922c-85d9-46a8-9d88-247d87f9f07c
22/01/06 15:23:51 INFO ShutdownHookManager: Deleting directory %LOCALAPPDATA%\spark-ca8a516f-fc90-410b-a633-4c362d203023
</pre>
</dd></dl>
-->

***

*[mics](https://lampwww.epfl.ch/~michelou/)/May 2024* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[apache_hadoop]: https://hadoop.apache.org/
[apache_spark]: https://spark.apache.org
[hdfs]: https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/HdfsDesign.html
[yarn]: https://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/YARN.html

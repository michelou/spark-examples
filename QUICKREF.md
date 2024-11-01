# <span id="top">Spark Quick Reference</span> <span style="font-size:90%;">[↩](README.md#top)</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://spark.apache.org/"><img src="https://spark.apache.org/images/spark-logo-trademark.png" width="120" alt="Spark project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This document gathers <a href="https://spark.apache.org/" rel="external">Spark</a> related tips and hints.
  </td>
  </tr>
</table>

## <span id="abbreviations">Abbreviations</span>

| Abbreviation | Description                    |
|:------------:|:-------------------------------|
| AES          | Advanced Encryption Standard   |
| DAG          | Direct Acyclic Graph           |
| HDFS         | Hadoop Distributed File System |
| ML           | Machine Learning               |
| OLAP         | Online Analytical Processing   |
| RDD          | [Resilient Distributed Dataset][databricks_rdd] |
| UDF          | User-defined Functions         |
| UDTF         | User-defined Table Functions   |
| YARN         | [Yet Another Resource Negotiator][techtarget_yarn] |

## <span id="properties">Spark Properties</span> [**&#x25B4;**](#top)

Spark configuration can be specified in three ways:
- Using a property file (either option `--properties-file FILE` or file `conf\spark-defaults.conf` as default location).
- Programmatically with setter methods of [`org.apache.spark.SparkConf`](https://spark.apache.org/docs/latest/api/java/org/apache/spark/SparkConf.html).
- Using dedicated command line options or `-c PROP=VALUE` for arbitrary properties.

For instance (see also article ["Spark submit --num-executors --executor-cores --executor-memory"](https://kontext.tech/article/977/spark-submit-num-executors-executor-cores-executor-memory), March 2022):

| Programmatically                        | Command&nbsp;line option |   |
|:----------------------------------------|:-------------------------|:--|
| `.set("spark.executor.cores", "8")`     | `--executor-cores 8`     |   |
| `.set("spark.executor.memory", "128m")` | `--executor-memory 128m` |   |
| `.setAppName("name")`                   | `--name "name"`          |   |
| `.setMaster("local[2]")`                | `--master "local[2]"`    |   |
| `.setSparkHome("<some path>")`          | `--` | |

<!-- https://sparkbyexamples.com/spark/spark-submit-command/ -->
> **Note**: The **`spark-submit`** command internally uses [`org.apache.spark.deploy.SparkSubmit`](https://github.com/apache/spark/blob/master/core/src/main/scala/org/apache/spark/deploy/SparkSubmit.scala) class with the options and command line arguments you specify.

---

*[mics](https://lampwww.epfl.ch/~michelou/)/November 2024* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[blog_meakins]: https://pivotalbi.com/build-your-own-winutils-for-spark/
[databricks_rdd]: https://databricks.com/glossary/what-is-rdd
[techtarget_yarn]: https://www.techtarget.com/searchdatamanagement/definition/Apache-Hadoop-YARN-Yet-Another-Resource-Negotiator

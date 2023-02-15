# <span id="top">Spark Quick Reference</span> <span style="size:30%;"><a href="README.md">↩</a></span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://spark.apache.org/"><img src="https://spark.apache.org/images/spark-logo-trademark.png" width="120" alt="Spark project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This document gathers <a href="https://spark.apache.org/" rel="external">Spark</a> related tips and hints.
  </td>
  </tr>
</table>

## <span id="abbreviations">Abbreviations</span>

| Abbreviation |                                |
|:------------:|:-------------------------------|
| DAG          | Direct Acyclic Graph           |
| HDFS         | Hadoop Distributed File System |
| ML           | Machine Learning               |
| OLAP         | Online Analytical Processing   |
| RDD          | [Resilient Distributed Dataset][databricks_rdd] |

## <span id="properties">Spark Properties</span>

| Programmatically         | Command line option   |   |
|:-------------------------|:----------------------|:--|
| `.setAppName("name")`    | `--name "name"`       |   |
| `.setMaster("local[2]")` | `--master "local[2]"` | |

<!-- https://sparkbyexamples.com/spark/spark-submit-command/ -->
> **Note**: `spark-submit` command internally uses org.apache.spark.deploy.SparkSubmit class with the options and command line arguments you specify.

---

*[mics](https://lampwww.epfl.ch/~michelou/)/February 2023* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[blog_meakins]: https://pivotalbi.com/build-your-own-winutils-for-spark/
[databricks_rdd]: https://databricks.com/glossary/what-is-rdd

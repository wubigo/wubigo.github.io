---
layout: post
title: Develop Apache Spark Apps with IntelliJ IDEA on Windows OS
date: 2012-10-04
tag: Bigdata
---

# mapr downside with intermediate state
“MapReduce’s approach of fully materializing intermediate state has downsides compared to Unix pipes:
* A MapReduce job can only start when all tasks in the preceding jobs (that generate”“its inputs) have completed, whereas processes connected by a Unix pipe are started at the same time, with output being consumed as soon as it is produced. Skew or varying load on different machines means that a job often has a few straggler tasks that take much longer to complete than the others. Having to wait until all of the preceding job’s tasks have completed slows down the execution of the workflow as a whole.
* Mappers are often redundant: they just read back the same file that was just written by a reducer, and prepare it for the next stage of partitioning and sorting. In many cases, the mapper code could be part of the previous reducer: if the reducer output was partitioned and sorted in the same way as mapper output, then reducers could be chained together directly, without interleaving with mapper stages.
* “Storing intermediate state in a distributed filesystem means those files are replicated across several nodes, which is often overkill for such temporary data”


# Develop Apache Spark Apps with IntelliJ IDEA on Windows OS

[https://www.linkedin.com/pulse/develop-apache-spark-apps-intellij-idea-windows-os-samuel-yee](https://www.linkedin.com/pulse/develop-apache-spark-apps-intellij-idea-windows-os-samuel-yee)


# Spark notes

[http://stackoverflow.com/questions/40796818/how-to-append-a-resource-jar-for-spark-submit](http://stackoverflow.com/questions/40796818/how-to-append-a-resource-jar-for-spark-submit)
Set SPARK_PRINT_LAUNCH_COMMAND environment variable to have the complete Spark command printed out to the console, e.g. $ SPARK_PRINT_LAUNCH_COMMAND=1 ./bin/spark-shell Spark Command: /Library/Ja... Refer to Print Launch Command of Spark Scripts (or org.apache.spark.launcher.Main Standalone Application where this environment variable is actually used). Tip Avoid using scala.App trait for a Spark app
 docker run -v `pwd`:/data -e SPARK_PRINT_LAUNCH_COMMAND=1 -it heuermh/adam adam-shell
Avoid using scala.App trait for a Spark application’s main class in Scala as

reported in SPARK-4170 Closure problems when running Scala app that "extends

App".

Refer to Executing Main — runMain internal method in this document.

Make sure to use the same version of Scala as the one used to build your distribution of Spark. Pre-built distributions of Spark 1.x use Scala 2.10, while pre-built distributions of Spark 2.0.x use Scala 2.11.
10
down vote

Steps to install Spark(1.6.2-bin-hadoop2.6)prebuild in local mode  on windows:

Install Java 7 or later. To test java installation is complete, open command prompt type javaand hit enter. If you receive a message 'Java' is not recognized as an internal or external command. You need to configure your environment variables, JAVA_HOME and PATHto point to the path of jdk.

Download and install Scala.

Set SCALA_HOME in Control Panel\System and Security\System goto "Adv System settings" and add %SCALA_HOME%\bin in PATH variable in environment variables.

Install Python 2.6 or later from Python Download link.

Download SBT. Install it and set SBT_HOME as an environment variable with value as <<SBT PATH>>.
Download winutils.exe from HortonWorks repo or git repo. Since we don't have a local Hadoop installation on Windows we have to download winutils.exe and place it in a bindirectory under a created Hadoop home directory. Set HADOOP_HOME = <<Hadoop home directory>> in environment variable.and add it to path env
We will be using a pre-built Spark package, so choose a Spark pre-built package for Hadoop Spark download. Download and extract it.

Set SPARK_HOME and add %SPARK_HOME%\bin in PATH variable in environment variables.

Run command: spark-shell

Open http://localhost:4040/ in a browser to see the SparkContext web UI.


$ cat rdd1.txt
chr1    10016
chr1    10017
chr1    10018
chr1    20026
scala> val lines = sc.textFile("/data/rdd1.txt")


scala> case class Chrom(name: String, value: Long)

defined class Chrom


scala> val chroms = lines.map(_.split("\\s+")).map(r => Chrom(r(0), r(1).toLong))

chroms: org.apache.spark.rdd.RDD[Chrom] = MapPartitionsRDD[5] at map at <console>:28


scala> val df = chroms.toDF

16/10/28 16:17:42 WARN ObjectStore: Version information not found in metastore. hive.metastore.schema.verification is not enabled so recording the schema version 1.2.0

16/10/28 16:17:43 WARN ObjectStore: Failed to get database default, returning NoSuchObjectException

df: org.apache.spark.sql.DataFrame = [name: string, value: bigint]


scala> df.show

+----+-----+

|name|value|

+----+-----+

|chr1|10016|

|chr1|10017|

|chr1|10018|

|chr1|20026|

|chr1|20036|

|chr1|30016|

|chr1|30026|

|chr2|40016|

|chr2|40116|

|chr2|50016|

|chr3|70016|

+----+-----+

scala> df.filter('value > 30000).show

+----+-----+

|name|value|

+----+-----+

|chr1|30016|

|chr1|30026|

|chr2|40016|

|chr2|40116|

|chr2|50016|

|chr3|70016|



+----+-----+


scala> case class Chrom2(name: String, value: Long, value: Long)

scala> val chroms2 = rdd2.map(_.split("\\s+")).map(r => Chrom2(r(0), r(1).toLong, r(2).toLong))



chroms2: org.apache.spark.rdd.RDD[Chrom2] = MapPartitionsRDD[35] at map at <console>:28


scala> val df2=chroms2.toDF



df2: org.apache.spark.sql.DataFrame = [name: string, min: bigint ... 1 more field]


scala> df.join(df2, Seq("name")).where($"value".between($"min", $"max")).groupBy($"name").count().show()









$./bin/spark-shell --packages com.databricks:spark-csv_2.11:1.2

.0







Your csv file does not have the same number of fields in each row - this cannot be parsed as is into a DataFrame





As of Spark 2.0.0, DataFrame - the flagship data abstraction of previous
versions of Spark SQL - is currently a mere type alias for Dataset[Row] :





A Dataset is local if it was created from local collections using SparkSession.emptyDataset
or SparkSession.createDataset methods and their derivatives like toDF. If so, the queries on
the Dataset can be optimized and run locally, i.e. without using Spark executors.

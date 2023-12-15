name := "HelloWorld"

version := "0.1.0"

scalaVersion := "2.13.12"

scalacOptions ++= Seq(
  "-encoding",
  "UTF-8",
  "-deprecation"
)

useCoursier := false

// Dependencies with "provided" scope are only available during compilation
// and testing, and are not available at runtime or for packaging
val sparkVersion = "3.5.0"

// https://mvnrepository.com/artifact/org.apache.spark/spark-core
libraryDependencies += "org.apache.spark" %% "spark-core" % sparkVersion //% "provided"

// https://mvnrepository.com/artifact/org.apache.spark/spark-sql
libraryDependencies += "org.apache.spark" %% "spark-sql" % sparkVersion //% "provided"

ThisBuild / assemblyMergeStrategy := {
  case _ => MergeStrategy.first
  //case x =>
  //  val oldStrategy = (ThisBuild / assemblyMergeStrategy).value
  //  oldStrategy(x)
}

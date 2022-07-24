name := "HelloWorld"

version := "0.1.0"

scalaVersion := "2.13.8"

scalacOptions ++= Seq(
  "-encoding",
  "UTF-8",
  "-deprecation"
)

useCoursier := false

// Dependencies with "provided" scope are only available during compilation
// and testing, and are not available at runtime or for packaging
val sparkVersion = "3.2.1"

// https://mvnrepository.com/artifact/org.apache.spark/spark-core
libraryDependencies += "org.apache.spark" %% "spark-core" % sparkVersion % "provided"

// https://mvnrepository.com/artifact/org.apache.spark/spark-sql
libraryDependencies += "org.apache.spark" %% "spark-sql" % sparkVersion % "provided"

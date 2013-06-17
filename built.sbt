import AssemblyKeys._

organization := "com.janprach.scala-boot"

name := "scala-boot"

version := "0.0.1-SNAPSHOT"

scalaVersion := "2.10.2"

libraryDependencies ++= Seq(
  "org.scalatest" %% "scalatest" % "2.0.M6-SNAP21" % "test"
)

assemblySettings

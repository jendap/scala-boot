import AssemblyKeys._

organization := "com.janprach.scala-boot"

name := "scala-boot"

version := "0.0.1-SNAPSHOT"

scalaVersion := "2.11.4"

libraryDependencies ++= Seq(
  "org.scalatest" %% "scalatest" % "2.2.2" % "test"
)

assemblySettings

// I would personally prefer sbt to use these scala files.
// But even the latest sbt documentation still explicitly
// prefer *.sbt files.

/*
import sbt._
import Keys._
import sbtassembly.Plugin._
import AssemblyKeys._

object ScalaBootBuild extends Build {
  lazy val buildSettings = Defaults.defaultSettings ++ Seq(
    organization := "com.janprach.scala-boot",
    version := "0.0.1-SNAPSHOT",
    scalaVersion := "2.10.2",
    libraryDependencies ++= Seq(
      "org.scalatest" %% "scalatest" % "2.0.M6-SNAP21" % "test"
    )
  )

  lazy val scalaBoot = Project(
    id = "scala-boot",
    base = file("."),
    settings = buildSettings ++ assemblySettings ++ Seq(
      // additional custom settings
    )
  )
}
*/

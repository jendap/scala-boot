import sbt._
import Keys._
import sbtassembly.AssemblyPlugin.autoImport._

object ScalaBootBuild extends Build {
  lazy val commonSettings = Seq(
    organization := "com.janprach.scala-boot",
    version := "0.0.1-SNAPSHOT",
    scalaVersion := "2.11.7",
    libraryDependencies ++= Seq(
      "org.scalatest" %% "scalatest" % "2.2.4" % "test"
    )
  )

  lazy val scalaBoot = Project(
    id = "scala-boot",
    base = file("."),
    settings = commonSettings ++ Seq(
      // additional custom settings
      updateOptions := updateOptions.value.withCachedResolution(true)
    )
  )
}

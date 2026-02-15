name := "play-docker"

version := "1.0.0"

scalaVersion := "3.8.1"

libraryDependencies += guice

lazy val root = (project in file(".")).enablePlugins(PlayJava)
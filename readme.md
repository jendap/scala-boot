Scala Playground
================


What
----

This is sample Scala project to hwlp people fet started with Scala. Try out Scala.

This project does not focus on actual Scala. At least not quite yet. It's about
development tooling best practicies. It's about IDE and build system. Those aspects
are done well here. So you can focus your first efforts on Scala itsef and not fight
some monster tool or write a script to compile nor google where to download things.

There are things which are unnecessary complicated - mainly the pom.xml file. It can be
just a little fraction of what it is. But we encourage the best habits from the very
beginning and so it's done well rather than short.


Who
---

Target audience for this are people new to Scala.


How
---

Dependencies. Download and install:
 * [jdk](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
 * [maven](http://maven.apache.org/download.cgi)
 * [git](http://git-scm.com/downloads)

Clone the repository.
```sh
git clone https://github.com/jendap/scala-boot.git
```

Test.
```sh
mvn test
```

Package.
```sh
mvn package
```

Run.
```sh
java -jar target/scala-boot-*-jar-with-dependencies.jar
```


Why
---

__Project__ - Born to help me show off Scala and get people started with it.

__Tests__ - Nothing works without test. Code is never done without tests.
  It's hard to innovate or just maintain the code without tests. Tests are a must!

__Maven vs Sbt__ - Maven just works, has great documentation, great conventions
  and has great support in a lot of tools. Plus you can use it for java, clojure, etc.
  Sbt build is also present because for good or bad it is a de facto standard build
  tool in Scala ecosystem.

__Scala Worksheets__ - Nice thing! But at least in Eclipse they tend to change
  the worksheet file, which is bad for source code versioning. Plus once you
  understand what a test is there's not much use for worksheets. I.e. worksheets
  are, imho, good for a first Scala lesson, bad for fifth.


IDE
---

I would recommend using one of the leading java IDEs - Eclipse, Idea or Netbeans.
In that order. Idea has some parts of Scala support better but worse than Eclipse.
Netbeans has probably least advanced Scala support of them all.

Manual install - just install Eclipse or Idea manually and their respective Scala plugins.

These are two scripts included for Eclipse. The first one can install Eclipse
with Scala plugin.
```sh
./support/install-eclipse.sh
```

The script takes optional argument with a directory where the Eclipse should be
installed. The default directory is _$HOME/eclipse.scala_.

Note: The script was tested only on Ubuntu 13.04. It may work on Debian and Fedora
based distributions as well. It may (untested) work even on Mac OS X.

The second script can run the newly installed Eclipse.
```sh
./support/run-eclipse.sh
```

Start using Eclipse and import your first maven project into Eclipse:
 1. There will be two dialog windows from Scala plugin. Just click OK.
 2. Close the welcome screen.
 3. Go to menu: _File_ -> _Import..._ -> _Maven_ -> _Existing Maven Projects_
 4. Select directory where you've cloned this project.
 5. Look around! There are some Scala files! Open them! Go to menu: _Run_ -> _Run as_ -> _..._
 6. Enjoy!

__Tip:__ You can import from git directly - explore _Git_ instead of _Maven_
in the _Import..._ dialog.


Maven 101
---------

 * `mvn clean` - cleanup all the stuff created by the build process
 * `mvn compile` - just compile
 * `mvn test` - run tests
 * `mvn package` - create jar files for deployment
 * `mvn verify` - run integration tests
 * `mvn install` - install into your $HOME/.m2 directory

__Tip:__ Try `mvn -q test` if you don't like all the logging messages maven prints by default.

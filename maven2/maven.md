maven 
=======================
mvn archetype:generate -DgroupId={project-packaging} 
   -DartifactId={project-name} 
   -DarchetypeArtifactId=maven-archetype-quickstart 
   -DinteractiveMode=false
   
   mvn archetype:generate -DgroupId=com.mkyong -DartifactId=NumberGenerator \
	-DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
	
mvn eclipse:eclipse
mvn compile
mvn package

mvn install(jar)
mvn deploy(repo)

========================================================================
mvn install:install-file \
  -DgroupId=javax.transaction \
  -DartifactId=jta \
  -Dpackaging=jar \
  -Dversion=1.0.1B \
  -Dfile=jta-1.0.1B.jar \
  -DgeneratePom=true
mvn install:install-file -Dfile=/home/max/Downloads/jaudiotagger-2.2.4-SNAPSHOT.jar -DgroupId=org     -DartifactId=jaudiotagger -Dversion=2.2.4-SNAPSHOT -Dpackaging=jar
mvn install:install-file -Dfile=/home/max/Downloads/jaudiotagger-2.0.4-SNAPSHOT.jar -DgroupId=org     -DartifactId=jaudiotagger -Dversion=2.0.4-SNAPSHOT -Dpackaging=jar

j2ee 7 with maven:
mvn -DarchetypeGroupId=org.codehaus.mojo.archetypes -DarchetypeArtifactId=webapp-javaee7 -DarchetypeVersion=0.1-SNAPSHOT -DarchetypeRepository=https://nexus.codehaus.org/content/repositories/snapshots/ -DgroupId=org.glassfish -DartifactId=javaee7-sample -Dversion=1.0-SNAPSHOT -Dpackage=org.glassfish.javaee7-sample -Darchetype.interactive=false --batch-mode --update-snapshots archetype:generate


maven web 2.0
mvn archetype:generate -DgroupId={project-packaging} 
	-DartifactId={project-name} 
	-DarchetypeArtifactId=maven-archetype-webapp 
	-DinteractiveMode=false
 
//for example 
$ mvn archetype:generate -DgroupId=com.mkyong 
	-DartifactId=CounterWebApp 
	-DarchetypeArtifactId=maven-archetype-webapp 
	-DinteractiveMode=false

mvn eclipse:eclipse -Dwtpversion=2.0

mvn dependency:copy-dependencies

test
================
The Surefire Plugin is used during the test phase of the build lifecycle to execute the unit tests of an application
mvn -Dtest=TestCircle#testOne+testTwo test

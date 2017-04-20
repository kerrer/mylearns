mvn jetty jrebel:
===
1. export REBEL_HOME="/work/java/jrebel/6.5.2/lib"
   export MAVEN_OPTS="-noverify -agentpath:$REBEL_HOME/libjrebel64.so"
   
2. jetty plugin: <scanIntervalSeconds>0</scanIntervalSeconds>

3. pom.xml: 
    <plugin>
				<groupId>org.zeroturnaround</groupId>
				<artifactId>jrebel-maven-plugin</artifactId>
				<version>1.1.6</version>
				<executions>
					<execution>
						<id>generate-rebel-xml</id>
						<phase>process-resources</phase>
						<goals>
							<goal>generate</goal>
						</goals>
					</execution>
				</executions>
	</plugin>
			
	
		
tomcat jrebel:
===
export REBEL_HOME="/work/java/jrebel/6.5.2/lib"
export CATALINA_OPTS="$CATALINA_OPTS -noverify -agentpath:$REBEL_HOME/libjrebel64.so -Drebel.properties=$REBEL_HOME/config/jrebel.properties -Drebel.disable_update=true "

mvn jetty xrebel(web gui)
===
export XREBEL_HOME="/work/java/jrebel/xrebel-3.1.3"
export MAVEN_OPTS="-noverify -javaagent:$XREBEL_HOME/xrebel.jar"

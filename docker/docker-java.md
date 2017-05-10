activiti
===

CREATE USER 'activiti'@'%.%.%.%' IDENTIFIED BY 'password';
CREATE DATABASE IF NOT EXISTS `activiti_production` DEFAULT CHARACTER SET `utf8` COLLATE `utf8_unicode_ci`;
GRANT ALL PRIVILEGES ON `activiti_production`.* TO 'activiti'@'%.%.%.%';

docker run --name=activiti -it --rm \
-p 9080:8080 --link mysql:mysql \
-v /var/run/docker.sock:/run/docker.sock \
-v /usr/bin/docker:/bin/docker \
-e 'DB_NAME=activiti_production' -e 'DB_USER=activiti' -e 'DB_PASS=mmmm' \
-e 'TOMCAT_ADMIN_USER=admin' -e 'TOMCAT_ADMIN_PASSWORD=mmmm' \
eternnoir/activiti



sonarqube:9092
================================
docker run -d --name sonarqube -p 9333:9000 -p 9092:9092 sonarqube
docker run -d --name sonarqube --link postgres:postgres \
    -p 9000:9000 -p 9092:9092 \
    -e SONARQUBE_JDBC_USERNAME=postgres \
    -e SONARQUBE_JDBC_PASSWORD=mmmm \
    -e SONARQUBE_JDBC_URL=jdbc:postgresql://postgres:5432/sonar \
    sonarqube

#maven私服
1. nexus3 admin:mmmm
==================================
mkdir /some/dir/nexus-data && chown -R 200 /some/dir/nexus-data
docker run -d --restart=always -p 2525:8081 --name nexus -v /work/data/nexus:/nexus-data sonatype/nexus3

2. artifactory
=========================
docker run --name artifactory -d -v /work/data/jfrog/artifactory:/var/opt/jfrog/artifactory -p 3636:8081 docker.bintray.io/jfrog/artifactory-oss

admin password or mmmm
docker run --name artifactory -d  -p 4646:8080 mattgruter/artifactory

3. admin 1t
=========================================
docker run -d --name archiva -h archiva -d -p 4545:8080 -v /work/data/archiva:/archiva-data xetusoss/archiva


jenkins【CI】(单机/分布式):3131
===============================================
docker run -d --restart=always --name jenkins -p 3131:8080 -p 50000:50000 -v /work/data/jenkins/home:/var/jenkins_home jenkins

 - login:admin mmmm
 - cli:
   ----------------
   wget http://localhost:3131/jnlpJars/jenkins-cli.jar
   java -jar jenkins-cli.jar -s http://localhost:3131 help
   java -jar jenkins-cli.jar -s http://localhost:3131  install-plugin  --username admin --password mmmm checkstyle cloverphp crap4j dry htmlpublisher jdepend plot pmd violations warnings xunit
   java -jar jenkins-cli.jar -s http://localhost:3131 safe-restart

jira
==
docker run --name jira --detach --publish 9000:8080 cptactionhank/atlassian-jira:latest

jmeter(单机/分布式)
=====================
docker run -d -P --name slave1 -v /Users/cagdas/docker_mnt/:/jmeter_log cirit/jmeter:slave -j /jmeter_log/slave1.log
docker run -d -P --name master -v /Users/cagdas/docker_mnt/:/jmeter_log --link slave1 --link slave2 --link slave3 
cirit/jmeter:master -t /jmeter_log/test.jmx -R slave1,slave2,slave3 -j /jmeter_log/master.log -l /jmeter_log/result.jtl -X
--------------
docker run -d -P --name gslave1 -v /work/data/jmeter/slave1/:/jmeter_log cirit/jmeter:slave_running_gatling -j /jmeter_log/gslave1.log

docker run -d -P --name gmaster -v /work/data/jmeter/master/:/jmeter_log --link gslave1 --link gslave2 --link gslave3 cirit/jmeter:master -t /jmeter_log/test_gatling.jmx -R gslave1,gslave2,gslave3 -j /jmeter_log/master.log -l /jmeter_log/result.jtl -X -GatlingMode=ON -GatlingSimulationsPath=/jmeter/simulations -GatlingTestRunOptions="-nr -m -s sample.TestSimulation"

docker run -d -P --name gmaster -v /work/data/jmeter/master/:/jmeter_log --link gslave1  cirit/jmeter:master -t /jmeter_log/test_gatling.jmx -R gslave1 -j /jmeter_log/master.log -l /jmeter_log/result.jtl -X -GatlingMode=ON -GatlingSimulationsPath=/jmeter/simulations -GatlingTestRunOptions="-nr -m -s sample.TestSimulation"

Gatling作为一款开源免费的性能测试工具
gatling(单机/分布式)
=====
docker run -it --rm denvazh/gatling
Mount configuration and simulation files from host machine and run gatling in interactive mode

docker run -it --rm -v /home/core/gatling/conf:/opt/gatling/conf \
-v /home/core/gatling/user-files:/opt/gatling/user-files \
-v /home/core/gatling/results:/opt/gatling/results \
denvazh/gatling


gocd 【CI】(单机/分布式)
========================================================================
docker run -d  --name go-server -e AGENT_KEY=388b633a88de126531afa41eff9aa69e -p 8153:8153 -p 8154:8154 gocd/gocd-server
docker run -d  --name go-agent --link go-server:go-server -e AGENT_KEY=388b633a88de126531afa41eff9aa69e gocd/gocd-agent


gitlab 【CI】(单机/分布式)
========================================================================
 - docker run --detach --restart=always \
    --hostname git.max.com \
    --env GITLAB_OMNIBUS_CONFIG="external_url "http://git.max.com:8929"; gitlab_rails['gitlab_shell_ssh_port'] = 2289;" \
    --publish 8929:8929 --publish 2289:2289 \
    --name gitlab \
    --restart always \
    --volume /work/data/gitlab/config:/etc/gitlab \
    --volume /work/data/gitlab/logs:/var/log/gitlab \
    --volume /work/data/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest

 - docker run -d --restart=always --name gitlab-runner --restart always \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v /work/data/gitlab/runner/config:/etc/gitlab-runner  --link gitlab:gitlab \
   gitlab/gitlab-runner:latest

 - docker exec -it gitlab-runner gitlab-runner  register -n \
   --url http://git.max.com:8929/ci \
   --registration-token DgftTEFGjEGLP3ZgSTxj \
   --executor docker \
   --description "maven 3.3.9-jdk-8" \
   --docker-image "maven:3.3.9-jdk-8" \
   --docker-links "gitlab:gitlab" \
   --docker-volumes /var/run/docker.sock:/var/run/docker.sock
  
 - docker exec -it gitlab-runner gitlab-runner unregister \
     --url  http://git.max.com:8929/ci --token fd31deecb8a007aabc59ce4c036c9a

gogs
========================================================================
docker run --name=gogs -p 10022:22 -p 10080:3000 -v /work/data/gogs:/data gogs/gogs

gerrit
========================================================================
docker run -d -v ~/gerrit_volume:/var/gerrit/review_site -p 8080:8080 -p 29418:29418 openfrontier/gerrit


:redmine
========================================================================

docker run -d --name redmine -p 3000:3000 --link postgres:postgres redmine

1. docker run -d --name mysql-redmine \
   -e MYSQL_ROOT_PASSWORD=mmmm -e MYSQL_DATABASE=redmine  \
   -v /work/data/mysql/redmine:/var/lib/mysql mysql

2. docker run -d --name redmine -p 3000:3000 \
  -v /work/data/redmine/files:/usr/src/redmine/files \
  -v /work/data/redmine/plugins:/usr/src/redmine/plugins  \
  --link mysql-redmine:mysql redmine

drools
=============================================
1. docker run -p 8085:8080 -p 8001:8001 -v /work/data/drools/wb_git:/opt/jboss/wildfly/bin/.niogit -d --name drools-workbench   jboss/drools-workbench-showcase
   http://localhost:8080/drools-wb
   
USER        PASSWORD    ROLE
*************************************************
admin       admin       admin,analyst,kiemgmt
krisv       krisv       admin,analyst
john        john        analyst,Accounting,PM
mary        mary        analyst,HR
sales-rep   sales-rep   analyst,sales
katy        katy        analyst,HR
jack        jack        analyst,IT
salaboy     salaboy     admin,analyst,IT,HR,Accounting

2. docker run -p 8080:8080 -p 8001:8001 -d --name jbpm-workbench jboss/jbpm-workbench-showcase
http://localhost:8080/jbpm-console

USER        PASSWORD    ROLE
*************************************************
admin       admin       admin,analyst,kiemgmt
krisv       krisv       admin,analyst
john        john        analyst,Accounting,PM
mary        mary        analyst,HR
sales-rep   sales-rep   analyst,sales
katy        katy        analyst,HR
jack        jack        analyst,IT
salaboy     salaboy     admin,analyst,IT,HR,Accounting

3. docker run -p 8180:8080 -p 9990:9990 -d --name kie-server --link drools-workbench:kie_wb jboss/kie-server-showcase
http://localhost:8180/kie-server
This image provides a default user kieserver using password kieserver1! and with the role kie-server
 
 USER        PASSWORD    ROLE
*************************************************
admin       admin       admin,analyst,kiemgmt
krisv       krisv       admin,analyst
john        john        analyst,Accounting,PM
mary        mary        analyst,HR
sales-rep   sales-rep   analyst,sales
katy        katy        analyst,HR
jack        jack        analyst,IT
salaboy     salaboy     admin,analyst,IT,HR,Accounting



activiti
=========
1. docker run --name=mysql_activiti -d \
   -e MYSQL_ROOT_PASSWORD=mmmm \
   -e MYSQL_DATABASE=activiti_production \
   -e MYSQL_USER=activiti -e MYSQL_PASSWORD=mmmm \
    -v /work/data/mysql/activiti:/var/lib/mysql mysql

2. docker run --name=activiti -d -p 8089:8080 --link mysql_activiti:mysql \
   -e DB_NAME=activiti_production -e DB_USER=activiti -e DB_PASS=mmmm \
   eternnoir/activiti
  
3. login
username: kermit
password: kermit


jboos jbpm
================
docker run -p 8080:8080 -p 8001:8001 -d --name jbpm-workbench jboss/jbpm-workbench-showcase:latest
docker run -p 8080:8080 -p 8001:8001 -v /work/data/jboss/jbpm/wb_git:/opt/jboss/wildfly/bin/.niogit -d --name jbpm-workbench jboss/jbpm-workbench-showcase





docker pull apereo/cas
============================
1. 
keytool -genkey -alias tomcat -keyalg RSA -keypass changeit -storepass changeit -keystore server.keystore -validity 3600
keytool -export -trustcacerts -alias tomcat -file server.cer -keystore server.keystore -storepass changeit
cp server.cer /usr/java/latest/jre/lib/security/server.cer
keytool -import -trustcacerts -alias tomcat -keystore "/usr/java/latest/jre/lib/security/cacerts" -file "/usr/java/latest/jre/lib/security/server.cer" -storepass changeit
2. 
docker run -d -p 8080:8080 -p 8443:8443 --name cas --link mysql:db -v /etc/cas:/cas-overlay/etc/cas apereo/cas:v5.0.5
3. 
./gradlew clean build
./gradlew bootRun

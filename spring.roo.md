project --topLevelPackage com.tenminutes
persistence setup --provider HIBERNATE --database HYPERSONIC_IN_MEMORY
entity --class ~.Timer --testAutomatically
field string --fieldName message --notNull
controller all --package ~.web
selenium test --controller ~.web.TimerController
perform tests
perform package
perform eclipse
mvn tomcat:run


==========

project --topLevelpackage com.dw.roo.conference --java 6 --projectName conference
jpa setup --database MYSQL --provider HIBERNATE --userName root --passwordd mmmm --databaseName conference
database properties list
database properties set --key database.usl --value jdbc:mysql://localhost:3306/confreces?characterEncoding=UTF-8
entity jpa --class ~.domain.Speaker --testAutomatically
entity jpa --class ~.domain.Talk  --testAutomatically
field string --fieldName firstname --class ~.domain.Speaker --notNull 
 field string --fieldName lastname --notNull 
 field string --fieldName email --unique --notNull
 field string --fieldName organization 
 field date --fieldName birthdate --type java.util.Date --past --notNull 
 field number --type java.lang.Long --fieldName age --min 25 --max 60
 

:
: https://maven.apache.org/guides/getting-started/
:
: Create simple mavent project:
:   mvn -B archetype:generate \
:   -DarchetypeGroupId=org.apache.maven.archetypes \
:   -DgroupId=com.mycompany.app \
:   -DartifactId=my-app
:
: Compile and Test
:   mvn compile
:   mvn test
:   mvn test-compile
:
: Create a JAR
:   mvn package
:
: Clean
:   mvn clean
:
: Generate an IntelliJ IDEA descriptor for the project
:   mvn idea:idea
:
@ echo off
set JDK_HOME=C:\Program Files\Java\jdk1.8.0_77
set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_77\jre
: If HOME is set
: set MAVEN_HOME=%HOME%\maven-3.3.9
set MAVEN_HOME=%USERPROFILE%\maven-3.3.9

set PATH=%JAVA_HOME%\bin;%MAVEN_HOME%\bin;C:\Windows\system32

: This are options for Java VM
: set MAVEN_OPTS=--offline

echo ========================================================================
echo        MAVEN_HOME=%MAVEN_HOME%
echo          JDK_HOME=%JDK_HOME%
echo         JAVA_HOME=%JAVA_HOME%
echo ========================================================================
echo on


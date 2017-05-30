@echo off
:: ---------------------------------------------------------------------
:: IntelliJ IDEA startup script.
:: ---------------------------------------------------------------------

:: Which IDE we use (Idea or CLion)
:: PLATFORM_PREFIX Must be 'CLion' or 'Idea'
set PLATFORM_PREFIX=Idea
set IDE_HOME_NAME=IdeaIC2017
set IDE_CFG_DIR=%USERPROFILE%\.config\.IdeaIC2017.3

:: Log, dump file locations
set LOG_DIR=%USERPROFILE%\log
set ETC_DIR=%USERPROFILE%\etc
set BIN_DIR=%USERPROFILE%\bin

:: IDE Home, propeties, etc
set IDE_BIN_DIR=%USERPROFILE%\%IDE_HOME_NAME%\bin
set IDE_HOME=%USERPROFILE%\%IDE_HOME_NAME%
set IDE_PROPERTIES_PROPERTY="%ETC_DIR%/%PLATFORM_PREFIX%.properties"
set LOG_CONFIG_FILE=%ETC_DIR%\%PLATFORM_PREFIX%.log.properties

SET BITS=
IF EXIST "%JRE%\lib\amd64" SET BITS=64
set VM_OPTIONS_FILE=%ETC_DIR%\%PLATFORM_PREFIX%%BITS%.vmoptions

:: Java
SET JAVA_EXE=javaw.exe
set JDK=C:\Program Files\Java\jdk1.8.0_131

:: PATH
set PATH=%JDK%\bin;C:\windows\system32

IF "%PLATFORM_PREFIX%" == "Idea" (
 set IDEA_ARGS=-Didea.jre.check=true
 IF EXIST "%IDEA_JDK%" (
   set JDK=%IDEA_JDK%
 )
 IF NOT "%IDEA_CLASSPATH%" == "" SET CLASSPATH=%IDEA_CLASSPATH%;%CLASSPATH%
 IF NOT "%IDEA_PROPERTIES%" == "" SET IDE_PROPERTIES_PROPERTY="%IDEA_PROPERTIES%"
 IF NOT "%IDEA_VM_OPTIONS%" == "" SET VM_OPTIONS_FILE=%IDEA_VM_OPTIONS%
) ELSE (
 :: Note a space after equal sign
 set IDEA_ARGS= 
 IF EXIST "%CL_JDK%" (
   set JDK=%CL_JDK%
 )
 IF NOT "%CL_CLASSPATH%" == "" SET CLASSPATH=%CL_CLASSPATH%;%CLASSPATH%
 IF NOT "%CL_PROPERTIES%" == "" SET IDE_PROPERTIES_PROPERTY="%CL_PROPERTIES%"
 IF NOT "%CL_VM_OPTIONS%" == "" SET VM_OPTIONS_FILE=%CL_VM_OPTIONS%
)
set JDK_HOME=%JDK%
set JDK_BIN_DIR=%JDK%\bin
set JAVA_HOME=%JDK%\jre
set JRE=%JAVA_HOME%

:: Note a space after equal sign
setlocal EnableDelayedExpansion
set VM_OPTIONS= 
FOR /F "eol=# delims=" %%I IN (%VM_OPTIONS_FILE%) DO set VM_OPTIONS=!VM_OPTIONS! "%%I"

set JVM_ARGS=-Xbootclasspath/a:%IDE_HOME%/lib/boot.jar
set JVM_ARGS=%JVM_ARGS% -XX:ErrorFile=%LOG_DIR%/java_error_in_%PLATFORM_PREFIX%_%%p.log
set JVM_ARGS=%JVM_ARGS% -XX:HeapDumpPath=%LOG_DIR%/java_error_in_%PLATFORM_PREFIX%.hprof
:: set JVM_ARGS=%JVM_ARGS% -Djava.util.logging.config.file=%LOG_CONFIG_FILE%

set CLASSPATH=%IDE_HOME%\lib\bootstrap.jar
set CLASSPATH=%CLASSPATH%;%IDE_HOME%\lib\extensions.jar
set CLASSPATH=%CLASSPATH%;%IDE_HOME%\lib\util.jar
set CLASSPATH=%CLASSPATH%;%IDE_HOME%\lib\jdom.jar
set CLASSPATH=%CLASSPATH%;%IDE_HOME%\lib\log4j.jar
set CLASSPATH=%CLASSPATH%;%IDE_HOME%\lib\trove4j.jar
set CLASSPATH=%CLASSPATH%;%IDE_HOME%\lib\jna.jar
set CLASSPATH=%CLASSPATH%;%JDK%\lib\tools.jar

set PATH=%IDE_BIN_DIR%;%JDK_BIN_DIR%;C:\Windows\System32;C:\Windows

:: Create directories
IF NOT EXIST "%IDE_CFG_DIR%" mkdir "%IDE_CFG_DIR%"
IF NOT EXIST "%LOG_DIR%" mkdir "%LOG_DIR%"

echo ================================================================>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo PATH=%PATH%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo JDK=%JDK%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo JDK_HOME=%JDK_HOME%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo JRE=%JRE%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo JAVA_HOME=%JAVA_HOME%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo BITS=%BITS%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo PLATFORM_PREFIX=%PLATFORM_PREFIX%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo IDE_BIN_DIR=%IDE_BIN_DIR%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo IDE_HOME=%IDE_HOME%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
:: echo LOG_CONFIG_FILE=%LOG_CONFIG_FILE%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo VM_OPTIONS_FILE=%VM_OPTIONS_FILE%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo JVM_ARGS=%JVM_ARGS%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo IDEA_ARGS=%IDEA_ARGS%>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1
echo ================================================================>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1

:: ---------------------------------------------------------------------
:: Run the IDE.
:: ---------------------------------------------------------------------

echo on
start %JAVA_EXE% -classpath "%CLASSPATH%" ^
 %JVM_ARGS% ^
 %VM_OPTIONS% ^
 -Didea.paths.selector=%IDE_HOME_NAME% ^
 "-Djb.vmOptionsFile=%VM_OPTIONS_FILE%" ^
 -Didea.properties.file=%IDE_PROPERTIES_PROPERTY% ^
 -Didea.platform.prefix=%PLATFORM_PREFIX% %IDEA_ARGS% ^
 -Didea.system.path=%IDE_CFG_DIR%/system ^
 -Didea.config.path=%IDE_CFG_DIR%/config ^
 com.intellij.idea.Main %*>>%LOG_DIR%\%PLATFORM_PREFIX%_console.log 2>&1


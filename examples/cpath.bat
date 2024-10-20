@echo off
setlocal enabledelayedexpansion

@rem output parameter: _CPATH

if not defined _DEBUG set _DEBUG=%~1
if not defined _DEBUG set _DEBUG=0
set _VERBOSE=0

if not defined _MVN_CMD set "_MVN_CMD=%MAVEN_HOME%\bin\mvn.cmd"
if %_DEBUG%==1 echo [%~n0] "_MVN_CMD=%_MVN_CMD%" 1>&2

if %_DEBUG%==1 ( set _MVN_OPTS=
) else ( set _MVN_OPTS=--quiet
)
@rem use newer PowerShell version if available
where /q pwsh.exe
if %ERRORLEVEL%==0 ( set _PWSH_CMD=pwsh.exe
) else ( set _PWSH_CMD=powershell.exe
)
set __CENTRAL_REPO=https://repo1.maven.org/maven2
set "__LOCAL_REPO=%USERPROFILE%\.m2\repository"

set "__TEMP_DIR=%TEMP%\lib"
if not exist "%__TEMP_DIR%" mkdir "%__TEMP_DIR%"
if %_DEBUG%==1 echo [%~n0] "__TEMP_DIR=%__TEMP_DIR%" 1>&2

set _LIBS_CPATH=

set __SCALA_BINARY_VERSION=2.13

@rem https://mvnrepository.com/artifact/org.scala-lang/scala3-library
@rem call :add_jar "org.scala-lang" "scala3-library_3" "3.3.3"

@rem https://mvnrepository.com/artifact/org.scala-lang/scala-library
@rem Spark 3.5.1 depends on Scala standard library 2.13.8+
call :add_jar "org.scala-lang" "scala-library" "2.13.15"

set __SPARK_VERSION=3.5.3

@rem https://mvnrepository.com/artifact/org.apache.spark/spark-catalyst
@rem Note: contains symbol 'type org.apache.spark.sql.Row'
@rem call :add_jar "org.apache.spark" "spark-catalyst_%__SCALA_BINARY_VERSION%" "%__SPARK_VERSION%"

@rem https://mvnrepository.com/artifact/org.apache.spark/spark-common-utils
call :add_jar "org.apache.spark" "spark-common-utils_%__SCALA_BINARY_VERSION%" "%__SPARK_VERSION%"

@rem https://mvnrepository.com/artifact/org.apache.spark/spark-core
call :add_jar "org.apache.spark" "spark-core_%__SCALA_BINARY_VERSION%" "%__SPARK_VERSION%"

@rem https://mvnrepository.com/artifact/org.apache.spark/spark-launcher
@rem call :add_jar "org.apache.spark" "spark-launcher_%__SCALA_BINARY_VERSION%" "%__SPARK_VERSION%"

@rem https://mvnrepository.com/artifact/org.apache.spark/spark-sql
call :add_jar "org.apache.spark" "spark-sql_%__SCALA_BINARY_VERSION%" "%__SPARK_VERSION%"

@rem https://mvnrepository.com/artifact/org.apache.spark/spark-streaming
@rem call :add_jar "org.apache.spark" "spark-streaming_%__SCALA_BINARY_VERSION%" "%__SPARK_VERSION%"

@rem https://mvnrepository.com/artifact/org.apache.spark/spark-tags
call :add_jar "org.apache.spark" "spark-tags_%__SCALA_BINARY_VERSION%" "%__SPARK_VERSION%"

@rem https://mvnrepository.com/artifact/org.apache.spark/spark-unsafe
call :add_jar "org.apache.spark" "spark-unsafe_%__SCALA_BINARY_VERSION%" "%__SPARK_VERSION%"

set __FRAMELESS_VERSION=0.16.0

@rem https://mvnrepository.com/artifact/org.typelevel/frameless-core
call :add_jar "org.typelevel" "frameless-core_%__SCALA_BINARY_VERSION%" "%__FRAMELESS_VERSION%"

@rem https://mvnrepository.com/artifact/org.typelevel/frameless-dataset
call :add_jar "org.typelevel" "frameless-dataset_%__SCALA_BINARY_VERSION%" "%__FRAMELESS_VERSION%"

@rem https://mvnrepository.com/artifact/org.typelevel/frameless-dataset-spark32
@rem call :add_jar "org.typelevel" "frameless-dataset-spark32_%__SCALA_BINARY_VERSION%" "%__FRAMELESS_VERSION%"

@rem https://mvnrepository.com/artifact/org.typelevel/frameless-refined
call :add_jar "org.typelevel" "frameless-refined_%__SCALA_BINARY_VERSION%" "%__FRAMELESS_VERSION%"

@rem https://mvnrepository.com/artifact/com.github.pureconfig/pureconfig
call :add_jar "com.github.pureconfig" "pureconfig-core_3" "0.17.7"

goto end

@rem #########################################################################
@rem ## Subroutines

@rem input parameters: %1=group ID, %2=artifact ID, %3=version
@rem global variable: _LIBS_CPATH
:add_jar
@rem https://mvnrepository.com/artifact/org.portable-scala
set __GROUP_ID=%~1
set __ARTIFACT_ID=%~2
set __VERSION=%~3

set __JAR_NAME=%__ARTIFACT_ID%-%__VERSION%.jar
set __JAR_PATH=%__GROUP_ID:.=\%\%__ARTIFACT_ID:/=\%
set __JAR_FILE=
for /f "usebackq delims=" %%f in (`where /r "%__LOCAL_REPO%\%__JAR_PATH%" %__JAR_NAME% 2^>NUL`) do (
    set "__JAR_FILE=%%f"
)
if not exist "%__JAR_FILE%" (
    set "__JAR_URL=%__CENTRAL_REPO%/%__GROUP_ID:.=/%/%__ARTIFACT_ID%/%__VERSION%/%__JAR_NAME%"
    set "__JAR_FILE=%__TEMP_DIR%\%__JAR_NAME%"
    if not exist "!__JAR_FILE!" (
        if %_DEBUG%==1 ( echo %_DEBUG_LABEL% call "%_PWSH_CMD%" -c "Invoke-WebRequest -Uri '!__JAR_URL!' -Outfile '!__JAR_FILE!'" 1>&2
        ) else if %_VERBOSE%==1 ( echo Download file %__JAR_NAME% to directory "!__TEMP_DIR:%USERPROFILE%=%%USERPROFILE%%!" 1>&2
        )
        call "%_PWSH_CMD%" -c "$progressPreference='silentlyContinue';Invoke-WebRequest -Uri '!__JAR_URL!' -Outfile '!__JAR_FILE!'"
        if not !ERRORLEVEL!==0 (
            echo %_ERROR_LABEL% Failed to download file %__JAR_NAME% 1>&2
            set _EXITCODE=1
            goto :eof
        )
        if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_MVN_CMD%" %_MVN_OPTS% install:install-file -Dfile="!__JAR_FILE!" -DgroupId="%__GROUP_ID%" -DartifactId=%__ARTIFACT_ID% -Dversion=%__VERSION% -Dpackaging=jar 1>&2
        ) else if %_VERBOSE%==1 ( echo Install Maven artifact into directory "!__LOCAL_REPO:%USERPROFILE%=%%USERPROFILE%%!\%__SCALA_XML_PATH%" 1>&2
        )
        @rem see https://stackoverflow.com/questions/16727941/how-do-i-execute-cmd-commands-through-a-batch-file
        call "%_MVN_CMD%" %_MVN_OPTS% install:install-file -Dfile="!__JAR_FILE!" -DgroupId="%__GROUP_ID%" -DartifactId=%__ARTIFACT_ID% -Dversion=%__VERSION% -Dpackaging=jar
        if not !ERRORLEVEL!==0 (
            echo %_ERROR_LABEL% Failed to install Maven artifact into directory "!__LOCAL_REPO:%USERPROFILE%=%%USERPROFILE%%!" ^(error:!ERRORLEVEL!^) 1>&2
        )
        for /f "usebackq delims=" %%f in (`where /r "%__LOCAL_REPO%\%__JAR_PATH%" %__JAR_NAME% 2^>NUL`) do (
            set "__JAR_FILE=%%f"
        )
    )
)
set "_LIBS_CPATH=%_LIBS_CPATH%!__JAR_FILE!;"
goto :eof

@rem #########################################################################
@rem ## Cleanups

:end
endlocal & (
    set "_CPATH=%_LIBS_CPATH%"
)
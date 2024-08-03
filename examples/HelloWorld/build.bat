@echo off
setlocal enabledelayedexpansion

@rem only for interactive debugging !
set _DEBUG=0

@rem #########################################################################
@rem ## Environment setup

set _EXITCODE=0

call :env
if not %_EXITCODE%==0 goto end

call :args %*
if not %_EXITCODE%==0 goto end

@rem #########################################################################
@rem ## Main

if %_HELP%==1 (
    call :help
    exit /b !_EXITCODE!
)
if %_CLEAN%==1 (
    call :clean
    if not !_EXITCODE!==0 goto end
)
if %_COMPILE%==1 (
    call :compile
    if not !_EXITCODE!==0 goto end
)
if %_RUN%==1 (
    call :run
    if not !_EXITCODE!==0 goto end
)
goto end

@rem #########################################################################
@rem ## Subroutines

:env
set _BASENAME=%~n0
set "_ROOT_DIR=%~dp0"
set _TIMER=0

set "_SOURCE_DIR=%_ROOT_DIR%src"
set "_TARGET_DIR=%_ROOT_DIR%target"
set "_CLASSES_DIR=%_TARGET_DIR%\classes"

call :env_colors
set _DEBUG_LABEL=%_NORMAL_BG_CYAN%[%_BASENAME%]%_RESET%
set _ERROR_LABEL=%_STRONG_FG_RED%Error%_RESET%:
set _WARNING_LABEL=%_STRONG_FG_YELLOW%Warning%_RESET%:

if not exist "%JAVA_HOME%\bin\java.exe" (
    echo %_ERROR_LABEL% Java SDK installation directory not found 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_JAR_CMD=%JAVA_HOME%\bin\jar.exe"
set "_JAVA_CMD=%JAVA_HOME%\bin\java.exe"

if not exist "%SCALA_HOME%\bin\scalac.bat" (
    echo %_ERROR_LABEL% Scala 2 installation directory not found 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_SCALAC_CMD=%SCALA_HOME%\bin\scalac.bat"

if not exist "%SPARK_HOME%\bin\spark-submit.cmd" (
    echo %_ERROR_LABEL% Spark installation directory not found 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_SPARK_SUBMIT_CMD=%SPARK_HOME%\bin\spark-submit.cmd"

@rem use newer PowerShell version if available
where /q pwsh.exe
if %ERRORLEVEL%==0 ( set _PWSH_CMD=pwsh.exe
) else ( set _PWSH_CMD=powershell.exe
)
goto :eof

:env_colors
@rem ANSI colors in standard Windows 10 shell
@rem see https://gist.github.com/mlocati/#file-win10colors-cmd

@rem normal foreground colors
set _NORMAL_FG_BLACK=[30m
set _NORMAL_FG_RED=[31m
set _NORMAL_FG_GREEN=[32m
set _NORMAL_FG_YELLOW=[33m
set _NORMAL_FG_BLUE=[34m
set _NORMAL_FG_MAGENTA=[35m
set _NORMAL_FG_CYAN=[36m
set _NORMAL_FG_WHITE=[37m

@rem normal background colors
set _NORMAL_BG_BLACK=[40m
set _NORMAL_BG_RED=[41m
set _NORMAL_BG_GREEN=[42m
set _NORMAL_BG_YELLOW=[43m
set _NORMAL_BG_BLUE=[44m
set _NORMAL_BG_MAGENTA=[45m
set _NORMAL_BG_CYAN=[46m
set _NORMAL_BG_WHITE=[47m

@rem strong foreground colors
set _STRONG_FG_BLACK=[90m
set _STRONG_FG_RED=[91m
set _STRONG_FG_GREEN=[92m
set _STRONG_FG_YELLOW=[93m
set _STRONG_FG_BLUE=[94m
set _STRONG_FG_MAGENTA=[95m
set _STRONG_FG_CYAN=[96m
set _STRONG_FG_WHITE=[97m

@rem strong background colors
set _STRONG_BG_BLACK=[100m
set _STRONG_BG_RED=[101m
set _STRONG_BG_GREEN=[102m
set _STRONG_BG_YELLOW=[103m
set _STRONG_BG_BLUE=[104m

@rem we define _RESET in last position to avoid crazy console output with type command
set _BOLD=[1m
set _UNDERSCORE=[4m
set _INVERSE=[7m
set _RESET=[0m
goto :eof

@rem input parameter: %*
@rem output parameters: _CLEAN, _COMPILE, _DEBUG, _RUN, _TIMER, _VERBOSE
:args
set _CLEAN=0
set _COMPILE=0
set _HELP=0
set _RUN=0
set _TIMER=0
set _VERBOSE=0
set __N=0
:args_loop
set "__ARG=%~1"
if not defined __ARG (
    if !__N!==0 set _HELP=1
    goto args_done
)
if "%__ARG:~0,1%"=="-" (
    @rem option
    if "%__ARG%"=="-debug" ( set _DEBUG=1
    ) else if "%__ARG%"=="-help" ( set _HELP=1
    ) else if "%__ARG%"=="-timer" ( set _TIMER=1
    ) else if "%__ARG%"=="-verbose" ( set _VERBOSE=1
    ) else (
        echo %_ERROR_LABEL% Unknown option "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
   )
) else (
    @rem subcommand
    if "%__ARG%"=="clean" ( set _CLEAN=1
    ) else if "%__ARG%"=="compile" ( set _COMPILE=1
    ) else if "%__ARG%"=="help" ( set _HELP=1
    ) else if "%__ARG%"=="run" ( set _COMPILE=1& set _RUN=1
    ) else (
        echo %_ERROR_LABEL% Unknown subcommand "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
    set /a __N+=1
)
shift
goto args_loop
:args_done
set _STDERR_REDIRECT=2^>NUL
if %_DEBUG%==1 set _STDERR_REDIRECT=

set _APP_NAME=HelloWorld
set _APP_VERSION=0.1.0

set "_ASSEMBLY_FILE=%_TARGET_DIR%\%_APP_NAME%-assembly-%_APP_VERSION%.jar"

@rem name may be prefixed by one or more package names
set _CLASS_NAME=HelloWorld
@rem name may contain spaces
set _SPARK_NAME=Hello World

if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% Options    : _TIMER=%_TIMER% _VERBOSE=%_VERBOSE% 1>&2
    echo %_DEBUG_LABEL% Subcommands: _CLEAN=%_CLEAN% _COMPILE=%_COMPILE% _HELP=%_HELP% _RUN=%_RUN% 1>&2
    echo %_DEBUG_LABEL% Variables  : "_ASSEMBLY_FILE=%_ASSEMBLY_FILE%" 1>&2
    echo %_DEBUG_LABEL% Variables  : "HADOOP_HOME=%HADOOP_HOME%" 1>&2
    echo %_DEBUG_LABEL% Variables  : "JAVA_HOME=%JAVA_HOME%" 1>&2
    echo %_DEBUG_LABEL% Variables  : "MAVEN_HOME=%MAVEN_HOME%" 1>&2
    echo %_DEBUG_LABEL% Variables  : "SCALA_HOME=%SCALA_HOME%" 1>&2
    echo %_DEBUG_LABEL% Variables  : "SPARK_HOME=%SPARK_HOME%" 1>&2
)
if %_TIMER%==1 for /f "delims=" %%i in ('call "%_PWSH_CMD%" -c "(Get-Date)"') do set _TIMER_START=%%i
goto :eof

:help
if %_VERBOSE%==1 (
    set __BEG_P=%_STRONG_FG_CYAN%
    set __BEG_O=%_STRONG_FG_GREEN%
    set __BEG_N=%_NORMAL_FG_YELLOW%
    set __END=%_RESET%
) else (
    set __BEG_P=
    set __BEG_O=
    set __BEG_N=
    set __END=
)
echo Usage: %__BEG_O%%_BASENAME% { ^<option^> ^| ^<subcommand^> }%__END%
echo.
echo   %__BEG_P%Options:%__END%
echo     %__BEG_O%-debug%__END%      print commands executed by this script
echo     %__BEG_O%-timer%__END%      print total execution time
echo     %__BEG_O%-verbose%__END%    print progress messages
echo.
echo   %__BEG_P%Subcommands:%__END%
echo     %__BEG_O%clean%__END%       delete generated files
echo     %__BEG_O%compile%__END%     generate class files
echo     %__BEG_O%help%__END%        print this help message
echo     %__BEG_O%run%__END%         execute the generated program "!_ASSEMBLY_FILE:%_ROOT_DIR%=!"
goto :eof

:clean
call :rmdir "%_TARGET_DIR%"
goto :eof

@rem input parameter: %1=directory path
:rmdir
set "__DIR=%~1"
if not exist "%__DIR%\" goto :eof
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% rmdir /s /q "%__DIR%" 1>&2
) else if %_VERBOSE%==1 ( echo Delete directory "!__DIR:%_ROOT_DIR%=!" 1>&2
)
rmdir /s /q "%__DIR%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to delete directory "!__DIR:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:compile
if not exist "%_CLASSES_DIR%" mkdir "%_CLASSES_DIR%"

call :action_required "%_ASSEMBLY_FILE%" "%_SOURCE_DIR%\main\scala\*.scala"
if %_ACTION_REQUIRED%==0 goto :eof

set __SOURCE_FILES=
set __N=0
for /f "delims=" %%f in ('dir /b /s "%_SOURCE_DIR%\main\scala\*.scala" 2^>NUL') do (
    set __SOURCE_FILES=!__SOURCE_FILES! "%%f"
    set /a __N+=1
)
if %__N%==0 (
    echo %_WARNING_LABEL% No Scala source file found 1>&2
    goto :eof
) else if %__N%==1 ( set __N_FILES=%__N% Scala source file
) else ( set __N_FILES=%__N% Scala source files
)
call :libs_cpath
if not %_EXITCODE%==0 goto :eof

set "__CPATH=%_LIBS_CPATH%%_CLASSES_DIR%"
set __SCALAC_OPTS=-deprecation -cp "%__CPATH%" -d "%_CLASSES_DIR%"
@rem if %_DEBUG%==1 set __SCALAC_OPTS=-Ylog-classpath %__SCALAC_OPTS%

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_SCALAC_CMD%" %__SCALAC_OPTS% %__SOURCE_FILES% 1>&2
) else if %_VERBOSE%==1 ( echo Compile %__N_FILES% into directory "!_CLASSES_DIR:%_ROOT_DIR%=!" 1>&2
)
call "%_SCALAC_CMD%" %__SCALAC_OPTS% %__SOURCE_FILES%
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to compile %__N_FILES% into directory "%_CLASSES_DIR%" 1>&2
    set _EXITCODE=1
    goto :eof
)
call :create_jar
if not %_EXITCODE%==0 goto :eof
goto :eof

@rem create an assembly file containing both application and Scala library class files
:create_jar
set "__MANIFEST_FILE=%_TARGET_DIR%\MANIFEST.MF"
(
    echo Main-Class: %_CLASS_NAME%
    echo Specification-Title: %_APP_NAME%
    echo Specification-Version: %_APP_VERSION%
    echo Specification-Vendor: default
    echo Implementation-Title: %_APP_NAME%
    echo Implementation-Version: %_APP_VERSION%
    echo Implementation-Vendor: default
    echo Implementation-Vendor-Id: default
)> "%__MANIFEST_FILE%"
set __JAR_OPTS=cfm "%_ASSEMBLY_FILE%" "%__MANIFEST_FILE%" -C "%_CLASSES_DIR%" .

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_JAR_CMD%" %__JAR_OPTS%
) else if %_VERBOSE%==1 ( echo Create assembly file "!_ASSEMBLY_FILE:%_ROOT_DIR%=!" 1>&2
)
call "%_JAR_CMD%" %__JAR_OPTS%
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to create assembly file "!_ASSEMBLY_FILE:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
call :libs_cpath
if not %_EXITCODE%==0 goto :eof

set "__CPATH=%_LIBS_CPATH%"
set "__SCALA_JAR_FILE="
:loop_cpath
for /f "delims=; tokens=1,*" %%f in ("%__CPATH%") do (
    set "__JAR_FILE=%%f"
    if not "!__JAR_FILE:scala-library=!"=="!__JAR_FILE!" (
        set "__SCALA_JAR_FILE=!__JAR_FILE!"
    )
    set "__CPATH=%%g"
    goto loop_cpath
)
if not exist "%__SCALA_JAR_FILE%" (
    echo %_ERROR_LABEL% Scala library file not found 1>&2
    set _EXITCODE=1
    goto :eof
)
set "__ASSEMBLY_DIR=%_TARGET_DIR%\assembly"
if not exist "%__ASSEMBLY_DIR%" mkdir "%__ASSEMBLY_DIR%"
pushd "%__ASSEMBLY_DIR%"

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_JAR_CMD%" xf "%__SCALA_JAR_FILE%" 1>&2
) else if %_VERBOSE%==1 ( echo Extract class files from "!__SCALA_JAR_FILE:%USERPROFILE%=%%USERPROFILE%%!" 1>&2
)
call "%_JAR_CMD%" xf "!__SCALA_JAR_FILE!"
@rem rename Scala LICENSE and NOTICE files
for /f "delims=" %%i in ("%__SCALA_JAR_FILE%") do set "__BASENAME=%%~ni"
for %%j in (LICENSE NOTICE) do (
    if exist "%%j" move "%%j" "%%j_!__BASENAME!" 1>NUL
)
@rem we've created our own file META-INF/MANIFEST.MF
if exist "META-INF\MANIFEST.MF" rmdir /s /q "META-INF"
popd
set __JAR_OPTS=uf "%_ASSEMBLY_FILE%" -C "%__ASSEMBLY_DIR%" .

if %_DEBUG%==1 ( echo "%_JAR_CMD%" %__JAR_OPTS%
) else if %_VERBOSE%==1 ( echo Update assembly file "!_ASSEMBLY_FILE:%_ROOT_DIR%=!" 1>&2
)
call "%_JAR_CMD%" %__JAR_OPTS%
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to update assembly file "!_ASSEMBLY_FILE:%_ROOT_DIR%=!" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:run
if not exist "%_ASSEMBLY_FILE%" (
    echo %_ERROR_LABEL% Assembly file not found ^("%_ASSEMBLY_FILE%"^) 1>&2
    set _EXITCODE=1
    goto :eof
)
@rem https://spark.apache.org/docs/latest/configuration.html#dynamically-loading-spark-properties
set __SPARK_SUBMIT_OPTS=--name "%_SPARK_NAME%" --class "%_CLASS_NAME%" --master local "%_ASSEMBLY_FILE%"
if %_DEBUG%==1 set __SPARK_SUBMIT_OPTS=--verbose %__SPARK_SUBMIT_OPTS%

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_SPARK_SUBMIT_CMD%" %__SPARK_SUBMIT_OPTS% 1>&2
) else if %_VERBOSE%==1 ( echo Execute Spark application "%_SPARK_NAME%" 1>&2
)
call "%_SPARK_SUBMIT_CMD%" %__SPARK_SUBMIT_OPTS%
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to execute Spark application "%_SPARK_NAME%" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

@rem input parameter: 1=target file 2,3,..=path (wildcards accepted)
@rem output parameter: _ACTION_REQUIRED
:action_required
set "__TARGET_FILE=%~1"

set __PATH_ARRAY=
set __PATH_ARRAY1=
:action_path
shift
set "__PATH=%~1"
if not defined __PATH goto action_next
if defined __PATH_ARRAY set "__PATH_ARRAY=%__PATH_ARRAY%,"
set __PATH_ARRAY=%__PATH_ARRAY%'%__PATH%'
if defined __PATH_ARRAY1 set "__PATH_ARRAY1=%__PATH_ARRAY1%,"
set __PATH_ARRAY1=%__PATH_ARRAY1%'!__PATH:%_ROOT_DIR%=!'
goto action_path

:action_next
set __TARGET_TIMESTAMP=00000000000000
for /f "usebackq" %%i in (`call "%_PWSH_CMD%" -c "gci -path '%__TARGET_FILE%' -ea Stop | select -last 1 -expandProperty LastWriteTime | Get-Date -uformat %%Y%%m%%d%%H%%M%%S" 2^>NUL`) do (
     set __TARGET_TIMESTAMP=%%i
)
set __SOURCE_TIMESTAMP=00000000000000
for /f "usebackq" %%i in (`call "%_PWSH_CMD%" -c "gci -recurse -path %__PATH_ARRAY% -ea Stop | sort LastWriteTime | select -last 1 -expandProperty LastWriteTime | Get-Date -uformat %%Y%%m%%d%%H%%M%%S" 2^>NUL`) do (
    set __SOURCE_TIMESTAMP=%%i
)
call :newer %__SOURCE_TIMESTAMP% %__TARGET_TIMESTAMP%
set _ACTION_REQUIRED=%_NEWER%
if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% %__TARGET_TIMESTAMP% Target : '%__TARGET_FILE%' 1>&2
    echo %_DEBUG_LABEL% %__SOURCE_TIMESTAMP% Sources: %__PATH_ARRAY% 1>&2
    echo %_DEBUG_LABEL% _ACTION_REQUIRED=%_ACTION_REQUIRED% 1>&2
) else if %_VERBOSE%==1 if %_ACTION_REQUIRED%==0 if %__SOURCE_TIMESTAMP% gtr 0 (
    echo No action required ^(%__PATH_ARRAY1%^) 1>&2
)
goto :eof

@rem output parameter: _NEWER
:newer
set __TIMESTAMP1=%~1
set __TIMESTAMP2=%~2

set __DATE1=%__TIMESTAMP1:~0,8%
set __TIME1=%__TIMESTAMP1:~-6%

set __DATE2=%__TIMESTAMP2:~0,8%
set __TIME2=%__TIMESTAMP2:~-6%

if %__DATE1% gtr %__DATE2% ( set _NEWER=1
) else if %__DATE1% lss %__DATE2% ( set _NEWER=0
) else if %__TIME1% gtr %__TIME2% ( set _NEWER=1
) else ( set _NEWER=0
)
goto :eof

@rem input parameter: %1=flag to add Scala 3 libs
@rem output parameter: _LIBS_CPATH
:libs_cpath
set __ADD_SCALA3_LIBS=%~1

for /f "delims=" %%f in ("%~dp0\.") do set "__BATCH_FILE=%%~dpfcpath.bat"
if not exist "%__BATCH_FILE%" (
    echo %_ERROR_LABEL% Batch file "%__BATCH_FILE%" not found 1>&2
    set _EXITCODE=1
    goto :eof
)
if %_DEBUG%==1 echo %_DEBUG_LABEL% "%__BATCH_FILE%" %_DEBUG% 1>&2
call "%__BATCH_FILE%" %_DEBUG%
set "_LIBS_CPATH=%_CPATH%"

if defined __ADD_SCALA3_LIBS (
    if not defined SCALA3_HOME (
        echo %_ERROR_LABEL% Variable SCALA3_HOME not defined 1>&2
        set _EXITCODE=1
        goto :eof
    )
    for /f "delims=" %%f in ("%SCALA3_HOME%\lib\*.jar") do (
        set "_LIBS_CPATH=!_LIBS_CPATH!%%f;"
    )
)
goto :eof

@rem output parameter: _DURATION
:duration
set __START=%~1
set __END=%~2

for /f "delims=" %%i in ('call "%_PWSH_CMD%" -c "$interval = New-TimeSpan -Start '%__START%' -End '%__END%'; Write-Host $interval"') do set _DURATION=%%i
goto :eof

@rem #########################################################################
@rem ## Cleanups

:end
if %_TIMER%==1 (
    for /f "delims=" %%i in ('call "%_PWSH_CMD%" -c "(Get-Date)"') do set __TIMER_END=%%i
    call :duration "%_TIMER_START%" "!__TIMER_END!"
    echo Total execution time: !_DURATION! 1>&2
)
if %_DEBUG%==1 echo %_DEBUG_LABEL% _EXITCODE=%_EXITCODE% 1>&2
exit /b %_EXITCODE%
endlocal

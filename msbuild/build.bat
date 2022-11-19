@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

CALL Config.bat

SET PROJECT=msproject.csproj

IF "x%1" == "x" (
	CALL :ALL
	REM disable echo because subroutine might enable echo
	@ECHO OFF
	IF NOT !ERRORLEVEL! == 0 (
		ECHO ERROR : ALL returned !ERRORLEVEL!
		EXIT /B !ERRORLEVEL!
	)
) else (
	FOR %%i IN (%*) DO (
		CALL :_CHECK_LABEL %%i
		IF !ERRORLEVEL! == 0 (
			CALL :%%i
			REM disable echo because subroutine might enable echo
			@ECHO OFF

			IF NOT !ERRORLEVEL! == 0 (
				ECHO ERROR : %%i returned !ERRORLEVEL!
				EXIT /B !ERRORLEVEL!
			)
		) ELSE (
			ECHO ERROR : no such label, "%%i"
			EXIT /B 1
		)
		
	)
)

@ECHO ON
@EXIT /B !ERRORLEVEL!

REM ===============================
REM === All
REM ===============================
:ALL
CALL :BUILD
CALL :RUN
@GOTO :EOF

REM ===============================
REM === Version
REM ===============================
:VERSION
MSBuild.exe --Version
@GOTO :EOF

REM ===============================
REM === Build
REM ===============================
:BUILD
msbuild -t:restore
MSBuild.exe -t:Build !PROJECT! -property:Configuration=Debug
@GOTO :EOF

REM ===============================
REM === Clean
REM ===============================
:CLEAN
ECHO This is clean.
CSCRIPT //NOLOGO "%~f0?.wsf" //job:Clean
@GOTO :EOF

REM ===============================
REM === Test
REM ===============================
:TEST
ECHO This is test.
BIN\example.exe
@GOTO :EOF

REM ===============================
REM === Run
REM ===============================
:RUN
CALL :TEST
@GOTO :EOF

REM ===============================
REM === _CHECK_LABEL
REM ===============================
:_CHECK_LABEL
FINDSTR /I /R /C:"^[ ]*:%1\>" "%~f0" >NUL 2>NUL
@GOTO :EOF

REM ===============================
REM === END
REM ===============================
:END
@ECHO ON
@EXIT /B !ERRORLEVEL!

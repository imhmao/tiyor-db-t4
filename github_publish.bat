@echo off
set dist=dist
set setOwner=owner
set strUsr=usrName
set strPwd=clrPwd
set strNewOwner=%1
set strNewUsr=%2
set strNewPwd=%3
set file=nuget.tpl.config
set output=nuget.config
set chk=1

if "%strNewOwner%" == "" set chk=0
if "%strNewUsr%" == "" set chk=0
if "%strNewPwd%" == "" set chk=0
if "%chk%" == "0" (
    set "msg=Usage: github_pack.bat ^<Owner^> ^<User Name^> ^<Personal Token^>"
    goto show
) else (

    for /f "delims=\" %%a in ('dir /b /a-d /o-d "%dist%\*.nupkg"') do (
        set "nupkg=%%a"
    )
    if "!nupkg!"=="" (
        set "msg=Nuget package not found."
        goto show
    ) else (

        setlocal enabledelayedexpansion
        for /f "tokens=*" %%j in (%file%) do (
            set "tmp=%%j"
            if not !tmp!.==. (
            set "tmp=!tmp:%setOwner%=%strNewOwner%!"
            set "tmp=!tmp:%strUsr%=%strNewUsr%!"
            set "tmp=!tmp:%strPwd%=%strNewPwd%!"
            echo !tmp!>>temp.txt
            )
        )
        move temp.txt %output% >nul
        if exist %output% (
            dotnet nuget push "%dist%/!nupkg!" --api-key %strNewPwd% --source "github"
            set "msg=finish"
            goto show
        ) else (
            set "msg= %output% generate failed."
            goto show
        )
    )
  
)

:show
    echo .
    echo .
    echo .      %msg%
    echo .
    echo .
    goto end

:end
    if exist %output% del %output%
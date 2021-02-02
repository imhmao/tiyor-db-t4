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
        goto find
    )
  
)
:find
    setlocal enabledelayedexpansion

    for /f "tokens=*" %%j in (%file%) do (
        set "ner=%%j"
        if not !ner!.==. (
        set "ner=!ner:%setOwner%=%strNewOwner%!"
        set "ner=!ner:%strUsr%=%strNewUsr%!"
        set "ner=!ner:%strPwd%=%strNewPwd%!"
        echo !ner!>>temp.txt
        )
    )

    move temp.txt %output% >nul
    goto dotnet

:show
    echo .
    echo .
    echo .      %msg%
    echo .
    echo .
    goto end

:dotnet
 if exist %output% (
            @REM echo dotnet nuget push "%dist%/!nupkg!" --api-key %strNewPwd% --source "github"
            echo publishing ... 
            dotnet nuget push "%dist%/!nupkg!" --api-key %strNewPwd% --source "github"
            set "msg=finish"
            goto show
        ) else (
            set "msg= %output% generate failed."
            goto show
        )
:end
    if exist %output% del %output%
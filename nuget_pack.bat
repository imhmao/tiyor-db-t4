set dist=dist
if not exist %dist% ( 
    md %dist%
) else (
    del %dist%\*.nupkg
)

copy *.tt %dist%
copy *.ttinclude %dist%
copy Package.nuspec %dist%./
cd %dist%
nuget pack
cd ..

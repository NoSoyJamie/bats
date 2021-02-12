@echo off
cd %USERPROFILE%
set /P URL=Paste Twitch URL Here:
youtube-dl "%URL%"
for /f Delims^=^ EOL^= %%P In ('youtube-dl --get-filename "%URL%"') do set twitchfn=%%~P
set twitchfn=%twitchfn:~18%
set twitchfn=%twitchfn:~0,-4%
for /f "tokens=1-20 delims=abcdefghijklmnopqrstuvwxyz!@#$&*()-=:/.?" %%a in ("%URL%") do set twid=%%a%%b%%c%%d%%e%%f%%g%%h%%i%%j%%k%%l%%m%%n%%o
tcd --video %twid% --format ssa --output Movies\
cd Movies\
ffmpeg -i "%twitchfn%.mp4" -i "%twid%.ssa" -c:v copy -c:a copy -c:s copy "%twitchfn%.mkv"
del "%twitchfn%.mp4"
del "%twid%.ssa"
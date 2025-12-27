@ECHO OFF
REM ****************************************************************************************************
REM 
REM Extrahiert Bilder eines Timelapse-Videos
REM
REM   Input:
REM        SAM.mp4 .... Timelapse Video

REM   Output:
REM        2_Images   ... Folder mit den extrahierten Bildern
REM
REM ****************************************************************************************************



REM *** Extract I-Frames
ECHO -------------------- Extract I-Frames
ffmpeg -v quiet -stats -i SAM.MP4 -vf "select='eq(pict_type,I)'" -vsync vfr -frame_pts true -q:v 2 -qmin 1 -qmax 2 2_Images\out-%%04d.jpg

REM *** Extract B-Frames
ECHO -------------------- Extract B-Frames
ffmpeg -v quiet -stats -i SAM.MP4 -vf "select='eq(pict_type,B)'" -vsync vfr -frame_pts true -q:v 2 -qmin 1 -qmax 2 2_Images\out-%%04d.jpg

REM *** Extract P-Frames
REM     Samsung Gear360 Timlapse-Videos haben keine P-Frames. prüfe es mit:
REM     ffprobe -show_frames -select_streams v:0 -print_format json SAM.MP4 > output.txt 2>&1

ECHO -------------------- Write Manufacturer and Camera Model
exiftool -make="SAMSUNG" -model="SM-R210" -overwrite_original -progress: 2_Images

pause

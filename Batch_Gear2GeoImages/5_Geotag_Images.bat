@ECHO OFF
REM ****************************************************************************************************
REM 
REM Schreibt Geo-Tags korreliert sie mit einem GPS-Track
REM
REM   Input:
REM        TRK.gpx .... GPS Logfile (UTC-Zeit)
REM        3_Stitched . Folder mit zeitgestempelten Bildern	
REM   Output:
REM        3_Stitched . Folder mit den Geo getaggten Bildern
REM
REM ****************************************************************************************************

ECHO -------------------- Write Geotags
exiftool -geotag TRK.gpx -overwrite_original -progress: 3_Stitched
pause
@ECHO OFF
REM ****************************************************************************************************
REM 
REM Schreibt Zeitstempel, Hersteller und Kameramodell in die Exif-Daten der Bilder
REM
REM   Input:
REM        starttime .. Zeitpunkt des ersten Bildes (Lokalzeit, z.B.: 2025:09:18 11:33:50)
REM        incrtime ... Zeitintervall zwischen 2 Bildern in Sekunden. Z.B.: 2.8433 
REM        2_Images ... Folder mit den extrahierten Bildern
REM   Output:
REM        2_Images ... Folder mit den extrahierten Bildern
REM
REM ****************************************************************************************************

set starttime="2025:12:27 12:08:39"
set incrtime=1.081081


REM *** Setze Tag "DateTimeOriginal" auf Startwert in allen Bildern
ECHO -------------------- Set StartTime
exiftool -datetimeoriginal=%starttime% -overwrite_original -progress: 2_Images

ECHO -------------------- Increment Timestamp
exiftool -fileOrder filename "-datetimeoriginal+<0:0:${filesequence;$_*= %incrtime%}" -overwrite_original -progress: 2_Images

pause
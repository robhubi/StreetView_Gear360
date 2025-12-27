@ECHO OFF
REM ****************************************************************************************************
REM 
REM Fügt 2 Fischaugen-Bilder zu einem Kugelpanorama
REM
REM verwendet Multiblend (Switch /m) weil viel schneller als enblend
REM
REM   Input:
REM        2_Images ... Folder mit den extrahierten Bildern
REM   Output:
REM        3_Stitched   ... Folder mit Kugelpanorama-Bildern
REM
REM ****************************************************************************************************

ECHO -------------------- Stitch Images (be patient - ~5s/image)
call "gear360pano.cmd" /m /o "3_Stitched" "2_Images\*.jpg" "gear360video4096_V5.pto"
pause
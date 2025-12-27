************************************************************************************
* Reads timelapse mp4 file, extracts individual frames and correlates with GPS file
*
*    - Copy the input files *.mp4 or *.gpx to the directory containing the batch files
*    - Rename the input files to: SAM.mp4 or TRK.gpx
*    - Start the script ‘1_Split_Video.bat’
*    - Open ‘2_Calc_Timestamps.xlsx’ and calculate “inctime”
*    - Edit the script ‘3_Set_Timestamps.bat’:
*       + Set the start time in the script (= date & time of the first frame in local time)
*       + Set the time increment (= average time difference between 2 consecutive images in seconds) in the script
*    - Start script ‘3_Set_Timestamps.bat’
*    - Start ‘4_StitcheImages.bat’
*    - Start ‘5_Geotag_Images.bat’
*
*    Tools: FFmpeg, ExifTool, Hugin, multiblend, gear360pano.cmd and gear360video4096.pto
*
*    For further details, see comments in the script and documentation
*
************************************************************************************

German
************************************************************************************
* Liest Timelapse mp4-File, extrahiert die Einzelbilder und korreliert mit GPS-File
*
*    - Kopiere die Eingabe-Files *.mp4 bzw. *.gpx in das Verzeichnis mit den Batch Files
*    - Benenne die Eingabe-Files um in: SAM.mp4 bzw. TRK.gpx
*    - Starte Script "1_Split_Video.bat"
*    - Öffne "2_Calc_Timestamps.xlsx" und berechne "inctime"
*    - Editiere Script "3_Set_Timestamps.bat":
*       + Setze im Script die Startzeit (= Zeitpunkt des ersten Bildes in lokaler Zeit)
*       + Setze im Script das Zetinkrement (= mittlere Zeitdifferenz zwischen 2 aufeinanderfolgende Bilder in Sekunden)
*    - Starte Script "3_Set_Timestamps.bat"
*    - Starte "4_StitcheImages.bat"
*    - Starte "5_Geotag_Images.bat"
*
*    Tools: FFmpeg, ExifTool, Hugin, multiblend, gear360pano.cmd und gear360video4096.pto
*
*    Weitere Details siehe Kommentare im Script und Doku 
*
************************************************************************************

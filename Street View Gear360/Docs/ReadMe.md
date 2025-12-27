## Poor Man's Street View

![Sv01_Banner](SV_Images/Sv01_Banner.jpg)

Für das Mappen sind Street View Bilder eine großartige Unterstützung. Schnelligkeit und Vollständigkeit der Datenerfassung sind die größten Pluspunkte. Einzig die hohen Kosten waren für mich abschreckend.

Das ändert sich derzeit. Die erste und zweite Generation der Consumer 360°-Kameras kommt nun zu sehr günstigen Preisen in den Gebrauchtwarenhandel. Die Samsung Gear 360 Modell 2017 ist z.B. ab 20€ zu haben. Da musste ich zugreifen :-)

### Kamerahalterung fürs Fahrrad

Ziel war, so schnell wie möglich Testfahrten machen zu können. Es kamen daher nur Komponenten in Frage, die im eigenen Lager oder beim Händler um die Ecke vorrätig waren. Das Design spielte keine Rolle, es sollte nur beim Fahren nicht stören und bei Nichtgebrauch rasch demontierbar sein.

Die Konstruktion zeigen die folgenden Bilder:

![Sv02_sKameraAufnehmer](SV_Images/Sv02_sKameraAufnehmer.jpg)

*Bild 01: DIY Stockstativ fürs Fahrrad ([Zoom](SV_Images/Sv02_KameraAufnehmer.jpg)). Länge = 165cm*

![Sv03_sGesAnsi](SV_Images/Sv03_sGesAnsi.jpg)

*Bild 02: Montage am Fahrrad mit Rohrschellen ([zoom](SV_Images/Sv03_GesAnsi.jpg)). Rohrschellen mit Gummieinlage und M8 Anschlussmutter. Das Objektiv ist auf etwa 2,10 Meter Höhe*

Das Stockstativ wird mit isolierten Rohrschellen am Fahrrad befestigt. Die Rohrschellen sind in jedem Baumarkt in diversen Durchmessern zu haben. Mit der oberen Befestigung wird auf das Lot ausgerichtet: verschieben entlang des Gepäcksträgers verändert die Neigung in Fahrrichtung; die Einschraubtiefe der äußeren Rohrschelle verändert die Neigung quer zur Fahrrichtung.

### Prinzipieller Datenfluss

1. Fotoaufnahmen (beide 180° Objektive gleichzeitig) in periodischen Intervallen
2. Fotoaufnahmen mit Zeitstempel versehen
3. GPS aufzeichnen (Ort und Zeit)
4. Aus zwei 180°-Bildern eine Kugelpanorama erstellen
5. Geotagging des Panoramas

Es gibt mehrere Möglichkeiten diesen Datenfluss automatisiert ablaufen zu lassen. Sie unterscheiden sich deutlich in Aufwand und Qualität. 

### Richtwerte für periodische Foto Intervalle

Zur Orientierung einige Richtwerte, die für mein Gefühl einen guten Kompromiss zwischen Redundanz und flüssigen Bewegungsablauf auf Mapillary eingehen:

| Bewegungsgeschwindigkeit | Intervallzeit |
| ------------------------ | ------------- |
| 5 km/h                   | 2 s           |
| 10 km/h                  | 1 s           |
| 20 km/h                  | 0,5 s         |

Die Redundanz ist wegen der signifikanten Rechenzeit für die Erstellung des Kugelpanoramas von Bedeutung. Der Speicherbedarf ist das kleinere Problem.

### Realisierung #1: mit Samsung App Gear 360

Die Samsung App wird nicht mehr gepflegt und läuft daher nur auf älteren Smartphones. Kompatible Betriebssysteme sind iOS 10.0 bis iOS 13.0 und Android 6 bis Android 10.

Die Samsung App managt den gesamten Datenfluss von der Aufnahme bis zum georeferenzierten Kugelpanorama selbständig, eine Anwenderintervention ist nicht erforderlich. 

Zumindest fast: Der Samsung App fehlt die Funktion Intervallaufnahme. Für den gedachten Zweck, müsste man der Auslöser periodisch selbst betätigen. Das ist klarerweise nicht praktikabel.

Mit einer weiteren App - Auto Clicker - lässt sich aber auch das automatisieren. Die minimale Intervallzeit liegt bei etwa 3s (Android 8 Smartphone Galaxy S7 edge). Limitierend ist vermutlich die Bluetooth Datenübertragung und die Rechenzeit für das Kugelpanorama (Stitching)

**Resümee Realisierung #1**

| Vorteile (+)                                                 | Nachteile (-)                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Läuft vollautomatisch ab, keine Benutzerinterventionen nötig. | Minimale Intervallzeit von 3s ist nur fürs Wandern geeignet. |
|                                                              | Ein altes Smartphone wird benötigt.                          |

Für meine Anwendung am Fahrrad ist diese Realisierung deutlich zu langsam.



### Realisierung #2: Gear 360 Modding

Mit einem Mod wird die intervallfunktion auf der Kamera selbst implementiert. Der Mod biegt die normale Foto-Funktion - 1 Aufnahme nach Drücken des Auslösers - um in - periodische Aufnahmen nach Drücken des Auslösers. Der Mod basiert auf die Arbeiten von [ottokiksmaler](https://github.com/ottokiksmaler/gear360_modding) und kann [hier](https://github.com/robhubi/gear360_modding) runtergeladen werden.

Der Entfall der Datenübertragung beschleunigt den Prozess der Bildaufnahme. Die minimale Intervallzeit für eine konstante Periodendauer beträgt 1,9s. 

**Resümee Realisierung #2**

| Vorteile (+)                                                 | Nachteile (-)                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Minimale Intervallzeit ist mit 1,9s kürzer, als mit der Samsung App. | Minimale Intervallzeit von 1,9s ist fürs Radfahren zu lang.  |
| Bilder haben einen Zeitstempel                               | Kein Geotagging der Bilder, GPS-Track von einem externen Gerät notwendig |
| Kein Smartphone erforderlich                                 | Bilder sind nicht zu einem Kugelpanorama zusammengefügt.     |

Für meine Anwendung am Fahrrad ist auch diese Realisierung zu langsam.

### Realisierung #3: Time Lapse Video

Diese Funktion ist in der Kamera implementiert. Die kleinste einstellbare Intervallzeit ist 0,5s. Die Ausgabe ist ein Video mit 4096x2048 Px und 10 Bildern/s. Jedes Frame zeigt das Bild der beiden 180°-Linsen nebeneinander:

![Sv04_sDoubleLens_218](SV_Images/Sv04_sDoubleLens_218.jpg)

*Bild 03: Frame eines Time Lapse Videos ([Zoom](SV_Images/Sv04_DoubleLens_218.jpg)). Linkes und rechtes Bild schauen jeweils quer zur Fahrrichtung*

Die tatsächliche Intervallzeit beträgt jedoch 1,1s. Bei Einstellung "Time lapse interval" = 1s ist die tatsächliche Intervallzeit 1,6s usw. Das gilt ebenso für kleinere Videoauflösungen. An der Kamera stellt man offenbar eine Pausenzeit ein und nicht die Intervallzeit.

Die Frames haben weder Zeitstempel noch GPS-Koordinaten.

**Resümee Realisierung #3**

| Vorteile (+)                     | Nachteile (-)                                                |
| -------------------------------- | ------------------------------------------------------------ |
| Minimale Intervallzeit ist 1,1s. | Minimale Intervallzeit von 1,1s ist für schnelles Radfahren etwas zu lang. |
|                                  | Ergebnis ist ein Video und keine Folge von Einzelbilder      |
|                                  | Die Frames haben keinen Zeitstempel                          |
|                                  | Kein Geotagging der Bilder, GPS-Track von einem externen Gerät notwendig |

Eine Intervallzeit von 1,1s liefert bis zu 15 km/h einigermaßen flüssige Bildsequenzen. Für meine Anwendung am Fahrrad ist diese Realisierung ausreichend. Die nötige, intensive Nachbereitung der Daten kann man als Nachteil oder als Herausforderung sehen. Für mich ist es das letztere :-)

### Datenaufnahme

1. Gear 360 (2017) Kameraeinstellungen: Time Lapse Video; Auflösung 4k; Intervall 0.5s
2. GPS-Tracker auf 1s Intervall stellen
3. Video Aufzeichnung starten und GPS-Zeit (mindestens 1s Auflösung) filmen
4. Strecke abfahren
5. GPS-Zeit filmen und Video Aufzeichnung beenden

Die gefilmte GPS-Zeit ist für die Berechnung der Frame-Zeitstempel essentiell. Mein Garmin Oregon 650 zeugt die Sekunden in der GPS-Zeit nur in einem großen Datenfeld.

### Datennachbereitung

Ein vollständige Automatisierung ist leider nicht möglich, das Ablesen der GPS-Zeit vom Foto ist ein manueller Zwischenschritt. Alle anderen Schritte sind mit einem Windows Batch-File automatisiert.

Folgende Programmkomponenten müssen installiert sein (Windows):

1. [FFmpeg](https://www.ffmpeg.org/) (V 2025-09-18) Video Tool
2. [ExifTool](https://exiftool.org/) (V 13.12) Meta Information Editor
3. [Hugin](https://hugin.sourceforge.io/) (V 2025.0.0) Panorama Stitcher
4. [multiblend](https://horman.net/multiblend/) (V 2.0rc5) Fast Image Blender
5. [gear360pano.cmd + gear360video4096.pto](https://github.com/ultramango/gear360pano) (V 2019-02-03) Script generiert Kugelpanorama. Das hier verlinkte Original benötigte 4 Anpassungen. 



#### Schritt 1: Video zu Einzelbilder

Die Einzelbilder sind im Video als I- und B-Frames kodiert. P-Frames verwendet die Kamera Gear 360 (2017) nicht. Die Benennung der Bilder spiegelt die Position im Video. Beispiel für den Extrakt von I-Frames:

`ffmpeg -v quiet -stats -i SAM.MP4 -vf "select='eq(pict_type,I)'" -vsync vfr -frame_pts true -q:v 2 -qmin 1 -qmax 2 2_Images\out-%%04d.jpg`

#### Schritt 2: Erstes und letztes Bild datieren

Um eine Sequenz von Bildern mit dem ExifTool zu datieren, ist der Startzeitpunkt des ersten Bildes und das zeitliche Inkrement zum nächsten Bild anzugeben. Die gefilmte GPS-Zeit am Anfang und Ende des Videos ist für das jeweilige Frame der Zeitstempel. Daraus lässt sich unschwer der Startzeitpunkt und das Inkrement berechnen. Ein Excel-File unterstützt dabei.

Das Ergebnis ist in das Script des nächsten Schrittes zu übertragen.

#### Schritt 3: Alle Bilder datieren

Zuerst werden alle Bilder mit den Startzeitpunkt datiert und anschließend werden die Sekunden mit dem Produkt aus Bild-Nr und Inkrement (in sek) erhöht.

`exiftool -datetimeoriginal=%starttime% -overwrite_original -progress: 2_Images`

`exiftool -fileOrder filename "-datetimeoriginal+<0:0:${filesequence;$_*= %incrtime%}" -overwrite_original -progress: 2_Images`

#### Schritt 4: Kugelpanorama berechnen

Die Berechnung eines Kugelpanoramas aus zwei 180° Fischaugen-Bildern ist komplex und dauert immens lang. Pro Bild rechnet Hugin etwa 5s, d.h. ein Video mit 20min Länge braucht etwa 1h 31min zur Panorama berechnung.

`call "gear360pano.cmd" /m /o "3_Stitched" "2_Images\*.jpg" "gear360video4096_V5.pto"`

`gear360pano.cmd` ist eine leicht modifizierte Version von [ultramango](https://github.com/ultramango/gear360pano). Im Kern bildet es eine Schleife, die durch alle Bilder im angegebenen Verzeichnis geht.

`gear360video4096_V5.pto` ist eine Vorlage für Hugin, die alle Parameter zur Berechnung des Kugelpanoramas enthält. Ich machte meine eigene Vorlage, da mir die Version von ultramango zu unpräzise zusammenfügte.

![Sv04_sSpherPano_218](SV_Images/Sv05_sSpherPano_218.jpg)

*Bild 04: Kugelpanorama mit äquirektangulärer Projektion ([zoom](SV_Images/Sv05_SpherPano_218.jpg)) aus Bild 03. Siehe [Mapillary](https://www.mapillary.com/app/?pKey=25562666360065922) für eine Darstellung im 3D-Raum.*

#### Schritt 5: Geotagging der Bilder

Die Position des Bildes wird über den Abgleich der Zeitstempel in den Bildmetadaten (EXIF) mit den Zeitpunkten der GPS-Aufzeichnung bestimmt.

`exiftool -geotag TRK.gpx -overwrite_original -progress: 3_Stitched`



### Resümee

Mit der Kamera Gear 360 (2017) kann mit minimalen finanziellen Aufwand eine funktionierende Street View -Aufnahmelösung aufgebaut werden. Mit der Samsung App beträgt die minimale Intervallzeit 3s. Für Street View-Aufnahmen als Fußgänger ist diese Konfiguration optimal, weil sie kein Postprocessing der Daten benötigt.

Radfahrer wählen besser den Weg über das Time Lapse-Video. Hier beträgt die minimale Intervallzeit 1,1s. Das reicht für Street View-Aufnahmen bis etwa 15 km/h. Diese Konfiguration erfordert ein intensives Postprocessing der Daten. Bis auf das Ablesen der Uhrzeit sind jedoch alle Schritte automatisierbar.

Die Batch-File können ........ heruntergeladen werden. Sie laufen unter Windows, können aber auch für andere Betriebssysteme und andere 360°-Kameras angepasst werden.

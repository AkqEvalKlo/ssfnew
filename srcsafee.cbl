?CONSULT $SYSTEM.SYSTEM.COBOLEX0
?SEARCH  $SYSTEM.SYSTEM.COBOLLIB
?SEARCH  =TALLIB
?SEARCH  =ASC2EBC
?SEARCH  =EBC2ASC
?SEARCH  =HCDAY
?NOLMAP, SYMBOLS, INSPECT
?SAVE ALL
?SAVEABEND
?LINES 66
?SQL

 IDENTIFICATION DIVISION.
 PROGRAM-ID. SRCSAFE.

 DATE-COMPILED.
*                     12345678901234567890123456789012345
*****************************************************************
* Letzte Aenderung :: 2014-12-05
* Letzte Version   :: A.02.28
* Kurzbeschreibung :: Dieses Programm arbeitet als SourceSafe in
* Kurzbeschreibung :: der Tandem-Umgebung
*
*
* Aenderungen (Version und Datum in Variable K-PROG-START aendern)
*              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
* Start Versionsbeschreibung
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar
*-------|---------|-----|----------------------------------------*
*A.02.|2014 |  |
*       |         |     |
*-------|---------|-----|----------------------------------------*
*A.02.28|20141205 | jb  | Bei einem SAVE wird nun geprüft, ob es
*       |         |     | sich um eine LIB handelt, dann auch noch
*       |         |     | in das ELIB-Verzeichnis kopieren
*-------|---------|-----|----------------------------------------*
*A.02.27|20140807 | jb  | Meldung wer letztes CHECKIN durchgeführt
*       |         |     | hat korrigiert - jetzt sollte auch der
*       |         |     | richtige User angezeigt werden
*-------|---------|-----|----------------------------------------*
*A.02.26|20140710 | jb  | - Beim CHECKOUT wird jetzt angezeigt wer
*       |         |     |   und wann den letztem CHECKIN durchge-
*       |         |     |   führt hat
*       |         |     | - der Cursor auf die Protokolltabelle
*       |         |     |   wurde in der Sortierfolge umgedreht,
*       |         |     |   so dass jetzt erst die neuen Einträge
*       |         |     |   gezeigt werden.
*-------|---------|-----|----------------------------------------*
*A.02.25|20131211 | jb  | Bei Eingabestrings in der Funktion R4W
*       |         |     | werden " (Gänsebeine) durch # ersetzt,
*       |         |     | da sonst der PREPARE bei dynamische SQL
*       |         |     | Fehler produziert.
*-------|---------|-----|----------------------------------------*
*A.02.24|20131123 | jb  | Sources, die nach PSRC kopiert werden,
*       |         |     | erhalten jetzt den Security-String "NUUU"
*-------|---------|-----|----------------------------------------*
*A.02.23|20131112 | jb  | Anzeige der Protokolleintraege nur noch
*       |         |     | fuer explizit angegebene Source. letzte
*       |         |     | Stelle des Modulnamens wird entfernt
*-------|---------|-----|----------------------------------------*
*A.02.22|20130822 | jb  | Erweiterte Prüfung, wenn schon ein Eintrag
*       |         |     | in ABNAHME existiert.
*-------|---------|-----|----------------------------------------*
*A.02.21|20130716 | jb  | - kleine Korrekturen
*       |         |     |
*-------|---------|-----|----------------------------------------*
*A.02.20|20130711 | jb  | Erweiterungen wg. PCI Zertifizierer:
*       |         |     | - Tabelle Abnahme erweitert
*       |         |     | - Mail Übernahmeantrag geändert
*       |         |     | - neues Mail, wenn Notübernahme (Sicherheitswarn)
*       |         |     | - neue Funktion #EmergContr# einfügen
*       |         |     |
*       |         |     | Prüfung auf Eingabe auf Sourcetyp eingefügt
*-------|---------|-----|----------------------------------------*
*A.02.10|20130613 | jb  | - kleine Korrekturen
*       |         |     | - neues Subkommando für den LIST-Befehl
*       |         |     |   List FREIGABE - soll alle Programme
*       |         |     |   zeigen, die von WEAT noch nicht
*       |         |     |   freigegeben wurden
*-------|---------|-----|----------------------------------------*
*A.02.09|20130529 | jb  | - Bei Erstellung Freigabe-Antrag an WEAT
*       |         |     |   jetzt auch Eintrag in Protokoll-Tabelle
*       |         |     | - Funktion LIST MONTH nn wg. SQL-Datums
*       |         |     |   macke geaendert. Ggf. wird der Tag des
*       |         |     |   Monats auf 28 reduziert
*       |         |     | - Freigabeantraege koennen jetzt mit den
*       |         |     |   gleichen Angaben fuer mehrere Programme
*       |         |     |   erstellt werden
*-------|---------|-----|----------------------------------------*
*A.02.08|20130513 | jb  | - zusätzlicher Hinweis bei Not-Übernahme
*       |         |     | - noch vorhandenen Fehler bei
*       |         |     |   Mail-Adressaten korrigiert
*-------|---------|-----|----------------------------------------*
*A.02.07|20130502 | jb  | Bei Modulen wird KEIN Eintrag in mehr in
*       |         |     | Tabelle =ABNAHME eingefügt
*-------|---------|-----|----------------------------------------*
*A.02.06|20130419 | jb  | Email Copies wurden nicht versendet,
*       |         |     | dafür 2* die Empfänger -> korrigiert
*-------|---------|-----|----------------------------------------*
*A.02.05|20130415 | jb  | Korrektur der Mail-Aufbereitung bei R4W
*       |         |     | Bei Fkt CREAT-ABNAHME wird nun auch ein
*       |         |     | einfaches Gänsebein ersetzt (durch +)
*-------|---------|-----|----------------------------------------*
*A.02.04|20130410 | jb  | Untersuchung des Sources in Funktion PRGNEU
*       |         |     | umstrukturiert, um zu vermeiden, dass
*       |         |     | Versionshinweise ab der ENVIRONMENT DIVISION
*       |         |     | noch beachtet werden. Bei Funktion R2P wurde
*       |         |     | das falsche Feld zur Evaluierung, ob Freigabe
*       |         |     | erteilt wurde abgefragt
*-------|---------|-----|----------------------------------------*
*A.02.03|20130409 | jb  | Fehlernummern korrigiert; Anzeige User in
*       |         |     | Verwaltungsfunktion sortiert; wenn Versions-
*       |         |     | Update gefunden, danach nicht weiter suchen
*-------|---------|-----|----------------------------------------*
*A.02.02|20130403 | jb  | Berechtigungen für die Funktionen "MODIN"
*       |         |     | und "MODIS" nachgetragen
*       |         |     | Sollte der SQLCOMP mit Completioncode <> 0
*       |         |     | beendet werde, so läuft das Programm
*       |         |     | jetzt weiter
*-------|---------|-----|----------------------------------------*
*A.02.01|20130328 | jb  | - div. kleinere Korrekturen
*       |         |     | - für die Fkt. PRGNEU wird nun das Source-
*       |         |     |   file aus WSRC genommen
*-------|---------|-----|----------------------------------------*
*A.02.00|20130326 | jb  | Die folgenden Erweiterungen wurden
*       |         |     | realisiert:
*       |         |     | - Bei R2T wird der initiale Eintrag in
*       |         |     |   Tabelle =ABNAHME erstellt
*       |         |     | - Neue Funktion R4W eingefügt, dabei wird
*       |         |     |   ein Mail erstellt. Für das Mail muss
*       |         |     |   VOR dem Programmstart ein ASSIGN gesetzt
*       |         |     |   werden. Zum Beispiel:
*       |         |     |      assign email,$CFAX.#email
*       |         |     |   (sollte Bestandteil des SSF-Makros sein
*-------|---------|-----|----------------------------------------*
*A.01.47|20130214 | jb  | Den Usern werden jetzt Rollen zugewiesen.
*       |         |     | Jeder Rolle sind Funktionen zugewiesen.
*       |         |     | Dafür wurden 2 neue Tabelle erzeugt:
*       |         |     | - =SSUSER   user mit Rollen
*       |         |     | - =SSROLES  Rollen mit Funktionen
*       |         |     | - Userverwaltung angepasst und erweitert
*-------|---------|-----|----------------------------------------*
*A.01.46|20130211 | jb  | zugelassene User jetzt mit Gruppennamen
*-------|---------|-----|----------------------------------------*
* Ende Änderungsbeschreibung
*A.01.45|20130205 | jb  | - Neues Kommando "MODIS": Zeigt die Pro-
*       |         |     |   gramme in denen ein Modul enthalten ist
*       |         |     | - Neues Kommando "MODIN": Zeigt die
*       |         |     |   Module in einem Programm
*       |         |     | - Meldungen in Texttabelle überarbeitet
*-------|---------|-----|----------------------------------------*
*A.01.44|20130124 | jb  | Neues Kommando "DOK" eingefügt. Zeigt
*       |         |     | die Versionsbeschreibungen zwischen den
*       |         |     | Markiertungen
*       |         |     |   "* Start Versionsbeschreibung" bzw.
*       |         |     |   "* Aenderungen"
*       |         |     | und
*       |         |     |   "* Ende Versionsbeschreibung"  bzw.
*       |         |     |   "* Programmbeschreibung"
*       |         |     | Ohne Parameter zeigt es die Änderungen vom
*       |         |     | Sourcesave an. Mit Parameter Sourcefile
*       |         |     | vom jeweiligen Source
*-------|---------|-----|----------------------------------------*
*A.01.43|20130122 | jb  | In der Funktion "AT" wird jetzt geprüft,
*       |         |     | ob das file auf TRUNOLD ein Openflag hat
*       |         |     | dann Abbruch der Funktion
*-------|---------|-----|----------------------------------------*
*A.01.42|20130104 | jb  | Obeydatei (SSOBYnnn) wird jetzt auch bei
*       |         |     | timeout gelöscht
*-------|---------|-----|----------------------------------------*
*A.01.41|20130103 | jb  | Funktionserweiterungen:
*       |         |     | - Für Kommando "P" kann nun auch voll aus-
*       |         |     |   geschrieben werden "protokoll"
*       |         |     | - LIST NOTINPROD - Kommando erweitert
*       |         |     |   durch Parameter USER grp.username
*-------|---------|-----|----------------------------------------*
*A.01.40|20121122 | jb  | Funktionen R2T und R2P erweitert. Ist das
*       |         |     | Sourcefile ein Modul (CM), dann wird das
*       |         |     | Object gem SSPARM von EMOD nach TMOD bzw.
*       |         |     | von TMOD nach PMOD gestellt
*       |         |     | - kommentiert mit (Version A.01.40)
*-------|---------|-----|----------------------------------------*
*A.01.35|20121122 | jb  | Fehlerkorrektur bei gestrigen Erweiterungen
*       |         |     | wg. Openflag prüfen
*-------|---------|-----|----------------------------------------*
*A.01.34|20121121 | jb  | - Verschlüsselung der User geändert
*       |         |     | - Berechtigungen (lesen/schreiben) pro
*       |         |     |   User vergeben
*       |         |     | - bei PRGNEU wird zunächst geprüft, ob
*       |         |     |   das Sourcefile ein Openflag hat und
*       |         |     |   solange abgewartet bis das wech ist,
*       |         |     |   bevor mit den ReferenzTabs begonnen wird
*       |         |     | - ebenso bei REL2TEST
*-------|---------|-----|----------------------------------------*
*A.01.33|20121119 | jb  | bei der Funktion "REL2PROD" wird jetzt
*       |         |     | nach einem Eintrag in der Referenztabelle
*       |         |     | =PROGRAMX gesucht mit PROGRAMM=Source
*       |         |     | und PMODUL=svol-source of ssparm.
*       |         |     | Bei Vorhandensein: Hinweis auf Tabelle
*       |         |     | NAMEDPRC zeigen
*-------|---------|-----|----------------------------------------*
*A.01.32|20121114 | jb  | - Subkommando der "LIST"-Funktion umbe-
*       |         |     |   nannt in: "NOTINPROD"
*       |         |     | - Verwaltungsfunktion für zugelassene
*       |         |     |   User eingefügt: Delete, New, List
*-------|---------|-----|----------------------------------------*
*A.01.31|20121113 | jb  | Neues Subkommando der "LIST"-Funktion: "NOTPROD"
*       |         |     | zeigt alle Sources, die zwar in Test
*       |         |     | aktiviert, aber noch nicht in Produktion
*       |         |     | gestellt wurde
*-------|---------|-----|----------------------------------------*
*A.01.30|20121031 | jb  | Vor dem Aufruf vom SQLCOMP (Fkt. "AT")
*       |         |     | wird noch mal ein Delay gemacht
*-------|---------|-----|----------------------------------------*
*A.01.29|20121029 | jb  | PRGNEU nur aufrufen, wenn vorher R2T
*       |         |     | ohne Fehler gelaufen ist
*-------|---------|-----|----------------------------------------*
*A.01.28|20121022 | jb  | Die TACL-Prozedur PRGNEU komplett übernommen
*       |         |     | (alle Funktionen integriert ohne TACL-Aufruf)
*       |         |     | PRGNEU wird im Anschluss an REL2TEST
*       |         |     | zusätzlich ausgeführt. Zusätzlich kann
*       |         |     | die Funktion auch separat aufgerufen werden.
*-------|---------|-----|----------------------------------------*
*A.01.27|20121010 | jb  | Zusätzliche Abfrage wenn Zugriff auf Source
*       |         |     | in SSAFE nicht geklappt hat => dann
*       |         |     | Funktion verlassen
*-------|---------|-----|----------------------------------------*
*A.01.26|20120824 | jb  | beim LIST-Kommando in der Zeile zusätzlich
*       |         |     | den letzten Status anzeigen
*-------|---------|-----|----------------------------------------*
*A.01.25|20120720 | jb  | - Fehlertext bei Security-Problem bei
*       |         |     |   CHECKIN korrigiert
*       |         |     | - Leerzeile bei Start PROT-Kommando
*       |         |     | - Prozedur PRGNEU über TACL-Prozess
*       |         |     |   eingebunden. Zunächst als separater Aufruf
*       |         |     |   weil !!! funktioniert noch nicht !!!
*-------|---------|-----|----------------------------------------*
*A.01.24|20120717 | jb  | - Ungenauigkeit beim Setzen Default Catalog
*       |         |     |   bereinigt
*       |         |     | - Fehlermeldung, wenn unbekanntes Kommando
*-------|---------|-----|----------------------------------------*
*A.01.23|20120706 | jb  | FUP DUP nach WSRC nun auch mit "sourcedate"
*-------|---------|-----|----------------------------------------*
*A.01.22|20120629 | jb  | Delay-Time gesetzt
*-------|---------|-----|----------------------------------------*
*A.01.21|20120629 | jb  | STOP-Funktion mit ABEND
*-------|---------|-----|----------------------------------------*
*A.01.20|20120622 | jb  | Neue Funktion: STOP - alle Prozesse des
*       |         |     | SourceSafes, ausser des eigenen, werden
*       |         |     | gestoppt - das funktioniert nur bei
*       |         |     | Prozessen mit Namen, daher muss der RUN-
*       |         |     | Aufruf mit der Option /name/ erfolgen
*-------|---------|-----|----------------------------------------*
*A.01.19|20120607 | jb  | Obey-Datei von SSOBEY umbenannt auf
*       |         |     | SSOBYnnn, wobei nnn der User ist
*-------|---------|-----|----------------------------------------*
*A.01.18|20120606 | jb  | LIST-Kommando mit Angabe einer Source
*       |         |     | mit wildcharakter
*       |         |     | AXCEL durch OCA ersetzt
*-------|---------|-----|----------------------------------------*
*A.01.17|20120510 | jb  | alle FUPs mit ALLOW ERRORS
*-------|---------|-----|----------------------------------------*
*A.01.16|20120504 | jb  | Axcellerierung und SQLCOMP aus der Fkt.
*       |         |     | R2T entfernt und in die Funktion AT
*       |         |     | eingefügt.
*       |         |     | Axcellerierung ist NICHT mehr default.
*-------|---------|-----|----------------------------------------*
*A.01.15|20120503 | jb  | Unterstützung von SWITCH-1 eingebaut
*       |         |     | Nach setzen der Defines werden bei
*       |         |     | TRACE-ON die gesetzten Defines gezeigt
*-------|---------|-----|----------------------------------------*
*A.01.14|20120430 | jb  | Nach Ummelden werden die Defines des
*       |         |     | WE.Users geladen. Zugriff auf die Tabelle
*       |         |     | =DEFCAT (DEFINES) mit dynamischem SQL
*-------|---------|-----|----------------------------------------*
*A.01.13|20120424 | jb  | Namen der FUP-Obey-Datei um vollst.
*       |         |     | Pfad ergänzt. SetUpStrings nach SQL-Comp
*       |         |     | wieder gerade gebogen
*-------|---------|-----|----------------------------------------*
*A.01.12|20120419 | jb  | beim CHECKIN Kommandos für FUP geändert
*       |         |     | statt: RENAME, SECURE, GIVE
*       |         |     | jetzt: DUP, SECURE, PURGE
*-------|---------|-----|----------------------------------------*
*A.01.11|20120328 | jb  | nur User der Gruppe aus SSPARM/LOGIN
*       |         |     | werden zugelassen
*-------|---------|-----|----------------------------------------*
*A.01.10|20100505 | jb  | AXCEL und SQLCOMP in Funktion REL2TEST
*       |         |     | eingefügt. Dadurch entfällt der User-Hin-
*       |         |     | weis.
*       |         |     | Prozessüberwachung über $RECEIVE und
*       |         |     | completioncode in der Datenstruktur
*       |         |     | gem. _COMPLETION^PROCDEATH
*       |         |     | User-Autentikation geändert
*-------|---------|-----|----------------------------------------*
*A.01.02|20100221 | jb  | Meldung nach R2P erweitert
*-------|---------|-----|----------------------------------------*
*A.01.01|20100217 | jb  | HELP-Funktion korrigiert,
*       |         |     | Kommando ACTIVTEST in ACTIVTST umbenannt
*-------|---------|-----|----------------------------------------*
*A.01.00|20110216 |     | Freigabe
*     40|20110211 |     | Funktion SAVE eingefügt
*     31|20110210 |     | Funktion REL2PROD um Eintrag in Tabelle
*       |         |     | WVERSION erweitert, damit wird das Makro
*       |         |     | PUTPROG überflüssig
*       |         |     | dynamisches SQL für den Insert
*     30|20110209 |     | Funktion REL2PROD überarbeitet
*     21|20110208 |     | Prüfung bei CHECKIN/REL2TEST auf Sec.
*     20|20110207 |     | Funktion REL2TEST neu konzipiert
*     15|20110203 |     | Funktion REL2PROD eingefügt (nicht freigegeben)
*     11|20110203 |     | weitere Prüfungen eingebaut
*     10|20110202 |     | FUP generell auf OBEY umgestellt
*     08|20110128 |     | Funktion REL2PROD eingefügt
*A.00.07|20110125 | jb  | Neuerstellung
*       |         |     |
*----------------------------------------------------------------*
* Ende Versionsbeschreibung
*
* Programmbeschreibung
* --------------------
*
* Für Ausgabe des FUP wird default $BIT gesetzt. Über den Parameter
* PARAM-FUP-OUT kann die Ausgabe auf andere devices gelegt werden.
* Z.B. $WE.#SSAFE für den WEAT-Spooler
*
*
* Das Programm stellt einen Source Safe für die Tandem-Sources.
* Es gibt die folgenden Funktionen (nicht unbedingt aktuell):
*
*    ACTIVTEST   - Aktivieren in Test-Appl.
*                  ggf. löschen in TRUNOLD
*                  ggf. Renamen vorhandenes Obj. nach TRUNOLD
*                  Rename objectN nach object
*
*    CHECKIN     - damit wird ein Sourcefile von einem User in den
*                  Safe übernommen.
*
*    CHECKOUT    - damit wird ein Sourcefile für einen bestimmten
*                  User freigegeben
*
*    LIST        - Auflistung
*
*        leer        - aller Sources
*        CHECKEDIN   - aller eingecheckten Sources
*        CHECKEDOUT  - alle ausgecheckten Sources
*                   [,MONTH AnzahlMonate]
*                        - Liste der ausgecheckten Sources
*                          älter als AnzahlMonate
*                   [,USER username]
*                        - aller ausgecheckten Sources [eines Users]
*        NOTINPROD - Liste aller Sources, die in TEST aktiviert sind,
*                    aber für die Produktion weder released noch
*                    aktiviert sind
*        RELEASED    - aller Freigaben für Produktion erteilt aber nicht übernommen
*
*    PROT        - der Protolleinträge aller Sources oder
*                    [source]
*                        - einer Source
*    REL2PROD    - ggf. Löschen PRUNARCH.object
*                  ggf. renamen PRUN.object nach PRUNARCH.object
*                  Übernahme Object aus TRUN nach PRUN
*                  Übergabe Source aus TSRC nach PSRC (mit rollover)
*
*    REL2TEST    - Übergabe Object aus Entw. nach Test mit nameN
*                  sichern Source aus WSRC in SSRC (mit rollover)
*                  Übergabe Source nach Test (mit rollover)
*
*    SAVE        - sichern Source aus WSRC in SSRC (mit rollover)
*
*    SHOW [source]   - Anzeige Details einer Source
*
*
*
*
*
******************************************************************
*
* Uebersicht der SECTIONs:
*
* CONFIGURATION
* INPUT-OUTPUT
* FILE
* WORKING-STORAGE
* EXTENDED-STORAGE
*
* terminal-eingabe-use
*
* A000-STEUERUNG
*
* B000-VORLAUF
* B090-ENDE
* B100-USER-ABFRAGEN
* B200-BEARB-STARTUP
*
* C000-INIT
* C010-UMMELDEN
* C020-GET-AUTENT
* C030-PUT-AUTENT
* C040-WE-DEFINES
* C050-GET-USER-INFO
* C100-CHECKIN
* C110-CHECKOUT
* C200-LIST
* C210-SHOW
* C220-PROT
* C250-DOKUMENT
* C260-MODIS
* C270-MODIN
* C300-REL2PROD
* C310-REL2TEST
* C320-SAVE
* C340-REL4WEAT
* C360-ACTIVTEST
* C400-STOP
* C410-PRGNEU
* C420-VERWALTUNG
* C500-EMERGENCY-CONTROL
*
* D000-ALLE-FEHL-006
* D020-SETMODE
* D040-SET-CATDEFINE
* D050-SET-TABDEFINE
* D060-SET-DEFCAT
*
* D250-VERSIONS-DOKU
* D260-SHOW-MODIS
* D270-SHOW-MODIN
* D310-COPY-ROLLOVER
* D320-COPY-OBJECT
* D330-WVERSION
* D340-ABNAHME-WERTE
* D360-ACTIVTEST-PARM
* D410-REFERENZEN
* D420-DELETE-USER
* D430-LIST-ALL-USER
* D440-INSERT-USER
* D450-LIST-ROL-FKT
* D500-AUSWAHL-OBJECT
* D700-CREATE-ABNAHME
* D710-UPDATE-ABNAHME-AT
* D720-UPDATE-ABNAHME-R2P
*
* E100-FIND-START
* E110-FIND-NEXT
* E120-FILE-INFO
* E150-OBEY-FUP
* E310-AXCEL
* E320-SQL
* E330-VERSION
* E410-LOOK4CALL
* E411-LOOK4COPY
* E412-LOOK4INVOKE
* E413-LOOK4LASTDAT
* E414-LOOK4LASTVERS
* E415-LOOK4SHORTDESCR
* E416-LOOK4UPDDESCR
* E440-SHOW-ROLLEN
*
* F310-DEFINE
*
* H100-HELP
*
* M000-STARTUP-VOLUME
* M020-STARTUP-OUT
* M030-STARTUP-STRING
* M040-USER-PROCINFO
* M050-PARAM-FUP-OUT
* M140-CALL-HCDAY
* M500-MAIL-AUFHEBUNG
* M510-MAIL-ABNAHMEANTRAG
* M520-MAIL-SICHERHEITSWARUNUNG
*
* N010-ASSIGN-SSOBEY
* N020-OPEN-OUT
* N030-CHECK-STARTUP
* N035-CHECK-EINGABE
* N500-EMAIL-KOPF
* N510-PROGRAMMINFORMATIONEN
*
* o030-CMD-LIST
*
* R100-SHOW-TEXT
*
* S100-SELECT-SSAFE
* S110-UPDATE-SSAFE-CHECKIN
* S120-UPDATE-SSAFE-CHECKOUT
* S121-UPDATE-SSAFE-REL2TEST
* S122-UPDATE-SSAFE-REL2PROD
* S130-INSERT-SSAFE
* S140-OPEN-SSAFE-CURSOR
* S141-FETCH-SSAFE-CURSOR
* S142-CLOSE-SSAFE-CURSOR
* S200-INSERT-SSPROT
* S210-OPEN-SSPROT-CURSOR
* S211-FETCH-SSPROT-CURSOR
* S212-CLOSE-SSPROT-CURSOR
* S220-SELECT-SSPROT-MAX
* S222-SELECT-SSPROT-ALL
* S223-SELECT-SSPROT-MAX-ZP
* S224-SELECT-SSPROT-MAX-CI
* S300-SELECT-SSPARM
* S310-UPDATE-SSPARM
* S320-SELECT-SSPARM-USER
* S330-OPEN-SSPARM-CURSOR
* S331-FETCH-SSPARM-CURSOR
* S332-CLOSE-SSPARM-CURSOR
* S340-INSERT-SSPARM
* S350-DELETE-SSPARM
* S400-INSERT-WVERSION
* S500-OPEN-DEFCAT-CURSOR
* S510-FETCH-DEFCAT-CURSOR
* S520-CLOSE-DEFCAT-CURSOR
* S600-OPEN-SSTEXT-CURSOR
* S601-FETCH-SSTEXT-CURSOR
* S602-CLOSE-SSTEXT-CURSOR
* S620-OPEN-RECHTE-CURSOR
* S621-FETCH-RECHTE-CURSOR
* S622-CLOSE-RECHTE-CURSOR
* S623-SELECT-SSUSER
* S624-INSERT-SSUSER
* S625-DELETE-SSUSER
* S630-OPEN-USER-CURSOR
* S631-FETCH-USER-CURSOR
* S632-CLOSE-USER-CURSOR
* S640-OPEN-ROLLEN-CURSOR
* S641-FETCH-ROLLEN-CURSOR
* S642-CLOSE-ROLLEN-CURSOR
* S645-SELECT-SSROLES
* S700-INSERT-ABNAHME
* S710-UPDATE-ABNAHME-WE1
* S712-UPDATE-ABNAHME-WE2
* S714-UPDATE-ABNAHME-WE3
* S716-UPDATE-ABNAHME-WE4
* S720-OPEN-ABNAHME-CURSOR
* S721-FETCH-ABNAHME-CURSOR
* S722-CLOSE-ABNAHME-CURSOR
* S730-DELETE-ABNAHME
* S740-OPEN-ABNAHME-A-CURSOR
* S741-FETCH-ABNAHME-A-CURSOR
* S742-CLOSE-ABNAHME-A-CURSOR
* S750-OPEN-ABNAHME-S-CURSOR
* S751-FETCH-ABNAHME-S-CURSOR
* S752-CLOSE-ABNAHME-S-CURSOR
* S790-SELECT-EKONTAKT
* S800-DELETE-REF-TABS
* S810-INSERT-PROGRAMS
* S820-INSERT-PROGRAMX
* S825-SELECT-PROGRAMX
* S830-INSERT-LIBS
* S840-SELECT-PROGRAMS
* S845-UPDATE-PRG-AEND
* S846-UPDATE-PRG-VERS
* S847-UPDATE-PRG-DESCR
* S850-INSERT-TABS
* S860-OPEN-MODIS-CURSOR
* S861-FETCH-MODIS-CURSOR
* S862-CLOSE-MODIS-CURSOR
* S870-OPEN-MODIN-CURSOR
* S871-FETCH-MODIN-CURSOR
* S872-CLOSE-MODIN-CURSOR
*
* U000-EINGABE
* U010-AUSGABE
* U011-AUSGABE-SPACELINE
* U020-ZEIT
* U030-TIMESTAMP
* U100-BEGIN
* U110-COMMIT
* U120-ROLLBACK
* U200-ERSTELLEN-OBEYDATEI
* U210-FUP
* U310-DECR
* U320-ENCR
* U400-OBJECT-NAME
*
* V000-FC
* V100-STARTUP
* V200-PURGE-OBEYDATEI
*
* W020-COBOLFILEINFO
* W030-CREATEPROCESS
* W200-OPENINFO
* W350-PUTSTARTUPTEXT
* W360-DELETESTARTUP
* W400-DELETEDEFINE
* W410-DEFINESETATTR
* W420-ADDDEFINE
* W430-DEFINEINFO
*
******************************************************************

 ENVIRONMENT DIVISION.
 CONFIGURATION SECTION.
 SPECIAL-NAMES.
     SWITCH-1 IS TRACE-FLAG
         ON  STATUS IS TRACE-ON
         OFF STATUS IS TRACE-OFF
     CLASS ALPHNUM IS "0123456789"
                      "abcdefghijklmnopqrstuvwxyz"
                      "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                      " .,;-_!§$%&/=*+"
     DECIMAL-POINT IS COMMA.

 INPUT-OUTPUT SECTION.
 FILE-CONTROL.
     SELECT MSG-DATEI    ASSIGN TO $RECEIVE.
     SELECT HTERMINAL    ASSIGN TO #TERM
                         FILE STATUS IS FILE-STATUS.
     SELECT LISTE        ASSIGN TO #DYNAMIC.
     SELECT SSOBEY       ASSIGN TO #DYNAMIC
                         FILE STATUS IS FILE-STATUS.
     SELECT SOURCEF      ASSIGN TO #DYNAMIC.
     SELECT EMAIL        ASSIGN EMAIL.

 RECEIVE-CONTROL.
     TABLE OCCURS 1 TIMES
     REPORT SYSTEM MESSAGES.

 DATA DIVISION.
 FILE SECTION.
 FD  MSG-DATEI.
 01          MSG-SATZ.
     05      MSG-STATUS          PIC S9(04) COMP.
     05      MSG-PHANDLE         PIC  X(20).
     05      MSG-CPU-TIME        PIC S9(18) COMP.
     05      MSG-JOBID           PIC S9(04) COMP.
     05      MSG-COMPLETION-CODE PIC S9(04) COMP.
     05      MSG-TERMINATION-CODE PIC S9(04) COMP.
     05      MSG-SUBSYSTEM       PIC  X(12).
     05      MSG-PHANDLE-KILLER  PIC  X(20).
     05      MSG-TERMTEXT-LEN    PIC S9(04) COMP.
     05      MSG-PROCNAME.
      10     MSG-ZOFFSET         PIC S9(04) COMP.
      10     MSG-ZLEN            PIC S9(04) COMP.
     05      MSG-FLAGS           PIC S9(04) COMP.
     05      MSG-RESERVE         PIC  X(06).
     05      MSG-DATA            PIC  X(112).
     05      MSG-REST            PIC  X(06).

 FD  HTERMINAL.
 01  HTERM-IN                    PIC X(128).

 FD  LISTE.
 01  LISTE-SATZ                  PIC X(80).

 FD  SSOBEY.
 01  SSOBEY-SATZ                 PIC X(80).

 FD  SOURCEF
     RECORD  IS VARYING IN SIZE
             FROM 0 TO 128 CHARACTERS
             DEPENDING ON REC-LEN.
 01  SOURCEF-RECORD              PIC X(128).

 FD  EMAIL.
 01  EMAIL-RECORD                PIC X(080).

 WORKING-STORAGE SECTION.
*--------------------------------------------------------------------*
* Comp-Felder: Praefix Cn mit n = Anzahl Digits
*--------------------------------------------------------------------*
 01          COMP-FELDER.
     05      C4-ANZ              PIC S9(04) COMP.
     05      C4-ANZ1             PIC S9(04) COMP.
     05      C4-ANZ2             PIC S9(04) COMP.
     05      C4-ANZ3             PIC S9(04) COMP.
     05      C4-ANZ-PROC         PIC S9(04) COMP.
     05      C4-BESCH-LEN        PIC S9(04) COMP.
     05      C4-COUNT            PIC S9(04) COMP.
     05      C4-I1               PIC S9(04) COMP.
     05      C4-I2               PIC S9(04) COMP.
     05      C4-INLEN            PIC S9(04) COMP.
     05      C4-INLEN-A          PIC S9(04) COMP.
     05      C4-LEN              PIC S9(04) COMP.
     05      C4-OPT              PIC  9(04) COMP.
     05      C4-PERROR           PIC S9(04) COMP.
     05      C4-PTR              PIC S9(04) COMP.
     05      C4-STR-PTR          PIC S9(04) COMP.

     05      C9-ANZ              PIC S9(09) COMP.
     05      C9-COUNT            PIC S9(09) COMP.
     05      C9-DELAY-TIME       PIC S9(09) COMP.
     05      C9-TIME-OUT         PIC S9(07)V99.

     05      C18-VAL             PIC S9(18) COMP.

     05      CD4-X.
      10                         PIC X value low-value.
      10     CD4-X2              PIC X.
     05      CD4-NUM redefines CD4-X
                                 PIC S9(04) COMP.

*--------------------------------------------------------------------*
* Display-Felder: Praefix D
*--------------------------------------------------------------------*
 01          DISPLAY-FELDER.
     05      D-NUM1              PIC  9.
     05      D-NUM2              PIC  9(02).
     05      D-NUM31             PIC  9(03).
     05      D-NUM32             PIC  9(03).
     05      D-NUM4              PIC -9(04).
     05      D-NUM4V             PIC -9(04).
     05      D-NUM4O             PIC  9(04).
     05      D-NUM6              PIC  9(06).
     05      D-NUM8              PIC  9(08).
     05      D-FILE-GROUP        PIC  9(03).
     05      D-FILE-OWNER        PIC  9(03).
     05      D-SEC-STRING        PIC X(04).
     05      D-SOURCE            PIC X(08).
     05      IN-SOURCE           PIC X(36).
     05      OUT-SOURCE          PIC X(36).

*--------------------------------------------------------------------*
* Parameter fuer Untermodulaufrufe: Praefix P
*--------------------------------------------------------------------*
 01          PARAMETER-FELDER.
**  ---> fuer Routine GET-/PUT-STARTUPTEXT
     05      P-PORTION           PIC X(30).
     05      P-TEXT              PIC X(128).
     05      P-RESULT            PIC S9(04) COMP VALUE ZERO.
     05      p-list              PIC  9(09) COMP VALUE ZERO.

 01          P-DEFINE            PIC X(24).
 01          P-ATTRIBUT          PIC X(16).
 01          P-VALUE             PIC X(36).
 01          P-VALUELEN          PIC S9(04) comp.
 01          P-DEF-NAMES         PIC X(16).
 01          P-REPLACE           PIC S9(04) comp value 1.

 01          P-CLASS             PIC X(16).
 01          P-VALUE-BUFLEN      PIC S9(04) COMP VALUE 24.

 01          P-HEX8              PIC X(08).
 01          P-HEX16             PIC X(16).

**  ---> für Routinen PROCESSHANDLE_GETMINE_, PROCESS_GETINFO_,
**  ---> und          USER_GETINFO_, PROCESSNAME_CREATE_
 01          P-ERROR             PIC S9(04) COMP.
 01          P-ERROR-DETAIL      PIC XX.
 01          P-PROCESSHANDLE     PIC X(20).

 01          P-HOMETERM          PIC X(26).
 01          P-HOMETERM-MAX      PIC S9(04) COMP VALUE 26.
 01          P-HOMETERM-LEN      PIC S9(04) COMP.
 01          P-PROG-FNAME        PIC X(47).
 01          P-PROG-FNAME-LEN47  PIC S9(04) COMP VALUE 47.
 01          P-PROG-FNAME-LEN    PIC S9(04) COMP.
 01          P-PROC-NAME         PIC X(20).
 01          P-PROC-NAME-LEN20   PIC S9(04) COMP VALUE 20.
 01          P-PROC-NAME-LEN     PIC S9(04) COMP.

**  ---> für Stop-Routine
 01          ST-PRIM-PROC-HANDLE PIC X(20).
 01          ST-HOMETERM         PIC X(26).
 01          ST-HOMETERM-MAX     PIC S9(04) COMP VALUE 26.
 01          ST-HOMETERM-LEN     PIC S9(04) COMP.
 01          ST-PROG-FNAME       PIC X(47).
 01          ST-PROG-FNAME-LEN47 PIC S9(04) COMP VALUE 47.
 01          ST-PROG-FNAME-LEN   PIC S9(04) COMP.
 01          ST-PROC-PAIR        PIC X(47).
 01          ST-PROC-PAIR-LEN47  PIC S9(04) COMP VALUE 47.
 01          ST-PROC-PAIR-LEN    PIC S9(04) COMP.
 01          ST-PROC-FNAME       PIC X(47).
 01          ST-PROC-FNAME-LEN47 PIC S9(04) COMP VALUE 47.
 01          ST-PROC-FNAME-LEN   PIC S9(04) COMP.
 01          ST-FEHL             PIC S9(04) COMP VALUE ZERO.
 01          ST-RETCODE          PIC S9(04) COMP VALUE ZERO.
 01          ST-SEARCH-INDEXO.
     05      ST-SEARCH-INDEX     PIC S9(09) COMP VALUE ZERO.
 01          ST-OPTION-ABEND     PIC S9(04) COMP VALUE 1.

 01          P-CREATOR-ACCESS-ID PIC X(2).
 01          P-CAI REDEFINES P-CREATOR-ACCESS-ID.
     05      P-CAI-GID           PIC X.
     05      P-CAI-UID           PIC X.

 01          P-PROCESS-ACCESS-ID PIC X(2).
 01          P-PAI REDEFINES P-PROCESS-ACCESS-ID.
     05      P-PAI-GID           PIC X.
     05      P-PAI-UID           PIC X.

 01          P-USERID            PIC X(4) VALUE LOW-VALUE.
 01          PR-USERID REDEFINES P-USERID.
     05                          PIC XX.
     05      PR-UI.
      10     PR-GUI              PIC X.
      10     PR-UUI              PIC X.

 01          P-PRIMGROUP         PIC X(4) VALUE LOW-VALUE.
 01          PR-PRIMGROUP REDEFINES P-PRIMGROUP.
     05                          PIC XX.
     05      PR-PG               PIC XX.
     05      PR-PG-R   REDEFINES PR-PG   PIC S9(04) COMP.

 01          P-USER-NAME         PIC X(32) VALUE SPACE.
 01          P-USER-MAXLEN       PIC S9(4) COMP VALUE 32.
 01          P-USER-CURLEN       PIC S9(4) COMP VALUE ZERO.

**          ---> Parameter fuer COBOLLIB: ASSIGN
 01          ASS-FNAME           PIC X(34).
 01          ASS-FSTATUS         PIC S9(04) COMP.

*--------------> WT^OPENINFO und WT^FINFOBYNAME
 01          AP-DNAME            PIC X(36).
 01          AP-DNAME-LEN        PIC S9(4) COMP VALUE ZERO.
 01          AP-STATUS           PIC S9(04) COMP.
 01          AP-PREVTAG.
     05      AP-PREVTAGN         PIC S9(18) COMP.
 01          AP-DELAY-FLAG       PIC X.
          88 AP-DELAY-ON                     VALUE LOW-VALUE.
          88 AP-DELAY-OFF                    VALUE HIGH-VALUE.
 01          AP-DNAME-ZW         PIC X(36).


*--------------------------------------------------------------------*
* Felder mit konstantem Inhalt: Praefix K
*--------------------------------------------------------------------*
 01          KONSTANTE-FELDER.
     05      K-PROG-START        PIC X(78) VALUE
                             "Source Safe  (A.02.28 vom 05.12.2014)".
     05      K-MODUL             PIC X(08) VALUE "SRCSAFE".
     05      K-OCA               PIC X(47) VALUE "$SYSTEM.SYSTEM.OCA".
     05      K-AXCEL             PIC X(47) VALUE "$SYSTEM.SYSTEM.AXCEL".
     05      K-FUP               PIC X(47) VALUE "$SYSTEM.SYSTEM.FUP".
     05      K-SQLCOMP           PIC X(47) VALUE "$SYSTEM.SYSTEM.SQLCOMP".
     05      K-TACL              PIC X(47) VALUE "$SYSTEM.SYSTEM.TACL".
     05      K-OBEYDATEI.
      10                         PIC X(05) VALUE "SSOBY".
      10     K-OBEYDATEI-USER    PIC 9(03).
     05      K-FUP-OUT           PIC X(08) VALUE "$BIT".

 01          K-VALUE-1           PIC S9(04)    COMP VALUE 1.
 01          K-DELAY-TIME        PIC S9(09)    COMP VALUE 10.
 01          K-TIME-OUT60        PIC S9(07)V99 COMP VALUE 60.
 01          K-TIME-OUT600       PIC S9(07)V99 COMP VALUE 600.
 01          K-SPACES64          PIC X(64) VALUE SPACES.
 01          K-SPACES32          PIC X(32) VALUE SPACES.
 01          K-SPACES16          PIC X(16) VALUE SPACES.

 01          K-PROMPTS.
     05      K-PROMPT-CMD.
      10                         PIC X(10) VALUE "  SRCSAFE ".
      10     K-PROMPT-CMD-T      PIC X(08).
      10                         PIC X(04) VALUE " >>".
     05      K-PROMPT-CHECKIN    PIC X(22) VALUE "  Funktion CHECKIN +>".
     05      K-PROMPT-CHECKOUT   PIC X(22) VALUE " Funktion CHECKOUT +>".
     05      K-PROMPT-SOURCE     PIC X(22) VALUE "        Source-Modul:".
     05      K-PROMPT-SOURCE-TYP PIC X(22) VALUE "          Source-Typ:".
     05      K-PROMPT-PASSWORT   PIC X(22) VALUE "   Passwort eingeben:".
     05      K-PROMPT-LEER-SRC   PIC X(22) VALUE "  leer oder Src-Name:".
     05      K-PROMPT-WEITER     PIC X(22) VALUE "        weiter (j/n):".
     05      K-PROMPT-FC         PIC X(22) VALUE "                   ...".
     05      K-PROMPT-VERW       PIC X(22) VALUE "  Verwalt. SRCSAFE +>".
     05      K-PROMPT-VDUSER     PIC X(22) VALUE "  zu löschender User:".
     05      K-PROMPT-VIUSER     PIC X(22) VALUE "          neuer User:".
     05      K-PROMPT-ROLLE      PIC X(22) VALUE "        Angabe Rolle:".
     05      K-PROMPT-AUFTRAGGEB PIC X(22) VALUE "        Auftraggeber:".
     05      K-PROMPT-AUFTR-LINK PIC X(22) VALUE "    Link zum Auftrag:".
     05      K-PROMPT-VOM        PIC X(22) VALUE "    vom (tt.mm.jjjj):".
     05      K-PROMPT-KONZ-LINK  PIC X(22) VALUE "    Link zum Konzept:".
     05      K-PROMPT-TEST-LINK  PIC X(22) VALUE "Link zum Testprotok.:".
     05      K-PROMPT-FREI-LINK  PIC X(22) VALUE "   Link zur Freigabe:".
     05      K-PROMPT-SOS        PIC X(22) VALUE "Grund für Abweichung:".
     05      K-PROMPT-DELETE     PIC X(22) VALUE "      Löschen? (j/n):".
     05      K-PROMPT-FORTFAHREN PIC X(22) VALUE "weiteres Prog? (n/j):".
     05      K-PROMPT-OBJECT     PIC X(22) VALUE "    Object oder leer:".
     05      K-PROMPT-VERSION    PIC X(22) VALUE "             Version:".

 01          K-PROMPT-TABELLE REDEFINES K-PROMPTS.
     05      K-PROMPT-ELE        PIC X(22) OCCURS 24.

 01          PROMPT-FLAG         PIC S9(04) COMP.
          88 PROMPT-CMD                      VALUE 01.
          88 PROMPT-CHECKIN                  VALUE 02.
          88 PROMPT-CHECKOUT                 VALUE 03.
          88 PROMPT-SOURCE                   VALUE 04.
          88 PROMPT-SOURCE-TYP               VALUE 05.
          88 PROMPT-PASSWORT                 VALUE 06.
          88 PROMPT-LEER-SRC                 VALUE 07.
          88 PROMPT-WEITER                   VALUE 08.
          88 PROMPT-FC                       VALUE 09.
          88 PROMPT-VERW                     VALUE 10.
          88 PROMPT-VDUSER                   VALUE 11.
          88 PROMPT-VIUSER                   VALUE 12.
          88 PROMPT-ROLLE                    VALUE 13.
          88 PROMPT-AUFTRAGGEB               VALUE 14.
          88 PROMPT-AUFTR-LINK               VALUE 15.
          88 PROMPT-VOM                      VALUE 16.
          88 PROMPT-KONZ-LINK                VALUE 17.
          88 PROMPT-TEST-LINK                VALUE 18.
          88 PROMPT-FREI-LINK                VALUE 19.
          88 PROMPT-SOS                      VALUE 20.
          88 PROMPT-DELETE                   VALUE 21.
          88 PROMPT-FORTFAHREN               VALUE 22.
          88 PROMPT-OBJECT                   VALUE 23.
          88 PROMPT-VERSION                  VALUE 24.
 01          PROMPT-FLAG-A       PIC S9(04) COMP.


*--------------------------------------------------------------------*
* Conditional-Felder
*--------------------------------------------------------------------*
 01          SCHALTER.
     05      FILE-STATUS         PIC X(02).
          88 FILE-OK                         VALUE "00".
          88 FILE-NOK                        VALUE "01" THRU "99".
          88 FILE-TIME-OUT                   VALUE "30".
     05      REC-STAT REDEFINES  FILE-STATUS.
        10   FILE-STATUS1        PIC X.
          88 FILE-EOF                        VALUE "1".
          88 FILE-INVALID                    VALUE "2".
          88 FILE-PERMERR                    VALUE "3".
          88 FILE-LOGICERR                   VALUE "4".
          88 FILE-NONAME                     VALUE "5" THRU "8".
          88 FILE-IMPLERR                    VALUE "9".
        10                       PIC X.

     05      PRG-STATUS          PIC X       VALUE SPACE.
          88 PRG-OK                          VALUE SPACE.
          88 PRG-ABBRUCH                     VALUE HIGH-VALUE.
          88 PRG-ENDE                        VALUE LOW-VALUE.

     05      FILES-FLAG          PIC X       VALUE LOW-VALUE.
          88 F-OK                            VALUE LOW-VALUE.
          88 F-EOF                           VALUE HIGH-VALUE.

     05      FILE-IN-STATUS      PIC X       VALUE SPACE.
          88 FILE-IN-CLOSE                   VALUE SPACE.
          88 FILE-IN-OPEN                    VALUE HIGH-VALUE.

     05      FILE-OUT-STATUS      PIC X      VALUE SPACE.
          88 FILE-OUT-CLOSE                  VALUE SPACE.
          88 FILE-OUT-OPEN                   VALUE HIGH-VALUE.

     05      AUSGABE-FLAG        PIC X       VALUE LOW-VALUE.
          88 AUSGABE-DISPLAY                 VALUE LOW-VALUE.
          88 AUSGABE-DATEI                   VALUE HIGH-VALUE.

     05      EINGABE-FLAG        PIC X       VALUE LOW-VALUE.
          88 EINGABE-DISPLAY                 VALUE LOW-VALUE.
          88 EINGABE-DATEI                   VALUE HIGH-VALUE.

     05      CHECK-FLAG          PIC X       VALUE SPACE.
          88 CHECK-NOK                       VALUE SPACE.
          88 CHECK-OK                        VALUE HIGH-VALUE.

     05      CHECKIN-FLAG        PIC X       VALUE SPACE.
          88 CHECKIN-FIRST                   VALUE SPACE.
          88 CHECKIN-NEXT                    VALUE HIGH-VALUE.

     05      TSRC-FLAG           PIC X       VALUE SPACE.
          88 TSRC-NO                         VALUE SPACE.
          88 TSRC-YES                        VALUE HIGH-VALUE.

     05      SRCZ-FLAG           PIC X       VALUE SPACE.
          88 SRCZ-NO                         VALUE SPACE.
          88 SRCZ-YES                        VALUE HIGH-VALUE.

     05      PROCTYPE-FLAG       PIC X       VALUE SPACE.
          88 PROC-NO-NAME                    VALUE SPACE.
          88 PROC-NAMED                      VALUE HIGH-VALUE.

     05      EIN-FLAG            PIC X       VALUE SPACE.
          88 EIN-ASCII                       VALUE SPACE.
          88 EIN-ALPHA-NUM                   VALUE LOW-VALUE.
          88 EIN-NUM                         VALUE HIGH-VALUE.
          88 EIN-KLEIN-GROSS                 VALUE "K".

     05      FOUND-FLAG          PIC X       VALUE SPACE.
          88 FOUND-NO                        VALUE SPACE.
          88 FOUND-YES                       VALUE HIGH-VALUE.

     05      REF-TABS-FLAG       PIC X       VALUE SPACE.
          88 REF-TABS-OK                     VALUE SPACE.
          88 REF-TABS-NOK                    VALUE HIGH-VALUE.

     05      STU-FLAG            PIC X       VALUE SPACE.
          88 STU-IN                          VALUE SPACE.
          88 STU-OUT                         VALUE LOW-VALUE.
          88 STU-STRING                      VALUE HIGH-VALUE.

     05      AXL-FLAG            PIC X       VALUE SPACE.
          88 AXL-NOAXL                       VALUE SPACE.
          88 AXL-AXL                         VALUE HIGH-VALUE.

     05      SQL-FLAG            PIC X       VALUE SPACE.
          88 SQL-SQL                         VALUE SPACE.
          88 SQL-NOSQL                       VALUE HIGH-VALUE.

     05      CURS-FLAG           PIC X       VALUE SPACE.
          88 CURS-NOK                        VALUE SPACE.
          88 CURS-SSAFE                      VALUE LOW-VALUE.
          88 CURS-SSAFE2                     VALUE HIGH-VALUE.
          88 CURS-ABNAHME                    VALUE "A".

     05      SSF-FLAG            PIC X       VALUE SPACE.
          88 SSF-EOD                         VALUE SPACE.
          88 SSF-OK                          VALUE HIGH-VALUE.

     05      SSPRM-FLAG          PIC X       VALUE SPACE.
          88 SSPRM-EOD                       VALUE SPACE.
          88 SSPRM-OK                        VALUE HIGH-VALUE.

     05      SSPROT-FLAG         PIC X       VALUE SPACE.
          88 SSPROT-EOD                      VALUE SPACE.
          88 SSPROT-OK                       VALUE HIGH-VALUE.

     05      SSTEXT-FLAG         PIC X       VALUE SPACE.
          88 SSTEXT-EOD                      VALUE SPACE.
          88 SSTEXT-OK                       VALUE HIGH-VALUE.

     05      USER-FLAG           PIC X       VALUE SPACE.
          88 USER-EOD                        VALUE SPACE.
          88 USER-OK                         VALUE HIGH-VALUE.

     05      REFTABS-FLAG        PIC X       VALUE SPACE.
          88 REFTABS-EOD                     VALUE SPACE.
          88 REFTABS-OK                      VALUE HIGH-VALUE.

     05      DYNCURS-FLAG        PIC X       VALUE SPACE.
          88 DYNCURS-EOD                     VALUE SPACE.
          88 DYNCURS-OK                      VALUE HIGH-VALUE.

     05      DEFCAT-FLAG         PIC 9       VALUE ZERO.
          88 DEFCAT-OK                       VALUE ZERO.
          88 DEFCAT-NOK                      VALUE 1.

     05      SOURCEF-FLAG        PIC X       VALUE SPACE.
          88 SOURCEF-FOUND                   VALUE SPACE.
          88 SOURCEF-NOK                     VALUE LOW-VALUE.
          88 SOURCEF-OK                      VALUE HIGH-VALUE.

     05      V-FLAG              PIC 99      VALUE ZERO.
          88 V-SONST                         VALUE ZERO.
          88 V-CALL                          VALUE 1.
          88 V-COPY                          VALUE 2.
          88 V-DATUM                         VALUE 3.
          88 V-VERSION                       VALUE 4.
          88 V-BESCHREIBUNG                  VALUE 5.
          88 V-TAB                           VALUE 6.
          88 V-PACK                          VALUE 7.
          88 V-INVOKE                        VALUE 8.
          88 V-UPDVERS                       VALUE 9.

     05      COMMENT-FLAG        PIC X       VALUE SPACE.
          88 COMMENT-ON                      VALUE SPACE.
          88 COMMENT-OFF                     VALUE LOW-VALUE.

     05      REL4WEAT-FLAG       PIC X       VALUE SPACE.
          88 REL4WEAT-FIRST                  VALUE SPACE.
          88 REL4WEAT-FOLLOWED               VALUE HIGH-VALUE.

     05      SRC-TYP             PIC X(02).
          88 SRC-TYP-OK                      VALUE "CS" "CO" "CX" "CM"
                                                   "CL" "TB" "TP" "UC".

     05      CMD-KOMMANDO        PIC X(10).
          88 CMD-ACTIVPROD                   VALUE "AP"  "ACTIVPROD".
          88 CMD-ACTIVTEST                   VALUE "AT"  "ACTIVTST"
                                                         "ACTIVTEST".
          88 CMD-CHECKIN                     VALUE "IN"  "CHECKIN".
          88 CMD-CHECKOUT                    VALUE "OUT" "CHECKOUT".
          88 CMD-DOKUMENT                    VALUE "D" "DOK".
          88 CMD-EMERGENCY-CONTROL           VALUE "EC" "EMERGCONTR".
          88 CMD-EXIT                        VALUE "E" "EX" "EXI" "EXIT".
          88 CMD-HELP                        VALUE "?" "H" "HE" "HEL" "HELP"
                                                   "HILFE".
          88 CMD-LIST                        VALUE "L" "LIST".
          88 CMD-MODIN                       VALUE "MIN" "MODIN".
          88 CMD-MODIS                       VALUE "MIS" "MODIS".
          88 CMD-PRGNEU                      VALUE "PRGNEU".
          88 CMD-PROT                        VALUE "P" "PROT" "PROTOKOLL".
          88 CMD-REL2PROD                    VALUE "R2P" "REL2PROD".
          88 CMD-REL2TEST                    VALUE "R2T" "REL2TEST".
          88 CMD-REL4WEAT                    VALUE "R4W" "REL4WEAT".
          88 CMD-ROLLEN                      VALUE "R" "ROLLEN".
          88 CMD-SAVE                        VALUE "SA" "SAVE".
          88 CMD-SHOW                        VALUE "SH" "SHOW".
          88 CMD-STOP                        VALUE "STOP".
          88 CMD-VERW                        VALUE "V" "VERW" "VERWALTUNG".
**       ---> zus. Kommandos für Verwaltung (LIST gibt's schon)
          88 CMD-NEW                         VALUE "N" "NEW" "NEU".
          88 CMD-DEL                         VALUE "D" "DEL" "DELETE".

     05      SOURCE-TYP          PIC X(02)   VALUE SPACE.
          88 SOURCE-PROGRAM                  VALUE "CS" "CO" "CX".
          88 SOURCE-OTHER-FILE               VALUE "CM" "CL" "TB" "TP"
                                                   "UC".
 01          ACCESS-FLAG.
     05      ACCESS-FLAG-1       PIC X(01)   VALUE SPACE.
          88 READ-ACCESS                     VALUE "J".
     05      ACCESS-FLAG-2       PIC X(01)   VALUE SPACE.
          88 WRITE-ACCESS                    VALUE "J".
     05      ACCESS-FLAG-3       PIC X(01)   VALUE SPACE.
     05      ACCESS-FLAG-4       PIC X(01)   VALUE SPACE.
     05      ACCESS-FLAG-5       PIC X(01)   VALUE SPACE.
     05      ACCESS-GRP          PIC 9(03)   VALUE ZERO.


**  ---> die folgenden Flags beschreiben die für den User zugelassenen
**  ---> Funtionen
 01          ROLFKT-FLAG.
     05      ROLFKT-FLAG-1       PIC X(01)   VALUE SPACE.
          88 ROLFKT-DOK                      VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-2       PIC X(01)   VALUE SPACE.
          88 ROLFKT-LIST                     VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-3       PIC X(01)   VALUE SPACE.
          88 ROLFKT-PROT                     VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-4       PIC X(01)   VALUE SPACE.
          88 ROLFKT-SHOW                     VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-5       PIC X(01)   VALUE SPACE.
          88 ROLFKT-CHECKOUT                 VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-6       PIC X(01)   VALUE SPACE.
          88 ROLFKT-CHECKIN                  VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-7       PIC X(01)   VALUE SPACE.
          88 ROLFKT-REL2TEST                 VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-8       PIC X(01)   VALUE SPACE.
          88 ROLFKT-SAVE                     VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-9       PIC X(01)   VALUE SPACE.
          88 ROLFKT-ACTIVTST                 VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-10      PIC X(01)   VALUE SPACE.
          88 ROLFKT-REL4WEAT                 VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-11      PIC X(01)   VALUE SPACE.
          88 ROLFKT-REL2PROD                 VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-12      PIC X(01)   VALUE SPACE.
          88 ROLFKT-VERW                     VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-13      PIC X(01)   VALUE SPACE.
          88 ROLFKT-MODIS                    VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-14      PIC X(01)   VALUE SPACE.
          88 ROLFKT-MODIN                    VALUE HIGH-VALUE.
     05      ROLFKT-FLAG-15      PIC X(01)   VALUE SPACE.
     05      ROLFKT-FLAG-16      PIC X(01)   VALUE SPACE.


**  ---> Aufbau / Schema des FKT-Flags
**       Eingabemöglichkeiten
**       1>      SRCSAFE                           => FKT-ABFRAGE
**       1.1     SRCSAFE >> CHECKIN                => FKT-EINGABE
**       1.1.1                      >> file        => FKT-FILE
**       1.1.2                      >> subvol.file => FKT-FILE
**       1.2     SRCSAFE >> CHECKIN file           => FKT-EINGABE-FILE
**       1.3     SRCSAFE >> CHECKIN subvol.file    => FKT-EINGABE-FILE
**
**       2>      SRCSAFE CHECKIN                   => FKT-STARTUP-ABFRAGE
**       3>      SRCSAFE CHECKIN file              => FKT-STARTUP-FILE
**       3>      SRCSAFE CHECKIN subvol.file       => FKT-STARTUP-FILE
 01          FUNKTIONEN.
     05      FKT-FLAG            PIC X       VALUE LOW-VALUE.
          88 FKT-ABFRAGE                     VALUE LOW-VALUE.
          88 FKT-EINGABE                     VALUE "a".
          88 FKT-FILE                        VALUE "#".
          88 FKT-EINGABE-FILE                VALUE "9".
          88 FKT-STARTUP-ABFRAGE             VALUE SPACE.
          88 FKT-STARTUP-FILE                VALUE "E".


*--------------------------------------------------------------------*
* weitere Arbeitsfelder
*--------------------------------------------------------------------*
 01          WORK-FELDER.
     05      W-DUMMY             PIC 9(02).
     05      W-DUMMY-1           PIC X(10).
     05      W-DUMMY-2           PIC X(10).
     05      W-DUMMY-3           PIC X(13).
     05      W-ZP                PIC X(22).
     05      W-LAST-MODIFY       PIC 9(18).
**          ---> hier soll Volume.Subvolume (Standort des Prg-Aufrufs) stehen
     05      W-VOLUME            PIC X(25).
     05      W-IN                PIC X(35).
**          ---> hier steht das default oder eingegebene OUT-File
     05      W-OUT               PIC X(35).
**          ---> hier steht ggf. der STARTUP-STRING
     05      W-STRING            PIC X(128).
     05      W-SOURCE-NAME       PIC X(28).
**          ---> hier steht Gruppe.Username
     05      W-USER-GRP-NAME     PIC X(32).
     05      W-USER-GRP-NAME-LEN PIC S9(04) COMP.
**          ---> hier steht Username
     05      W-USER-NAME         PIC X(08).
     05      W-VERW-USER         PIC X(08).
     05      W-SSUSER            PIC X(16).
**          ---> hier steht der Gruppenname (alpha)
     05      W-GRP-NAME          PIC X(08).
     05      W-GRP-NAME-LEN      PIC S9(04) COMP.
**          ---> hier steht der num. Gruppenwert des Users
     05      W-USER-GRP          PIC 9(03).
     05      W-SPER-GRP          PIC 9(03).
**          ---> hier steht der num. Wert des Users
     05      W-USER-NR           PIC 9(03).
**          ---> hier steht die Programmversionsbezeichnung
     05      W-PROG-VERSION-COMMENT.
      10                         PIC X(01) VALUE "*".
      10     W-PROG-VERSION      PIC X(08).
**          ---> hier steht das Programmobject
     05      W-PROG-OBJECT       PIC X(08).
**          ---> hier steht jetzt mein HomeTerminal
     05      W-MY-HOMETERM       PIC X(26).
**          ---> hier steht das ausgeführte Programmfile
     05      W-MY-PROG-FNAME     PIC X(47).

     05      W-SSROLLE           PIC X(16).
     05      W-SOURCE            PIC X(08).
     05      W-SOURCE-W          PIC X(08).
     05      W-SUBKOMMANDO       PIC X(10).

     05      W-TEXT              PIC X(70).
     05      W-FUP-OUT           PIC X(16).
     05      W-PROGRAM           PIC X(47).
     05      W-LOC               PIC X(16).
     05      W-LOC-LEN           PIC S9(04) COMP.

 01          W-HEUTE-TT          PIC 99.

 01          W-SOURCE-MODUL-ALT  PIC X(08).
 01          W-BEREICH           PIC X(08).
 01          W-RECORD            PIC X(128).

 01          W-TEILSTRING-TABELLE.
     05      W-TEILSTRING-TAB    occurs 10.
      10     W-TEILSTRING        PIC X(10).

 01          W-DELIM-TABELLE.
     05      W-DELIM-TAB         occurs 10.
      10     W-DELIM             PIC X(01).

 01          W-COUNT-TABELLE.
     05      W-COUNT-TAB         occurs 10.
      10     W-COUNT             PIC S9(04) comp.

 01          W-LIST-SUBS.
     05      W-LIST-SUBCMD       PIC X(10).
     05      W-LIST-SUBPRM1      PIC X(10).
     05      W-LIST-SUBPRM1-VAL  PIC X(20).
     05      W-LIST-SUBPRM2      PIC X(10).
     05      W-LIST-SUBPRM2-VAL.
      10     W-LIST-SUBPRM2-VALN PIC 9(10).

 01          W-VERSIONS-TABELLE.
     05      W-VERSIONS-TAB      OCCURS 5.
      10     W-VERSION           PIC X(01).
      10     W-VERSION-FILE      PIC X(36).

 01          W-UMSCHL.
     05      W-UMSCHL1           PIC X(08).
     05      W-UMSCHL2           PIC X(08).
     05      W-UMSCHL-IN         PIC X(08).
     05      W-UMSCHL-OUT        PIC X(08).

 01          AKT-ZEIT            PIC 9(08).
 01          EINGABE             PIC X(128).
 01          EINGABE-ALT         PIC X(128).
 01          ZEILE               PIC X(80).

 01          REC-LEN             PIC  9(04) COMP.

 01          FIND-BUFFER.
     05      FB-ERROR                PIC S9(04) COMP.
     05      FB-SEARCH-ID.
      10     FB-SEARCH-IDN           PIC S9(04) COMP.
     05      FB-SEARCH-PATTERN       PIC X(34).
     05      FB-SEARCH-PATTERNLEN    PIC S9(04) COMP.
     05      FB-RESOLVE-LEVEL        PIC S9(04) COMP VALUE  0.
     05      FB-DEVICE-TYPE          PIC S9(04) COMP VALUE  3.
     05      FB-NAME                 PIC X(128).
     05      FB-NAMEMAXLEN           PIC S9(04) COMP VALUE 128.
     05      FB-NAMELEN              PIC S9(04) COMP.

**          ---> Fuer Filehandling
 01          FILE-BUFFERS.
     05      SOURCE-FILE         PIC X(36).
     05      SOURCE-VOLS.
      10     SOURCE-FILE-VOL     PIC X(08).
      10     SOURCE-FILE-SUBVOL  PIC X(08).
     05      SOURCE-FILE-NAME    PIC X(08).

     05      DEST-FILE           PIC X(36).
     05      DEST-VOLS.
      10     DEST-FILE-VOL       PIC X(08).
      10     DEST-FILE-SUBVOL    PIC X(08).
     05      DEST-FILE-NAME      PIC X(08).

     05      DEST-FILE-ALT       PIC X(36).

     05      SEARCH-FILE         PIC X(36).
     05      SEARCH-VOLS.
      10     SEARCH-FILE-VOL     PIC X(08).
      10     SEARCH-FILE-SUBVOL  PIC X(08).
     05      SEARCH-FILE-NAME    PIC X(08).

**          ---> Parameter fuer TAL-Aufrufe
 01          T-ERROR             PIC S9(4) COMP.
 01          T-FNAME             PIC X(34) VALUE SPACES.
 01          T-FNAME-LEN         PIC S9(4) COMP.
 01          T-FNAME-LEN-MAX     PIC S9(4) COMP VALUE 34.
 01          T-ITEM-LIST.
     05      T-ITEM-LIST-062     PIC S9(4) COMP VALUE 062.
     05      T-ITEM-LIST-145     PIC S9(4) COMP VALUE 145.
     05      T-ITEM-LIST-058     PIC S9(4) COMP VALUE 058.
 01          T-NUM-OF-ITEMS      PIC S9(4) COMP VALUE 3.
 01          T-RESULT.
     05      T-RESULT-SECS       PIC X(04).
     05      T-RESULT-MODI       PIC X(08).
     05      T-RESULT-GROUP-USER PIC X(02).
 01          T-RESULT-MAX        PIC S9(4) COMP VALUE 14.
 01          T-RESULT-LEN        PIC S9(4) COMP.
 01          T-ERROR-ITEM        PIC S9(4) COMP.

 01          UA-TEXT             PIC X(128).
 01          UA-TEXTLEN          PIC S9(04) COMP.
 01          UA-ERROR            PIC S9(04) COMP.
 01          UA-OPTIONS          PIC S9(04) COMP.
 01          UA-STATUS.
     05      UA-STATUS-N         PIC S9(04) COMP.
 01          UA-DIALOG-ID.
     05      UA-DIALOG-IDN       PIC S9(18) COMP.

 01          CFI-ERROR           PIC S9(04) COMP.
 01          CFI-FNUM            PIC S9(02) COMP.

 01          SM-FKT              PIC S9(04) COMP.
 01          SM-PARM1            PIC S9(04) COMP.


**          ---> Datum-Uhrzeit Timestamp (TAL-Routine)
 01          TAL-TIME.
     05      TAL-JHJJMMTT.
      10     TAL-JHJJ            PIC S9(04) COMP.
      10     TAL-MM              PIC S9(04) COMP.
      10     TAL-TT              PIC S9(04) COMP.
     05      TAL-HHMI.
      10     TAL-HH              PIC S9(04) COMP.
      10     TAL-MI              PIC S9(04) COMP.
     05      TAL-SS              PIC S9(04) COMP.
     05      TAL-HS              PIC S9(04) COMP.
     05      TAL-MS              PIC S9(04) COMP.

 01          TAL-TIME-D.
     05      TAL-JHJJMMTT.
        10   TAL-JHJJ            PIC  9(04).
        10   TAL-MM              PIC  9(02).
        10   TAL-TT              PIC  9(02).
     05      TAL-HHMI.
        10   TAL-HH              PIC  9(02).
        10   TAL-MI              PIC  9(02).
     05      TAL-SS              PIC  9(02).
     05      TAL-HS              PIC  9(02).
     05      TAL-MS              PIC  9(02).
 01          TAL-TIME-N REDEFINES TAL-TIME-D.
     05      TAL-TIME-N16        PIC  9(16).
     05      TAL-TIME-REST       PIC  9(02).

 01          TAL-JUL-DAY         PIC S9(9) COMP.

**          ---> zum Zeitpunkt berechnen
 01          LAST-MODIFY-X       PIC X(8).
 01          LAST-MODIFY-N REDEFINES LAST-MODIFY-X
                                 PIC S9(18) COMP.

*--------------------------------------------------------------------*
* Parameter für Untermodulaufrufe - COPY-Module
*--------------------------------------------------------------------*
**          ---> Copystrecke fuer HCDAY
     COPY    HCDAYC OF "=COPYLIB".


******************************************************************
* Felder für die Routine V000-FC Section
******************************************************************
 01          FC-COMP-FELDER.
     05      FC-ANZ              PIC S9(04) COMP.
     05      FC-I1               PIC S9(04) COMP.

 01          FC-WEITERES.
     05      FC-TIME-OUT60       PIC S9(07)V99 COMP VALUE 60.
     05      FC-PROMPT-A         PIC X(10) VALUE "Eingabe > ".
     05      FC-PROMPT-M         PIC X(10) VALUE "       .. ".

**  ---> Parameter für FIXSTRING
 01          FC-TEMPLATE         PIC X(132).
 01          FC-TEMPLATE-LEN     PIC S9(04) COMP.
 01          FC-DATA             PIC X(132).
 01          FC-DATA-LEN         PIC S9(04) COMP.
 01          FC-MAX-DATA-LEN     PIC S9(04) COMP.
 01          FC-STATUS           PIC S9(04) COMP.



******************************************************************
******************************************************************
 EXTENDED-STORAGE SECTION.
**          ---> Zwischenspeicher
 01          W-BUFFER            PIC X(512).
 01          W-BUFFER-LEN        PIC S9(04) COMP.

**          ---> Teil-Strings
 01          EW-TEILSTRING-TABELLE.
     05      EW-TEILSTRING-TAB   occurs 10.
      10     EW-TEILSTRING       PIC X(100).

**          ---> Befehlstabelle für FUP
 01          FUP-COMMANDS.
     05      FUP-COMMANDS-TAB    OCCURS 50.
      10     FUP-COMMAND         PIC X(80).
 01          FUP-COMMANDS-ANZ    PIC S9(04) COMP.

**          ---> Zeilendefinitionen für Kommandos
 01          LIST-ZEILEN.
     05      LZ-TITEL.
      10                         PIC X(05) VALUE SPACES.
      10                         PIC X(10) VALUE "Source".
      10                         PIC X(11) VALUE "SRC-Typ".
      10                         PIC X(12) VALUE "Status".
      10                         PIC X(21) VALUE "Zeitpunkt".
      10                         PIC X(20) VALUE "Last User".
     05      SZ-TITEL REDEFINES LZ-TITEL   PIC X(79).

     05      LZ-UNTERSTRICHE.
      10                         PIC X(05) VALUE SPACES.
      10                         PIC X(08) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(09) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(10) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(19) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(14) VALUE ALL "-".
     05      SZ-UNTERSTRICHE REDEFINES LZ-UNTERSTRICHE PIC X(73).

     05      LZ-DATEN.
      10                         PIC X(05) VALUE SPACES.
      10     LZD-SOURCE-MODUL    PIC X(08).
      10                         PIC X(02) VALUE SPACES.
      10     LZD-SOURCE-TYP      PIC X(09).
      10                         PIC X(02) VALUE SPACES.
      10     LZD-SOURCE-STATUS   PIC X(10).
      10                         PIC X(02) VALUE SPACES.
      10     LZD-ZEITPUNKT       PIC X(19).
      10                         PIC X(02) VALUE SPACES.
      10     LZD-USER            PIC X(14).
      10                         PIC X(02) VALUE SPACES.
      10     LZD-LST             PIC X(02) VALUE SPACES.
     05      SZ-DATEN1 REDEFINES LZ-DATEN  PIC X(75).

 01          LIST-FREIGABE-ZEILEN.
     05      LF-HINWEIS.
      10                         PIC X(05) VALUE SPACES.
      10                         PIC X(74) VALUE
         "Aktuell steht die Freigabe der folgenden Programme aus:".
     05      LF-TITEL.
      10                         PIC X(05) VALUE SPACES.
      10                         PIC X(10) VALUE "Programm".
      10                         PIC X(10) VALUE "Version".
      10                         PIC X(12) VALUE "vom".
      10                         PIC X(18) VALUE "angefordert von".
      10                         PIC X(16) VALUE "am".
     05      LF-UNTERSTRICHE.
      10                         PIC X(05) VALUE SPACES.
      10                         PIC X(08) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(08) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(10) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(16) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(16) VALUE ALL "-".
     05      LF-DATEN.
      10                         PIC X(05) VALUE SPACES.
      10     LFD-PRG-NAME        PIC X(08).
      10                         PIC X(02) VALUE SPACES.
      10     LFD-VERSION         PIC X(08).
      10                         PIC X(02) VALUE SPACES.
      10     LFD-DATUM           PIC X(10).
      10                         PIC X(02) VALUE SPACES.
      10     LFD-FREIGABE-ANTRAG-VON  PIC X(16).
      10                         PIC X(02) VALUE SPACES.
      10     LFD-FREIGABE-ANTRAG-AM   PIC X(16).
      10                         PIC X(02) VALUE SPACES.


 01          SHOW-ZEILEN.
     05      SZ-DATEN2.
      10                         PIC X(05) VALUE SPACES.
      10                         PIC X(13) VALUE SPACES.
      10     SZD2-TEXT           PIC X(17).
      10                         PIC X(03) VALUE ":".
      10     SZD2-ZEITPUNKT      PIC X(19).

     05      SZ-DATEN3.
      10                         PIC X(05) VALUE SPACES.
      10                         PIC X(09) VALUE "Freigabe".
      10     SZD3-FREIGABE-TEXT  PIC X(06).
      10     SZD3-FREIGABE-STAT  PIC X(17).
      10                         PIC X(01) VALUE SPACES.
      10     SZD3-ZEITPUNKT      PIC X(19).

 01          PROT-ZEILEN.
     05      PZ-TITEL.
      10                         PIC X(05) VALUE SPACES.
      10                         PIC X(10) VALUE "Source".
      10                         PIC X(12) VALUE "Aktion".
      10                         PIC X(21) VALUE "Zeitpunkt".
      10                         PIC X(16) VALUE "User".
      10                         PIC X(11) VALUE "Freigabe".

     05      PZ-UNTERSTRICHE.
      10                         PIC X(05) VALUE SPACES.
      10                         PIC X(08) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(10) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(19) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(14) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(11) VALUE ALL "-".

     05      PZ-DATEN.
      10                         PIC X(05) VALUE SPACES.
      10     PZD-SOURCE-MODUL    PIC X(08).
      10                         PIC X(02) VALUE SPACES.
      10     PZD-AKTION          PIC X(10).
      10                         PIC X(02) VALUE SPACES.
      10     PZD-ZEITPUNKT       PIC X(19).
      10                         PIC X(02) VALUE SPACES.
      10     PZD-USER            PIC X(14).
      10                         PIC X(02) VALUE SPACES.
      10     PZD-KZ-FREIGABE     PIC X(11).
      10                         PIC X(02) VALUE SPACES.

**  ---> Ausgabezeilen für die Verwaltungsfunktion
 01          VERW-ZEILEN.
     05      VZ-TITEL.
      10                         PIC X(05) VALUE SPACES.
      10                         PIC X(18) VALUE "User".
      10                         PIC X(24) VALUE "Berechtigung seit".
      10                         PIC X(16) VALUE "Rolle".
     05      VZ-UNTERSTRICHE.
      10                         PIC X(05) VALUE SPACES.
      10                         PIC X(16) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(22) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(16) VALUE ALL "-".
     05      VZ-DATEN.
      10     VZ-HEADER.
       15                        PIC X(05) VALUE SPACES.
       15    VZD-USER            PIC X(16).
       15                        PIC X(02) VALUE SPACES.
      10     VZD-ZEITPUNKT       PIC X(22).
      10                         PIC X(02) VALUE SPACES.
      10     VZD-ROLLE           PIC X(16).
**  ---> Hilfs-Anzeige der definierten Rollen
     05      VZ-TITEL-R.
      10                         PIC X(22) VALUE SPACES.
      10                         PIC X(18) VALUE "Definierte Rollen".
     05      VZ-UNTERSTRICHE-R.
      10                         PIC X(22) VALUE SPACES.
      10                         PIC X(18) VALUE ALL "-".
     05      VZ-DATEN-R.
      10                         PIC X(22) VALUE SPACES.
      10     VZR-ROLLE           PIC X(16).
**  ---> Anzeige der definierten Rollen und zugehörige Funktionen
     05      VZ-TITEL-F.
      10                         PIC X(22) VALUE SPACES.
      10                         PIC X(18) VALUE "Rolle".
      10                         PIC X(18) VALUE "Funktion".
     05      VZ-UNTERSTRICHE-F.
      10                         PIC X(22) VALUE SPACES.
      10                         PIC X(16) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(16) VALUE ALL "-".
     05      VZ-DATEN-F.
      10     VZ-HEADER-F.
       15                        PIC X(22) VALUE SPACES.
       15    VZF-ROLLE           PIC X(16).
      10                         PIC X(02) VALUE SPACES.
      10     VZF-FUNKTION        PIC X(16).

**  ---> Zeilendefinitionen für Bearbeitung von Sicherheitswarnungen
 01          NK-ZEILEN.
     05      NK-UEBERSCHRIFT.
      10                         PIC X(05) VALUE SPACE.
      10                         PIC X(10) VALUE "Object".
      10                         PIC X(10) VALUE "Version".
      10                         PIC X(12) VALUE "vom".
      10                         PIC X(18) VALUE "Entwickler".
      10                         PIC X(16) VALUE "Übergabe am".
     05      NK-STRICHE.
      10                         PIC X(05) VALUE SPACE.
      10                         PIC X(08) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACE.
      10                         PIC X(08) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACE.
      10                         PIC X(10) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACE.
      10                         PIC X(16) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACE.
      10                         PIC X(16) VALUE ALL "-".
     05      nk-daten.
      10                         PIC X(05) VALUE SPACE.
      10     NKD-PRG-NAME        PIC X(08).
      10                         PIC X(02) VALUE SPACE.
      10     NKD-VERSION         PIC X(08).
      10                         PIC X(02) VALUE SPACE.
      10     NKD-DATUM           PIC X(10).
      10                         PIC X(02) VALUE SPACE.
      10     NKD-REL2TEST-VON    PIC X(16).
      10                         PIC X(02) VALUE SPACE.
      10     NKD-REL2PROD-AM     PIC X(16).

**  ---> Zeilendefinitionen für Funktion MODIS
 01          MI-ZEILEN.
     05      MI-TITEL.
      10                         PIC X(10) VALUE "Das Modul ".
      10     MIT-MODUL           PIC X(08).
      10                         PIC X(33) VALUE
             " ist enthalten in den Programmen:".

     05      MI-TITEL1.
      10                         PIC X(13) VALUE "Das Programm ".
      10     MIT-MODUL1          PIC X(08).
      10                         PIC X(33) VALUE
             " enthält die Module:".

     05      MI-UEBERSCHRIFT.
      10                         PIC X(08) VALUE "Programm".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(08) VALUE "Version".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(10) VALUE "vom".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(08) VALUE "Sprache".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(35) VALUE "Beschreibung".

     05      MI-UNTERSTRICHE.
      10                         PIC X(08) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(08) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(10) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(08) VALUE ALL "-".
      10                         PIC X(02) VALUE SPACES.
      10                         PIC X(35) VALUE ALL "-".

     05      MI-DATEN.
      10     MID-HEADER.
       15     MID-PROGRAMM       PIC X(08).
       15                        PIC X(02) VALUE SPACES.
       15     MID-VERSION        PIC X(08).
       15                        PIC X(02) VALUE SPACES.
       15     MID-VERS-DAT       PIC X(10).
       15                        PIC X(02) VALUE SPACES.
       15     MID-SPRACHE        PIC X(08).
       15                        PIC X(02) VALUE SPACES.
      10     MID-BESCHREIBUNG    PIC X(35).

     05      MI-ERGEBNIS.
      10                         PIC X(05) VALUE " --- ".
      10     MIE-COUNT           PIC Z.ZZ9.
      10                         PIC X(12) VALUE " Fundstellen".

**          ---> Zeilenaufbau für Freigabe-Antrags EMAIL
 01          EMAIL-SATZ.
     05      EM-K1.
      10                         PIC X(16) VALUE "SMTP>> From:".
      10     EM-K1-FROM          PIC X(64).
**  --->
     05      EM-K2.
      10                         PIC X(16) VALUE "SMTP>> To:".
      10     EM-K2-TO            PIC X(64).
**  --->
     05      EM-K3.
      10                         PIC X(16) VALUE "SMTP>> CC:".
      10     EM-K3-CC            PIC X(64).
**  --->
     05      EM-K4.
      10                         PIC X(16) VALUE "SMTP>> Subject:".
      10                         PIC X(31) VALUE
                 """Übernahmeantrag für Programm: ".
      10     EM-K4-PRG-NAME      PIC X(16).
      10                         PIC X(04) VALUE """".
      10                         PIC X(13) VALUE SPACES.
**  --->
     05      EM-K5.
      10                         PIC X(16) VALUE "SMTP>> Subject:".
*      10                         PIC X(04) VALUE """".
      10     EM-K5-VALUE         PIC X(58).
      10                         PIC X(04) VALUE """".
      10                         PIC X(02) VALUE SPACES.
**  --->
     05      EM-LZ.
      10                         PIC X(80) VALUE SPACES.
**  --->
     05      EM-STRICH.
      10                         PIC X(64) VALUE ALL "-".
      10                         PIC X(16) VALUE SPACES.
**  --->
     05      EM-PZ.
      10     EM-PZ-GRUPPE.
       15                        PIC X(04).
       15    EM-PZ-HEADER        PIC X(20).
      10     EM-PZ-VALUE         PIC X(40).
     05      EM-PZ-R REDEFINES EM-PZ.
      10                         PIC X(04).
      10     EM-PZ-REST          PIC X(60).

**  ---> Texte für EMAIL
 01          TEM-TEXTE.
     05      TEM-BETREFF1        PIC X(48) VALUE
         """Aufhebung der Sicherheitswarnung für Programm:".
     05      TEM-BETREFF2        PIC X(34) VALUE
         """Sicherheitswarnung für Programm:".
     05      TEM-ALLG-INFO1.
      10                         PIC X(37)
                 VALUE "Für das folgende,geänderte Programm ".
      10     TEM-ALLG-PRG-NAME   PIC X(08).
      10                         PIC X(08) VALUE " wird um".
     05      TEM-ALLG-INFO2      PIC X(50)
                 VALUE "Freigabe gebeten (Funktion im WEAT-Menue)".
     05      TEM-PRG-INFO        PIC X(24)
                 VALUE "Programminformationen".
     05      TEM-PRG             PIC X(10) VALUE "Programm:".
     05      TEM-PRG-VERS        PIC X(10) VALUE "Version:".
     05      TEM-PRG-DATUM       PIC X(10) VALUE "Datum:".
     05      TEM-PRG-FKT         PIC X(20) VALUE "Progr. Funktion:".
     05      TEM-UPD-BESCHR      PIC X(20) VALUE "Upd.Beschreibung:".
     05      TEM-AUFTR-INFO      PIC X(34)
                 VALUE "Auftragsinformationen (ggf. leer)".
     05      TEM-AUFTR           PIC X(10) VALUE "Auftrag:".
     05      TEM-AUFTR-VON       PIC X(10) VALUE "von:".
     05      TEM-AUFTR-DATUM     PIC X(10) VALUE "Datum:".
     05      TEM-REL-INFO        PIC X(24)
                 VALUE "Übernahmeinformationen".
     05      TEM-ENTWICKLER      PIC X(16) VALUE "Entwickler:".
     05      TEM-CONTROLLER-TEST PIC X(16) VALUE "Controller-Test:".
     05      TEM-CONTROLLER-PROD PIC X(18) VALUE "Controller-Prod.:".
     05      TEM-BEGRUENDUNG     PIC X(16) VALUE "Begründung:".
     05      TEM-VERLETZUNG      PIC X(16) VALUE "Verletzung am:".
     05      TEM-MAIL-DATUM      PIC X(07) VALUE "Datum: ".
     05      TEM-BEARBEITER      PIC X(28)
                 VALUE "gleiche Namen der Bearbeiter".
     05      TEM-AUFHEBUNG       PIC X(46)
                 VALUE "Aufhebung der Sicherheitswarnung durch:".

     05      TEM-TEXT01          PIC X(30) VALUE
         "Bei der Übergabe des Programms".
     05      TEM-TEXT02          PIC X(08) VALUE
         "in eine ".
     05      TEM-TEXT03          PIC X(50) VALUE
         "nächste Bearbeitungsstufe ist eine Verletzung des ".
     05      TEM-TEXT04          PIC X(32) VALUE
         "Vier-Augen-Prinzips aufgetreten".

     05      TEM-TEXT11          PIC X(34) VALUE
         "Die bei der Übergabe des Programms".
     05      TEM-TEXT12          PIC X(08) VALUE
         "in eine ".
     05      TEM-TEXT13          PIC X(64) VALUE
         "nächste Bearbeitungsstufe aufgetretene Verletzung ist ".
     05      TEM-TEXT14          PIC X(56) VALUE
         "zur Gewährleistung des Vier-Augen-Prinzips nachträglich".
     05      TEM-TEXT15          PIC X(44) VALUE
         "durch eine zweite Person kontrolliert worden".

*        "1234567890123456789012345678901234567890123456789012345678901234"
     05      TEM-EVV-1           PIC X(64) VALUE
         "Einhaltung von Vorschriften".
     05      TEM-EVV-2           PIC X(64) VALUE
         "Der Ersteller bestätigt, dass für jede geprüfte Änderung".
     05      TEM-EVV-3           PIC X(64) VALUE
         "Funktionalitätstests durchgeführt werden, um sicherzustellen,".
     05      TEM-EVV-4           PIC X(64) VALUE
         "dass die Änderung nicht die Sicherheit des Systems".
     05      TEM-EVV-5           PIC X(64) VALUE
         "beeinträchtigt, sowie, dass für die geprüfte Änderung ein ".
     05      TEM-EVV-6           PIC X(64) VALUE
         "Back-Out-Verfahren existiert.".

     05      TEM-EVV-7           PIC X(64) VALUE
         "Des Weiteren bestätigt der Controller-Test die Überprüfung bei".
     05      TEM-EVV-8           PIC X(64) VALUE
         "benutzerspezifischen Codeänderungen, dass alle Updates auf ihre".
     05      TEM-EVV-9           PIC X(64) VALUE
         "Konformität mit der PCI-DSS-Anforderung 6.5 getestet wurden,".
     05      TEM-EVV-10          PIC X(64) VALUE
         "bevor sie implementiert werden.".

 01          ADRESSEN.
     05      ADR-1               PIC X(60).
     05      ADR-2               PIC X(60).
     05      ADR-3               PIC X(60).
 01          ADR-WORK            PIC X(60).


******************************************************************
* Im folgenden zunaechst Anforderungen vom Embedded SQL erfüllen
******************************************************************

 EXEC SQL
     INCLUDE STRUCTURES ALL VERSION 315
 END-EXEC

 EXEC SQL
     INCLUDE SQLCA
 END-EXEC

* Fuer dynamisches SQL
 EXEC SQL
     INCLUDE SQLSA
 END-EXEC.

 EXEC SQL
     INCLUDE SQLDA (IN-SQLDA,1,INPARAM-NAMESBUFF,30)
 END-EXEC

 EXEC SQL
     BEGIN DECLARE SECTION
 END-EXEC

******************************************************************
* Im folgenden zunaechst Host-Variable, die nicht Bestandteil von
* SQL - Tabellen sind
******************************************************************
 01          HOST-VARIABLE.
     05      H-DUMMY             PIC X(02).
     05      H-MONATE            PIC X(02).
     05      H-HEUTE-TT          PIC X(02).
     05      H-DEFAULT-DATUM     PIC X(16).

 01  DYN-STATEMENT-BUFFER        PIC X(1024).

**  ---> Source Safe - Programm-Verzeichnis
 EXEC SQL
     INVOKE =SSAFE       AS  SSAFE
 END-EXEC

**  ---> Source Safe - Parameter
 EXEC SQL
     INVOKE =SSPARM      AS  SSPARM
 END-EXEC

**  ---> Source Safe - Aktions-Protokoll
 EXEC SQL
     INVOKE =SSPROT      AS  SSPROT
 END-EXEC

**  ---> Source Safe - Texte
 EXEC SQL
     INVOKE =SSTEXT      AS  SSTEXT
 END-EXEC

**  ---> Source Safe - Rollendefinitionen
 EXEC SQL
     INVOKE =SSROLES     AS  SSROLES
 END-EXEC

**  ---> Source Safe - zugelassene User
 EXEC SQL
     INVOKE =SSUSER      AS  SSUSER
 END-EXEC

** =========================================

**  ---> Versionsmeldungen von Programmen
 EXEC SQL
     INVOKE =ABNAHME     AS ABNAHME
 END-EXEC

**  ---> Define-Tabelle
 EXEC SQL
     INVOKE =DEFCAT      AS DEFCAT
 END-EXEC

**  ---> Kontaktadressen für eMail-Versendung
 EXEC SQL
    INVOKE =EKONTAKT     AS  EKONTAKT
 END-EXEC

**  ---> Programmreferenztabelle
 EXEC SQL
    INVOKE =PROGRAMS     AS PROGRAMS
 END-EXEC

**  ---> Modul-Referenztabelle
 EXEC SQL
    INVOKE =PROGRAMX     AS PROGRAMX
 END-EXEC

**  ---> Tabs-Referenztabelle
 EXEC SQL
    INVOKE =TABS         AS TABS
 END-EXEC

**  ---> Tabs-Referenztabelle
 EXEC SQL
    INVOKE =LIBS         AS LIBS
 END-EXEC

 EXEC SQL
     END DECLARE SECTION
 END-EXEC

******************************************************************
* Im folgenden werden die benoetigten CURSOR auf die             *
* verschiedenen SQL - Tabellen definiert                         *
******************************************************************
**  ---> Anzeige Cursor auf Tabelle =SSTEXT
 EXEC SQL
     DECLARE SSTEXT_CURS CURSOR FOR
         SELECT  TEXTE
           FROM  =SSTEXT
          WHERE  BEREICH, KATEGORIE
                 =    :BEREICH   OF SSTEXT
                     ,:KATEGORIE OF SSTEXT
           ORDER BY BEREICH, KATEGORIE, LFD_NR
         BROWSE  ACCESS
 END-EXEC

**  ---> Anzeige Cursor auf Tabelle =SSPROT
 EXEC SQL
     DECLARE SSPROT_CURS CURSOR FOR
         SELECT  SOURCE_MODUL, ZPINS, AKTION, GROUP_USER, KZ_FREIGABE
           FROM  =SSPROT
          WHERE  SOURCE_MODUL like :SOURCE-MODUL of SSPROT
           ORDER BY ZPINS desc
         BROWSE  ACCESS
 END-EXEC

**  ---> Anzeige Cursor auf Tabelle =SSPARM
 EXEC SQL
     DECLARE SSPARM_CURS CURSOR FOR
         SELECT  AKTION, SVOL_SOURCE, SVOL_DEST, ZPINS
           FROM  =SSPARM
          WHERE  AKTION = :AKTION of SSPARM
           ORDER BY SVOL_SOURCE
         BROWSE  ACCESS
 END-EXEC

**  ---> Anzeige Cursor auf Tabelle =SSAFE
 EXEC SQL
     DECLARE SSAFE_CURS CURSOR FOR
         SELECT   SOURCE_MODUL, SOURCE_STATUS, GROUP_USER, SOURCE_TYP
                 ,FREIGABE_TEST, FREIGABE_PROD, ZP_CHECKIN, ZP_CHECKOUT
                 ,ZP_FREIGABE_TEST, ZP_FREIGABE_PROD
           FROM  =SSAFE
          WHERE  SOURCE_MODUL    LIKE :SOURCE-MODUL  of SSAFE
            AND  SOURCE_STATUS   LIKE :SOURCE-STATUS of SSAFE
            AND  GROUP_USER      LIKE :GROUP-USER    of SSAFE
            AND  FREIGABE_PROD   LIKE :FREIGABE-PROD of SSAFE
            and  ZP_CHECKOUT      year to second
                 < CURRENT        year to second
                 - :H-HEUTE-TT TYPE AS INTERVAL DAY
                 - :H-MONATE   TYPE AS INTERVAL MONTH
           ORDER BY SOURCE_MODUL
         BROWSE  ACCESS
 END-EXEC

**  ---> Anzeige Cursor-2 auf Tabelle =SSAFE
 EXEC SQL
     DECLARE SSAFE_CURS2 CURSOR FOR
         SELECT   SOURCE_MODUL, SOURCE_STATUS, GROUP_USER, SOURCE_TYP
                 ,FREIGABE_TEST, FREIGABE_PROD, ZP_CHECKIN, ZP_CHECKOUT
                 ,ZP_FREIGABE_TEST, ZP_FREIGABE_PROD
           FROM  =SSAFE
          WHERE FREIGABE_TEST="TA"
            AND (FREIGABE_PROD<>"PA" OR ZP_FREIGABE_TEST > ZP_FREIGABE_PROD)
            AND  GROUP_USER      LIKE :GROUP-USER    of SSAFE
          ORDER  BY SOURCE_MODUL
         BROWSE  ACCESS
 END-EXEC

**  ---> Cursor ueber alle Defines KATALOG/DEFINE
 EXEC SQL
     DECLARE DEFCAT_CURS CURSOR FOR
         SELECT   DEF_NAME, DEF_FILE, DEF_KATALOG, DEF_TYP
           FROM  =DEFCAT
          WHERE  DEF_KATALOG = "$WSOFT.TWCA"
            AND  DEF_TYP IN ("TA", "CA")
         BROWSE ACCESS
 END-EXEC

**  ---> Cursor zum Anzeigen der Programme in denen Sourcename enthalten ist
**  ---> Funktion MODIS
 EXEC SQL
     DECLARE MODIS_CURS CURSOR FOR
         SELECT   S.PROGRAMM, S.VERSION, S.VERS_DAT, S.SPRACHE
                 ,S.BESCHREIBUNG, X.PMODUL
           FROM  =PROGRAMS S  LEFT JOIN =PROGRAMX X
                                     ON (S.PROGRAMM) = (X.PROGRAMM)
          WHERE  X.PMODUL LIKE UPSHIFT(:PMODUL of PROGRAMX)
         BROWSE ACCESS
 END-EXEC

**  ---> Cursor zum Anzeigen der Module die in Sourcename enthalten sind
**  ---> Funktion MODIN
 EXEC SQL
     DECLARE MODIN_CURS CURSOR FOR
         SELECT   S.PROGRAMM, S.VERSION, S.VERS_DAT, S.SPRACHE
                 ,S.BESCHREIBUNG, X.PMODUL
           FROM  =PROGRAMS S  LEFT JOIN =PROGRAMX X
                                     ON (S.PROGRAMM) = (X.PROGRAMM)
          WHERE  X.PROGRAMM LIKE UPSHIFT(:PROGRAMM OF PROGRAMX)
         BROWSE ACCESS
 END-EXEC

**  ---> Cursor zur Suche der Rechte eines Users
 EXEC SQL
     DECLARE RECHTE_CURS CURSOR FOR
         SELECT  U.USER, U.ROLLE, U.FLAG, U.ZPINS, R.FUNKTION
           FROM  =SSUSER U, =SSROLES R
          WHERE  U.USER  = :USER OF SSUSER
            AND  U.ROLLE = R.ROLLE
         BROWSE ACCESS
 END-EXEC

**  ---> Cursor zur Anzeige der User
 EXEC SQL
     DECLARE USER_CURS CURSOR FOR
         SELECT  USER, ROLLE, FLAG, ZPINS
           FROM  =SSUSER
          WHERE  USER LIKE :USER OF SSUSER
          ORDER BY USER
         BROWSE ACCESS
 END-EXEC

**  ---> Cursor zur Anzeige der Rollen/Funktionen
 EXEC SQL
     DECLARE ROLLEN_CURS CURSOR FOR
         SELECT  ROLLE, FUNKTION
           FROM  =SSROLES
          ORDER BY ROLLE
         BROWSE ACCESS
 END-EXEC

******************************************************************
* Ende der SQL - Definitionen                                    *
******************************************************************

 PROCEDURE DIVISION.
 declaratives.
 terminal-eingabe-use section.
     use after standard exception procedure on hterminal.

 terminal-eingabe-error.
     display " "
     evaluate true
         when file-time-out
                 if  K-TIME-OUT600 = C9-TIME-OUT
                     enter "FILE_PURGE_" using  ap-dname (1:ap-dname-len)
                                         giving p-result
                     display " Programm wird wegen timeout beendet "
                     STOP RUN
                 end-if
     end-evaluate.

 end declaratives.


******************************************************************
* Steuerungs-Section
******************************************************************
 A000-STEUERUNG SECTION.
 A000-00.
**  ---> Eröffnungen, holen Umfeld, interpretieren STARTUPTEXT
     PERFORM B000-VORLAUF
     IF  PRG-ABBRUCH
         STOP RUN
     END-IF

**  ---> Verarbeitung je nach Eingabeform
     EVALUATE TRUE
         WHEN FKT-ABFRAGE            PERFORM B100-USER-ABFRAGEN
                                       UNTIL PRG-ABBRUCH or PRG-ENDE
         WHEN FKT-STARTUP-ABFRAGE    PERFORM B200-BEARB-STARTUP
         WHEN FKT-STARTUP-FILE       PERFORM B200-BEARB-STARTUP

     END-EVALUATE

**  ---> Ende-Routine
     PERFORM B090-ENDE

     STOP RUN.

******************************************************************
* Vorlauf
******************************************************************
 B000-VORLAUF SECTION.
 B000-00.
**  ---> Oeffnen Terminal
     OPEN INPUT HTERMINAL
          WITH TIME LIMITS
          SHARED

**  ---> Ausgabe zunaechst mal auf Display legen
     SET AUSGABE-DISPLAY TO TRUE

**  ---> Initialisierungen
     PERFORM C000-INIT
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> oeffnen $RECEIVE
     OPEN INPUT MSG-DATEI

**  ---> holen User und Prozess-Info
     PERFORM M040-USER-PROCINFO
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> Ummeldung und Autentikation
     PERFORM C020-GET-AUTENT
     PERFORM C010-UMMELDEN
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> zugelassene Funktionen des Users holen
     IF  ROLFKT-FLAG = SPACE
         PERFORM C050-GET-USER-INFO
         IF  PRG-ABBRUCH
             EXIT SECTION
         END-IF
     END-IF

**  ---> holen Environment - VOLUME
     PERFORM M000-STARTUP-VOLUME
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> setzen Name inkl. Pfad für Obeydatei und Länge bestimmen
     MOVE 1 TO AP-DNAME-LEN
     MOVE W-USER-NR TO K-OBEYDATEI-USER
     STRING  SOURCE-FILE-VOL
             "."
             SOURCE-FILE-SUBVOL
             "."
             K-OBEYDATEI
                 DELIMITED BY SPACE
       INTO  AP-DNAME  with pointer AP-DNAME-LEN
     END-STRING
     SUBTRACT 1 FROM AP-DNAME-LEN

**  ---> holen Environment - OUT
     PERFORM M020-STARTUP-OUT
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> holen Environment - STRING
**  ---> ggf. werden Kommando und Source-file Info's bereitgestellt
     PERFORM M030-STARTUP-STRING
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> ggf. holen Parameter für OUT für FUP
     PERFORM M050-PARAM-FUP-OUT

**  ---> erstellen Obey-Datei
     PERFORM U200-ERSTELLEN-OBEYDATEI
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> nun erstmal die Defines-Tabelle (=DEFCAT) für WE-User zuordnen
     PERFORM D070-SET-DEFAULT
**  ---> nur wenn SWITCH-1 gesetzt ist
     IF  TRACE-ON
         PERFORM W430-DEFINEINFO
     END-IF

**  ---> setzen Tabellendefines der WE-Gruppe
     PERFORM C040-WE-DEFINES
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> ggf. Startmeldung anzeigen
     IF  not (FKT-STARTUP-ABFRAGE or FKT-STARTUP-FILE)
**      ---> Programminfo
         MOVE K-PROG-START TO ZEILE
         PERFORM U010-AUSGABE
         PERFORM U011-AUSGABE-SPACELINE
     END-IF
     .
 B000-99.
     EXIT.

******************************************************************
* Ende
******************************************************************
 B090-ENDE SECTION.
 B090-00.
     PERFORM U011-AUSGABE-SPACELINE

**  ---> Obey Datei löschen
     PERFORM V200-PURGE-OBEYDATEI

     IF  FKT-ABFRAGE
         CLOSE HTERMINAL
     END-IF

**  ---> und Message-Datei schliessen
     CLOSE MSG-DATEI
     .
 B090-99.
     EXIT.

******************************************************************
* User Abfragen - Aufruf nur durch SRCSAFE
******************************************************************
 B100-USER-ABFRAGEN SECTION.
 B100-00.
     INITIALIZE SCHALTER
     PERFORM U011-AUSGABE-SPACELINE
     MOVE SPACE TO W-SOURCE
     SET FKT-EINGABE TO TRUE
     SET EIN-ASCII
         PROMPT-CMD TO TRUE
     PERFORM U020-ZEIT
     PERFORM U000-EINGABE

**  ---> Eingabe-String vereinzeln
     MOVE ZERO TO C4-ANZ
     MOVE 1    TO C4-PTR
     PERFORM N030-CHECK-STARTUP
     IF  CHECK-NOK
         GO TO B100-00
     END-IF

**  ---> Verzweigung je nach Eingabe
     EVALUATE TRUE
         WHEN CMD-CHECKIN    PERFORM C100-CHECKIN
         WHEN CMD-CHECKOUT   PERFORM C110-CHECKOUT
         WHEN CMD-EXIT       SET PRG-ENDE TO TRUE
         WHEN CMD-HELP       PERFORM H100-HELP
         WHEN CMD-LIST       PERFORM C200-LIST
         WHEN CMD-SHOW       PERFORM C210-SHOW
         WHEN CMD-PROT       PERFORM C220-PROT
         WHEN CMD-DOKUMENT   PERFORM C250-DOKUMENT
         WHEN CMD-MODIS      PERFORM C260-MODIS
         WHEN CMD-MODIN      PERFORM C270-MODIN
         WHEN CMD-REL2PROD   PERFORM C300-REL2PROD
         WHEN CMD-REL2TEST   PERFORM C310-REL2TEST
         WHEN CMD-SAVE       PERFORM C320-SAVE
         WHEN CMD-REL4WEAT   SET REL4WEAT-FIRST TO TRUE
                             PERFORM C340-REL4WEAT
         WHEN CMD-ACTIVTEST  PERFORM C360-ACTIVTEST
         WHEN CMD-STOP       PERFORM C400-STOP
         WHEN CMD-PRGNEU     PERFORM C410-PRGNEU
         WHEN CMD-VERW       PERFORM C420-VERWALTUNG
         WHEN CMD-EMERGENCY-CONTROL
                             PERFORM C500-EMERGENCY-CONTROL
         WHEN OTHER          GO TO B100-00
     END-EVALUATE
     .
 B100-99.
     EXIT.

******************************************************************
* Bearbeitung der Funktionen - Aufruf mit Startup-String
******************************************************************
 B200-BEARB-STARTUP SECTION.
 B200-00.
**  ---> Bearbeitung des Kommandos
     EVALUATE TRUE
         WHEN CMD-CHECKIN    PERFORM C100-CHECKIN
         WHEN CMD-HELP       PERFORM H100-HELP
         WHEN CMD-CHECKOUT   PERFORM C110-CHECKOUT
         WHEN CMD-LIST       PERFORM C200-LIST
         WHEN CMD-SHOW       PERFORM C210-SHOW
         WHEN CMD-PROT       PERFORM C220-PROT
         WHEN CMD-DOKUMENT   PERFORM C250-DOKUMENT
         WHEN CMD-MODIS      PERFORM C260-MODIS
         WHEN CMD-MODIN      PERFORM C270-MODIN
         WHEN CMD-REL2PROD   PERFORM C300-REL2PROD
         WHEN CMD-REL2TEST   PERFORM C310-REL2TEST
         WHEN CMD-SAVE       PERFORM C320-SAVE
         WHEN CMD-REL4WEAT   SET REL4WEAT-FIRST TO TRUE
                             PERFORM C340-REL4WEAT
         WHEN CMD-ACTIVTEST  PERFORM C360-ACTIVTEST
         WHEN CMD-STOP       PERFORM C400-STOP
         WHEN CMD-PRGNEU     PERFORM C410-PRGNEU
         WHEN CMD-VERW       PERFORM C420-VERWALTUNG
         WHEN CMD-EMERGENCY-CONTROL
                             PERFORM C500-EMERGENCY-CONTROL
         WHEN OTHER          CONTINUE

     END-EVALUATE
     .
 B200-99.
     EXIT.

******************************************************************
* Initialisierungen
******************************************************************
 C000-INIT SECTION.
 C000-00.
     INITIALIZE
                 SCHALTER
     SET AP-DELAY-ON TO TRUE
     MOVE SPACES TO ACCESS-FLAG
     MOVE "0001-01-01:00:00" TO H-DEFAULT-DATUM

     MOVE K-TIME-OUT600 TO C9-TIME-OUT
     MOVE K-DELAY-TIME  TO C9-DELAY-TIME
     PERFORM U030-TIMESTAMP
     .
 C000-99.
     EXIT.

******************************************************************
* ummelden als Grp-Mgr
******************************************************************
 C010-UMMELDEN SECTION.
 C010-00.
**  ---> filenummer von Terminal holen
     PERFORM W020-COBOLFILEINFO
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     IF  SSPRM-EOD OR C4-I1 = ZERO
**      ---> Echo für PW-Eingabe ausschalten
         MOVE ZERO TO SM-PARM1
         PERFORM D020-SETMODE
         IF  PRG-ABBRUCH
             EXIT SECTION
         END-IF

**      ---> Passwort abfragen
         PERFORM U011-AUSGABE-SPACELINE
         SET EIN-ASCII
             PROMPT-PASSWORT TO TRUE
         PERFORM U000-EINGABE

**      ---> Echo erstmal wieder einschalten
         MOVE 1 TO SM-PARM1
         PERFORM D020-SETMODE
         PERFORM U011-AUSGABE-SPACELINE
         IF  PRG-ABBRUCH
             EXIT SECTION
         END-IF

**      ---> Programm beenden
         IF  EINGABE = "E" OR = "e" OR = SPACE
             SET PRG-ABBRUCH TO TRUE
             EXIT SECTION
         END-IF
     ELSE
         MOVE W-UMSCHL-OUT TO EINGABE
         COMPUTE C4-ANZ = C4-I1 - 1
     END-IF

**  ---> aufbereiten Parameter
     STRING  "WE.SUPER"
             ", "
             EINGABE (1:C4-ANZ)
                 DELIMITED BY SIZE
       INTO  UA-TEXT
     END-STRING
     ADD 10 TO C4-ANZ
     MOVE C4-ANZ TO UA-TEXTLEN
     MOVE LOW-VALUE  TO UA-DIALOG-ID
     MOVE 8325       TO UA-OPTIONS
     ENTER TAL "USER_AUTHENTICATE_"
                USING UA-TEXT (1:UA-TEXTLEN)
                      UA-OPTIONS
                      UA-DIALOG-ID
                      UA-STATUS
               GIVING UA-ERROR

     IF  UA-ERROR > ZERO AND SSPRM-OK
         SET SSPRM-EOD TO TRUE
         GO TO C010-00
     END-IF

     IF  UA-ERROR > ZERO
         DISPLAY " !!! Fehlerhaftes Passwort - Programm-Abbruch !!!"
**      ---> aufbereiten Protokolleintrage
         MOVE "PW-ERROR"     TO SOURCE-MODUL OF SSPROT
         MOVE "PW"           TO AKTION       OF SSPROT
         MOVE P-USER-NAME    TO GROUP-USER   OF SSPROT
         MOVE UA-ERROR TO D-NUM4
         MOVE D-NUM4   TO D-NUM2
         MOVE D-NUM2         TO KZ-FREIGABE  OF SSPROT

         PERFORM U100-BEGIN
         PERFORM S200-INSERT-SSPROT
         PERFORM U110-COMMIT

         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF

     IF  C4-I1 > ZERO
         PERFORM C030-PUT-AUTENT
     END-IF

     PERFORM U011-AUSGABE-SPACELINE
     PERFORM U011-AUSGABE-SPACELINE
     .
 C010-99.
     EXIT.

******************************************************************
* holen Eintrag aus Tabelle SSPARM
******************************************************************
 C020-GET-AUTENT SECTION.
 C020-00.
     MOVE "AUTENT" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

     IF  SVOL-SOURCE OF SSPARM = SPACE
         MOVE ZERO TO C4-I1
         EXIT SECTION
     END-IF

     MOVE SVOL-SOURCE OF SSPARM TO W-UMSCHL-IN
     PERFORM U310-DECR
**  ---> Ausgabe in W-UMSCHL-OUT
     .
 C020-99.
     EXIT.

******************************************************************
* schreiben Eintrag in Tabelle SSPARM
******************************************************************
 C030-PUT-AUTENT SECTION.
 C030-00.
     MOVE EINGABE (1:C4-ANZ) TO W-UMSCHL-IN
     PERFORM U320-ENCR
     MOVE W-UMSCHL-OUT TO SVOL-SOURCE OF SSPARM
     MOVE spaces       TO SVOL-DEST   OF SSPARM

     MOVE "AUTENT" TO AKTION OF SSPARM
     PERFORM U100-BEGIN
     PERFORM S310-UPDATE-SSPARM
     PERFORM U110-COMMIT
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF
     .
 C030-99.
     EXIT.

******************************************************************
* setzen Defines der WE-Usergruppe
******************************************************************
 C040-WE-DEFINES SECTION.
 C040-00.
**  ---> erstmal die Defines-Tabelle (=DEFCAT) für WE-User zuordnen
     PERFORM D060-SET-DEFCAT
**  ---> nur wenn SWITCH-1 gesetzt ist
     IF  TRACE-ON
         PERFORM W430-DEFINEINFO
     END-IF

**  ---> öffnen Cursor auf =DEFCAT
     PERFORM S500-OPEN-DEFCAT-CURSOR

**  ---> lesen 1. Eintrag
     PERFORM S510-FETCH-DEFCAT-CURSOR

**  ---> Schleife über alle Einträge
     PERFORM UNTIL   DEFCAT-NOK
             OR      PRG-ABBRUCH

         EVALUATE DEF-TYP OF DEFCAT

             WHEN "CA"       PERFORM D040-SET-CATDEFINE
             WHEN "TA"       PERFORM D050-SET-TABDEFINE
             WHEN "PV"       PERFORM D050-SET-TABDEFINE
             WHEN OTHER      continue

         END-EVALUATE

**      ---> nur wenn SWITCH-1 gesetzt ist
         IF  TRACE-ON
             PERFORM W430-DEFINEINFO
         END-IF

**      ---> lesen nächsten Eintrag
         PERFORM S510-FETCH-DEFCAT-CURSOR

     END-PERFORM

**  ---> schliessen Cursor
     PERFORM S520-CLOSE-DEFCAT-CURSOR
     .
 C040-99.
     EXIT.

******************************************************************
* Holen Berechtigungen für angemeldeten User, merken in ROLFKT-FLAGs
******************************************************************
 C050-GET-USER-INFO SECTION.
 C050-00.
**  ---> zunächst alle Flags initialisieren
     INITIALIZE ROLFKT-FLAG

**  ---> öffnen Join auf die Tabellen =SSUSER / =SSROLES
     MOVE W-USER-GRP-NAME (1:W-USER-GRP-NAME-LEN) TO W-UMSCHL-IN
     PERFORM U320-ENCR
     MOVE W-UMSCHL-OUT TO USER OF SSUSER
     IF  W-USER-GRP-NAME-LEN > 8
         MOVE W-USER-GRP-NAME (9:W-USER-GRP-NAME-LEN - 8) TO W-UMSCHL-IN
     ELSE
         MOVE SPACES TO W-UMSCHL-IN
     END-IF
     PERFORM U320-ENCR
     MOVE W-UMSCHL-OUT TO USER OF SSUSER (9:)
     PERFORM S620-OPEN-RECHTE-CURSOR

**  ---> lesen 1. Eintrag
     PERFORM S621-FETCH-RECHTE-CURSOR

**  ---> Schleife über alle Fundstellen / Funktionen
     PERFORM UNTIL USER-EOD OR PRG-ABBRUCH

         EVALUATE FUNKTION OF SSROLES
             WHEN "DOK"      SET ROLFKT-DOK      TO TRUE
             WHEN "LIST"     SET ROLFKT-LIST     TO TRUE
             WHEN "PROT"     SET ROLFKT-PROT     TO TRUE
             WHEN "SHOW"     SET ROLFKT-SHOW     TO TRUE
             WHEN "ACTIVTST" SET ROLFKT-ACTIVTST TO TRUE
             WHEN "REL2PROD" SET ROLFKT-REL2PROD TO TRUE
             WHEN "REL4WEAT" SET ROLFKT-REL4WEAT TO TRUE
             WHEN "CHECKIN"  SET ROLFKT-CHECKIN  TO TRUE
             WHEN "CHECKOUT" SET ROLFKT-CHECKOUT TO TRUE
             WHEN "REL2TEST" SET ROLFKT-REL2TEST TO TRUE
             WHEN "SAVE"     SET ROLFKT-SAVE     TO TRUE
             WHEN "VERW"     SET ROLFKT-VERW     TO TRUE
             WHEN "MODIN"    SET ROLFKT-MODIN    TO TRUE
             WHEN "MODIS"    SET ROLFKT-MODIS    TO TRUE
*             WHEN OTHER
         END-EVALUATE

**      ---> nachlesen
         PERFORM S621-FETCH-RECHTE-CURSOR

     END-PERFORM

**  ---> schließen Cursor
     PERFORM S622-CLOSE-RECHTE-CURSOR

**  ---> prüfen, ob überhaupt Funktionen zugelassen sind
     IF  C4-COUNT = ZERO
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-034" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF
     .
 C050-99.
     EXIT.


******************************************************************
* Check-in eines Programms
******************************************************************
 C100-CHECKIN SECTION.
 C100-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-CHECKIN
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> zunächstmal ein bisschen initialisieren
     INITIALIZE FUP-COMMANDS

     IF  FKT-STARTUP-ABFRAGE or FKT-EINGABE
**      ---> nur Kommando eingegeben, also holen Source-Modul Name
         SET EIN-ASCII
             PROMPT-SOURCE TO TRUE
         PERFORM U000-EINGABE
         IF  EINGABE = "E" OR = SPACE
             EXIT SECTION
         END-IF
         MOVE ZERO TO C4-ANZ
         MOVE 1    TO C4-PTR
         PERFORM N035-CHECK-EINGABE
         IF  CHECK-NOK
             GO TO C100-00
         END-IF
     END-IF

**  ---> dann überprüfen, ob das Source überhaupt ausgecheckt ist
     MOVE W-SOURCE TO SOURCE-MODUL OF SSAFE
     PERFORM S100-SELECT-SSAFE
**  ---> Abfragen, ob Fehler
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     IF  SSF-OK
         SET CHECKIN-NEXT TO TRUE
         IF  SOURCE-STATUS not = "CO"
**          ---> Fehler: Source nicht ausgecheckt
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-015" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             EXIT SECTION
         END-IF
     ELSE
**      ---> erstmaliges CHECKIN
         SET CHECKIN-FIRST TO TRUE
         MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
         MOVE "HINW-001" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
**      ---> Abfrage Source-Typ
         SET EIN-ASCII
             PROMPT-SOURCE-TYP TO TRUE
         PERFORM U000-EINGABE
         MOVE EINGABE TO SRC-TYP
         PERFORM UNTIL SRC-TYP-OK OR EINGABE = "EXIT"
             PERFORM U000-EINGABE
         END-PERFORM
         if  eingabe = "exit"
             exit section
         end-if
         MOVE EINGABE TO SOURCE-TYP OF SSAFE
     END-IF

**  ---> zunächst mal den Last-Modify Zeitpunkt der angegebenen
**       Datei holen und merken
**       vollst. Filename in SOURCE-FILE-VOL
     MOVE SOURCE-FILE TO T-FNAME
     PERFORM E120-FILE-INFO
     IF  T-ERROR NOT = ZERO
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-024" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         SET FKT-ABFRAGE TO TRUE
         EXIT SECTION
     END-IF

     MOVE TAL-TIME-D TO W-LAST-MODIFY
     SET TSRC-NO TO TRUE

**  ---> wenn File-Group = 120 Prüfung auf Sec-String überspringen
     IF  D-FILE-GROUP NOT = 120
**      ---> prüfen, ob die Securities richtig gesetzt sind
         IF  NOT (D-SEC-STRING = "AAAA" OR D-SEC-STRING = "NNNN")
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-018" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             SET FKT-ABFRAGE TO TRUE
             EXIT SECTION
         END-IF
     END-IF

**  ---> erst noch SubVol-Pattern und destination SVOL holen
     MOVE "CHECKIN" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> Destination File-Name zusammenbasteln
     MOVE SPACES TO DEST-FILE
     MOVE SOURCE-FILE-VOL     TO DEST-FILE-VOL
     MOVE SVOL-DEST OF SSPARM TO DEST-FILE-SUBVOL
     MOVE SOURCE-FILE-NAME    TO DEST-FILE-NAME
     STRING  DEST-FILE-VOL       DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-SUBVOL    DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-NAME      DELIMITED BY SPACE
       INTO  DEST-FILE
     END-STRING

**  ---> dann prüfen alle Dateien, des angegebenen Sources, ob nicht
**       Vielleicht noch jüngere vorhanden sind
**  ---> suchen in SUBVOLS mit search-pattern aus Tabelle SSPARM
     MOVE SVOL-SOURCE OF SSPARM TO SEARCH-FILE-SUBVOL

     PERFORM E100-FIND-START
     MOVE ZERO TO FUP-COMMANDS-ANZ
     PERFORM E110-FIND-NEXT

**   ---> Schleife über alle Dateien mit gleichem Namen
     PERFORM UNTIL F-EOF
             OR    PRG-ABBRUCH

**      ---> holen Last-Modify-Zeitpunkt
         MOVE SOURCE-FILE TO T-FNAME
         PERFORM E120-FILE-INFO
         IF  TAL-TIME-D > W-LAST-MODIFY
             MOVE FB-NAME (1:FB-NAMELEN) TO W-TEXT (6:1)
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-024" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             SET PRG-ABBRUCH TO TRUE
             EXIT SECTION
         END-IF

**      ---> suchen nächsten
         PERFORM E110-FIND-NEXT

     END-PERFORM

**  ---> Fehler und Warnungen erlauben
     IF  FUP-COMMANDS-ANZ = ZERO
         ADD 1 TO FUP-COMMANDS-ANZ
         MOVE "ALLOW 10 ERRORS, 10 WARNINGS" TO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-IF

**  ---> duplizieren vom akt. Standort nach WSRC, nur, wenn nicht schon da
**               (dup SVol.SourceE, WSRC.SourceE)
     ADD 1 TO FUP-COMMANDS-ANZ
     STRING  " DUP "         DELIMITED BY SIZE
             SOURCE-FILE     DELIMITED BY SPACE
             ", "            DELIMITED BY SIZE
             DEST-FILE       DELIMITED BY SPACE
             ", sourcedate"  DELIMITED BY SIZE
       INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-STRING

**  ---> security auf "AUUU"
     ADD 1 TO FUP-COMMANDS-ANZ
     STRING  " SECURE "      DELIMITED BY SIZE
             DEST-FILE       DELIMITED BY SPACE
             ", ""AUUU"""    DELIMITED BY SIZE
       INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-STRING

**  ---> Owner auf 120,255
     ADD 1 TO FUP-COMMANDS-ANZ
     STRING  " PURGE ! "     DELIMITED BY SIZE
             SOURCE-FILE     DELIMITED BY SPACE
       INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-STRING

**  ---> prüfen, ob SourceZ existiert, wenn ja: dann löschen
**  ---> !!! DEST-FILE wird hier manipuliert (endet dann mit "Z") !!!
     IF  SRCZ-YES
         MOVE ZERO TO C4-I1
         INSPECT DEST-FILE TALLYING C4-I1
             FOR CHARACTERS BEFORE INITIAL SPACE
         IF  C4-I1 > ZERO
             MOVE "Z" TO DEST-FILE (C4-I1:)
         END-IF

         ADD 1 TO FUP-COMMANDS-ANZ
         STRING  " PURGE ! "    DELIMITED BY SIZE
                 DEST-FILE   DELIMITED BY SPACE
           INTO  FUP-COMMAND (FUP-COMMANDS-ANZ)
         END-STRING
     END-IF

**  ---> Eintrag in Tabelle SSAFE
     MOVE W-SOURCE    TO SOURCE-MODUL  OF SSAFE
     MOVE "CI"        TO SOURCE-STATUS OF SSAFE
     MOVE P-USER-NAME TO GROUP-USER    OF SSAFE
**  ---> Source-Typ wird oben eingestellt
     IF  CHECKIN-FIRST
         MOVE "NO"    TO FREIGABE-TEST OF SSAFE
         MOVE "NO"    TO FREIGABE-PROD OF SSAFE
     END-IF

     PERFORM U100-BEGIN

**  ---> ggf. wird statt Update ein Insert durchgeführt
     PERFORM S110-UPDATE-SSAFE-CHECKIN
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF

**  ---> Eintrag in Protokolltabelle SSPROT
     MOVE W-SOURCE    TO SOURCE-MODUL OF SSPROT
     MOVE "CI"        TO AKTION       OF SSPROT
     MOVE P-USER-NAME TO GROUP-USER   OF SSPROT
     MOVE "NO"        TO KZ-FREIGABE  OF SSPROT
     PERFORM S200-INSERT-SSPROT
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF
     PERFORM U110-COMMIT

**  ---> Obey Datei füllen und FUP ausführen
     PERFORM E150-OBEY-FUP

**  ---> Bestätigung an den User
     IF  PRG-OK
         MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
         MOVE "HINW-014" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
     END-IF
     .
 C100-99.
     EXIT.

******************************************************************
* Check-out eines Programms
******************************************************************
 C110-CHECKOUT SECTION.
 C110-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-CHECKOUT
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> zunächstmal ein bisschen initialisieren
     INITIALIZE FUP-COMMANDS

     IF  FKT-STARTUP-ABFRAGE or FKT-EINGABE
**      ---> nur Kommando eingegeben, also holen Source-Modul Name
         SET EIN-ASCII
             PROMPT-SOURCE TO TRUE
         PERFORM U000-EINGABE
         IF  EINGABE = "E" OR = SPACE
             EXIT SECTION
         END-IF
         MOVE ZERO TO C4-ANZ
         MOVE 1    TO C4-PTR
         PERFORM N035-CHECK-EINGABE
         IF  CHECK-NOK
             GO TO C110-00
         END-IF
     END-IF

**  ---> dann überprüfen, ob das Source überhaupt eingecheckt ist
     MOVE W-SOURCE TO SOURCE-MODUL OF SSAFE
     PERFORM S100-SELECT-SSAFE
     IF  SSF-OK
         IF  SOURCE-STATUS not = "CI"
**          ---> Fehler: Source nicht eingecheckt
             MOVE W-SOURCE TO W-TEXT (6:)
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-004" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             EXIT SECTION
         ELSE
             MOVE W-SOURCE TO SOURCE-MODUL of SSPROT
             MOVE "CI"     TO AKTION       of SSPROT
             PERFORM S223-SELECT-SSPROT-MAX-ZP
             PERFORM S224-SELECT-SSPROT-MAX-CI

             DISPLAY " "
             DISPLAY " ===> letzter CHECKIN: "
                     ZP-CHECKIN of SSAFE
                     "  durch "
                     GROUP-USER of SSPROT
                     " <==="
             DISPLAY " "
         END-IF
     ELSE
**      ---> SQL-Status <> Null erhalten
         IF  PRG-ABBRUCH
**          ---> sonstiger SQL-Fehler
             EXIT SECTION
         ELSE
**          ---> Source ist nicht vorhanden
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-001" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             SET FKT-EINGABE TO TRUE
             GO TO C110-00
         END-IF
     END-IF

**  ---> erst noch Dest.-SubVol holen
     MOVE "CHECKOUT" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> dann prüfen, ob nicht vielleicht auf Destination-Subvol noch
**       eine Datei gleichen Namens ist
**  ---> Dest.SVol aus Tabelle SSPARM verwenden
     MOVE SVOL-DEST OF SSPARM TO SEARCH-FILE-SUBVOL

     PERFORM E100-FIND-START
     MOVE ZERO TO FUP-COMMANDS-ANZ
     PERFORM E110-FIND-NEXT

**   ---> Schleife über alle Dateien mit gleichem Namen
     PERFORM UNTIL F-EOF
             OR    PRG-ABBRUCH

**      ---> wenn Datei auch in .ESRC. steht muss diese
**           vor dem RENAME gelöscht werden (SEARCH-FILE untersuchen)
         IF  W-SOURCE-NAME NOT = SEARCH-FILE
             MOVE ZERO TO C4-I1
             INSPECT SEARCH-FILE TALLYING C4-I1
                 FOR CHARACTERS BEFORE INITIAL ".ESRC."

**          ---> ist vorhanden, wenn C4-I1 > 0
             IF  C4-I1 > ZERO
                 MOVE "FEHLER"   TO BEREICH   OF SSTEXT
                 MOVE "FEHL-003" TO KATEGORIE OF SSTEXT
**              ---> anzeigen Hilfstext
                 PERFORM R100-SHOW-TEXT
                 SET PRG-ABBRUCH TO TRUE
                 EXIT SECTION
             END-IF
         END-IF

**      ---> suchen nächsten
         PERFORM E110-FIND-NEXT

     END-PERFORM

**  ---> in SOURCE-FILE-... steht der Standort des Users
**       muss also wie folgt geändert werden
**       Standort Source: ist SSPARM.SVOL-DEST bei CHECKIN  vermerkt
**       Destination    : ist SSPARM.SVOL-DEST bei CHECKOUT vermerkt
**  ---> Destinaion ist bereit geholt - nun auch verwenden
     MOVE SPACES TO DEST-FILE
     MOVE SOURCE-FILE-VOL     TO DEST-FILE-VOL
     MOVE SVOL-DEST OF SSPARM TO DEST-FILE-SUBVOL
     MOVE SOURCE-FILE-NAME    TO DEST-FILE-NAME
     MOVE SPACES TO DEST-FILE
     STRING  DEST-FILE-VOL       DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-SUBVOL    DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-NAME      DELIMITED BY SPACE
       INTO  DEST-FILE
     END-STRING

**  ---> jetzt den Source-Standort bestimmen
     MOVE "CHECKIN" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF
     MOVE SPACES TO SOURCE-FILE
     MOVE SVOL-DEST OF SSPARM TO SOURCE-FILE-SUBVOL
     STRING  SOURCE-FILE-VOL     DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             SOURCE-FILE-SUBVOL  DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             SOURCE-FILE-NAME    DELIMITED BY SPACE
       INTO  SOURCE-FILE
     END-STRING

**  ---> duplizieren in das Verzeichnis SSAFE.SVOL_DEST
     IF  FUP-COMMANDS-ANZ = ZERO
         ADD 1 TO FUP-COMMANDS-ANZ
         MOVE "ALLOW 10 ERRORS, 10 WARNINGS" TO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-IF
     ADD 1 TO FUP-COMMANDS-ANZ
     STRING  " DUP "         DELIMITED BY SIZE
             SOURCE-FILE     DELIMITED BY SPACE
             ", "            DELIMITED BY SIZE
             DEST-FILE       DELIMITED BY SPACE
             ", sourcedate"  DELIMITED BY SIZE
       INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-STRING

**  ---> security auf "UUUU"
     ADD 1 TO FUP-COMMANDS-ANZ
     STRING  " SECURE "      DELIMITED BY SIZE
             DEST-FILE       DELIMITED BY SPACE
             ", ""UUUU"""    DELIMITED BY SIZE
       INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-STRING

**  ---> Owner auf nnn,nnn
     ADD 1 TO FUP-COMMANDS-ANZ
     STRING  " GIVE "        DELIMITED BY SIZE
             DEST-FILE       DELIMITED BY SPACE
             ", "            DELIMITED BY SIZE
             W-USER-GRP      DELIMITED BY SIZE
             ","             DELIMITED BY SIZE
             W-USER-NR       DELIMITED BY SIZE
       INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-STRING

     MOVE DEST-FILE TO DEST-FILE-ALT
**  ---> RENAME für Sicherungskopie (...E => ...Z)
     MOVE SOURCE-FILE TO DEST-FILE
     MOVE ZERO TO C4-I1
     INSPECT DEST-FILE TALLYING C4-I1
         FOR CHARACTERS BEFORE INITIAL SPACE
     IF  C4-I1 > ZERO
         MOVE "Z" TO DEST-FILE (C4-I1:)
     END-IF

     ADD 1 TO FUP-COMMANDS-ANZ
     STRING  " RENAME "      DELIMITED BY SIZE
             SOURCE-FILE     DELIMITED BY SPACE
             ", "            DELIMITED BY SIZE
             DEST-FILE       DELIMITED BY SPACE
       INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-STRING

**  ---> Eintrag in Tabelle SSAFE
     MOVE W-SOURCE    TO SOURCE-MODUL  OF SSAFE
     MOVE "CO"        TO SOURCE-STATUS OF SSAFE
     MOVE P-USER-NAME TO GROUP-USER    OF SSAFE

     PERFORM U100-BEGIN
     PERFORM S120-UPDATE-SSAFE-CHECKOUT
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF

**  ---> Eintrag in Protokolltabelle SSPROT
     MOVE W-SOURCE    TO SOURCE-MODUL OF SSPROT
     MOVE "CO"        TO AKTION       OF SSPROT
     MOVE P-USER-NAME TO GROUP-USER   OF SSPROT
     PERFORM S200-INSERT-SSPROT
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF
     PERFORM U110-COMMIT

**  ---> Obey Datei füllen und FUP ausführen
     PERFORM E150-OBEY-FUP

**  ---> Bestätigung an den User
     IF  PRG-OK
         MOVE DEST-FILE-ALT TO W-TEXT (9:)
         MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
         MOVE "HINW-013" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
     END-IF
     .
 C110-99.
     EXIT.


******************************************************************
* Listen der module und der Protokolle
******************************************************************
 C200-LIST SECTION.
 C200-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-LIST
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

     PERFORM U011-AUSGABE-SPACELINE

**  ---> subkommando steht in W-LIST-SUBCMD
**  ---> ggf. steht ein Parameter dazu in W-LIST-SUBPRM (USER + MONTH)
     MOVE ALL "%" TO SOURCE-STATUS OF SSAFE
                     FREIGABE-PROD OF SSAFE
                     GROUP-USER    OF SSAFE
                     SOURCE-MODUL  OF SSAFE
     MOVE ZEROES  TO H-MONATE

**  ---> wenn aktueller Tag > 28 => entsprechend viel abziehen
     IF  W-HEUTE-TT > 28
         COMPUTE D-NUM2 = W-HEUTE-TT - 28
         MOVE D-NUM2 TO H-HEUTE-TT
     ELSE
         MOVE ZEROES TO H-HEUTE-TT
     END-IF
     SET CURS-SSAFE TO TRUE

**  ---> für Suche nach Sources mit Wild-Character für SQL umsetzen
     INSPECT W-LIST-SUBCMD CONVERTING "?* "
                                   TO "_%%"
     MOVE ZEROES TO C4-I1
                    C4-I2
     INSPECT W-LIST-SUBCMD TALLYING  C4-I1 FOR ALL "_"
                                     C4-I2 FOR ALL "%"

     EVALUATE W-LIST-SUBCMD
         WHEN "CHECKEDIN%"   MOVE "CI" TO SOURCE-STATUS OF SSAFE
         WHEN "CHECKEDOUT"   MOVE "CO" TO SOURCE-STATUS OF SSAFE
                             IF  W-LIST-SUBPRM1 = "USER"
                                 MOVE W-LIST-SUBPRM1-VAL TO GROUP-USER OF SSAFE
                             END-IF
                             IF  W-LIST-SUBPRM2 = "MONTH"
                                 MOVE W-LIST-SUBPRM2-VALN TO D-NUM2
                                 MOVE D-NUM2              TO H-MONATE
                             END-IF
         WHEN "RELEASED%%"   MOVE "CI" TO SOURCE-STATUS OF SSAFE
                             MOVE "PR" TO FREIGABE-PROD OF SSAFE
         WHEN "NOTINPROD%"   SET CURS-SSAFE2 TO TRUE
                             IF  W-LIST-SUBPRM1 = "USER"
                                 MOVE W-LIST-SUBPRM1-VAL TO GROUP-USER OF SSAFE
                             END-IF
         WHEN "FREIGABE%%"   SET CURS-ABNAHME TO TRUE
         WHEN OTHER          IF  C4-I1 = ZERO and C4-I2 = ZERO
                                 continue
                             ELSE
                                 MOVE W-LIST-SUBCMD TO SOURCE-MODUL OF SSAFE
                             END-IF
     END-EVALUATE

**  ---> öffnen Cursor
     PERFORM D200-OPEN-LIST-CURSOR

**  ---> lesen ersten Eintrag
     PERFORM D201-FETCH-LIST-CURSOR
     MOVE 99 TO C4-ANZ

     IF  SSF-EOD
**      ---> Select brachte ein Null-Ergebnis
         MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
         MOVE "HINW-003" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
     END-IF

**  ---> Schleife über alle Einträge
     PERFORM UNTIL SSF-EOD
                OR PRG-ABBRUCH

         IF  CURS-ABNAHME
             PERFORM D206-SHOW-LIST2
         ELSE
             PERFORM D205-SHOW-LIST1
         END-IF

**      ---> lesen nächsten Eintrag
         PERFORM D201-FETCH-LIST-CURSOR

**      ---> wenn mehr als 18 Zeilen: abfragen, ob weiter
         IF  C4-ANZ > 19 and SSF-OK
             PERFORM U011-AUSGABE-SPACELINE
             SET EIN-ASCII
                 PROMPT-WEITER TO TRUE
             PERFORM U000-EINGABE
             IF  EINGABE = "E" or = "N"
                 SET SSF-EOD TO TRUE
             END-IF
             MOVE 99 TO C4-ANZ
             PERFORM U011-AUSGABE-SPACELINE
         ELSE
             ADD 1 TO C4-ANZ
         END-IF

     END-PERFORM

**  ---> schliessen Cursor
     PERFORM D202-CLOSE-LIST-CURSOR

     IF  C4-COUNT > 1
**      --->
         MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
         MOVE "HINW-007" TO KATEGORIE OF SSTEXT
         MOVE C4-COUNT TO D-NUM4
         STRING  "    "
                 D-NUM4
                 " Sätze angezeigt"
                     DELIMITED BY SIZE
           INTO  W-TEXT
         END-STRING
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
     END-IF
     .
 C200-99.
     EXIT.

******************************************************************
* zeigen Status eines Moduls
******************************************************************
 C210-SHOW SECTION.
 C210-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-SHOW
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

     IF  W-SOURCE = SPACE
**      ---> Fehler: Source nicht angegeben
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-012" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> holen Daten aus Tabelle
     MOVE W-SOURCE TO SOURCE-MODUL OF SSAFE
     PERFORM S100-SELECT-SSAFE
**  ---> Abfragen, ob Fehler
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     IF  SSF-EOD
**      ---> Fehler: Source exisiert nicht
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-001" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> ausgeben Überschrift
     PERFORM U011-AUSGABE-SPACELINE
     MOVE SZ-TITEL TO ZEILE
     PERFORM U010-AUSGABE
     MOVE SZ-UNTERSTRICHE TO ZEILE
     PERFORM U010-AUSGABE

**  ---> aufbereiten Daten
     MOVE SOURCE-MODUL OF SSAFE          TO LZD-SOURCE-MODUL
     EVALUATE SOURCE-TYP OF SSAFE
         WHEN "CS"   MOVE "Cobol-Srv"    TO LZD-SOURCE-TYP
         WHEN "CO"   MOVE "Cobol-Obj"    TO LZD-SOURCE-TYP
         WHEN "CP"   MOVE "Cobol-Prg"    TO LZD-SOURCE-TYP
         WHEN "CM"   MOVE "Cobol-Mod"    TO LZD-SOURCE-TYP
         WHEN "CL"   MOVE "Cobol-Lib"    TO LZD-SOURCE-TYP
         WHEN "CX"   MOVE "CobObj-oS"    TO LZD-SOURCE-TYP
         WHEN "TB"   MOVE "TAL-Lib"      TO LZD-SOURCE-TYP
         WHEN "TP"   MOVE "TACL-Proc"    TO LZD-SOURCE-TYP
         WHEN "UC"   MOVE "UDC"          TO LZD-SOURCE-TYP
         WHEN OTHER  MOVE "???"          TO LZD-SOURCE-TYP
     END-EVALUATE
     EVALUATE SOURCE-STATUS OF SSAFE
         WHEN "CI"   MOVE "CheckedIn"    TO LZD-SOURCE-STATUS
                     MOVE ZP-CHECKIN OF SSAFE
                                         TO LZD-ZEITPUNKT
                     MOVE " letzter CheckOut" TO SZD2-TEXT
                     IF  ZP-CHECKOUT OF SSAFE = ZP-CHECKIN OF SSAFE
                         MOVE SPACES     TO SZD2-ZEITPUNKT
                     ELSE
                         MOVE ZP-CHECKOUT OF SSAFE
                                         TO SZD2-ZEITPUNKT
                     END-IF

         WHEN "CO"   MOVE "CheckedOut"   TO LZD-SOURCE-STATUS
                     MOVE ZP-CHECKOUT OF SSAFE
                                         TO LZD-ZEITPUNKT
                     MOVE "  letzter CheckIn" TO SZD2-TEXT
                     MOVE ZP-CHECKIN OF SSAFE
                                         TO SZD2-ZEITPUNKT
         WHEN OTHER  MOVE "???"          TO LZD-SOURCE-STATUS
     END-EVALUATE
     MOVE GROUP-USER OF SSAFE            TO LZD-USER
     MOVE SZ-DATEN1 TO ZEILE
     PERFORM U010-AUSGABE
     PERFORM U010-AUSGABE

     MOVE SZ-DATEN2 TO ZEILE
     PERFORM U010-AUSGABE

     MOVE "Test:" TO SZD3-FREIGABE-TEXT
     EVALUATE FREIGABE-TEST OF SSAFE
         WHEN "TR"   MOVE "released"     TO SZD3-FREIGABE-STAT
         WHEN "TA"   MOVE "aktiv"        TO SZD3-FREIGABE-STAT
         WHEN "NO"   MOVE "nein"         TO SZD3-FREIGABE-STAT
         WHEN "SA"   MOVE "gesichert"    TO SZD3-FREIGABE-STAT
         WHEN OTHER  MOVE "???"          TO SZD3-FREIGABE-STAT
     END-EVALUATE
     IF  ZP-FREIGABE-TEST OF SSAFE = ZP-CHECKIN OF SSAFE
         MOVE SPACES                     TO SZD3-ZEITPUNKT
     ELSE
         MOVE ZP-FREIGABE-TEST OF SSAFE  TO SZD3-ZEITPUNKT
     END-IF

     MOVE SZ-DATEN3 TO ZEILE
     PERFORM U010-AUSGABE

     MOVE "Prod:" TO SZD3-FREIGABE-TEXT
     EVALUATE FREIGABE-PROD OF SSAFE
         WHEN "PR"   MOVE "released"     TO SZD3-FREIGABE-STAT
         WHEN "PA"   MOVE "aktiv"        TO SZD3-FREIGABE-STAT
         WHEN "NO"   MOVE "nein"         TO SZD3-FREIGABE-STAT
         WHEN OTHER  MOVE "???"          TO SZD3-FREIGABE-STAT
     END-EVALUATE
     IF  ZP-FREIGABE-PROD OF SSAFE = ZP-CHECKIN OF SSAFE
         MOVE SPACES                     TO SZD3-ZEITPUNKT
     ELSE
         MOVE ZP-FREIGABE-PROD OF SSAFE  TO SZD3-ZEITPUNKT
     END-IF

     MOVE SZ-DATEN3 TO ZEILE
     PERFORM U010-AUSGABE
     PERFORM U011-AUSGABE-SPACELINE
     .
 C210-99.
     EXIT.

******************************************************************
* zeigen Protokolleintraege
******************************************************************
 C220-PROT SECTION.
 C220-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-PROT
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

     IF  W-SOURCE = SPACE
**      ---> Fehler: Source nicht angegeben
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-012" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> holen Daten aus Tabelle SSPROT
     MOVE ZERO TO C4-ANZ1
     INSPECT W-SOURCE TALLYING
             C4-ANZ1 FOR CHARACTERS BEFORE INITIAL SPACE
     MOVE all "_"  TO SOURCE-MODUL OF SSPROT
     MOVE W-SOURCE (1:C4-ANZ1 - 1) TO SOURCE-MODUL OF SSPROT (1:C4-ANZ1 - 1)

*     IF  W-SOURCE = SPACE
*         MOVE all "_"  TO SOURCE-MODUL OF SSPROT
*     ELSE
*         MOVE W-SOURCE TO SOURCE-MODUL OF SSPROT
*     END-IF
     PERFORM U011-AUSGABE-SPACELINE

**  ---> öffnen Cursor
     PERFORM S210-OPEN-SSPROT-CURSOR

**  ---> lesen 1. Eintrag
     MOVE SPACES TO W-SOURCE-MODUL-ALT
     PERFORM S211-FETCH-SSPROT-CURSOR
     MOVE 99 TO C4-ANZ

**  ---> Schleife über alle Einträge
     PERFORM UNTIL SSPROT-EOD
                OR PRG-ABBRUCH

**      ---> aufbereiten Datenzeile
         IF  C4-ANZ > 90
**          ---> Überschrift aufbereiten
             MOVE PZ-TITEL TO ZEILE
             PERFORM U010-AUSGABE
             MOVE PZ-UNTERSTRICHE TO ZEILE
             PERFORM U010-AUSGABE

             MOVE SOURCE-MODUL OF SSPROT TO PZD-SOURCE-MODUL
             MOVE 1 TO C4-ANZ
         ELSE
*             IF  SOURCE-MODUL OF SSPROT = W-SOURCE-MODUL-ALT
                 MOVE SPACES                 TO PZD-SOURCE-MODUL
*             ELSE
*                 MOVE SOURCE-MODUL OF SSPROT TO PZD-SOURCE-MODUL
*             END-IF
         END-IF

         EVALUATE AKTION OF SSPROT
             WHEN "CI"   MOVE "CheckedIn"    TO PZD-AKTION
             WHEN "CO"   MOVE "CheckedOut"   TO PZD-AKTION
             WHEN "AK"   MOVE "Aktivierng"   TO PZD-AKTION
             WHEN "FR"   MOVE "Freigabe"     TO PZD-AKTION
             WHEN "PW"   MOVE "PW Error"     TO PZD-AKTION
             WHEN "SA"   MOVE "Sicherung"    TO PZD-AKTION
             WHEN OTHER  MOVE "???"          TO PZD-AKTION
         END-EVALUATE
         MOVE ZPINS OF SSPROT (1:19)         TO PZD-ZEITPUNKT
         MOVE GROUP-USER OF SSPROT           TO PZD-USER
         EVALUATE KZ-FREIGABE OF SSPROT
             WHEN "48"   MOVE "Secur. Err."  TO PZD-KZ-FREIGABE
             WHEN "NO"   MOVE "nein"         TO PZD-KZ-FREIGABE
             WHEN "TR"   MOVE "T-Released"   TO PZD-KZ-FREIGABE
             WHEN "TA"   MOVE "Test aktiv"   TO PZD-KZ-FREIGABE
             WHEN "FA"   MOVE "beantragt"    TO PZD-KZ-FREIGABE
             WHEN "FW"   MOVE "erteilt"      TO PZD-KZ-FREIGABE
             WHEN "PR"   MOVE "P-Released"   TO PZD-KZ-FREIGABE
             WHEN "PA"   MOVE "Prod. aktiv"  TO PZD-KZ-FREIGABE
             WHEN "SA"   MOVE "gesichert"    TO PZD-KZ-FREIGABE
             WHEN OTHER  IF  KZ-FREIGABE OF SSPROT NUMERIC
                             MOVE KZ-FREIGABE OF SSPROT TO D-NUM2
                             MOVE "Error "   TO PZD-KZ-FREIGABE
                             MOVE D-NUM2     TO PZD-KZ-FREIGABE (7:2)
                         ELSE
                             MOVE "???"      TO PZD-KZ-FREIGABE
                         END-IF
         END-EVALUATE
         MOVE PZ-DATEN TO ZEILE
         PERFORM U010-AUSGABE

**      ---> lesen nächsten Eintrag
         MOVE SOURCE-MODUL OF SSPROT TO W-SOURCE-MODUL-ALT
         PERFORM S211-FETCH-SSPROT-CURSOR

**      ---> wenn mehr als 18 Zeilen: abfragen, ob weiter
         IF  C4-ANZ > 18 and SSPROT-OK
             PERFORM U011-AUSGABE-SPACELINE
             SET EIN-ASCII
                 PROMPT-WEITER TO TRUE
             PERFORM U000-EINGABE
             IF  EINGABE = "E" or = "N"
                 SET SSPROT-EOD TO TRUE
             END-IF
             MOVE 99 TO C4-ANZ
             PERFORM U011-AUSGABE-SPACELINE
         ELSE
             ADD 1 TO C4-ANZ
         END-IF

     END-PERFORM

**  ---> schliessen Cursor
     PERFORM S212-CLOSE-SSPROT-CURSOR
     .
 C220-99.
     EXIT.

******************************************************************
* Anzeigen Versionsdokumentation aus den Programmen
******************************************************************
 C250-DOKUMENT SECTION.
 C250-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-DOK
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

     IF  W-SOURCE = SPACE
**  ---> für Anzeige vom Sourcesafe
         MOVE "SRCSAFEE" TO SOURCE-MODUL OF SSAFE
                            SOURCE-FILE-NAME
     ELSE
**  ---> für Anzeige von Sourcen auf TSRC
         MOVE W-SOURCE TO SOURCE-MODUL OF SSAFE
     END-IF

**  ---> holen SSAFE-Eintrag
     PERFORM S100-SELECT-SSAFE
**  ---> Abfragen, ob Fehler
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     IF  SSF-OK
**      ---> dann überprüfen, ob das Source überhaupt eingecheckt ist
         IF  SOURCE-STATUS not = "CI"
**          ---> Fehler: Source nicht eingecheckt
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-016" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             EXIT SECTION
         END-IF
**      ---> dann überprüfen, ob das Programm für TEST released ist
         IF  not (FREIGABE-TEST = "TR" or = "TA")
**          ---> Fehler: Source nicht freigegeben für TEST
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-042" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             EXIT SECTION
         END-IF
     ELSE
         IF  NOT W-SOURCE = SPACE
**          ---> Fehler: Source nicht gefunden
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-001" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             EXIT SECTION
         END-IF
     END-IF

**  ---> erst noch Destination-SubVol (in SVOL_DEST) SVOL holen
     MOVE "R2T-SST" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> Eingabe File-Name zusammenbasteln
     MOVE SPACES TO DEST-FILE
     MOVE SOURCE-FILE-VOL     TO DEST-FILE-VOL
     MOVE SVOL-DEST OF SSPARM TO DEST-FILE-SUBVOL
     MOVE SOURCE-FILE-NAME    TO DEST-FILE-NAME
     STRING  DEST-FILE-VOL       DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-SUBVOL    DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-NAME      DELIMITED BY SPACE
       INTO  DEST-FILE
     END-STRING

**  ---> nachsehen, ob das Sourcefile kein Open-Flag hat
     MOVE AP-DNAME TO AP-DNAME-ZW
     MOVE DEST-FILE TO AP-DNAME
     PERFORM W200-OPENINFO
     MOVE AP-DNAME-ZW TO AP-DNAME
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> Anzeigen Versionshinweise
     MOVE DEST-FILE TO ASS-FNAME
     PERFORM D250-VERSIONS-DOKU
     IF  PRG-ABBRUCH or SOURCEF-NOK
         EXIT SECTION
     END-IF
     .
 C250-99.
     EXIT.

******************************************************************
* Anzeigen Programme, in denen ein Programm (Modul) enthalten ist
******************************************************************
 C260-MODIS SECTION.
 C260-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-MODIS
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

     IF  FKT-STARTUP-ABFRAGE or FKT-EINGABE
**      ---> nur Kommando eingegeben, also holen Source-Modul Name
         SET EIN-ASCII
             PROMPT-SOURCE TO TRUE
         PERFORM U000-EINGABE
         IF  EINGABE = "E" OR = SPACE
             EXIT SECTION
         END-IF
         MOVE ZERO TO C4-ANZ
         MOVE 1    TO C4-PTR
         PERFORM N035-CHECK-EINGABE
         IF  CHECK-NOK
             GO TO C260-00
         END-IF
     END-IF

**  ---> dann überprüfen, ob das Source ein Modul ist
     MOVE W-SOURCE TO SOURCE-MODUL OF SSAFE
     PERFORM S100-SELECT-SSAFE
     IF  SSF-OK
         IF  SOURCE-TYP of SSAFE not = "CM"
**          ---> Fehler: Source kein Modul
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE W-SOURCE   TO W-TEXT (6:)
             MOVE "FEHL-032" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             EXIT SECTION
         END-IF
     ELSE
**      ---> SQL-Status <> Null erhalten
         IF  PRG-ABBRUCH
**          ---> sonstiger SQL-Fehler
             EXIT SECTION
         ELSE
**          ---> Source ist nicht vorhanden
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-001" TO KATEGORIE OF SSTEXT
*             MOVE "FEHL-001" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             SET FKT-EINGABE TO TRUE
             EXIT SECTION
         END-IF
     END-IF

     PERFORM D260-SHOW-MODIS
     .
 C260-99.
     EXIT.

******************************************************************
* Anzeigen Module, die im Programm enthalten sind
******************************************************************
 C270-MODIN SECTION.
 C270-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-MODIN
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

     IF  FKT-STARTUP-ABFRAGE or FKT-EINGABE
**      ---> nur Kommando eingegeben, also holen Source-Modul Name
         SET EIN-ASCII
             PROMPT-SOURCE TO TRUE
         PERFORM U000-EINGABE
         IF  EINGABE = "E" OR = SPACE
             EXIT SECTION
         END-IF
         MOVE ZERO TO C4-ANZ
         MOVE 1    TO C4-PTR
         PERFORM N035-CHECK-EINGABE
         IF  CHECK-NOK
             GO TO C260-00
         END-IF
     END-IF

**  ---> dann überprüfen, ob das Source ein Modul ist
     MOVE W-SOURCE TO SOURCE-MODUL OF SSAFE
     PERFORM S100-SELECT-SSAFE
     IF  SSF-OK
         IF  not (SOURCE-TYP of SSAFE = "CS" or = "CO" or = "CX")
**          ---> Fehler: Source kein Programm
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE W-SOURCE   TO W-TEXT (6:)
             MOVE "FEHL-033" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             EXIT SECTION
         END-IF
     ELSE
**      ---> SQL-Status <> Null erhalten
         IF  PRG-ABBRUCH
**          ---> sonstiger SQL-Fehler
             EXIT SECTION
         ELSE
**          ---> Source ist nicht vorhanden
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-001" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             SET FKT-EINGABE TO TRUE
             EXIT SECTION
         END-IF
     END-IF

     PERFORM D270-SHOW-MODIN
     .
 C270-99.
     EXIT.

******************************************************************
* Release nach Produktion
******************************************************************
 C300-REL2PROD SECTION.
 C300-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-REL2PROD
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> zunächstmal ein bisschen initialisieren
     INITIALIZE FUP-COMMANDS
     MOVE ZERO       TO FUP-COMMANDS-ANZ
     IF  FUP-COMMANDS-ANZ = ZERO
         ADD 1 TO FUP-COMMANDS-ANZ
         MOVE "ALLOW 10 ERRORS, 10 WARNINGS" TO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-IF

     IF  FKT-STARTUP-ABFRAGE or FKT-EINGABE
**      ---> nur Kommando eingegeben, also holen Source-Modul Name
         SET EIN-ASCII
             PROMPT-SOURCE TO TRUE
         PERFORM U000-EINGABE
         IF  EINGABE = "E" OR = SPACE
             EXIT SECTION
         END-IF
         MOVE ZERO TO C4-ANZ
         MOVE 1    TO C4-PTR
         PERFORM N035-CHECK-EINGABE
         IF  CHECK-NOK
             GO TO C300-00
         END-IF
     END-IF

**  ---> holen SSAFE-Eintrag
     MOVE W-SOURCE TO SOURCE-MODUL OF SSAFE
     PERFORM S100-SELECT-SSAFE
**  ---> Abfragen, ob Fehler
     IF  SSF-EOD OR PRG-ABBRUCH
         PERFORM D000-ALLE-FEHL-006
         EXIT SECTION
     END-IF

**  ---> dann überprüfen, ob das Source überhaupt eingecheckt ist
     IF  SOURCE-STATUS not = "CI"
**      ---> Fehler: Source nicht eingecheckt
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-016" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF
**  ---> dann überprüfen, ob das Programm für TEST aktiviert ist
     IF  FREIGABE-TEST not = "TA"
         IF  SOURCE-TYP OF SSAFE not = "CM"
**          ---> Fehler: Source nicht aktiviert für TEST
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-030" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             EXIT SECTION
         END-IF
     END-IF

**  ---> Tabelle =ABNAHME vervollständigen
     PERFORM D720-UPDATE-ABNAHME-R2P
     IF  PRG-ENDE
         SET PRG-OK TO TRUE
         EXIT SECTION
     END-IF

**  ---> erst noch Source-SubVol (in SVOL_SOURCE) und destination SVOL holen
**       1. Schritt: TSRC nach PSRC mit rollover
     MOVE "R2P-SRC" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> Vorbereitung kopieren Source aus SubVol TSRC in PSRC-Subvol
     PERFORM D310-COPY-ROLLOVER
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> Eintrag mit Versionsbezeichnung im Source suchen
**       und in Tabelle WVERSION Eintrag erzeugen
     IF  SOURCE-TYP OF SSAFE not = "CM"
         MOVE SOURCE-FILE TO ASS-FNAME
         PERFORM D330-WVERSION
         IF  PRG-ABBRUCH or SOURCEF-NOK
             EXIT SECTION
         END-IF
     END-IF

**  ---> dann run/mod-SubVol (in SVOL_SOURCE) und destination run SVOL holen
**       2. Schritt: TRUN nach PRUN bzw. TMOD nach PMOD (Version A.01.40)
     IF  SOURCE-TYP OF SSAFE = "CM"
         MOVE "R2P-MOD" TO AKTION OF SSPARM
     ELSE
         MOVE "R2P-RUN" TO AKTION OF SSPARM
     END-IF
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> kopieren aus Entw. nach Test Appl. bzw. Rollover(Version A.01.40)
     IF  SOURCE-TYP OF SSAFE = "CM"
         PERFORM D310-COPY-ROLLOVER
         IF  PRG-ABBRUCH
             EXIT SECTION
         END-IF
     ELSE
         PERFORM D320-COPY-OBJECT
         IF  PRG-ABBRUCH or T-ERROR not = ZERO
             set ssf-eod to true
             EXIT SECTION
         END-IF
     END-IF

**  ---> Vorbereitung kopieren Object aus Test nach Prod. Appl.
*     PERFORM D320-COPY-OBJECT
*     IF  PRG-ABBRUCH  or  T-ERROR not = ZERO
*         EXIT SECTION
*     END-IF

**  ---> und noch security auf "NNNN"
     ADD 1 TO FUP-COMMANDS-ANZ
     STRING  " SECURE "      DELIMITED BY SIZE
             DEST-FILE       DELIMITED BY SPACE
             ", ""NNNN"""    DELIMITED BY SIZE
       INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-STRING

**  ---> Eintrag in Tabelle SSAFE
     MOVE W-SOURCE    TO SOURCE-MODUL  OF SSAFE
     MOVE "PR"        TO FREIGABE-PROD OF SSAFE
     MOVE P-USER-NAME TO GROUP-USER    OF SSAFE

**  ---> SQL Operationen in Transaktion
     PERFORM U100-BEGIN

     IF  SOURCEF-FOUND
         IF  SOURCE-TYP OF SSAFE not = "CM"
             PERFORM S400-INSERT-WVERSION
             IF  PRG-ABBRUCH
                 PERFORM U120-ROLLBACK
                 EXIT SECTION
             END-IF
         END-IF
     END-IF

     PERFORM S122-UPDATE-SSAFE-REL2PROD
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF

**  ---> Eintrag in Protokolltabelle SSPROT
     MOVE W-SOURCE    TO SOURCE-MODUL OF SSPROT
     MOVE "FR"        TO AKTION       OF SSPROT
     MOVE "PR"        TO KZ-FREIGABE  OF SSPROT
     MOVE P-USER-NAME TO GROUP-USER   OF SSPROT
     PERFORM S200-INSERT-SSPROT
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF
     PERFORM U110-COMMIT

**  ---> Obey Datei füllen und FUP ausführen
     PERFORM E150-OBEY-FUP

**  ---> Bestätigung an den User
     IF  PRG-OK
         IF  SOURCE-TYP OF SSAFE = "CM"
             MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
             MOVE "HINW-008" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             EXIT SECTION
         ELSE
             MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
             MOVE "HINW-009" TO KATEGORIE OF SSTEXT
             STRING "        GETPROG "                 delimited by size
                    W-PROG-OBJECT                      delimited by space
                    " "                                delimited by size
                    W-PROG-VERSION                     delimited by space
                    " aus der Produktionsapplikation " delimited by size
               INTO  W-TEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT

**          ---> ggf. Hinweis geben, dass Einträge in der Tabelle =NAMEDPRC
**               erforderlich sind. Dafür Modul (in SVOL_SOURCE) aus SSPARM
**               holen, Es darf nur ein Eintrag vorhanden sein !!!
             MOVE "NAMEDPRC" TO AKTION OF SSPARM
             PERFORM S300-SELECT-SSPARM
             IF  NOT SSPRM-OK
                 EXIT SECTION
             END-IF

**          ---> dann in der Referenztabelle =PROGRAMX suchen
             MOVE W-SOURCE              TO PROGRAMM OF PROGRAMX
             MOVE SVOL-SOURCE OF SSPARM TO PMODUL   OF PROGRAMX
             PERFORM S825-SELECT-PROGRAMX
             IF  REF-TABS-OK
**              ---> Eintrag gefunden, also Hinweis zeigen
                 MOVE "HINWEIS" TO BEREICH   OF SSTEXT
                 MOVE "OK-008"  TO KATEGORIE OF SSTEXT
**              ---> anzeigen Hilfstext
                 PERFORM R100-SHOW-TEXT
             END-IF
         END-IF
     END-IF
     .
 C300-99.
     EXIT.

******************************************************************
* Release nach Test
******************************************************************
 C310-REL2TEST SECTION.
 C310-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-REL2TEST
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> zunächstmal ein bisschen initialisieren
     INITIALIZE FUP-COMMANDS
     MOVE ZERO TO FUP-COMMANDS-ANZ
     IF  FUP-COMMANDS-ANZ = ZERO
         ADD 1 TO FUP-COMMANDS-ANZ
         MOVE "ALLOW 10 ERRORS, 10 WARNINGS" TO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-IF

     IF  FKT-STARTUP-ABFRAGE or FKT-EINGABE
**      ---> nur Kommando eingegeben, also holen Source-Modul Name
         SET EIN-ASCII
             PROMPT-SOURCE TO TRUE
         PERFORM U000-EINGABE
         IF  EINGABE = "E" OR = SPACE
             EXIT SECTION
         END-IF
         MOVE ZERO TO C4-ANZ
         MOVE 1    TO C4-PTR
         PERFORM N035-CHECK-EINGABE
         IF  CHECK-NOK
             GO TO C310-00
         END-IF
     END-IF

**  ---> dann überprüfen, ob das Source überhaupt eingecheckt ist
     MOVE W-SOURCE TO SOURCE-MODUL OF SSAFE
     PERFORM S100-SELECT-SSAFE
**  ---> Abfragen, ob Fehler
     IF  SSF-EOD OR PRG-ABBRUCH
         PERFORM D000-ALLE-FEHL-006
         EXIT SECTION
     END-IF

     IF  SOURCE-STATUS not = "CI"
**      ---> Fehler: Source nicht eingecheckt
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-016" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> erst noch Source-SubVol (in SVOL_SOURCE) und destination SVOL holen
**       1. Schritt: WSRC nach SSRC mit rollover
     MOVE "R2T-WSS" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> kopieren aus Übergangs-SubVol in SSF-Subvol
     PERFORM D310-COPY-ROLLOVER
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> dann Source-SubVol (in SVOL_SOURCE) und destination SVOL holen
**       2. Schritt: WSRC nach TSRC mit rollover
     MOVE "R2T-SST" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> kopieren aus Übergangs-SubVol in Source-Subvol
     PERFORM D310-COPY-ROLLOVER
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> dann run/mod-SubVol (in SVOL_SOURCE) und destination run SVOL holen
**       3. Schritt: ERUN nach TRUN bzw. EMOD nach TMOD (Version A.01.40)
     IF  SOURCE-TYP OF SSAFE = "CM"
         MOVE "R2T-MOD" TO AKTION OF SSPARM
     ELSE
         MOVE "R2T-RUN" TO AKTION OF SSPARM
     END-IF
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> kopieren aus Entw. nach Test Appl. bzw. Rollover(Version A.01.40)
     IF  SOURCE-TYP OF SSAFE = "CM"
         PERFORM D310-COPY-ROLLOVER
         IF  PRG-ABBRUCH
             EXIT SECTION
         END-IF
     ELSE
         PERFORM D320-COPY-OBJECT
         IF  PRG-ABBRUCH or T-ERROR not = ZERO
             set ssf-eod to true
             EXIT SECTION
         END-IF
     END-IF

**  ---> und noch security auf "CCCC"
     ADD 1 TO FUP-COMMANDS-ANZ
     STRING  " SECURE "      DELIMITED BY SIZE
             DEST-FILE       DELIMITED BY SPACE
             ", ""CCCC"""    DELIMITED BY SIZE
       INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-STRING

**  ---> Eintrag in Tabelle SSAFE
     MOVE W-SOURCE    TO SOURCE-MODUL  OF SSAFE
     MOVE "TR"        TO FREIGABE-TEST OF SSAFE
     MOVE P-USER-NAME TO GROUP-USER    OF SSAFE

     PERFORM U100-BEGIN
     PERFORM S121-UPDATE-SSAFE-REL2TEST
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF

**  ---> Eintrag in Protokolltabelle SSPROT
     MOVE W-SOURCE    TO SOURCE-MODUL OF SSPROT
     MOVE "FR"        TO AKTION       OF SSPROT
     MOVE "TR"        TO KZ-FREIGABE  OF SSPROT
     MOVE P-USER-NAME TO GROUP-USER   OF SSPROT
     PERFORM S200-INSERT-SSPROT
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF
     PERFORM U110-COMMIT

**  ---> Obey Datei füllen und FUP ausführen
     PERFORM E150-OBEY-FUP

**  ---> ggf. Referenzliste
     IF  not (SSF-EOD OR PRG-ABBRUCH)
         PERFORM C410-PRGNEU
     END-IF

**  ---> Eintrag in Tabelle =ABNAHME erzeugen
     IF  not (SSF-EOD OR PRG-ABBRUCH)
         PERFORM D700-CREATE-ABNAHME
     END-IF

**  ---> Bestätigung an den User
     IF  PRG-OK
         MOVE "HINWEIS"      TO BEREICH   OF SSTEXT
         IF  SOURCE-TYP OF SSAFE = "CM"
             MOVE "HINW-002" TO KATEGORIE OF SSTEXT
         ELSE
             MOVE "HINW-015" TO KATEGORIE OF SSTEXT
         END-IF
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
     END-IF
     .
 C310-99.
     EXIT.

******************************************************************
* Sichern Source in den SourceSafe Bereich
******************************************************************
 C320-SAVE SECTION.
 C320-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-SAVE
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> zunächstmal ein bisschen initialisieren
     INITIALIZE FUP-COMMANDS
     MOVE ZERO   TO FUP-COMMANDS-ANZ
     IF  FUP-COMMANDS-ANZ = ZERO
         ADD 1 TO FUP-COMMANDS-ANZ
         MOVE "ALLOW 10 ERRORS, 10 WARNINGS" TO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-IF

     IF  FKT-STARTUP-ABFRAGE or FKT-EINGABE
**      ---> nur Kommando eingegeben, also holen Source-Modul Name
         SET EIN-ASCII
             PROMPT-SOURCE TO TRUE
         PERFORM U000-EINGABE
         IF  EINGABE = "E" OR = SPACE
             EXIT SECTION
         END-IF
         MOVE ZERO TO C4-ANZ
         MOVE 1    TO C4-PTR
         PERFORM N035-CHECK-EINGABE
         IF  CHECK-NOK
             GO TO C320-00
         END-IF
     END-IF

**  ---> dann überprüfen, ob das Source überhaupt eingecheckt ist
     MOVE W-SOURCE TO SOURCE-MODUL OF SSAFE
     PERFORM S100-SELECT-SSAFE
**  ---> Abfragen, ob Fehler
     IF  SSF-EOD OR PRG-ABBRUCH
         PERFORM D000-ALLE-FEHL-006
         EXIT SECTION
     END-IF

     IF  SOURCE-STATUS not = "CI"
**      ---> Fehler: Source nicht eingecheckt
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-016" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> erst noch Source-SubVol (in SVOL_SOURCE) und destination SVOL holen
**       1. Schritt: WSRC nach SSRC mit rollover
     MOVE "SAVE-WSS" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> kopieren aus Übergangs-SubVol in SSF-Subvol
     PERFORM D310-COPY-ROLLOVER
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> ggf. noch Source-SubVol (in SVOL_SOURCE) und destination SVOL holen
**       wenn Source eine LIB ist
**       2. Schritt: WSRC nach SSRC mit rollover
     IF  SOURCE-TYP of SSAFE  = "CL"
         MOVE "SAVE-LIB" TO AKTION OF SSPARM
         PERFORM S300-SELECT-SSPARM
         IF  NOT SSPRM-OK
             EXIT SECTION
         END-IF

**      ---> kopieren aus Übergangs-SubVol in SSF-Subvol
         PERFORM D310-COPY-ROLLOVER
         IF  PRG-ABBRUCH
             EXIT SECTION
         END-IF
     END-IF

**  ---> Eintrag in Tabelle SSAFE
     MOVE W-SOURCE    TO SOURCE-MODUL  OF SSAFE
     MOVE "SA"        TO FREIGABE-TEST OF SSAFE
     MOVE P-USER-NAME TO GROUP-USER    OF SSAFE

     PERFORM U100-BEGIN
     PERFORM S121-UPDATE-SSAFE-REL2TEST
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF

**  ---> Eintrag in Protokolltabelle SSPROT
     MOVE W-SOURCE    TO SOURCE-MODUL OF SSPROT
     MOVE "SA"        TO AKTION       OF SSPROT
     MOVE "SA"        TO KZ-FREIGABE  OF SSPROT
     MOVE P-USER-NAME TO GROUP-USER   OF SSPROT
     PERFORM S200-INSERT-SSPROT
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF
     PERFORM U110-COMMIT

**  ---> Obey Datei füllen und FUP ausführen
     PERFORM E150-OBEY-FUP

**  ---> Bestätigung an den User
     IF  PRG-OK
         MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
         MOVE "HINW-016" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
     END-IF
     .
 C320-99.
     EXIT.

******************************************************************
* Freigabemail an WEAT schicken
******************************************************************
 C340-REL4WEAT SECTION.
 C340-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-REL4WEAT
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

     IF  FKT-STARTUP-ABFRAGE or FKT-EINGABE
**      ---> nur Kommando eingegeben, also holen Source-Modul Name
         SET EIN-ASCII
             PROMPT-SOURCE TO TRUE
         PERFORM U000-EINGABE
         IF  EINGABE = "E" OR = SPACE
             EXIT SECTION
         END-IF
         MOVE ZERO TO C4-ANZ
         MOVE 1    TO C4-PTR
         PERFORM N035-CHECK-EINGABE
         IF  CHECK-NOK
             GO TO C340-00
         END-IF
     END-IF

**  ---> Modul-Status muss ACTIVTST sein
**  ---> dann überprüfen, ob das Source überhaupt eingecheckt ist
     MOVE W-SOURCE TO SOURCE-MODUL OF SSAFE
     PERFORM S100-SELECT-SSAFE
**  ---> Abfragen, ob Fehler
     IF  SSF-EOD OR PRG-ABBRUCH
         PERFORM D000-ALLE-FEHL-006
         EXIT SECTION
     END-IF

     IF  FREIGABE-TEST not = "TA"
**      ---> Fehler: Source nicht eingecheckt
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-037" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> User darf nicht der User sein, der R2T durchgeführt hat
**  --->     max(zpins) mit KZ_FREIGABE="TR"
**  ---> also erstmal den max.ZPINS holen
     MOVE W-SOURCE TO SOURCE-MODUL OF SSPROT
     MOVE "TR"     TO KZ-FREIGABE  OF SSPROT
     PERFORM S220-SELECT-SSPROT-MAX
     IF  SSPROT-EOD
         EXIT SECTION
     END-IF
**  ---> dann restliche Info's holen
     MOVE W-SOURCE TO SOURCE-MODUL OF SSPROT
     PERFORM S222-SELECT-SSPROT-ALL
     IF  SSPROT-EOD
         EXIT SECTION
     END-IF

**  ---> prüfen, ob WD.user nicht = aktueller User ist
**  --->   und zwar ohne die Gruppe  W-USER-NAME
**  ---> (Rolle VERWALTER darf alles)
*     IF  NOT ROLFKT-VERW
**      ---> für den Vergleich Gruppe aus GROUP-USER entfernen
         MOVE ZERO TO C4-I1
         INSPECT GROUP-USER OF SSPROT TALLYING C4-I1
             FOR CHARACTERS BEFORE INITIAL "."

         IF  GROUP-USER OF SSPROT (C4-I1 + 2:) = W-USER-NAME
**          ---> Fehler: Controller darf nicht = Entwickler
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-038" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             EXIT SECTION
         END-IF
*     END-IF

**  ---> holen erforderliche Infos aus Referenztabelle =PROGRAMS
     MOVE W-SOURCE TO PROGRAMM OF PROGRAMS
     PERFORM S840-SELECT-PROGRAMS

**  ---> jetzt die erforderlichen Updates auf die Tabelle ABNAHME vorbereiten
**  ---> Eingaben prompten
     IF  REL4WEAT-FIRST
         PERFORM D340-ABNAHME-WERTE
         SET REL4WEAT-FOLLOWED TO TRUE
     END-IF

**  ---> Transaktion beginnen
     PERFORM U100-BEGIN

**  ---> Update auf Tabelle ABNAHME mit freigabe_antrag_von /_am
     MOVE W-SOURCE TO IN-SOURCE
     PERFORM U400-OBJECT-NAME
     MOVE OUT-SOURCE             TO PRG-NAME OF ABNAHME
     MOVE VERSION OF PROGRAMS    TO VERSION  OF ABNAHME
     MOVE P-USER-NAME TO FREIGABE-ANTRAG-VON OF ABNAHME
     PERFORM S712-UPDATE-ABNAHME-WE2

**  ---> Transaktion abschliessen
     IF  PRG-OK
         PERFORM U110-COMMIT
     ELSE
         PERFORM U120-ROLLBACK
         exit section
     END-IF

**  ---> Mail aufbereiten und versenden
     PERFORM M510-MAIL-ABNAHMEANTRAG
     IF  REF-TABS-NOK
         EXIT SECTION
     END-IF

**  ---> Eintrag in Protokolltabelle SSPROT
     PERFORM U100-BEGIN
     MOVE W-SOURCE    TO SOURCE-MODUL OF SSPROT
     MOVE "FR"        TO AKTION       OF SSPROT
     MOVE "FA"        TO KZ-FREIGABE  OF SSPROT
     MOVE P-USER-NAME TO GROUP-USER   OF SSPROT
     PERFORM S200-INSERT-SSPROT
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF
     PERFORM U110-COMMIT

**  ---> Abfrage, ob mit eingegebenen Werten für =ABNAHME weiter
**  ---> gearbeitet werden soll
     MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
     MOVE "HINW-018" TO KATEGORIE OF SSTEXT
     PERFORM R100-SHOW-TEXT
     SET EIN-ASCII
         PROMPT-FORTFAHREN TO TRUE
     PERFORM U000-EINGABE
     IF  EINGABE (1:C4-INLEN) = "J"
         SET FKT-EINGABE TO TRUE
         DISPLAY " "
         GO TO C340-00
     END-IF
     .
 C340-99.
     EXIT.

******************************************************************
* aktivieren in Test
******************************************************************
 C360-ACTIVTEST SECTION.
 C360-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-ACTIVTST
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> zunächstmal ein bisschen initialisieren
     INITIALIZE FUP-COMMANDS

     IF  FKT-STARTUP-ABFRAGE or FKT-EINGABE
**      ---> nur Kommando eingegeben, also holen Source-Modul Name
         SET EIN-ASCII
             PROMPT-SOURCE TO TRUE
         PERFORM U000-EINGABE
         IF  EINGABE = "E" OR = SPACE
             EXIT SECTION
         END-IF
         MOVE ZERO TO C4-ANZ
         MOVE 1    TO C4-PTR
         PERFORM N035-CHECK-EINGABE
         IF  CHECK-NOK
             GO TO C360-00
         END-IF
**      ---> prüfen, ob Parameter eingegeben wurden
         MOVE 2 TO C4-I1
         PERFORM D360-ACTIVTEST-PARM
     ELSE
**      ---> prüfen, ob Parameter eingegeben wurden
         MOVE 3 TO C4-I1
         PERFORM D360-ACTIVTEST-PARM
     END-IF

**  ---> holen SSAFE Eintrag
     MOVE W-SOURCE TO SOURCE-MODUL OF SSAFE
     PERFORM S100-SELECT-SSAFE
**  ---> Abfragen, ob Fehler
     IF  SSF-EOD OR PRG-ABBRUCH
         PERFORM D000-ALLE-FEHL-006
         EXIT SECTION
     END-IF

**  ---> dann überprüfen, ob das Source überhaupt eingecheckt ist
     IF  SOURCE-STATUS of SSAFE not = "CI"
**      ---> Fehler: Source nicht eingecheckt
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-016" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF
**  ---> dann überprüfen, ob Freigabe erteilt wurde
     IF  FREIGABE-TEST of SSAFE not = "TR"
**      ---> Fehler: Source nicht freigegeben
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-017" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> erst noch Source-SubVol (in SVOL_SOURCE) und destination SVOL holen
     MOVE "ACTIVTST" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> SourcN-file-name in einem Feld aufbereiten
     MOVE SPACES TO SOURCE-FILE
     STRING  SOURCE-FILE-VOL         DELIMITED BY SPACE
             "."                     DELIMITED BY SIZE
             SVOL-DEST OF SSPARM     DELIMITED BY SPACE
             "."                     DELIMITED BY SIZE
             SOURCE-FILE-NAME        DELIMITED BY SPACE
       INTO  SOURCE-FILE
     END-STRING

**  ---> "E" durch "N" ersetzen
     MOVE ZERO TO C4-I1
     INSPECT SOURCE-FILE TALLYING C4-I1
         FOR CHARACTERS BEFORE INITIAL " "
     MOVE "N" TO SOURCE-FILE (C4-I1:1)

**  ---> prüfen, ob Objekt-neu (sourcN) existiert
     MOVE SOURCE-FILE TO T-FNAME
     PERFORM E120-FILE-INFO
     IF  T-ERROR NOT = ZERO
**      ---> Fehler: Objekt (sourcN) nicht vorhanden
         MOVE SPACE TO W-TEXT
         STRING "!!! "       DELIMITED BY SIZE
                SOURCE-FILE  DELIMITED BY SPACE
           INTO W-TEXT
         END-STRING
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-028" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> prüfen, ob Objekt-akt (sourcS/O/ ) existiert
**  ---> Destination File-Name zusammenbasteln
     MOVE SOURCE-FILE-VOL     TO DEST-FILE-VOL
     MOVE SVOL-DEST OF SSPARM TO DEST-FILE-SUBVOL
     MOVE SOURCE-FILE-NAME    TO DEST-FILE-NAME

**  ---> "E" durch "S/O/ " ersetzen
     MOVE DEST-FILE-NAME TO IN-SOURCE
     PERFORM U400-OBJECT-NAME
     MOVE OUT-SOURCE TO DEST-FILE-NAME

**  ---> Zieldatei festlegen  (zB: $WSOFT.TRUN.prgname)
     MOVE SPACES TO DEST-FILE
     STRING  DEST-FILE-VOL       DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-SUBVOL    DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-NAME      DELIMITED BY SPACE
       INTO  DEST-FILE
     END-STRING

**  ---> Sicherungsversion des DEST-FILE zusammenstellen (zB: $WSOFT.TRUNOLD.prgname)
     MOVE SPACES TO DEST-FILE-ALT
     STRING  DEST-FILE-VOL       DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             SVOL-SOURCE OF SSPARM   DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-NAME      DELIMITED BY SPACE
       INTO  DEST-FILE-ALT
     END-STRING

**  ---> nachsehen, ob das DEST-File-alt (TRUNOLD) ein Open-Flag hat
     MOVE AP-DNAME      TO AP-DNAME-ZW
     MOVE DEST-FILE-ALT TO AP-DNAME
     SET AP-DELAY-OFF   TO TRUE
     PERFORM W200-OPENINFO
     MOVE AP-DNAME-ZW   TO AP-DNAME
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF
     IF  AP-STATUS = ZERO
**      ---> Fehler: Altes Objekt mit OPEN
         MOVE SPACE TO W-TEXT
         STRING "!!!            " DELIMITED BY SIZE
                DEST-FILE-ALT     DELIMITED BY SPACE
           INTO W-TEXT
         END-STRING
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-031" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> FUP-Kommandos zusammenstellen
     MOVE ZERO TO FUP-COMMANDS-ANZ
     IF  FUP-COMMANDS-ANZ = ZERO
         ADD 1 TO FUP-COMMANDS-ANZ
         MOVE "ALLOW 10 ERRORS, 10 WARNINGS" TO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-IF

**  ---> prüfen, ob gesicherte DEST-DATEI vorhanden
     MOVE DEST-FILE-ALT TO T-FNAME
     PERFORM E120-FILE-INFO
     IF  T-ERROR = ZERO
**      ---> Datei vorhanden, muss also gelöscht werden
         ADD 1 TO FUP-COMMANDS-ANZ
         STRING  " PURGE ! "         DELIMITED BY SIZE
                 DEST-FILE-ALT       DELIMITED BY SPACE
           INTO  FUP-COMMAND (FUP-COMMANDS-ANZ)
         END-STRING
     END-IF

**  ---> prüfen, ob alte DEST-DATEI vorhanden
     MOVE DEST-FILE TO T-FNAME
     PERFORM E120-FILE-INFO
     IF  T-ERROR = ZERO
**      ---> Datei vorhanden, muss also gesichert werden
         ADD 1 TO FUP-COMMANDS-ANZ
         STRING  " RENAME "          DELIMITED BY SIZE
                 DEST-FILE           DELIMITED BY SPACE
                 ", "                DELIMITED BY SIZE
                 DEST-FILE-ALT       DELIMITED BY SPACE
           INTO  FUP-COMMAND (FUP-COMMANDS-ANZ)
         END-STRING
     END-IF

**  ---> rename SOURCE-FILE nach DEST-FILE
     ADD 1 TO FUP-COMMANDS-ANZ
     STRING  " RENAME "          DELIMITED BY SIZE
             SOURCE-FILE         DELIMITED BY SPACE
             ", "                DELIMITED BY SIZE
             DEST-FILE           DELIMITED BY SPACE
       INTO  FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-STRING

**  ---> Eintrag in Tabelle SSAFE
     MOVE W-SOURCE    TO SOURCE-MODUL  OF SSAFE
     MOVE "TA"        TO FREIGABE-TEST OF SSAFE
     MOVE P-USER-NAME TO GROUP-USER    OF SSAFE

     PERFORM U100-BEGIN
     PERFORM S121-UPDATE-SSAFE-REL2TEST
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF

**  ---> Eintrag in Protokolltabelle SSPROT
     MOVE W-SOURCE    TO SOURCE-MODUL OF SSPROT
     MOVE "AK"        TO AKTION       OF SSPROT
     MOVE "TA"        TO KZ-FREIGABE  OF SSPROT
     MOVE P-USER-NAME TO GROUP-USER   OF SSPROT
     PERFORM S200-INSERT-SSPROT
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF
     PERFORM U110-COMMIT

**  ---> Obey Datei füllen und FUP ausführen
     PERFORM E150-OBEY-FUP

     IF  AXL-AXL
**      ---> DEST-File Accellerieren
         PERFORM E310-AXCEL
         IF  PRG-ABBRUCH
             EXIT SECTION
         END-IF
     END-IF

     IF  SQL-SQL
**      ---> DEST-File SQL-Compilieren
         PERFORM E320-SQL
         IF  PRG-ABBRUCH
             EXIT SECTION
         END-IF
     END-IF

**  ---> Tabelle =ABNAHME vervollständigen
     PERFORM D710-UPDATE-ABNAHME-AT

**  ---> Ende Tx und Bestätigung an den User
     IF  PRG-OK
         MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
         MOVE "HINW-012" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT

**      ---> Hinweis an den User
         IF  SOURCE-TYP OF SSAFE = "CS"
             MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
             MOVE "HINW-006" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
         END-IF
     END-IF
     .
 C360-99.
     EXIT.

******************************************************************
* Stoppen alle anderen SourceSafe-Prozesse
******************************************************************
 C400-STOP SECTION.
 C400-00.
**  ---> suchen Prozesse für den SourceSafe
     MOVE ZERO TO ST-SEARCH-INDEX
                  ST-FEHL
                  C4-ANZ-PROC

**  ---> Schleife über alle Prozesse
     PERFORM UNTIL ST-FEHL = 8
**      --> holen Process-handle
         ENTER TAL "PROCESS_GETPAIRINFO_"
                    USING OMITTED
                          ST-PROC-PAIR (1:ST-PROC-PAIR-LEN47)
                          ST-PROC-PAIR-LEN
                          ST-PRIM-PROC-HANDLE
                          OMITTED
                          ST-SEARCH-INDEXO
                   GIVING ST-FEHL
**      ---> holen Programmdateinamen zu dem Process-handle
         ENTER TAL "PROCESS_GETINFO_"
                    USING ST-PRIM-PROC-HANDLE
                          OMITTED OMITTED OMITTED OMITTED
                          ST-HOMETERM (1:ST-HOMETERM-MAX)
                          ST-HOMETERM-LEN
**                          OMITTED OMITTED
                          OMITTED OMITTED
                          OMITTED OMITTED OMITTED
                          ST-PROG-FNAME (1:ST-PROG-FNAME-LEN47)
                          ST-PROG-FNAME-LEN
                   GIVING ST-RETCODE
**      ---> holen Process-Namen zu dem Process-handle
         ENTER TAL "PROCESSHANDLE_DECOMPOSE_"
                    USING ST-PRIM-PROC-HANDLE
                          OMITTED OMITTED OMITTED
                          OMITTED OMITTED
                          ST-PROC-FNAME (1:ST-PROC-FNAME-LEN47)
                          ST-PROC-FNAME-LEN
                   GIVING ST-RETCODE

**      ---> prüfen, ob SourceSafe gefunden
         IF  ST-PROG-FNAME (1:ST-PROG-FNAME-LEN) = W-MY-PROG-FNAME
**          ---> wenn nicht mein HomeTerminal kann der Prozess gestoppt werden
             IF  ST-HOMETERM (1:ST-HOMETERM-LEN) not = W-MY-HOMETERM
                 ENTER TAL "PROCESS_STOP_"
                           USING ST-PRIM-PROC-HANDLE
                                 OMITTED
                                 ST-OPTION-ABEND
                 ADD 1 TO C4-ANZ-PROC
             END-IF
         END-IF
     END-PERFORM

     MOVE C4-ANZ-PROC TO D-NUM4
     DISPLAY " "
     DISPLAY " Anzahl gestoppte Prozesse: " D-NUM4
     DISPLAY " "
     .
 C400-99.
     EXIT.

******************************************************************
* Referenztabellen über Prozedur PRGNEU einfügen/ändern
******************************************************************
 C410-PRGNEU SECTION.
 C410-00.
**  ---> zunächstmal ein bisschen initialisieren
     INITIALIZE FUP-COMMANDS

     IF  NOT CMD-REL2TEST
         IF  FKT-STARTUP-ABFRAGE or FKT-EINGABE
**          ---> nur Kommando eingegeben, also holen Source-Modul Name
             SET EIN-ASCII
                 PROMPT-SOURCE TO TRUE
             PERFORM U000-EINGABE
             IF  EINGABE = "E" OR = SPACE
                 EXIT SECTION
             END-IF
             MOVE ZERO TO C4-ANZ
             MOVE 1    TO C4-PTR
             PERFORM N035-CHECK-EINGABE
             IF  CHECK-NOK
                 GO TO C410-00
             END-IF
         END-IF
     END-IF

**  ---> holen SSAFE-Eintrag
     MOVE W-SOURCE TO SOURCE-MODUL OF SSAFE
     PERFORM S100-SELECT-SSAFE
**  ---> Abfragen, ob Fehler
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     IF  SSF-OK
**      ---> dann überprüfen, ob das Source überhaupt eingecheckt ist
         IF  SOURCE-STATUS not = "CI"
**          ---> Fehler: Source nicht eingecheckt
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-016" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             EXIT SECTION
         END-IF
**      ---> dann überprüfen, ob das Programm für TEST released ist
         IF  not (FREIGABE-TEST = "TR" or = "TA")
**          ---> Fehler: Source nicht freigegeben für TEST
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-013" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             EXIT SECTION
         END-IF
     ELSE
**      ---> Fehler: Source nicht gefunden
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-001" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> erst noch Destination-SubVol (in SVOL_DEST) SVOL holen
     MOVE "R2T-SST" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> Eingabe File-Name zusammenbasteln
     MOVE SPACES TO DEST-FILE
     MOVE SOURCE-FILE-VOL       TO DEST-FILE-VOL
     MOVE SVOL-SOURCE OF SSPARM TO DEST-FILE-SUBVOL
     MOVE SOURCE-FILE-NAME      TO DEST-FILE-NAME
     STRING  DEST-FILE-VOL    DELIMITED BY SPACE
             "."              DELIMITED BY SIZE
             DEST-FILE-SUBVOL DELIMITED BY SPACE
             "."              DELIMITED BY SIZE
             DEST-FILE-NAME   DELIMITED BY SPACE
       INTO  DEST-FILE
     END-STRING

**  ---> Geduld-Hinweis an User
     MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
     MOVE "HINW-004" TO KATEGORIE OF SSTEXT
     PERFORM R100-SHOW-TEXT

**  ---> nachsehen, ob das Sourcefile kein Open-Flag hat
     MOVE AP-DNAME TO AP-DNAME-ZW
     MOVE DEST-FILE TO AP-DNAME
     PERFORM W200-OPENINFO
     MOVE AP-DNAME-ZW TO AP-DNAME
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> Einträge für Referenzlisten im Source suchen
**       und in Tabellen PROGRAMS, PROGRAMX,
**       einstellen
     MOVE DEST-FILE TO ASS-FNAME
     PERFORM D410-REFERENZEN
     IF  PRG-ABBRUCH or SOURCEF-NOK
         EXIT SECTION
     END-IF
     .
 C410-99.
     EXIT.

******************************************************************
* Verwaltung (zunächst nur User-Verwaltung)
******************************************************************
 C420-VERWALTUNG section.
 C420-00.
     IF  NOT ROLFKT-VERW
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Fehler- und Hilfstexte
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

     PERFORM UNTIL CMD-EXIT
             OR    PRG-ABBRUCH

         PERFORM U011-AUSGABE-SPACELINE
         SET FKT-EINGABE TO TRUE
         SET EIN-ASCII
             PROMPT-VERW TO TRUE
         PERFORM U000-EINGABE

**  ---> Eingabe-String vereinzeln
         MOVE ZERO TO C4-ANZ
         MOVE 1    TO C4-PTR
         PERFORM N030-CHECK-STARTUP
         IF  CHECK-NOK
             GO TO C420-00
         END-IF

**  ---> Verzweigung je nach Eingabe
         EVALUATE TRUE
*             WHEN CMD-EXIT       EXIT SECTION
             WHEN CMD-HELP       PERFORM H420-HELP
             WHEN CMD-DEL        PERFORM D420-DELETE-USER
             WHEN CMD-LIST       PERFORM D430-LIST-ALL-USER
             WHEN CMD-NEW        PERFORM D440-INSERT-USER
             WHEN CMD-ROLLEN     PERFORM D450-LIST-ROL-FKT
         END-EVALUATE
     END-PERFORM
     .
 C420-99.
     EXIT.

******************************************************************
* Kontrolle, ob Notfallübername noch überprüft werden muss
*    dazu Tabelle =ABNAHME scannen, ob ABNAHME.NK_STATUS = "NO"
*    dann Prg-Name, Version, Datum, rel2prod_von und rel2prod_am anzeigen,
*    Auswahl treffen lassen nach Prg-Name und Version
*    dann Mail "Aufhebung der Sicherheitswarung" erstellen
******************************************************************
 C500-EMERGENCY-CONTROL SECTION.
 C500-00.
**  ---> Berechtigung prüfen
     IF  NOT ROLFKT-REL2PROD
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-025" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> Anzeigen noch offene Sicherheitswarnungen
**  ---> dafür lesen Tabelle ABNAHME mit NK_STATUS = "NO"
     MOVE ALL "%" TO PRG-NAME  OF ABNAHME
     MOVE ALL "%" TO VERSION   OF ABNAHME
     MOVE "NO"    TO NK-STATUS OF ABNAHME
     PERFORM S750-OPEN-ABNAHME-S-CURSOR
     PERFORM S751-FETCH-ABNAHME-S-CURSOR

**  ---> wenn kein Eintrag vorhanden Mitteilung und Exit
     IF  DYNCURS-EOD
         MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
         MOVE "HINW-019" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         PERFORM S752-CLOSE-ABNAHME-S-CURSOR
         EXIT SECTION
     END-IF

**  ---> Schleife über alle Einträge
     PERFORM UNTIL DYNCURS-EOD
                OR PRG-ABBRUCH

**      ---> ggf. Überschrift
         IF  C9-COUNT = 1
**          ---> Überschrift zeigen
             PERFORM U011-AUSGABE-SPACELINE
             MOVE NK-UEBERSCHRIFT TO ZEILE
             PERFORM U010-AUSGABE
             MOVE NK-STRICHE TO ZEILE
             PERFORM U010-AUSGABE
         END-IF

**      ---> Anzeigen offenen Eintrag
         MOVE PRG-NAME     OF ABNAHME TO NKD-PRG-NAME
         MOVE VERSION      OF ABNAHME TO NKD-VERSION
         MOVE DATUM        OF ABNAHME TO NKD-DATUM
         MOVE REL2TEST-VON OF ABNAHME TO NKD-REL2TEST-VON
         MOVE REL2PROD-AM  OF ABNAHME TO NKD-REL2PROD-AM
         MOVE NK-DATEN TO ZEILE
         PERFORM U010-AUSGABE

**      ---> lesen nächsten Eintrag
         PERFORM S751-FETCH-ABNAHME-S-CURSOR

     END-PERFORM

**  ---> schliessen Cursor
     PERFORM S752-CLOSE-ABNAHME-S-CURSOR

**  ---> zeigen Hinweis was zu tun ist
     MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
     MOVE "HINW-020" TO KATEGORIE OF SSTEXT
**  ---> anzeigen Hilfstext
     PERFORM R100-SHOW-TEXT

**  ---> nun nach Object prompten
     SET DYNCURS-OK TO TRUE
     PERFORM UNTIL EINGABE = "E" OR = SPACE
         PERFORM D500-AUSWAHL-OBJECT
     END-PERFORM
     IF  PRG-ENDE
         SET PRG-OK TO TRUE
         EXIT SECTION
     END-IF

**  ---> prüfen, ob User diese Kontrolle überhaupt durchführen darf
     MOVE ZERO TO C4-I1
     INSPECT REL2TEST-VON OF ABNAHME TALLYING C4-I1
         FOR CHARACTERS BEFORE INITIAL "."

     IF  REL2TEST-VON OF ABNAHME (C4-I1 + 2:) = W-USER-NAME
**      ---> Fehler: Controller darf nicht = Entwickler sein
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-038" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> Update auf ABNAHME
     MOVE "OK"            TO NK-STATUS OF ABNAHME
     MOVE W-USER-GRP-NAME TO NK-VON    OF ABNAHME
     PERFORM U100-BEGIN
     PERFORM S716-UPDATE-ABNAHME-WE4
     IF  PRG-ABBRUCH
         PERFORM U120-ROLLBACK
         EXIT SECTION
     END-IF
     PERFORM U110-COMMIT

**  ---> Mail erstellen und versenden
     PERFORM M500-MAIL-AUFHEBUNG
     .
 C500-99.
     EXIT.

******************************************************************
* Fehlermeldung für alle C...-Sections
******************************************************************
 D000-ALLE-FEHL-006 SECTION.
 D000-00.
     MOVE BEREICH OF SSTEXT TO W-BEREICH
     MOVE "FEHLER"   TO BEREICH OF SSTEXT
     MOVE "FEHL-001" TO KATEGORIE OF SSTEXT
**  ---> anzeigen Hilfstext
     PERFORM R100-SHOW-TEXT
     MOVE W-BEREICH TO BEREICH OF SSTEXT
     .
 D000-99.
     EXIT.

******************************************************************
* Aufruf SETMODE 20
******************************************************************
 D020-SETMODE SECTION.
 D020-00.
     MOVE 20 TO SM-FKT
     ENTER TAL "SETMODE" USING
                                 CFI-FNUM
                                 SM-FKT
                                 SM-PARM1
     .
 D020-99.
     EXIT.

******************************************************************
* setzen Catalog Define
******************************************************************
 D040-SET-CATDEFINE SECTION.
 D040-00.
**  ---> erstmal DEFINE löschen
     MOVE ZERO               TO P-RESULT
     MOVE DEF-NAME OF DEFCAT TO P-DEFINE
     PERFORM W400-DELETEDEFINE
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> diverse Parameter setzen
     MOVE "CLASS"    TO P-ATTRIBUT
     MOVE "CATALOG"  TO P-VALUE
     MOVE 7          TO P-VALUELEN
     PERFORM W410-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     MOVE "SUBVOL"           TO P-ATTRIBUT
     MOVE DEF-FILE OF DEFCAT TO P-VALUE
     MOVE ZERO   TO C4-ANZ
     INSPECT P-VALUE TALLYING C4-ANZ
             FOR CHARACTERS BEFORE INITIAL " "
     MOVE C4-ANZ             TO P-VALUELEN
     PERFORM W410-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> und nun den DEFINE setzen
     MOVE DEF-NAME OF DEFCAT TO P-DEFINE
     PERFORM W420-ADDDEFINE
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF
     .
 D040-99.
     EXIT.

******************************************************************
* setzen Tabellen defines
******************************************************************
 D050-SET-TABDEFINE SECTION.
 D050-00.
**  ---> erstmal DEFINE löschen
     MOVE ZERO               TO P-RESULT
     MOVE DEF-NAME OF DEFCAT TO P-DEFINE
     PERFORM W400-DELETEDEFINE
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> dann diverse Parameter setzen
     MOVE "CLASS" TO P-ATTRIBUT
     MOVE "MAP"   TO P-VALUE
     MOVE 3       TO P-VALUELEN
     PERFORM W410-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     MOVE "FILE"             TO P-ATTRIBUT
     MOVE DEF-FILE OF DEFCAT TO P-VALUE
     MOVE ZERO   TO C4-ANZ
     INSPECT P-VALUE TALLYING C4-ANZ
             FOR CHARACTERS BEFORE INITIAL " "
     MOVE C4-ANZ             TO P-VALUELEN
     PERFORM W410-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> und nun den DEFINE setzen
     PERFORM W420-ADDDEFINE
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF
     .
 D050-99.
     EXIT.

******************************************************************
* setzen Define für =DEFCAT
******************************************************************
 D060-SET-DEFCAT SECTION.
 D060-00.
**  ---> dafür Standort aus SSPARM holen
     MOVE "DEFCAT" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> erstmal DEFINE löschen
     MOVE ZERO       TO P-RESULT
     MOVE "=DEFCAT"  TO P-DEFINE
     PERFORM W400-DELETEDEFINE
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> dann diverse Parameter setzen
     MOVE "CLASS" TO P-ATTRIBUT
     MOVE "MAP"   TO P-VALUE
     MOVE 3       TO P-VALUELEN
     PERFORM W410-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     MOVE "FILE"  TO P-ATTRIBUT
     STRING  SVOL-SOURCE OF SSPARM
             "."
             SVOL-DEST   OF SSPARM
                 DELIMITED BY SPACE
       INTO  P-VALUE
     END-STRING
     MOVE ZERO   TO C4-ANZ
     INSPECT P-VALUE TALLYING C4-ANZ
             FOR CHARACTERS BEFORE INITIAL " "
     MOVE C4-ANZ             TO P-VALUELEN
     PERFORM W410-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> und nun den DEFINE setzen
     MOVE "=DEFCAT"  TO P-DEFINE
     PERFORM W420-ADDDEFINE
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF
     .
 D060-99.
     EXIT.

******************************************************************
* setzen Define für =_DEFAULT
******************************************************************
 D070-SET-DEFAULT SECTION.
 D070-00.
**  ---> dafür Standort aus SSPARM holen
     MOVE "CATALOG" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> dann diverse Parameter setzen
     MOVE "CLASS"   TO P-ATTRIBUT
     MOVE "DEFAULTS" TO P-VALUE
     MOVE 8       TO P-VALUELEN
     PERFORM W410-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     MOVE "VOLUME" TO P-ATTRIBUT
     MOVE W-VOLUME   TO P-VALUE
     MOVE ZERO   TO C4-ANZ
     INSPECT P-VALUE TALLYING C4-ANZ
             FOR CHARACTERS BEFORE INITIAL " "
     MOVE C4-ANZ             TO P-VALUELEN
     PERFORM W410-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     MOVE "CATALOG"  TO P-ATTRIBUT
     MOVE SPACES TO P-VALUE
     STRING  SVOL-SOURCE OF SSPARM
                 DELIMITED BY SPACE
       INTO  P-VALUE
     END-STRING
     MOVE ZERO   TO C4-ANZ
     INSPECT P-VALUE TALLYING C4-ANZ
             FOR CHARACTERS BEFORE INITIAL " "
     MOVE C4-ANZ             TO P-VALUELEN
     PERFORM W410-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> und nun den DEFINE setzen
     MOVE "=_DEFAULTS"  TO P-DEFINE
     ENTER TAL "DEFINEADD"   USING P-DEFINE
                                   P-REPLACE
                            GIVING P-RESULT
     IF  P-RESULT NOT = ZERO
         MOVE P-RESULT TO D-NUM4
         DISPLAY " ---> Fehler vom DEFINEADD - "
                 D-NUM4
                 " > "
                 P-DEFINE
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF
     .
 D070-99.
     EXIT.

******************************************************************
* Öffnen verschiedene Cursor für das LIST-Kommando
******************************************************************
 D200-OPEN-LIST-CURSOR SECTION.
 D200-00.
**  ---> öffnen unterschiedliche Cursor
     IF  CURS-ABNAHME
         PERFORM S740-OPEN-ABNAHME-A-CURSOR
     ELSE
         PERFORM S140-OPEN-SSAFE-CURSOR
     END-IF
     .
 D200-99.
     EXIT.

******************************************************************
* Lesen verschiedene Cursor für das LIST-Kommando
******************************************************************
 D201-FETCH-LIST-CURSOR SECTION.
 D201-00.
**  ---> lesen unterschiedliche Cursor
     IF  CURS-ABNAHME
         PERFORM S741-FETCH-ABNAHME-A-CURSOR
     ELSE
         PERFORM S141-FETCH-SSAFE-CURSOR
     END-IF
     .
 D201-99.
     EXIT.

******************************************************************
* Schliessen verschiedene Cursor für das LIST-Kommando
******************************************************************
 D202-CLOSE-LIST-CURSOR SECTION.
 D202-00.
**  ---> lesen unterschiedliche Cursor
     IF  CURS-ABNAHME
         PERFORM S742-CLOSE-ABNAHME-A-CURSOR
     ELSE
         PERFORM S142-CLOSE-SSAFE-CURSOR
     END-IF
     .
 D202-99.
     EXIT.

******************************************************************
* Aufbereiten Zeilen für LIST-Kommando
******************************************************************
 D205-SHOW-LIST1 SECTION.
 D205-00.
**  ---> aufbereiten Datenzeile
     IF  C4-ANZ > 90
**      ---> Überschrift aufbereiten
         MOVE LZ-TITEL TO ZEILE
         PERFORM U010-AUSGABE
         MOVE LZ-UNTERSTRICHE TO ZEILE
         PERFORM U010-AUSGABE

*         MOVE SOURCE-MODUL OF SSAFE TO LZD-SOURCE-MODUL
         MOVE 1 TO C4-ANZ
*     ELSE
*         MOVE SOURCE-MODUL OF SSAFE TO LZD-SOURCE-MODUL
     END-IF

**  ---> Modul-Name
     MOVE SOURCE-MODUL OF SSAFE TO LZD-SOURCE-MODUL

**  ---> Source-Typ
     EVALUATE SOURCE-TYP OF SSAFE
         WHEN "CS"   MOVE "Cob-Serv"  TO LZD-SOURCE-TYP
         WHEN "CO"   MOVE "Cob-Obj"   TO LZD-SOURCE-TYP
         WHEN "CX"   MOVE "Cob-Prog"  TO LZD-SOURCE-TYP
         WHEN "CM"   MOVE "Cob-Modul" TO LZD-SOURCE-TYP
         WHEN "CL"   MOVE "Copy-Lib"  TO LZD-SOURCE-TYP
         WHEN "TB"   MOVE "TAL-Lib"   TO LZD-SOURCE-TYP
         WHEN "TP"   MOVE "TACL-Proc" TO LZD-SOURCE-TYP
         WHEN "UC"   MOVE "UDC"       TO LZD-SOURCE-TYP
         WHEN OTHER  MOVE "???"       TO LZD-SOURCE-TYP
     END-EVALUATE

**  ---> Source Status
     EVALUATE SOURCE-STATUS OF SSAFE
         WHEN "CI"   MOVE "CheckedIn"          TO LZD-SOURCE-STATUS
                     MOVE ZP-CHECKIN OF SSAFE  TO LZD-ZEITPUNKT
         WHEN "CO"   MOVE "CheckedOut"         TO LZD-SOURCE-STATUS
                     MOVE ZP-CHECKOUT OF SSAFE TO LZD-ZEITPUNKT
         WHEN OTHER  MOVE "???"                TO LZD-SOURCE-STATUS
                     MOVE SPACES               TO LZD-ZEITPUNKT
     END-EVALUATE

**  ---> Zeitpunkt
     EVALUATE W-LIST-SUBCMD
         WHEN "RELEASED" MOVE "Rel. Prod"                TO LZD-SOURCE-STATUS
                         MOVE ZP-FREIGABE-PROD OF SSAFE  TO LZD-ZEITPUNKT
     END-EVALUATE

**  ---> User
     MOVE GROUP-USER OF SSAFE TO LZD-USER

**  ---> letzten Status bestimmen
     MOVE ZP-FREIGABE-PROD OF SSAFE     TO W-ZP
     MOVE FREIGABE-PROD OF SSAFE        TO LZD-LST
     IF  ZP-FREIGABE-TEST > W-ZP
         MOVE ZP-FREIGABE-TEST OF SSAFE TO W-ZP
         MOVE FREIGABE-TEST OF SSAFE    TO LZD-LST
     END-IF
     IF  ZP-CHECKIN > W-ZP
         MOVE ZP-CHECKIN OF SSAFE       TO W-ZP
         MOVE SOURCE-STATUS OF SSAFE    TO LZD-LST
     END-IF
     IF  ZP-CHECKOUT > W-ZP
         MOVE ZP-CHECKOUT OF SSAFE      TO W-ZP
         MOVE SOURCE-STATUS OF SSAFE    TO LZD-LST
     END-IF

**  ---> ab in Anzeige
     MOVE LZ-DATEN TO ZEILE
     PERFORM U010-AUSGABE
     MOVE SPACES TO LZD-LST
     .
 D205-99.
     EXIT.

******************************************************************
* Aufbereiten Zeilen für List-Kommando FREIGABE
******************************************************************
 D206-SHOW-LIST2 SECTION.
 D206-00.
**  ---> aufbereiten Datenzeile
     IF  C4-ANZ > 90
**      ---> Überschrift aufbereiten
         MOVE LF-HINWEIS TO ZEILE
         PERFORM U010-AUSGABE
         PERFORM U011-AUSGABE-SPACELINE
         MOVE LF-TITEL TO ZEILE
         PERFORM U010-AUSGABE
         MOVE LF-UNTERSTRICHE TO ZEILE
         PERFORM U010-AUSGABE

         MOVE 1 TO C4-ANZ
     END-IF

**  ---> Daten Zeile
     MOVE PRG-NAME            OF ABNAHME TO LFD-PRG-NAME
     MOVE VERSION             OF ABNAHME TO LFD-VERSION
     MOVE DATUM               OF ABNAHME TO LFD-DATUM
     MOVE FREIGABE-ANTRAG-VON OF ABNAHME TO LFD-FREIGABE-ANTRAG-VON
     MOVE FREIGABE-ANTRAG-AM  OF ABNAHME TO LFD-FREIGABE-ANTRAG-AM

     MOVE LF-DATEN TO ZEILE
     PERFORM U010-AUSGABE
     .
 D206-99.
     EXIT.

******************************************************************
*
******************************************************************
 D250-VERSIONS-DOKU SECTION.
 D250-00.
**  ---> erst mal Sourcefile assignen
     ENTER "COBOLASSIGN" USING  SOURCEF
                                ASS-FNAME
                         GIVING ASS-FSTATUS
     IF  ASS-FSTATUS NOT = ZERO
         DISPLAY "Fehler bei COBOLASSIGN (DOKUMENT): "
                 ASS-FNAME " " ASS-FSTATUS
         DISPLAY " ---> Programm-Abbruch <--- "
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     ELSE
**      --->  Öffnen Datei
         OPEN INPUT SOURCEF
     END-IF

**  ---> erstes Lesen der Eingabedatei
     MOVE ZERO TO C4-COUNT
     READ SOURCEF at end set file-eof to true end-read
     DISPLAY " "

**  ---> Schleife bis EOF
     SET SOURCEF-OK TO TRUE
     PERFORM UNTIL   FILE-EOF
*             OR      SOURCEF-NOK

         ADD 1 TO C4-COUNT
         MOVE SOURCEF-RECORD TO W-RECORD
         INSPECT SOURCEF-RECORD CONVERTING "abcdefghijklmnopqrstuvwxyz"
                                        TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

**      ---> wenn ENVIRONMENT DIVISION erreicht, Schleife beenden
         MOVE ZERO TO C4-ANZ
         INSPECT SOURCEF-RECORD TALLYING
                 C4-ANZ FOR CHARACTERS BEFORE INITIAL "ENVIRONMENT DIVISION"
         IF  C4-ANZ >= 0 and < 50
             SET SOURCEF-NOK TO TRUE
             EXIT PERFORM
         END-IF

         IF  SOURCEF-RECORD (1:1) = "?" or = SPACE
             continue
         ELSE
             IF  SOURCEF-RECORD (1:28) =  "* START VERSIONSBESCHREIBUNG"
                 SET SOURCEF-FOUND TO TRUE
             END-IF
             IF  SOURCEF-RECORD (1:13) =  "* AENDERUNGEN"
                 SET SOURCEF-FOUND TO TRUE
             END-IF
             IF  SOURCEF-RECORD (1:27) =  "* ENDE VERSIONSBESCHREIBUNG"
                 SET SOURCEF-NOK TO TRUE
                 EXIT PERFORM
             END-IF
             IF  SOURCEF-RECORD (1:22) =  "* PROGRAMMBESCHREIBUNG"
                 SET SOURCEF-NOK TO TRUE
                 EXIT PERFORM
             END-IF
         END-IF

**      ---> anzeigen Zeile des Sourcefiles
         IF  SOURCEF-FOUND
             MOVE W-RECORD TO ZEILE
             PERFORM U010-AUSGABE
         END-IF

**      ---> nächstes Lesen
         READ SOURCEF at end set file-eof to true end-read

     END-PERFORM

     CLOSE SOURCEF
     DISPLAY " "
     .
 D250-99.
     EXIT.

******************************************************************
* Anzeigen Ergebnis: Modul ist in welchen Programmen
******************************************************************
 D260-SHOW-MODIS SECTION.
 D260-00.
**  ---> Holen der Informationen und anzeigen, öffnen Cursor, lesen 1. Satz
     PERFORM U011-AUSGABE-SPACELINE
     MOVE SPACE TO MI-DATEN

     MOVE W-SOURCE TO SOURCE-FILE
     MOVE ZERO TO C4-I1
     INSPECT SOURCE-FILE TALLYING C4-I1
         FOR CHARACTERS BEFORE INITIAL " "
     MOVE all "%" TO SOURCE-FILE (C4-I1:)
     MOVE SOURCE-FILE TO PMODUL OF PROGRAMX

     PERFORM S860-OPEN-MODIS-CURSOR
     MOVE SPACES TO VAL OF BESCHREIBUNG OF PROGRAMS
     PERFORM S861-FETCH-MODIS-CURSOR

**  ---> Schleife über alle Fundstellen
     PERFORM UNTIL REFTABS-EOD or PRG-ABBRUCH

         IF  C4-COUNT = 1
**          ---> Titel und Überschrift anzeigen
             MOVE W-SOURCE TO MIT-MODUL
             MOVE MI-TITEL TO ZEILE
             PERFORM U010-AUSGABE
             PERFORM U011-AUSGABE-SPACELINE
             MOVE MI-UEBERSCHRIFT TO ZEILE
             PERFORM U010-AUSGABE
             MOVE MI-UNTERSTRICHE TO ZEILE
             PERFORM U010-AUSGABE
         END-IF

         MOVE PROGRAMM     OF PROGRAMS TO MID-PROGRAMM
         MOVE VERSION      OF PROGRAMS TO MID-VERSION
         MOVE VERS-DAT     OF PROGRAMS TO MID-VERS-DAT
         MOVE SPRACHE      OF PROGRAMS TO MID-SPRACHE

         MOVE 1 TO C4-I1
         PERFORM VARYING C4-I1 FROM C4-I1 BY 35
                 UNTIL   C4-I1 > 400
                 OR      C4-I1 > LEN OF BESCHREIBUNG OF PROGRAMS

             MOVE VAL OF BESCHREIBUNG OF PROGRAMS (C4-I1:35) TO MID-BESCHREIBUNG

**          ---> Anzeigen
             MOVE MI-DATEN TO ZEILE
             PERFORM U010-AUSGABE
             MOVE SPACE TO MI-DATEN

         END-PERFORM

**      ---> nachlesen
         MOVE SPACES TO VAL OF BESCHREIBUNG OF PROGRAMS
         PERFORM S861-FETCH-MODIS-CURSOR

     END-PERFORM

**  ---> schließen Cursor
     PERFORM S862-CLOSE-MODIS-CURSOR

**  ---> Ergebnis anzeigen
     MOVE C4-COUNT TO MIE-COUNT
     MOVE MI-ERGEBNIS TO ZEILE
     PERFORM U010-AUSGABE
     .
 D260-99.
     EXIT.

******************************************************************
* Anzeigen Ergebnis: Program enthält foldende Module
******************************************************************
 D270-SHOW-MODIN SECTION.
 D270-00.
**  ---> Holen der Informationen und anzeigen, öffnen Cursor, lesen 1. Satz
     PERFORM U011-AUSGABE-SPACELINE
     MOVE SPACE TO MI-DATEN

     MOVE W-SOURCE TO SOURCE-FILE
     MOVE ZERO TO C4-I1
     INSPECT SOURCE-FILE TALLYING C4-I1
         FOR CHARACTERS BEFORE INITIAL " "
     MOVE all "%" TO SOURCE-FILE (C4-I1:)
     MOVE SOURCE-FILE TO PROGRAMM OF PROGRAMX

     PERFORM S870-OPEN-MODIN-CURSOR
     PERFORM S871-FETCH-MODIN-CURSOR

**  ---> Schleife über alle Fundstellen
     PERFORM UNTIL REFTABS-EOD or PRG-ABBRUCH

**      ---> holen Daten des Moduls
         MOVE SPACES TO VAL OF BESCHREIBUNG OF PROGRAMS
         MOVE PMODUL OF PROGRAMX TO PROGRAMM OF PROGRAMS
         INSPECT PROGRAMM OF PROGRAMS CONVERTING " "
                                              TO "_"
         PERFORM S875-SELECT-PROGRAMS

         IF  C4-COUNT = 1
**          ---> Titel und Überschrift anzeigen
             MOVE W-SOURCE  TO MIT-MODUL1
             MOVE MI-TITEL1 TO ZEILE
             PERFORM U010-AUSGABE
             PERFORM U011-AUSGABE-SPACELINE
             MOVE MI-UEBERSCHRIFT TO ZEILE
             PERFORM U010-AUSGABE
             MOVE MI-UNTERSTRICHE TO ZEILE
             PERFORM U010-AUSGABE
         END-IF

         MOVE PROGRAMM     OF PROGRAMS TO MID-PROGRAMM
         MOVE VERSION      OF PROGRAMS TO MID-VERSION
         MOVE VERS-DAT     OF PROGRAMS TO MID-VERS-DAT
         MOVE SPRACHE      OF PROGRAMS TO MID-SPRACHE

         MOVE 1 TO C4-I1
         PERFORM VARYING C4-I1 FROM C4-I1 BY 35
                 UNTIL   C4-I1 > 400
                 OR      C4-I1 > LEN OF BESCHREIBUNG OF PROGRAMS

             MOVE VAL OF BESCHREIBUNG OF PROGRAMS (C4-I1:35) TO MID-BESCHREIBUNG

**          ---> Anzeigen
             MOVE MI-DATEN TO ZEILE
             PERFORM U010-AUSGABE
             MOVE SPACE TO MI-DATEN

         END-PERFORM

**      ---> nachlesen
         PERFORM S871-FETCH-MODIN-CURSOR

     END-PERFORM

**  ---> schließen Cursor
     PERFORM S872-CLOSE-MODIN-CURSOR

**  ---> Ergebnis anzeigen
     MOVE C4-COUNT TO MIE-COUNT
     MOVE MI-ERGEBNIS TO ZEILE
     PERFORM U010-AUSGABE
     .
 D270-99.
     EXIT.

******************************************************************
* Release nach Test
******************************************************************
 D310-COPY-ROLLOVER SECTION.
 D310-00.
**  ---> Source-file-name in einem Feld aufbereiten
     MOVE SPACES TO SOURCE-FILE
     STRING  SOURCE-FILE-VOL         DELIMITED BY SPACE
             "."                     DELIMITED BY SIZE
             SVOL-SOURCE OF SSPARM   DELIMITED BY SPACE
             "."                     DELIMITED BY SIZE
             SOURCE-FILE-NAME        DELIMITED BY SPACE
       INTO  SOURCE-FILE
     END-STRING

**  ---> Destination File-Name zusammenbasteln
     MOVE SPACES TO DEST-FILE
     MOVE SOURCE-FILE-VOL     TO DEST-FILE-VOL
     MOVE SVOL-DEST OF SSPARM TO DEST-FILE-SUBVOL
     MOVE SOURCE-FILE-NAME    TO DEST-FILE-NAME
     STRING  DEST-FILE-VOL       DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-SUBVOL    DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-NAME      DELIMITED BY SPACE
       INTO  DEST-FILE
     END-STRING

**  ---> mögliche Versionsdateinamen aufbereiten
     MOVE SPACES TO W-VERSIONS-TABELLE

     MOVE ZERO TO C4-I1
     INSPECT DEST-FILE TALLYING C4-I1
         FOR CHARACTERS BEFORE INITIAL " "

     MOVE DEST-FILE TO W-VERSION-FILE (1)
     MOVE "A"       TO W-VERSION-FILE (1) (C4-I1:1)
     MOVE DEST-FILE TO W-VERSION-FILE (2)
     MOVE "B"       TO W-VERSION-FILE (2) (C4-I1:1)
     MOVE DEST-FILE TO W-VERSION-FILE (3)
     MOVE "C"       TO W-VERSION-FILE (3) (C4-I1:1)
     MOVE DEST-FILE TO W-VERSION-FILE (4)
     MOVE "D"       TO W-VERSION-FILE (4) (C4-I1:1)
     MOVE DEST-FILE TO W-VERSION-FILE (5)
**  ---> je nach Source-Typ (Version A.01.40)
     IF  SOURCE-TYP OF SSAFE = "CM"
     and AKTION OF SSPARM = "R2T-MOD" or = "R2P-MOD"
         MOVE "M"   TO W-VERSION-FILE (5) (C4-I1:1)
     ELSE
         MOVE "E"   TO W-VERSION-FILE (5) (C4-I1:1)
     END-IF

**  ---> dann prüfen alle vorhandenen Dateien, des angegebenen Sources
**       im SubVol SSPARM.SVOL_DEST, um korrekte FUP Befehle zu
**  ---> generieren
     MOVE SVOL-DEST OF SSPARM TO SEARCH-FILE-SUBVOL

     PERFORM E100-FIND-START
     PERFORM E110-FIND-NEXT

**   ---> Schleife über alle Dateien mit gleichem Namen
     PERFORM UNTIL F-EOF
             OR    PRG-ABBRUCH

**      ---> letztes Zeichen (A bis E) des Dateiamens in Tabelle speichern
         MOVE ZERO TO C4-I1
         INSPECT SEARCH-FILE TALLYING C4-I1
             FOR CHARACTERS BEFORE INITIAL " "

**          ---> letztes Zeichen merken
             EVALUATE SEARCH-FILE (C4-I1:1)
                 WHEN "A"        MOVE "A" TO W-VERSION (1)
                 WHEN "B"        MOVE "B" TO W-VERSION (2)
                 WHEN "C"        MOVE "C" TO W-VERSION (3)
                 WHEN "D"        MOVE "D" TO W-VERSION (4)
                 WHEN "E"        MOVE "E" TO W-VERSION (5)
**              ---> (Version A.01.40)
                 WHEN "M"        MOVE "M" TO W-VERSION (5)
                 WHEN OTHER      CONTINUE
             END-EVALUATE

**      ---> suchen nächsten
         PERFORM E110-FIND-NEXT

     END-PERFORM

**  ---> nun die FUP Kommandos aufbereiten

**  ---> Fehler und Warnungen erlauben
     IF  FUP-COMMANDS-ANZ = ZERO
         ADD 1 TO FUP-COMMANDS-ANZ
         MOVE "ALLOW 10 ERRORS, 10 WARNINGS" TO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-IF

     IF  W-VERSION (1) NOT = SPACE
**      ---> Version "..A" löschen
         ADD 1 TO FUP-COMMANDS-ANZ
         STRING  " PURGE ! "         DELIMITED BY SIZE
                 W-VERSION-FILE (1)  DELIMITED BY SPACE
           INTO  FUP-COMMAND (FUP-COMMANDS-ANZ)
         END-STRING
     END-IF

     IF  W-VERSION (2) NOT = SPACE
**      ---> Version "..B" nach "..A" renamen
         ADD 1 TO FUP-COMMANDS-ANZ
         STRING  " RENAME "          DELIMITED BY SIZE
                 W-VERSION-FILE (2)  DELIMITED BY SPACE
                 ", "                DELIMITED BY SIZE
                 W-VERSION-FILE (1)  DELIMITED BY SPACE
           INTO  FUP-COMMAND (FUP-COMMANDS-ANZ)
         END-STRING
     END-IF

     IF  W-VERSION (3) NOT = SPACE
**      ---> Version "..C" nach "..B" renamen
         ADD 1 TO FUP-COMMANDS-ANZ
         STRING  " RENAME "          DELIMITED BY SIZE
                 W-VERSION-FILE (3)  DELIMITED BY SPACE
                 ", "                DELIMITED BY SIZE
                 W-VERSION-FILE (2)  DELIMITED BY SPACE
           INTO  FUP-COMMAND (FUP-COMMANDS-ANZ)
         END-STRING
     END-IF

     IF  W-VERSION (4) NOT = SPACE
**      ---> Version "..D" nach "..C" renamen
         ADD 1 TO FUP-COMMANDS-ANZ
         STRING  " RENAME "          DELIMITED BY SIZE
                 W-VERSION-FILE (4)  DELIMITED BY SPACE
                 ", "                DELIMITED BY SIZE
                 W-VERSION-FILE (3)  DELIMITED BY SPACE
           INTO  FUP-COMMAND (FUP-COMMANDS-ANZ)
         END-STRING
     END-IF

     IF  W-VERSION (5) NOT = SPACE
**      ---> Version "..E" nach "..D" renamen
         ADD 1 TO FUP-COMMANDS-ANZ
         STRING  " RENAME "          DELIMITED BY SIZE
                 W-VERSION-FILE (5)  DELIMITED BY SPACE
                 ", "                DELIMITED BY SIZE
                 W-VERSION-FILE (4)  DELIMITED BY SPACE
           INTO  FUP-COMMAND (FUP-COMMANDS-ANZ)
         END-STRING
     END-IF

**  ---> und nun noch das Source-File aus "WSRC" duplizieren
**  ---> bzw. aus xMOD nach yMOD
     ADD 1 TO FUP-COMMANDS-ANZ
*>
     IF  SOURCE-TYP OF SSAFE = "CM"
     and AKTION OF SSPARM = "R2T-MOD" or = "R2P-MOD"
         MOVE ZERO TO C4-I1
         INSPECT SOURCE-FILE TALLYING C4-I1
             FOR CHARACTERS BEFORE INITIAL " "
         MOVE "M" TO SOURCE-FILE (C4-I1:1)
         MOVE W-VERSION-FILE (5) TO DEST-FILE
     end-if
*>

     STRING  " DUP "         DELIMITED BY SIZE
             SOURCE-FILE     DELIMITED BY SPACE
             ", "            DELIMITED BY SIZE
             DEST-FILE       DELIMITED BY SPACE
             ", sourcedate"  DELIMITED BY SIZE
       INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-STRING

**  ---> security umsetzen
     ADD 1 TO FUP-COMMANDS-ANZ
     EVALUATE AKTION OF SSPARM
         WHEN "R2P-SRC"
                         STRING  " SECURE "      DELIMITED BY SIZE
                                 DEST-FILE       DELIMITED BY SPACE
                                 ", ""NUUU"""    DELIMITED BY SIZE
                           INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
                         END-STRING
         WHEN "SAVE-LIB"
                         STRING  " SECURE "      DELIMITED BY SIZE
                                 DEST-FILE       DELIMITED BY SPACE
                                 ", ""AUUU"""    DELIMITED BY SIZE
                           INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
                         END-STRING
         WHEN OTHER
                         STRING  " SECURE "      DELIMITED BY SIZE
                                 DEST-FILE       DELIMITED BY SPACE
                                 ", ""CUUU"""    DELIMITED BY SIZE
                           INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
                         END-STRING

     END-EVALUATE
     .
 D310-99.
     EXIT.

******************************************************************
* Object von Entw. nach Test bzw. von Test nach Prod.
******************************************************************
 D320-COPY-OBJECT SECTION.
 D320-00.
**  ---> Source-file-name in einem Feld aufbereiten
     MOVE SPACES TO SOURCE-FILE
     STRING  SOURCE-FILE-VOL         DELIMITED BY SPACE
             "."                     DELIMITED BY SIZE
             SVOL-SOURCE OF SSPARM   DELIMITED BY SPACE
             "."                     DELIMITED BY SIZE
             SOURCE-FILE-NAME        DELIMITED BY SPACE
       INTO  SOURCE-FILE
     END-STRING

**  ---> "E" durch "S/O/ " ersetzen
     MOVE SOURCE-FILE TO IN-SOURCE
     PERFORM U400-OBJECT-NAME
     MOVE OUT-SOURCE TO SOURCE-FILE

**  ---> aufbereiten Dateiname für Ausgabe Hinweis
     UNSTRING SOURCE-FILE DELIMITED BY "."
         INTO W-DUMMY-1
              W-DUMMY-2
              W-PROG-OBJECT
     END-UNSTRING

**  ---> Destination File-Name zusammenbasteln
     MOVE SPACES TO DEST-FILE
     MOVE SOURCE-FILE-VOL     TO DEST-FILE-VOL
     MOVE SVOL-DEST OF SSPARM TO DEST-FILE-SUBVOL
     MOVE SOURCE-FILE-NAME    TO DEST-FILE-NAME
     STRING  DEST-FILE-VOL       DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-SUBVOL    DELIMITED BY SPACE
             "."                 DELIMITED BY SIZE
             DEST-FILE-NAME      DELIMITED BY SPACE
       INTO  DEST-FILE
     END-STRING

**  ---> "E" durch "N" ersetzen
     MOVE DEST-FILE TO IN-SOURCE
     PERFORM U400-OBJECT-NAME
     MOVE OUT-SOURCE TO DEST-FILE

**  ---> je nach Kommando unterschiedliche Namens-Endungen
     IF  CMD-REL2TEST
**      ---> bei Kommando REL2TEST den Prog-Namen mit "N" überschreiben
         MOVE "N" TO DEST-FILE (C4-I1:1)
     END-IF

**  ---> nun erstmal prüfen, ob Securities richtig gesetzt sind ("A" oder "N")
**       vollst. Filename in SOURCE-FILE-VOL
     MOVE SOURCE-FILE TO T-FNAME
     PERFORM E120-FILE-INFO
     IF  T-ERROR NOT = ZERO
**      ---> Datei sollte eingentlich da sein
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-010" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         SET FKT-ABFRAGE TO TRUE
         EXIT SECTION
     END-IF

**  ---> Object-N darf nicht da sein
*     IF  CMD-REL2PROD
         MOVE DEST-FILE TO T-FNAME
         PERFORM E120-FILE-INFO
         IF  T-ERROR = ZERO
**          ---> Datei darf nicht da sein
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             IF  CMD-REL2PROD
                 MOVE "FEHL-029" TO KATEGORIE OF SSTEXT
             ELSE
                 MOVE "FEHL-029" TO KATEGORIE OF SSTEXT
             END-IF
             STRING  "!    "  DELIMITED BY SIZE
                     DEST-FILE  DELIMITED BY SPACE
               INTO  W-TEXT
             END-STRING
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             SET FKT-ABFRAGE TO TRUE
             move 99 to t-error
             EXIT SECTION
         ELSE
             IF  T-ERROR = 11
                 MOVE ZERO TO T-ERROR
             END-IF
         END-IF
*     END-IF

**  ---> wenn File-Group = 120 Prüfung auf Sec-String überspringen
     IF  D-FILE-GROUP NOT = 120
         IF  NOT (D-SEC-STRING (1:1) = "A" OR D-SEC-STRING (1:1) = "N")
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-011" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
             SET FKT-ABFRAGE TO TRUE
             EXIT SECTION
         END-IF
     END-IF

**  ---> FUP DUP (src nach dest)
     ADD 1 TO FUP-COMMANDS-ANZ
     STRING  " DUP "         DELIMITED BY SIZE
             SOURCE-FILE     DELIMITED BY SPACE
             ", "            DELIMITED BY SIZE
             DEST-FILE       DELIMITED BY SPACE
             ", sourcedate"  DELIMITED BY SIZE
       INTO FUP-COMMAND (FUP-COMMANDS-ANZ)
     END-STRING
     .
 D320-99.
     EXIT.

******************************************************************
* Suchen im Sourcefile nach der Versionsbezeichnung und Eintragung
* in Tabelle WVERSION erzeugen
******************************************************************
 D330-WVERSION SECTION.
 D330-00.
**  ---> zunächst Sourcefile assignen
     ENTER "COBOLASSIGN" USING  SOURCEF
                                ASS-FNAME
                         GIVING ASS-FSTATUS
     IF  ASS-FSTATUS NOT = ZERO
         DISPLAY "Fehler bei COBOLASSIGN (OUT): "
                 ASS-FNAME " " ASS-FSTATUS
         DISPLAY " ---> Programm-Abbruch <--- "
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     ELSE
**      --->  Öffnen Datei
         OPEN INPUT SOURCEF
     END-IF

**  ---> Versionseintrag in Sourcefile suchen
     DISPLAY "Versionsbezeichnung suchen " with no advancing

**  ---> erstes Lesen der Eingabedatei
     READ SOURCEF

**  ---> Schleife bis EOF
     SET SOURCEF-OK TO TRUE
     PERFORM UNTIL   FILE-EOF
             OR      SOURCEF-FOUND

         DISPLAY "." with no advancing

         MOVE SOURCEF-RECORD TO W-RECORD
         INSPECT SOURCEF-RECORD CONVERTING "abcdefghijklmnopqrstuvwxyz"
                                        TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
         MOVE ZERO TO C4-ANZ
         INSPECT SOURCEF-RECORD TALLYING
                 C4-ANZ FOR CHARACTERS BEFORE INITIAL "* LETZTE VERSION   ::"
         IF  C4-ANZ >= 0 and < 40
             MOVE W-RECORD (C4-ANZ + 23:8) TO W-PROG-VERSION
             PERFORM E330-VERSION
             SET SOURCEF-FOUND TO TRUE
             EXIT PERFORM
         END-IF

**      ---> naechstes Lesen
         READ SOURCEF

     END-PERFORM

     CLOSE SOURCEF
     DISPLAY " "

     IF  FILE-EOF
         SET SOURCEF-NOK
             PRG-ABBRUCH TO TRUE
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-008" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         SET FKT-ABFRAGE TO TRUE
         EXIT SECTION
     END-IF
     .
 D330-99.
     EXIT.

******************************************************************
* Abfragen Werte für Tabelle =ABNAHME
******************************************************************
 D340-ABNAHME-WERTE SECTION.
 D340-00.
**  ---> erstmal initialisieren
     INITIALIZE  AUFTRAG-LINK    OF ABNAHME
                 AUFTRAG-VON     OF ABNAHME
                 KONZEPT-LINK    OF ABNAHME
                 TESTPROT-LINK   OF ABNAHME

**  ---> Auftraggeber prompten
     PERFORM U011-AUSGABE-SPACELINE
     SET EIN-KLEIN-GROSS
         PROMPT-AUFTRAGGEB TO TRUE
     PERFORM U000-EINGABE
     MOVE EINGABE (1:C4-INLEN) TO AUFTRAG-VON OF ABNAHME

**  ---> Inhalt für Feld "AUTRAG_LINK" prompten
     SET EIN-KLEIN-GROSS
         PROMPT-AUFTR-LINK TO TRUE
     PERFORM U000-EINGABE
**  ---> Gänsebeine ersetzen, da sonst SQL-Fehler bei dyn. SQL
     INSPECT EINGABE CONVERTING """"
                             TO "#"
     MOVE EINGABE (1:C4-INLEN) TO VAL OF AUFTRAG-LINK OF ABNAHME
     MOVE C4-INLEN             TO LEN OF AUFTRAG-LINK OF ABNAHME

**  ---> Datum zum Autrag prompten, dafür Schleife bis Eingabe OK
     MOVE 9999 TO HC-DAY-ERR
     PERFORM UNTIL HC-DAY-ERR = ZERO

         SET EIN-KLEIN-GROSS
             PROMPT-VOM TO TRUE
         PERFORM U000-EINGABE

**      ---> Datum muss nun geprüft werden !!
         MOVE EINGABE (1:C4-INLEN) TO HC-DAT-UNGEPR
         MOVE SPACE   TO HC-DAY-FKT-TABELLE
         MOVE "X"     TO HC-DAY-FKT (1)

**      ---> Aufruf Prüfmodul
         PERFORM M140-CALL-HCDAY
         IF  HC-DAY-ERR NOT = ZERO
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-036" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Hilfstext
             PERFORM R100-SHOW-TEXT
         END-IF

     END-PERFORM

**  ---> und aufbereiten
     MOVE HC-DAT-SORT (1:4) TO AUFTRAG-AM OF ABNAHME
     MOVE "-"               TO AUFTRAG-AM OF ABNAHME (5:1)
     MOVE HC-DAT-SORT (5:2) TO AUFTRAG-AM OF ABNAHME (6:2)
     MOVE "-"               TO AUFTRAG-AM OF ABNAHME (8:1)
     MOVE HC-DAT-SORT (7:2) TO AUFTRAG-AM OF ABNAHME (9:2)

**  ---> Link zum Konzept prompten
     SET EIN-KLEIN-GROSS
         PROMPT-KONZ-LINK TO TRUE
     PERFORM U000-EINGABE
**  ---> Gänsebeine ersetzen, da sonst SQL-Fehler bei dyn. SQL
     INSPECT EINGABE CONVERTING """"
                             TO "#"
     MOVE EINGABE (1:C4-INLEN) TO VAL OF KONZEPT-LINK OF ABNAHME
     MOVE C4-INLEN             TO LEN OF KONZEPT-LINK OF ABNAHME

**  ---> Link zum Testprotokoll prompten
     SET EIN-KLEIN-GROSS
         PROMPT-TEST-LINK TO TRUE
     PERFORM U000-EINGABE
**  ---> Gänsebeine ersetzen, da sonst SQL-Fehler bei dyn. SQL
     INSPECT EINGABE CONVERTING """"
                             TO "#"
     MOVE EINGABE (1:C4-INLEN) TO VAL OF TESTPROT-LINK OF ABNAHME
     MOVE C4-INLEN             TO LEN OF TESTPROT-LINK OF ABNAHME
     .
 D340-99.
     EXIT.

******************************************************************
* prüfen, ob Parameter zum Kommando ACTIVTEST eingegeben wurden
******************************************************************
 D360-ACTIVTEST-PARM SECTION.
 D360-00.
     EVALUATE W-TEILSTRING (C4-I1)

         WHEN "AXL"      SET AXL-AXL   TO TRUE
         WHEN "NOAXL"    SET AXL-NOAXL TO TRUE
         WHEN "SQL"      SET SQL-SQL   TO TRUE
         WHEN "NOSQL"    SET SQL-NOSQL TO TRUE
         WHEN OTHER      continue

     END-EVALUATE

**  ---> nachsehen, ob evtl. ein weiterer Parameter eingegeben wurde
     ADD 1 TO C4-I1
     EVALUATE W-TEILSTRING (C4-I1)

         WHEN "AXL"      SET AXL-AXL   TO TRUE
         WHEN "NOAXL"    SET AXL-NOAXL TO TRUE
         WHEN "SQL"      SET SQL-SQL   TO TRUE
         WHEN "NOSQL"    SET SQL-NOSQL TO TRUE
         WHEN OTHER      continue

     END-EVALUATE
     .
 D360-99.
     EXIT.

******************************************************************
* erstellen Referenzen für Programm (ersetzt Makro: PRGNEU)
*    - Prg. Beschreibung
*    - Prg. - Modul
*    - Prg. - Copy
*    - Prg. - Tabs
******************************************************************
 D410-REFERENZEN SECTION.
 D410-00.
**  ---> bevor es in die Untersuchung geht, ein paar default Werte setzen
     INITIALIZE  PROGRAMS
                 PROGRAMX
                 LIBS
                 TABS
     MOVE DEST-FILE-NAME TO PROGRAMM OF PROGRAMS
                            PROGRAMM OF PROGRAMX
                            PROGRAMM OF LIBS
                            PROGRAMM OF TABS

**  ---> zunächst Löschen alle Referenzeinträge
     PERFORM U100-BEGIN
     PERFORM S800-DELETE-REF-TABS
     PERFORM U110-COMMIT
     IF  REF-TABS-NOK
         DISPLAY " !!! Löschen REF-Tabs fehlgeschlagen - Fkt.-Abbruch !!!"
         EXIT SECTION
     END-IF

**  ---> und Eintrag für das Programm/Modul selbst in Tabelle =PROGRAMS
     IF  SOURCE-TYP OF SSAFE (1:1) = "C"
         MOVE "COBOL85" TO SPRACHE OF PROGRAMS
     END-IF
     IF  SOURCE-TYP OF SSAFE (1:1) = "T"
         MOVE "TAL" TO SPRACHE OF PROGRAMS
     END-IF
     IF  SOURCE-TYP OF SSAFE (1:1) = "U"
         MOVE "TACL" TO SPRACHE OF PROGRAMS
     END-IF
**  ---> Insert inkl. Transaktion
     PERFORM S810-INSERT-PROGRAMS
     IF  REF-TABS-NOK
         EXIT SECTION
     END-IF

**  ---> dann Sourcefile assignen
     ENTER "COBOLASSIGN" USING  SOURCEF
                                ASS-FNAME
                         GIVING ASS-FSTATUS
     IF  ASS-FSTATUS NOT = ZERO
         DISPLAY "Fehler bei COBOLASSIGN (PRGNEU): "
                 ASS-FNAME " " ASS-FSTATUS
         DISPLAY " ---> Programm-Abbruch <--- "
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     ELSE
**      --->  Öffnen Datei
         OPEN INPUT SOURCEF
     END-IF

**  ---> erstes Lesen der Eingabedatei
     SET FILE-OK TO TRUE
     READ SOURCEF at end set file-eof to true end-read

**  ---> Schleife bis EOF
     SET SOURCEF-OK TO TRUE
     SET V-SONST    TO TRUE
     SET COMMENT-ON TO TRUE
     PERFORM UNTIL   FILE-EOF
             OR      SOURCEF-FOUND
             OR      REF-TABS-NOK

*         DISPLAY "." with no advancing

         MOVE SOURCEF-RECORD TO W-RECORD
         INSPECT SOURCEF-RECORD CONVERTING "abcdefghijklmnopqrstuvwxyz"
                                        TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
         IF  not (SOURCEF-RECORD (1:1) = "*"  or = "?")
**          ---> überprüfen, ob noch Kommentare untersucht werden müssen
             MOVE ZERO TO C4-ANZ
             INSPECT SOURCEF-RECORD TALLYING
                     C4-ANZ FOR CHARACTERS BEFORE INITIAL "ENVIRONMENT DIVISION"
             IF  C4-ANZ >= 0 and < 50
                 SET COMMENT-OFF TO TRUE
             END-IF

             MOVE ZERO TO C4-ANZ
**          ---> verzweigen, je nach zu bedienender Ref.-Tabelle
             PERFORM E410-LOOK4CALL
             IF  REF-TABS-NOK
                 EXIT PERFORM
             END-IF
**          ---> wenn ein CALL gefunden: Rest überspringen
             IF  not V-CALL
                 PERFORM E411-LOOK4COPY
                 IF  REF-TABS-NOK
                     EXIT PERFORM
                 END-IF
**              ---> wenn ein COPY gefunden: Rest überspringen
                 IF  not V-COPY
                     PERFORM E412-LOOK4INVOKE
                     IF  REF-TABS-NOK
                         EXIT PERFORM
                     END-IF
                 END-IF
             END-IF
         ELSE
             IF  SOURCEF-RECORD (1:1) = "*" AND COMMENT-ON
**              ---> suchen nach dem letzten Änderungsdatum
                 PERFORM E413-LOOK4LASTDAT
                 IF  REF-TABS-NOK
                     EXIT PERFORM
                 END-IF
                 IF  NOT V-DATUM
**                  ---> suchen nach der letzten Versionsbezeichnung
                     PERFORM E414-LOOK4LASTVERS
                     IF  REF-TABS-NOK
                         EXIT PERFORM
                     END-IF
                     IF  NOT V-VERSION
**                      ---> suchen nach der letzten Versionskurzbeschreibung
                         PERFORM E415-LOOK4SHORTDESCR
                         IF  REF-TABS-NOK
                             EXIT PERFORM
                         END-IF
                         IF  NOT V-BESCHREIBUNG
**                          ---> suchen nach der Updatebeschreibung
                             PERFORM E416-LOOK4UPDDESCR
                             IF  REF-TABS-NOK
                                 EXIT PERFORM
                             END-IF
                         END-IF
                     END-IF
                 END-IF
             END-IF
         END-IF

**      ---> naechstes Lesen
         READ SOURCEF at end set file-eof to true end-read
         SET V-SONST TO TRUE

     END-PERFORM

     CLOSE SOURCEF
     DISPLAY " "

     IF  FILE-EOF
         MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
         MOVE "HINW-005" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         SET FKT-ABFRAGE TO TRUE
         EXIT SECTION
     else
         SET SOURCEF-NOK
             PRG-ABBRUCH TO TRUE
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-005" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         SET FKT-ABFRAGE TO TRUE
         EXIT SECTION
     END-IF
     .
 D410-99.
     EXIT.

******************************************************************
* Verwaltungsfunktion: Löschen zugelassenen User
******************************************************************
 D420-DELETE-USER SECTION.
 D420-00.
**  ---> Abfrage nach dem zu löschenden User
     SET EIN-ASCII
         PROMPT-VDUSER TO TRUE
     PERFORM U000-EINGABE
     IF  EINGABE = "E" OR = SPACE
         EXIT SECTION
     END-IF

     MOVE EINGABE (1:C4-ANZ) TO W-UMSCHL-IN
     PERFORM U320-ENCR
     MOVE W-UMSCHL-OUT TO USER OF SSUSER
     IF  C4-ANZ > 8
         MOVE EINGABE (9:C4-ANZ - 8) TO W-UMSCHL-IN
     ELSE
         MOVE SPACES TO W-UMSCHL-IN
     END-IF
     PERFORM U320-ENCR
     MOVE W-UMSCHL-OUT TO USER OF SSUSER (9:)

**  ---> Abfrage nach der Rolle
     SET EIN-ASCII
         PROMPT-ROLLE TO TRUE
     PERFORM U000-EINGABE
     EVALUATE EINGABE
         WHEN "E"    EXIT SECTION
         WHEN " "    MOVE ALL "_" TO ROLLE OF SSUSER
         WHEN OTHER  MOVE ALL "_" TO ROLLE OF SSUSER
                     MOVE EINGABE (1:C4-ANZ) TO ROLLE OF SSUSER (1:C4-ANZ)
     END-EVALUATE

**  ---> suchen Eintrag in Tabelle SSPARM
     PERFORM U100-BEGIN
     PERFORM S625-DELETE-SSUSER
     PERFORM U110-COMMIT
     IF  USER-EOD
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-021" TO KATEGORIE OF SSTEXT
         PERFORM R100-SHOW-TEXT
     END-IF
     .
 D420-99.
     EXIT.

******************************************************************
* Verwaltungsfunktion: Listen alle zugelassenen User
******************************************************************
 D430-LIST-ALL-USER SECTION.
 D430-00.
**  ---> öffnen Join auf die Tabellen =SSUSER / =SSROLES
     MOVE all "_" TO USER OF SSUSER
     MOVE SPACES TO W-SSUSER
     PERFORM S630-OPEN-USER-CURSOR

**  ---> lesen 1. Eintrag
     PERFORM S631-FETCH-USER-CURSOR

**  ---> Schleife über alle Fundstellen / Funktionen
     PERFORM UNTIL USER-EOD OR PRG-ABBRUCH

**      ---> anzeigen Eintrag, ggf. Überschrift
         IF  C4-COUNT = 1
             PERFORM U011-AUSGABE-SPACELINE
             MOVE VZ-TITEL TO ZEILE
             PERFORM U010-AUSGABE
             MOVE VZ-UNTERSTRICHE TO ZEILE
             PERFORM U010-AUSGABE
         END-IF
         IF  USER OF SSUSER = W-SSUSER
             MOVE SPACES TO VZ-HEADER
         ELSE
             MOVE USER OF SSUSER (1:8) TO W-UMSCHL-IN
             PERFORM U310-DECR
             MOVE W-UMSCHL-OUT         TO VZD-USER (1:8)
             MOVE USER OF SSUSER (9:8) TO W-UMSCHL-IN
             PERFORM U310-DECR
             MOVE W-UMSCHL-OUT         TO VZD-USER (9:8)
         END-IF

**      ---> Ausgabe
         MOVE ZPINS OF SSUSER      TO VZD-ZEITPUNKT
         MOVE ROLLE OF SSUSER TO VZD-ROLLE
         MOVE VZ-DATEN TO ZEILE
         PERFORM U010-AUSGABE

**      ---> lesen nächsten Eintrag
         MOVE USER OF SSUSER TO W-SSUSER
         PERFORM S631-FETCH-USER-CURSOR

     END-PERFORM

**  ---> schliessen Cursor
     PERFORM S632-CLOSE-USER-CURSOR
     .
 D430-99.
     EXIT.

******************************************************************
* Verwaltungsfunktion: Einfügen neuen User
******************************************************************
 D440-INSERT-USER SECTION.
 D440-00.
**  ---> Abfrage nach dem neuen User
     SET EIN-ASCII
         PROMPT-VIUSER TO TRUE
     PERFORM U000-EINGABE
     IF  EINGABE = "E" OR = SPACE
         EXIT SECTION
     END-IF

**  ---> aufbereiten verschl. User
     MOVE EINGABE (1:C4-ANZ) TO W-UMSCHL-IN
     PERFORM U320-ENCR
     MOVE W-UMSCHL-OUT TO USER OF SSUSER
     IF  C4-ANZ > 8
         MOVE EINGABE (9:C4-ANZ - 8) TO W-UMSCHL-IN
     ELSE
         MOVE SPACES TO W-UMSCHL-IN
     END-IF
     PERFORM U320-ENCR
     MOVE W-UMSCHL-OUT TO USER OF SSUSER (9:)

**  ---> Abfrage nach der Rolle
     SET EIN-ASCII
         PROMPT-ROLLE TO TRUE

**  ---> Schleife bis ordentliche Eingabe
     MOVE HIGH-VALUE TO EINGABE
     MOVE ZERO TO C4-ANZ
     PERFORM UNTIL EINGABE = SPACE
             OR    C4-ANZ > 1
         PERFORM U000-EINGABE
         EVALUATE EINGABE
             WHEN "E"    EXIT SECTION
             WHEN " "    EXIT SECTION
             WHEN "?"    PERFORM E440-SHOW-ROLLEN
             WHEN OTHER  MOVE EINGABE (1:C4-ANZ) TO ROLLE OF SSUSER
         END-EVALUATE
     END-PERFORM

**  ---> hier sollte noch überprüft werden, ob die Rolle existiert
     MOVE ROLLE OF SSUSER TO ROLLE OF SSROLES
     PERFORM S645-SELECT-SSROLES
     IF  USER-EOD
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-035" TO KATEGORIE OF SSTEXT
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> suchen, ob Eintrag in Tabelle SSUSER schom vorhanden
     PERFORM S623-SELECT-SSUSER
     IF  USER-OK
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-022" TO KATEGORIE OF SSTEXT
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

**  ---> nun kann er eingefügt werden
     PERFORM U100-BEGIN
     PERFORM S624-INSERT-SSUSER
     PERFORM U110-COMMIT
     .
 D440-99.
     EXIT.

******************************************************************
* Anzeigen Rollen mit zugehörigen Funktionen
******************************************************************
 D450-LIST-ROL-FKT SECTION.
 D450-00.
**  ---> öffnen auf die Tabelle =SSROLES
     MOVE SPACES TO W-SSROLLE
     PERFORM S640-OPEN-ROLLEN-CURSOR

**  ---> lesen 1. Eintrag
     PERFORM S641-FETCH-ROLLEN-CURSOR

**  ---> Schleife über alle Einträge
     PERFORM UNTIL USER-EOD OR PRG-ABBRUCH

**      ---> anzeigen Eintrag, ggf. Überschrift
         IF  C4-COUNT = 1
             PERFORM U011-AUSGABE-SPACELINE
             MOVE VZ-TITEL-F TO ZEILE
             PERFORM U010-AUSGABE
             MOVE VZ-UNTERSTRICHE-F TO ZEILE
             PERFORM U010-AUSGABE
         END-IF
         IF  ROLLE OF SSROLES = W-SSROLLE
             MOVE SPACES TO VZ-HEADER-F
         ELSE
             MOVE ROLLE OF SSROLES TO VZF-ROLLE
         END-IF

**      ---> Ausgabe
         MOVE FUNKTION OF SSROLES TO VZF-FUNKTION
         MOVE VZ-DATEN-F TO ZEILE
         PERFORM U010-AUSGABE

**      ---> lesen nächsten Eintrag
         MOVE ROLLE OF SSROLES TO W-SSROLLE
         PERFORM S641-FETCH-ROLLEN-CURSOR

     END-PERFORM

**  ---> schliessen Cursor
     PERFORM S642-CLOSE-ROLLEN-CURSOR
     .
 D450-99.
     EXIT.

******************************************************************
* Auswahl Object bei EmergencyControll
******************************************************************
 D500-AUSWAHL-OBJECT SECTION.
 D500-00.
**  ---> nun nach Object prompten
     SET EIN-ASCII
         PROMPT-OBJECT TO TRUE
     PERFORM U000-EINGABE
     IF  EINGABE = "E" OR = SPACE
         SET PRG-ENDE TO TRUE
         EXIT SECTION
     END-IF
     INSPECT EINGABE CONVERTING " "
                             TO "%"
     MOVE EINGABE TO PRG-NAME OF ABNAHME

**  ---> und nach Version
     SET EIN-ASCII
         PROMPT-VERSION TO TRUE
     MOVE SPACES TO EINGABE
     PERFORM UNTIL EINGABE NOT = SPACE
         PERFORM U000-EINGABE
     END-PERFORM
     INSPECT EINGABE CONVERTING " "
                             TO "%"
     MOVE EINGABE TO VERSION OF ABNAHME

**  ---> nun Lesen des angegebenen Eintrags
     MOVE "NO"    TO NK-STATUS OF ABNAHME
     PERFORM S750-OPEN-ABNAHME-S-CURSOR
     PERFORM S751-FETCH-ABNAHME-S-CURSOR

**  ---> wenn kein Eintrag vorhanden Mitteilung und Exit
     IF  DYNCURS-EOD
         MOVE "FEHLER"  TO BEREICH   OF SSTEXT
         MOVE "FEHL-044" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
         PERFORM S752-CLOSE-ABNAHME-S-CURSOR
         GO TO D500-00
     END-IF

**  ---> Cursor schliessen
     PERFORM S752-CLOSE-ABNAHME-S-CURSOR
     MOVE "E" TO EINGABE
     .
 D500-99.
     EXIT.

******************************************************************
* Ereugen Eintrag in Tabelle =ABNAHME
******************************************************************
 D700-CREATE-ABNAHME SECTION.
 D700-00.
     IF  SOURCE-TYP OF SSAFE = "CM"
         EXIT SECTION
     END-IF

**  ---> Tabellenstruktur =ABNAHME initialisieren
     INITIALIZE ABNAHME

**  ---> Programmnamen aufbereiten
     MOVE DEST-FILE-NAME TO IN-SOURCE
     PERFORM U400-OBJECT-NAME
     MOVE OUT-SOURCE TO PRG-NAME OF ABNAHME

**  ---> holen Infos aus Referenztabelle =PROGRAMS
     MOVE SOURCE-FILE-NAME TO PROGRAMM OF PROGRAMS
     PERFORM S840-SELECT-PROGRAMS
     MOVE VERSION             OF PROGRAMS TO VERSION         OF ABNAHME
     MOVE VERS-DAT            OF PROGRAMS TO DATUM           OF ABNAHME
     MOVE LEN OF BESCHREIBUNG OF PROGRAMS TO LEN OF PRG-INFO OF ABNAHME
     MOVE VAL OF BESCHREIBUNG OF PROGRAMS TO VAL OF PRG-INFO OF ABNAHME

**  ---> prüfen, ob schon ein Eintrag vorhanden ist: Dann => Fehler
     PERFORM S720-OPEN-ABNAHME-CURSOR
     PERFORM S721-FETCH-ABNAHME-CURSOR
     PERFORM S722-CLOSE-ABNAHME-CURSOR
     IF  REF-TABS-OK
         IF  ACT2PROD-VON not = SPACE
**          ---> wenn schon in Prod. überführt Funktion ablehnen
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-046" TO KATEGORIE OF SSTEXT
             PERFORM R100-SHOW-TEXT

**          ---> Eintrag in Tabelle SSAFE korrigieren
             MOVE W-SOURCE    TO SOURCE-MODUL  OF SSAFE
             MOVE SPACES      TO FREIGABE-TEST OF SSAFE
             MOVE P-USER-NAME TO GROUP-USER    OF SSAFE
             PERFORM U100-BEGIN
             PERFORM S121-UPDATE-SSAFE-REL2TEST
             IF  PRG-ABBRUCH
                 PERFORM U120-ROLLBACK
             ELSE
                 PERFORM U110-COMMIT
             END-IF
             EXIT SECTION
         END-IF

**      ---> User auffordern neue Version in Prg. einzutragen
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-039" TO KATEGORIE OF SSTEXT
         PERFORM R100-SHOW-TEXT
**      ---> User fragen, ob vorhandener ABNAHME-Eintrag gelöscht werden soll
         SET EIN-ASCII
             PROMPT-DELETE TO TRUE
         PERFORM U000-EINGABE
         IF  EINGABE (1:C4-INLEN) = "N"
             EXIT SECTION
         ELSE
**          ---> hier den schon vorhandenen Eintrag löschen
             PERFORM S730-DELETE-ABNAHME
             IF  PRG-ABBRUCH
                 EXIT SECTION
             END-IF
         END-IF
     END-IF

**  ---> umwandeln Umlaute
     IF  LEN OF PRG-INFO OF ABNAHME > ZERO
         INSPECT VAL OF PRG-INFO OF ABNAHME (1:LEN OF PRG-INFO OF ABNAHME)
             CONVERTING "äöüÄÖÜß""'"
                     TO "aouAOUs#+"
     END-IF

**  ---> Update-Info im Sourcefile suchen
     MOVE W-BUFFER     TO VAL OF UPD-INFO OF ABNAHME
     MOVE W-BUFFER-LEN TO LEN OF UPD-INFO OF ABNAHME

**  ---> umwandeln Umlaute
     IF  LEN OF UPD-INFO OF ABNAHME > ZERO
         INSPECT VAL OF UPD-INFO OF ABNAHME (1:LEN OF UPD-INFO OF ABNAHME)
             CONVERTING "äöüÄÖÜß""'"
                     TO "aouAOUs#+"
         ELSE
**          ---> wenn Länge = 0, sind Änderungsvermerke nicht gem.
**          ---> den Vorgaben (Tabellenform )
             MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
             MOVE "HINW-016" TO KATEGORIE OF SSTEXT
             PERFORM R100-SHOW-TEXT
     END-IF

**  ---> Einträge für User, der Programm released
     MOVE GROUP-USER       OF SSAFE TO REL2TEST-VON OF ABNAHME
     MOVE ZP-FREIGABE-TEST OF SSAFE TO REL2TEST-AM  OF ABNAHME

**  ---> schreiben in Tabelle =ABNAHME
     PERFORM S700-INSERT-ABNAHME
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF
     .
 D700-99.
     EXIT.

******************************************************************
* Update der Tabelle ABNAHME um Info wer/wann AT ausgeführt hat
******************************************************************
 D710-UPDATE-ABNAHME-AT SECTION.
 D710-00.
**  ---> holen erforderliche Infos aus Referenztabelle =PROGRAMS
     MOVE W-SOURCE TO PROGRAMM OF PROGRAMS
     PERFORM S840-SELECT-PROGRAMS

**  ---> Transaktion beginnen
     PERFORM U100-BEGIN

**  ---> Update in Tabelle =ABNAHME (act2test_von / act2test_am)
     MOVE W-SOURCE TO IN-SOURCE
     PERFORM U400-OBJECT-NAME
     MOVE OUT-SOURCE          TO PRG-NAME     OF ABNAHME
     MOVE VERSION OF PROGRAMS TO VERSION      OF ABNAHME
     MOVE P-USER-NAME         TO ACT2TEST-VON OF ABNAHME
     PERFORM S710-UPDATE-ABNAHME-WE1

**  ---> Ende Tx und Bestätigung an den User
     IF  PRG-OK
         PERFORM U110-COMMIT
     ELSE
         PERFORM U120-ROLLBACK
     END-IF
     .
 D710-99.
     EXIT.

******************************************************************
* Update der Tabelle ABNAHME um Info wer/wann R2P ausgeführt hat
*                               Freigabe_link, Grund_SOS
******************************************************************
 D720-UPDATE-ABNAHME-R2P SECTION.
 D720-00.
**  ---> erst mal den Satz aus Tabelle =ABNAHME lesen
**  ---> Programmnamen aufbereiten
     MOVE W-SOURCE TO IN-SOURCE
     PERFORM U400-OBJECT-NAME
     MOVE OUT-SOURCE TO PRG-NAME OF ABNAHME

**  ---> holen Infos aus Referenztabelle =PROGRAMS
     MOVE SOURCE-FILE-NAME TO PROGRAMM OF PROGRAMS
     PERFORM S840-SELECT-PROGRAMS
     MOVE VERSION             OF PROGRAMS TO VERSION         OF ABNAHME
     MOVE VERS-DAT            OF PROGRAMS TO DATUM           OF ABNAHME

**  ---> prüfen, ob der Eintrag auch vorhanden ist
     PERFORM S720-OPEN-ABNAHME-CURSOR
     PERFORM S721-FETCH-ABNAHME-CURSOR
     PERFORM S722-CLOSE-ABNAHME-CURSOR
     IF  REF-TABS-NOK
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-041" TO KATEGORIE OF SSTEXT
         PERFORM R100-SHOW-TEXT
**      ---> hier sollte das Programm beendet werden, da offenbar
**      ---> kein Rel2Test erfolgt ist (sonst wäre der Eintrag vorhanden)
         set prg-ende to true
         exit section
     END-IF

**  ---> prüfen, ob FREIGABE beantragt wurde, sonst Funktion beenden
     IF  FREIGABE-ANTRAG-VON OF ABNAHME = SPACE
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-045" TO KATEGORIE OF SSTEXT
         PERFORM R100-SHOW-TEXT
         set prg-ende to true
         exit section
     END-IF

     MOVE SPACES      TO NK-STATUS    OF ABNAHME
     MOVE P-USER-NAME TO REL2PROD-VON OF ABNAHME
**  ---> wenn Freigabe_Von und/oder kein Freigabe-Link:
**  ---> Nach Grund für NOT-Übernahme prompten
     IF  FREIGABE-VON OF ABNAHME = SPACE
     and LEN OF FREIGABE-LINK OF ABNAHME = ZERO
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-043" TO KATEGORIE OF SSTEXT
         PERFORM R100-SHOW-TEXT
         MOVE ZERO TO C4-ANZ
         SET EIN-KLEIN-GROSS
             PROMPT-SOS      TO TRUE
**      ---> Eingabe Pflicht, also solange abfragen bis Eingabe erfolgt
         PERFORM UNTIL C4-ANZ > ZERO

             PERFORM U000-EINGABE

         END-PERFORM

         MOVE EINGABE (1:C4-INLEN) TO VAL OF GRUND-SOS OF ABNAHME
         MOVE C4-ANZ               TO LEN OF GRUND-SOS OF ABNAHME
         MOVE "NO"                 TO        NK-STATUS OF ABNAHME

     END-IF

**  ---> Transaktion beginnen
     PERFORM U100-BEGIN

**  ---> Update in Tabelle =ABNAHME
     PERFORM S714-UPDATE-ABNAHME-WE3

**  ---> Ende Tx und Bestätigung an den User
     IF  PRG-OK
         PERFORM U110-COMMIT
     ELSE
         PERFORM U120-ROLLBACK
     END-IF

**  ---> ggf. Mail versenden
     IF  FREIGABE-VON OF ABNAHME = SPACE
     and LEN OF FREIGABE-LINK OF ABNAHME = ZERO
**      ---> Sicherheitswarnungsmail aufbereiten und versenden
         PERFORM M520-MAIL-SICHERHEITSWARUNUNG
     END-IF
     .
 D720-99.
     EXIT.

******************************************************************
* Start mit FILENAME-Suche
******************************************************************
 E100-FIND-START SECTION.
 E100-00.
* FILENAME_FINDSTART_, FILENAME_FINDNEXT_ und FILENAME_FINDFINISH_ benutzen
* nur in den Subvols DSRC, TSRC und PSRC (ggf. aus Parametertabelle)
* in TSRC darf es sich eigentlich nicht befinden, wenn doch und es ist älter
* muss es vorher gelöscht werden, sonst Fehlermeldung und Ende

**  ---> zunächst Volume-Angabe holen
     MOVE SPACES TO SEARCH-FILE-VOL
     UNSTRING W-VOLUME DELIMITED BY SPACE OR "."
         INTO SEARCH-FILE-VOL
     END-UNSTRING

**  ---> letztes Zeichen vom Source-Name durch "?" ersetzen
     MOVE 0 TO C4-I1
     MOVE W-SOURCE TO SEARCH-FILE-NAME
     INSPECT SEARCH-FILE-NAME TALLYING C4-I1
         FOR CHARACTERS BEFORE INITIAL " "
     IF  C4-I1 > 8
         MOVE "?" TO SEARCH-FILE-NAME (8:1)
     ELSE
         MOVE "?" TO SEARCH-FILE-NAME (C4-I1:1)
     END-IF

     MOVE SPACES TO FB-SEARCH-PATTERN
     STRING  SEARCH-FILE-VOL                     DELIMITED BY SPACE
             "."                                 DELIMITED BY SIZE
             SEARCH-FILE-SUBVOL                  DELIMITED BY SPACE
             "."                                 DELIMITED BY SIZE
             SEARCH-FILE-NAME                    DELIMITED BY SPACE
       INTO  FB-SEARCH-PATTERN
     END-STRING

     MOVE ZERO TO FB-SEARCH-PATTERNLEN
     INSPECT FB-SEARCH-PATTERN TALLYING FB-SEARCH-PATTERNLEN
         FOR CHARACTERS BEFORE INITIAL " "
     MOVE "*" TO FB-SEARCH-PATTERN (FB-SEARCH-PATTERNLEN:1)

**  ---> Start FIND
     MOVE 0 TO FB-RESOLVE-LEVEL
     MOVE 3 TO FB-DEVICE-TYPE
     ENTER TAL "FILENAME_FINDSTART_"
                USING FB-SEARCH-ID
                      FB-SEARCH-PATTERN (1:FB-SEARCH-PATTERNLEN)
                      FB-RESOLVE-LEVEL
               GIVING FB-ERROR
     .
 E100-99.
     EXIT.

******************************************************************
* Dateien zum FileSet suchen
******************************************************************
 E110-FIND-NEXT SECTION.
 E110-00.
     ENTER TAL "FILENAME_FINDNEXT_"
                USING FB-SEARCH-IDN
                      FB-NAME (1:FB-NAMEMAXLEN)
                      FB-NAMELEN
               GIVING FB-ERROR

     IF  FB-ERROR = ZERO
**      ---> Datei gefunden
         SET F-OK TO TRUE
         MOVE FB-NAME (1:FB-NAMELEN) TO SEARCH-FILE
         IF  FB-NAME (FB-NAMELEN:1) = "Z"
             SET SRCZ-YES TO TRUE
         ELSE
             SET SRCZ-NO  TO TRUE
         END-IF
     ELSE
         SET F-EOF TO TRUE
         IF  FB-ERROR = 1
             ENTER TAL "FILENAME_FINDFINISH_"
                        USING  FB-SEARCH-IDN
                        GIVING FB-ERROR
         ELSE
             PERFORM U011-AUSGABE-SPACELINE
             MOVE " !!! Fehler bei Dateiscan: " To ZEILE
             MOVE FB-ERROR TO D-NUM6
             MOVE D-NUM6 TO ZEILE (28:)
             PERFORM U010-AUSGABE
             PERFORM U011-AUSGABE-SPACELINE
             SET PRG-ABBRUCH TO TRUE
         END-IF
     END-IF
     .
 E110-99.
     EXIT.

******************************************************************
* holen Last-Modify Zeitpunkt
******************************************************************
 E120-FILE-INFO SECTION.
 E120-00.
     MOVE ZERO TO T-FNAME-LEN
     INSPECT T-FNAME TALLYING T-FNAME-LEN
             FOR CHARACTERS BEFORE INITIAL " "

     ENTER TAL "FILE_GETINFOLISTBYNAME_"
                 USING   T-FNAME (1 : T-FNAME-LEN)
                         T-ITEM-LIST
                         T-NUM-OF-ITEMS
                         T-RESULT
                         T-RESULT-MAX
                         T-RESULT-LEN
                         T-ERROR-ITEM
                 GIVING  T-ERROR

     IF  T-ERROR NOT = ZERO
         EXIT SECTION
     END-IF

**  ---> Last Modify Zeitpunkt
     MOVE T-RESULT (5:8) TO LAST-MODIFY-X
     ENTER TAL "INTERPRETTIMESTAMP"
                 USING   LAST-MODIFY-N
                         TAL-TIME
                 GIVING  TAL-JUL-DAY

     MOVE CORR TAL-TIME TO TAL-TIME-D

**  ---> Security String
     MOVE T-RESULT (1:1) TO CD4-X2
     MOVE CD4-NUM TO D-NUM1
     MOVE D-NUM1  TO D-SEC-STRING (1:1)

     MOVE T-RESULT (2:1) TO CD4-X2
     MOVE CD4-NUM TO D-NUM1
     MOVE D-NUM1  TO D-SEC-STRING (2:1)

     MOVE T-RESULT (3:1) TO CD4-X2
     MOVE CD4-NUM TO D-NUM1
     MOVE D-NUM1  TO D-SEC-STRING (3:1)

     MOVE T-RESULT (4:1) TO CD4-X2
     MOVE CD4-NUM TO D-NUM1
     MOVE D-NUM1  TO D-SEC-STRING (4:1)

     INSPECT D-SEC-STRING CONVERTING "012456"
                                  TO "AGONCU"

**  ---> File Owner bestimmen
     MOVE T-RESULT (13:1) TO CD4-X2
     MOVE CD4-NUM TO D-FILE-GROUP
     MOVE T-RESULT (14:1) TO CD4-X2
     MOVE CD4-NUM TO D-FILE-OWNER
     .
 E120-99.
     EXIT.

******************************************************************
* Obey-Datei füllen und Fup ausführen
******************************************************************
 E150-OBEY-FUP SECTION.
 E150-00.
**  ---> Obey-Datei assignen
     PERFORM N010-ASSIGN-SSOBEY
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> Obey Datei öffnen und füllen (erstellt wurde sie in B000)
     OPEN OUTPUT SSOBEY

**  ---> Schleife über alle erzeugten Kommandos
     PERFORM VARYING C4-I1 FROM 1 BY 1
             UNTIL   C4-I1 > FUP-COMMANDS-ANZ
             OR      PRG-ABBRUCH

         MOVE FUP-COMMAND (C4-I1) TO SSOBEY-SATZ
         WRITE SSOBEY-SATZ

     END-PERFORM

**  ---> schließen Obey Datei
     CLOSE SSOBEY

**  ---> FUP ausführen
     PERFORM U210-FUP
     .
 E150-99.
     EXIT.

******************************************************************
* Object-Programm accellerieren
******************************************************************
 E310-AXCEL SECTION.
 E310-00.
**  ---> Information an den User
     IF  PRG-OK
         MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
         MOVE "HINW-011" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
     END-IF

**  ---> erstmal löschen STARTUP-Text
     MOVE "*ALL*" TO P-PORTION
     PERFORM W360-DELETESTARTUP
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> setzen OUT-Parameter für Aufruf von AXCEL
**  ---> dafür erstmal DEFINE setzen
     MOVE "$WE.#OCA" TO W-LOC
*     MOVE "$WE.#AXCEL" TO W-LOC
     MOVE 10           TO W-LOC-LEN
     PERFORM F310-DEFINE
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     MOVE "OUT" TO P-PORTION
     MOVE "=MYDEFINE" TO P-TEXT
     PERFORM W350-PUTSTARTUPTEXT
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> setzen STRING-Parameter für Aufruf von AXCEL
     MOVE "STRING"  TO P-PORTION
     MOVE DEST-FILE TO P-TEXT

*     MOVE SPACES   TO P-TEXT
*     STRING  DEST-FILE   DELIMITED BY SPACE
*             ", "        DELIMITED BY SIZE
*             DEST-FILE   DELIMITED BY SPACE
*       INTO  P-TEXT
*     END-STRING
     PERFORM W350-PUTSTARTUPTEXT
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> und nun den AXCEL Prozess starten
     MOVE K-OCA TO W-PROGRAM
*     MOVE K-AXCEL TO W-PROGRAM
     PERFORM W030-CREATEPROCESS
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> Compile-Ergebnis anzeigen
     EVALUATE MSG-COMPLETION-CODE
         WHEN 0     DISPLAY ">> keine Fehler/Warnungen vom Accelerator"
         WHEN 1     DISPLAY ">>!! Warnungen vom Accelerator !!"
         WHEN 2     DISPLAY ">>!! Fehler vom Accelerator !!"
         WHEN OTHER MOVE MSG-COMPLETION-CODE TO D-NUM4
                    DISPLAY ">>!! sonstige Fehler ("
                            D-NUM4
                            ") vom Accelerator !!"
     END-EVALUATE
     IF  MSG-COMPLETION-CODE not = ZERO
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF
     DISPLAY " "
     .
 E310-99.
     EXIT.

******************************************************************
* Object-Programm SQL-Compilieren
******************************************************************
 E320-SQL SECTION.
 E320-00.
**  ---> Information an den User
     IF  PRG-OK
         MOVE "HINWEIS"  TO BEREICH   OF SSTEXT
         MOVE "HINW-010" TO KATEGORIE OF SSTEXT
**      ---> anzeigen Hilfstext
         PERFORM R100-SHOW-TEXT
     END-IF

**  ---> erstmal löschen STARTUP-Text
     MOVE "*ALL*" TO P-PORTION
     PERFORM W360-DELETESTARTUP
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> setzen IN-Parameter für Aufruf von SQLCOMP
     MOVE "IN" TO P-PORTION
     MOVE DEST-FILE TO P-TEXT
     PERFORM W350-PUTSTARTUPTEXT
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> setzen OUT-Parameter für Aufruf von SQLCOMP
**  ---> dafür erstmal DEFINE setzen
     MOVE "$WE.#SQLCOMP" TO W-LOC
     MOVE 12             TO W-LOC-LEN
     PERFORM F310-DEFINE
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     MOVE "OUT" TO P-PORTION
     MOVE "=MYDEFINE" TO P-TEXT
     PERFORM W350-PUTSTARTUPTEXT
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> für STRING-Parameter erstmal Werte holen
     MOVE "CATALOG" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> setzen STRING-Parameter für Aufruf von SQLCOMP
     MOVE "STRING" TO P-PORTION
     MOVE SPACES   TO P-TEXT
     STRING  "CATALOG "            DELIMITED BY SIZE
             SVOL-SOURCE OF SSPARM DELIMITED BY SPACE
       INTO  P-TEXT
     END-STRING
     PERFORM W350-PUTSTARTUPTEXT
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> nachsehen, ob das Sourcefile kein Open-Flag hat
     MOVE AP-DNAME TO AP-DNAME-ZW
     MOVE DEST-FILE TO AP-DNAME
     PERFORM W200-OPENINFO
     MOVE AP-DNAME-ZW TO AP-DNAME
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF
**  ---> nun erstmal ein klein wenig warten
*     ENTER TAL "DELAY" USING C9-DELAY-TIME

**  ---> und nun den Compile Prozess starten
     MOVE K-SQLCOMP TO W-PROGRAM
     PERFORM W030-CREATEPROCESS
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> Compile-Ergebnis anzeigen
     EVALUATE MSG-COMPLETION-CODE
         WHEN 0     DISPLAY ">> keine Fehler/Warnungen vom SQLCOMP"
         WHEN 1     DISPLAY ">>!! Warnungen vom SQLCOMP !!"
         WHEN 2     DISPLAY ">>!! Fehler vom SQLCOMP !!"
         WHEN OTHER MOVE MSG-COMPLETION-CODE TO D-NUM4
                    DISPLAY ">>!! sonstige Fehler ("
                            D-NUM4
                            ") vom SQLCOMP !!"
     END-EVALUATE
*20130403     IF  MSG-COMPLETION-CODE not = ZERO
*20130403         SET PRG-ABBRUCH TO TRUE
*20130403     END-IF
     DISPLAY " "

**  ---> und wieder löschen STARTUP-Text
     MOVE "*ALL*" TO P-PORTION
     PERFORM W360-DELETESTARTUP
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> startup für FUP wieder reaktivieren
     MOVE "OUT"  TO P-PORTION
     MOVE W-FUP-OUT TO P-TEXT
     PERFORM V100-STARTUP
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF
     .
 E320-99.
     EXIT.

******************************************************************
* Eintrag in Tabelle WVERSION erzeugen
******************************************************************
 E330-VERSION SECTION.
 E330-00.
     MOVE SOURCE-FILE-NAME TO IN-SOURCE
     PERFORM U400-OBJECT-NAME
**  ---> Ergebnis in OUT-SOURCE

     MOVE SPACE TO DYN-STATEMENT-BUFFER
     STRING  "INSERT INTO =VIEWVERS "             delimited by size
             "(PROGRAMM, VERSION, USER) VALUES "  delimited by size
             "("""                                delimited by size
             OUT-SOURCE                           delimited by space
             ""","""                              delimited by size
             W-PROG-VERSION                       delimited by space
             ""","""                              delimited by size
             P-USER-NAME                          delimited by space
             """)"                                delimited by size
       INTO  DYN-STATEMENT-BUFFER
     END-STRING
     .
 E330-99.
     EXIT.

******************************************************************
* Suchen nach 'CALL' Unterprogrammen
******************************************************************
 E410-LOOK4CALL SECTION.
 E410-00.
     MOVE ZERO TO C4-ANZ1 C4-ANZ2 C4-ANZ3
**  ---> zunächst nach CALL suchen
     INSPECT SOURCEF-RECORD TALLYING
             C4-ANZ1 FOR CHARACTERS BEFORE INITIAL " CALL "

     IF  C4-ANZ1 > 0 and < 40
         SET V-CALL TO TRUE
**      ---> nächsten Startpunkt bestimmen
*         COMPUTE C4-ANZ1 = C4-ANZ1 + 6
         move zero to c4-anz1
         INSPECT SOURCEF-RECORD TALLYING
                 C4-ANZ1 FOR CHARACTERS BEFORE INITIAL """"
         INSPECT SOURCEF-RECORD (C4-ANZ1 + 2:) TALLYING
                 C4-ANZ2 FOR CHARACTERS BEFORE INITIAL """"
         MOVE W-RECORD (C4-ANZ1 + 2 : C4-ANZ2) TO PMODUL OF PROGRAMX

**      ---> ein fügen in Ref-Tab PROGRAMX
         PERFORM S820-INSERT-PROGRAMX
     END-IF
     .
 E410-99.
     EXIT.

******************************************************************
* Suchen nach 'COPY' Modulen
******************************************************************
 E411-LOOK4COPY SECTION.
 E411-00.
**  ---> eine zu untersuchende Zeile kann zB wie folgt aussehen:
*
*       123456789012345678901234567890123456789012345678901234567890
**  --->549      COPY        PSYS020IFC  OF            "=MSGLIB".
*                            ----------                  ------
*                            Copy-Modul                    Lib
*
     MOVE ZERO TO C4-ANZ1 C4-ANZ2 C4-ANZ3
**  ---> zunächst nach COPY suchen
     INSPECT SOURCEF-RECORD TALLYING
             C4-ANZ1 FOR CHARACTERS BEFORE INITIAL " COPY "

     IF  C4-ANZ1 > 0 and < 40
         SET V-COPY TO TRUE
**      ---> nächsten Startpunkt bestimmen
         COMPUTE C4-ANZ1 = C4-ANZ1 + 6

**      ---> dann noch führende Spaces zaehlen
         INSPECT SOURCEF-RECORD (C4-ANZ1 : ) TALLYING
                 C4-ANZ2 FOR LEADING " "
**      ---> Startpunkt des Copy-Moduls bestimmen
         COMPUTE C4-ANZ1 = C4-ANZ1 + C4-ANZ2

**      ---> dann die Länge feststellen
         MOVE ZERO TO C4-ANZ2
         INSPECT SOURCEF-RECORD (C4-ANZ1 : ) TALLYING
                 C4-ANZ2 FOR CHARACTERS BEFORE INITIAL " "
         MOVE W-RECORD (C4-ANZ1 : C4-ANZ2) TO CMODUL OF LIBS
**      ---> neuen Startpunkt für Suche nach LIB bestimmen
         COMPUTE C4-ANZ1 = C4-ANZ1 + C4-ANZ2

**      ---> nach Startpunkt der LIB suchen
         MOVE ZERO TO C4-ANZ2
         INSPECT SOURCEF-RECORD (C4-ANZ1 : ) TALLYING
                 C4-ANZ2 FOR CHARACTERS BEFORE INITIAL " ""="
**      ---> Startpunkt der LIB bestimmen
         COMPUTE C4-ANZ1 = C4-ANZ1 + C4-ANZ2 + 3

**      ---> dann die Länge feststellen
         MOVE ZERO TO C4-ANZ2
         INSPECT SOURCEF-RECORD (C4-ANZ1 : ) TALLYING
                 C4-ANZ2 FOR CHARACTERS BEFORE INITIAL """"
         MOVE W-RECORD (C4-ANZ1 : C4-ANZ2) TO LIB OF LIBS

**      ---> ein fügen in Ref-Tab LIBS
         PERFORM S830-INSERT-LIBS
     END-IF
     .
 E411-99.
     EXIT.

******************************************************************
* Suchen nach 'INVOKE' SQL-Tabellen
******************************************************************
 E412-LOOK4INVOKE SECTION.
 E412-00.
     MOVE ZERO TO C4-ANZ1
     INSPECT SOURCEF-RECORD TALLYING
             C4-ANZ1 FOR CHARACTERS BEFORE INITIAL " INVOKE"
     IF  C4-ANZ1 > 0 and < 128
         SET V-INVOKE TO TRUE
         MOVE ZERO TO C4-ANZ1 C4-ANZ2 C4-ANZ3
         INSPECT SOURCEF-RECORD TALLYING
                 C4-ANZ1 FOR CHARACTERS BEFORE INITIAL "="
         INSPECT SOURCEF-RECORD (C4-ANZ1 + 2:) TALLYING
                 C4-ANZ2 FOR CHARACTERS BEFORE INITIAL SPACE
         MOVE W-RECORD (C4-ANZ1 + 2 : C4-ANZ2) TO TABELLE OF TABS
         PERFORM S850-INSERT-TABS
         EXIT SECTION

     END-IF
     .
 E412-99.
     EXIT.

******************************************************************
* Suchen nach 'Versions-Infos' - hier: Letzte Änderung
******************************************************************
 E413-LOOK4LASTDAT SECTION.
 E413-00.
**  ---> nach dem Änderungsdatum suchen
     MOVE ZERO TO C4-ANZ1
     INSPECT SOURCEF-RECORD (1:40) TALLYING
             C4-ANZ1 FOR CHARACTERS BEFORE INITIAL " LETZTE AENDERUNG ::"
*                                                   2345678901234567890
     IF  C4-ANZ1 > 0 and < 40
         SET V-DATUM TO TRUE
         ADD 22 TO C4-ANZ1
         MOVE W-RECORD (C4-ANZ1 : 10) TO VERS-DAT OF PROGRAMS
         PERFORM S845-UPDATE-PRG-AEND
         EXIT SECTION
     END-IF
     .
 E413-99.
     EXIT.

******************************************************************
* Suchen nach 'Versions-Infos' - hier: Letzte Version
******************************************************************
 E414-LOOK4LASTVERS SECTION.
 E414-00.
     MOVE SPACES TO W-PROG-VERSION

**  ---> nach der Versionsnummer suchen
     MOVE ZERO TO C4-ANZ1
     INSPECT SOURCEF-RECORD (1:40) TALLYING
             C4-ANZ1 FOR CHARACTERS BEFORE INITIAL " LETZTE VERSION   ::"
     IF  C4-ANZ1 > 0 and < 40
         SET V-VERSION TO TRUE
         ADD 22 TO C4-ANZ1
         MOVE W-RECORD (C4-ANZ1 : 8) TO VERSION OF PROGRAMS
                                        W-PROG-VERSION
         PERFORM S846-UPDATE-PRG-VERS
         EXIT SECTION
     END-IF
     .
 E414-99.
     EXIT.

******************************************************************
* Suchen nach 'Versions-Infos' - hier: Kurzbeschreibung
******************************************************************
 E415-LOOK4SHORTDESCR SECTION.
 E415-00.
**  ---> nach der Kurzbeschreibung suchen
**       dafür zunächst mal den Satz lesen, um die Länge von BESCHREIBUNG
**       heraus zu finden
     PERFORM S840-SELECT-PROGRAMS
     IF  REF-TABS-NOK
         EXIT SECTION
     END-IF

     MOVE LEN OF BESCHREIBUNG OF PROGRAMS TO C4-BESCH-LEN
     MOVE ZERO TO C4-ANZ1
     INSPECT SOURCEF-RECORD (1:40) TALLYING
             C4-ANZ1 FOR CHARACTERS BEFORE INITIAL " KURZBESCHREIBUNG ::"
     IF  C4-ANZ1 > 0 and < 40
         SET V-BESCHREIBUNG TO TRUE
         MOVE ZERO TO C4-ANZ2
         ADD 22 TO C4-ANZ1
         INSPECT SOURCEF-RECORD (C4-ANZ1 : ) TALLYING
                 C4-ANZ2 FOR CHARACTERS BEFORE INITIAL "     "
         IF  C4-BESCH-LEN = ZERO
             MOVE W-RECORD (C4-ANZ1 : C4-ANZ2)
                 TO VAL OF BESCHREIBUNG OF PROGRAMS
         ELSE
             MOVE W-RECORD (C4-ANZ1 : C4-ANZ2)
                 TO VAL OF BESCHREIBUNG OF PROGRAMS (C4-BESCH-LEN + 1 :)
         END-IF
         COMPUTE C4-BESCH-LEN = C4-BESCH-LEN + C4-ANZ2 + 1
         MOVE C4-BESCH-LEN TO LEN OF BESCHREIBUNG OF PROGRAMS
         PERFORM S847-UPDATE-PRG-DESCR
         EXIT SECTION
     END-IF
     .
 E415-99.
     EXIT.

******************************************************************
* Suchen nach 'Versions-Infos' - hier: Update Beschreibung
******************************************************************
 E416-LOOK4UPDDESCR SECTION.
 E416-00.
     IF  VERSION OF PROGRAMS = SPACE
         EXIT SECTION
     END-IF

     MOVE ZERO TO C4-ANZ1
**  ---> zunächst mal Versionsupdate suchen
     INSPECT SOURCEF-RECORD (1:20) TALLYING
             C4-ANZ1 FOR ALL VERSION OF PROGRAMS (1:7)
     IF  C4-ANZ1 = ZERO
**      ---> wenn c4-anz1=0, dann nicht gefunden
         EXIT SECTION
     END-IF

**  ---> jetzt ist die erste oder einzige Zeile gefunden
     SET V-UPDVERS TO TRUE
     SET FOUND-YES TO TRUE
     MOVE SPACES TO W-BUFFER
     MOVE 1 TO W-BUFFER-LEN

**  ---> Schleife bis Ende-Kommentar
     PERFORM UNTIL FOUND-NO or FILE-EOF

**      ---> nun die Zeile aufteilen
         MOVE ZERO TO C4-ANZ1
         MOVE 1    TO C4-PTR
         MOVE SPACES     TO EW-TEILSTRING-TABELLE
         MOVE SPACES     TO W-DELIM-TABELLE
         MOVE LOW-VALUES TO W-COUNT-TABELLE
*         UNSTRING W-RECORD DELIMITED BY "*" or "|"
         UNSTRING W-RECORD DELIMITED BY "|"
             INTO EW-TEILSTRING (1)  DELIMITER IN W-DELIM (1)
                                     COUNT     IN W-COUNT (1)
                  EW-TEILSTRING (2)  DELIMITER IN W-DELIM (2)
                                     COUNT     IN W-COUNT (2)
                  EW-TEILSTRING (3)  DELIMITER IN W-DELIM (3)
                                     COUNT     IN W-COUNT (3)
                  EW-TEILSTRING (4)  DELIMITER IN W-DELIM (4)
                                     COUNT     IN W-COUNT (4)
                  EW-TEILSTRING (5)  DELIMITER IN W-DELIM (5)
                                     COUNT     IN W-COUNT (5)
                  EW-TEILSTRING (6)  DELIMITER IN W-DELIM (6)
                                     COUNT     IN W-COUNT (6)
             WITH     POINTER C4-PTR
             TALLYING IN      C4-ANZ1
         END-UNSTRING
         if  c4-anz1 = zero
             exit perform
         end-if

         move zero to c4-anz1
         inspect ew-teilstring (4) tallying
                 c4-anz1 for characters before initial "     "

         MOVE EW-TEILSTRING (4) (1:c4-anz1) TO W-BUFFER (W-BUFFER-LEN:c4-anz1)
         ADD c4-anz1 TO W-BUFFER-LEN

**      ---> lesen nächsten Satz
         READ SOURCEF
             AT END  SET FILE-EOF TO TRUE
                     EXIT PERFORM
         END-READ
         MOVE SOURCEF-RECORD TO W-RECORD
         IF  W-RECORD (2:7) = "-------"
             SET FOUND-NO TO TRUE
         END-IF

     END-PERFORM

**  ---> Länge richtig stellen / in W-BUFFER steht der Text
     COMPUTE W-BUFFER-LEN = W-BUFFER-LEN - 1
     .
 E416-99.
     EXIT.

******************************************************************
* Hilsanzeige der definierten Rollen
******************************************************************
 E440-SHOW-ROLLEN SECTION.
 E440-00.
**  ---> öffnen Cursor auf =SSROLES und lesen 1. EIntrag
     MOVE SPACES TO W-DUMMY-3
     MOVE ZERO TO C4-COUNT
     PERFORM S640-OPEN-ROLLEN-CURSOR
     PERFORM S641-FETCH-ROLLEN-CURSOR

**  ---> Schleife über alle Rollen
     PERFORM UNTIL USER-EOD or PRG-ABBRUCH

**      ---> anzeigen Eintrag, ggf. Überschrift
         IF  C4-COUNT = 1
             PERFORM U011-AUSGABE-SPACELINE
             MOVE VZ-TITEL-R TO ZEILE
             PERFORM U010-AUSGABE
             MOVE VZ-UNTERSTRICHE-R TO ZEILE
             PERFORM U010-AUSGABE
         END-IF

**      ---> wiederholte Rollen überspringen
         IF  ROLLE OF SSROLES not = W-DUMMY-3
**          ---> Anzeigen Rollen
             MOVE ROLLE OF SSROLES TO VZR-ROLLE
             MOVE VZ-DATEN-R TO ZEILE
             PERFORM U010-AUSGABE
         END-IF

**      ---> nachlesen Cursor
         MOVE ROLLE OF SSROLES TO W-DUMMY-3
         PERFORM S641-FETCH-ROLLEN-CURSOR

     END-PERFORM

**  ---> schließen Cursor
     PERFORM S642-CLOSE-ROLLEN-CURSOR
     PERFORM U011-AUSGABE-SPACELINE
     .
 E440-99.
     EXIT.

******************************************************************
* Setzen Define für Spooler-Ausgabe
******************************************************************
 F310-DEFINE SECTION.
 F310-00.
**  ---> erstmal DEFINE löschen
     MOVE ZERO        TO P-RESULT
     MOVE "=MYDEFINE" TO P-DEFINE
     PERFORM W400-DELETEDEFINE
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> dann diverse Parameter setzen
     MOVE "CLASS" TO P-ATTRIBUT
     MOVE "SPOOL" TO P-VALUE
     MOVE 5       TO P-VALUELEN
*     MOVE "$WE.#COBOL85" TO P-DEF-NAMES
     PERFORM W410-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     MOVE "LOC"      TO P-ATTRIBUT
     MOVE W-LOC      TO P-VALUE
     MOVE W-LOC-LEN  TO P-VALUELEN
     PERFORM W410-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     MOVE "REPORT" TO P-ATTRIBUT
     MOVE ZERO TO C4-I1
     INSPECT DEST-FILE-NAME TALLYING C4-I1
         FOR CHARACTERS BEFORE INITIAL " "

     MOVE DEST-FILE-NAME TO P-VALUE
     MOVE C4-I1          TO P-VALUELEN
     PERFORM W410-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> und nun den DEFINE setzen
     PERFORM W420-ADDDEFINE
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF
     .
 F310-99.
     EXIT.

******************************************************************
* Anzeige der moeglichen Kommandos und der Syntax
******************************************************************
 H100-HELP SECTION.
 H100-00.
     MOVE "HELP" TO BEREICH OF SSTEXT
     IF  C4-ANZ = 2
         MOVE W-TEILSTRING (2) TO KATEGORIE OF SSTEXT
         PERFORM R100-SHOW-TEXT
     ELSE
         MOVE "HELP" TO KATEGORIE OF SSTEXT
**      ---> anzeigen allgemeinen Hilfstext
         PERFORM R100-SHOW-TEXT
     END-IF
     .
 H100-99.
     EXIT.

******************************************************************
* Anzeige der moeglichen Kommandos und der Syntax für VERW
******************************************************************
 H420-HELP SECTION.
 H420-00.
     MOVE "HELP" TO BEREICH   OF SSTEXT
     MOVE "VERW" TO KATEGORIE OF SSTEXT
**  ---> anzeigen allgemeinen Hilfstext
     PERFORM R100-SHOW-TEXT
     .
 H420-99.
     EXIT.

******************************************************************
* Environment: hier aktuelles Volume holen
******************************************************************
 M000-STARTUP-VOLUME SECTION.
 M000-00.
**  ---> Abfragen StartUpText - VOLUME
     MOVE "VOLUME"  TO P-PORTION
     MOVE SPACE TO P-TEXT
     ENTER "GETSTARTUPTEXT"  USING   P-PORTION
                                     P-TEXT
                             GIVING  P-RESULT

     EVALUATE P-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus GetStartUpText
                     MOVE P-RESULT TO D-NUM4
                     STRING  "GETSTARTUPTEXT (VOLUME) fehlerhaft: "
                             D-NUM4
                                 DELIMITED BY SIZE
                       INTO  ZEILE
                     END-STRING
                     PERFORM U010-AUSGABE
                     PERFORM U011-AUSGABE-SPACELINE
                     SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION
         WHEN ZERO
**                  ---> kein Startuptext (VOLUME) vorhanden
                     SET FKT-ABFRAGE TO TRUE

         WHEN OTHER
**                  ---> Startuptext (VOLUME) muss untersucht werden
                     MOVE P-TEXT TO W-VOLUME
                     UNSTRING P-TEXT DELIMITED BY ALL SPACE or "."
                         INTO SOURCE-FILE-VOL
                              SOURCE-FILE-SUBVOL
                     END-UNSTRING

     END-EVALUATE
     .
 M000-99.
     EXIT.

******************************************************************
* Environment: hier das OUT-Medium holen
******************************************************************
 M020-STARTUP-OUT SECTION.
 M020-00.
**  ---> Abfragen StartUpText - OUT
     MOVE "OUT" TO P-PORTION
     MOVE SPACE TO P-TEXT
     ENTER "GETSTARTUPTEXT"  USING   P-PORTION
                                     P-TEXT
                             GIVING  P-RESULT

     EVALUATE P-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus GetStartUpText
                     MOVE P-RESULT TO D-NUM4
                     STRING  "GETSTARTUPTEXT (OUT) fehlerhaft: "
                             D-NUM4
                                 DELIMITED BY SIZE
                       INTO  ZEILE
                     END-STRING
                     PERFORM U010-AUSGABE
                     PERFORM U011-AUSGABE-SPACELINE
                     SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION
         WHEN ZERO
**                  ---> kein Startuptext (OUT) vorhanden
                     SET FKT-ABFRAGE TO TRUE

         WHEN OTHER
**                  ---> Startuptext (OUT) gesetzt, muss untersucht werden
**                  ---> ggf. steht hier das hometerminal (Form: $xxx.#xxx)
                     MOVE P-TEXT TO W-OUT
                     MOVE ZERO TO C4-I1
                     INSPECT P-TEXT TALLYING C4-I1
                             FOR CHARACTERS BEFORE INITIAL ".#"
                     IF  C4-I1 = 128
**                      ---> kein hometerminal und auch kein Prozess
                         SET AUSGABE-DATEI
                             FKT-ABFRAGE
                             STU-OUT         TO TRUE
**                      ---> Hometerminal als Ausgabedatei eingegeben
                         PERFORM N020-OPEN-OUT
                     END-IF
     END-EVALUATE
     .
 M020-99.
     EXIT.


******************************************************************
* Environment holen: hier STRING holen
******************************************************************
 M030-STARTUP-STRING SECTION.
 M030-00.
**  --------------------------------------------------------------------
**  ---> Abfragen StartUpText - STRING
     MOVE "STRING" TO P-PORTION
     MOVE SPACE    TO P-TEXT
     ENTER "GETSTARTUPTEXT"  USING   P-PORTION
                                     P-TEXT
                             GIVING  P-RESULT

     EVALUATE P-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus GetStartUpText
                     MOVE P-RESULT TO D-NUM4
                     STRING  "GETSTARTUPTEXT (STRING) fehlerhaft: "
                             D-NUM4
                                 DELIMITED BY SIZE
                       INTO  ZEILE
                     END-STRING
                     PERFORM U010-AUSGABE
                     PERFORM U011-AUSGABE-SPACELINE
                     SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION
         WHEN ZERO
**                  ---> kein Startuptext (STRING) vorhanden
                     SET FKT-ABFRAGE TO TRUE

         WHEN OTHER
**                  ---> Startuptext (STRING) gesetzt, muss untersucht werden
                     INSPECT P-TEXT CONVERTING "abcdefghijklmnopqrstuvwxyz"
                                            TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                     MOVE P-TEXT TO W-STRING
                                    EINGABE
                     SET FKT-STARTUP-FILE TO TRUE
                     SET STU-STRING  TO TRUE
                     PERFORM N030-CHECK-STARTUP
                     IF  CHECK-NOK
                         SET FKT-ABFRAGE TO TRUE
                     END-IF
     END-EVALUATE
     .
 M030-99.
     EXIT.

******************************************************************
* holen User und Prozess-Informationen
******************************************************************
 M040-USER-PROCINFO SECTION.
 M040-00.
**  ---> holen Processhandle
     ENTER TAL "PROCESSHANDLE_GETMINE_"
         USING   P-PROCESSHANDLE
         GIVING  P-ERROR
     IF  P-ERROR NOT = ZERO
         MOVE P-ERROR TO D-NUM4
         STRING  "--> Fehler von: PROCESSHANDLE_GETMINE_ - "
                 D-NUM4
                     DELIMITED BY SIZE
           INTO  ZEILE
         END-STRING
         PERFORM U010-AUSGABE
         PERFORM U011-AUSGABE-SPACELINE
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF

**  ---> holen Processinformationen
     ENTER TAL "PROCESS_GETINFO_"
         USING   P-PROCESSHANDLE OMITTED OMITTED OMITTED OMITTED
                 P-HOMETERM (1:P-HOMETERM-MAX)
                 P-HOMETERM-LEN
                                 OMITTED
                 P-CREATOR-ACCESS-ID
                 P-PROCESS-ACCESS-ID
                                 OMITTED OMITTED
                 P-PROG-FNAME (1:P-PROG-FNAME-LEN47)
                 P-PROG-FNAME-LEN
**                                 OMITTED OMITTED
                                 OMITTED OMITTED
                 P-ERROR-DETAIL
         GIVING  P-ERROR

     IF  P-ERROR NOT = ZERO
         MOVE P-ERROR TO D-NUM4
         STRING  "--> Fehler von: PROCESS_GETINFO_ - "
                 D-NUM4
                     DELIMITED BY SIZE
           INTO  ZEILE
         END-STRING
         PERFORM U010-AUSGABE
         MOVE P-ERROR-DETAIL TO D-NUM4
         STRING  "-->    detail:  - "
                 D-NUM4
                     DELIMITED BY SIZE
           INTO  ZEILE
         END-STRING
         PERFORM U010-AUSGABE
         PERFORM U011-AUSGABE-SPACELINE
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF

**  ---> merken des eigenen Programmfiles
     MOVE P-PROG-FNAME (1:P-PROG-FNAME-LEN) TO W-MY-PROG-FNAME

**  ---> holen Userinformationen
     MOVE P-CREATOR-ACCESS-ID TO PR-UI
     ENTER TAL "USER_GETINFO_"
         USING   P-USER-NAME (1:P-USER-MAXLEN)
                 P-USER-CURLEN
                 P-USERID
                 OMITTED OMITTED OMITTED
                 P-PRIMGROUP
         GIVING  P-ERROR
     IF  P-ERROR NOT = ZERO
         MOVE P-ERROR TO D-NUM4
         STRING  "--> Fehler von: USER_GETINFO_ - "
                 D-NUM4
                     DELIMITED BY SIZE
           INTO  ZEILE
         END-STRING
         PERFORM U010-AUSGABE
         PERFORM U011-AUSGABE-SPACELINE
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF

     MOVE P-USER-NAME   TO W-USER-GRP-NAME
     MOVE P-USER-CURLEN TO W-USER-GRP-NAME-LEN
     UNSTRING W-USER-GRP-NAME DELIMITED BY "."
         INTO W-GRP-NAME
              W-USER-NAME
     END-UNSTRING

     MOVE P-HOMETERM (1:P-HOMETERM-LEN) TO W-MY-HOMETERM

**  ---> aufbereiten/aufberwahren numerische Gruppen-/User-Werte
     MOVE PR-GUI  TO CD4-X2
     MOVE CD4-NUM TO W-USER-GRP
     MOVE PR-UUI  TO CD4-X2
     MOVE CD4-NUM TO W-USER-NR

**  ---> holen zulässige User-Group
     MOVE "LOGIN" TO AKTION OF SSPARM
     PERFORM S300-SELECT-SSPARM
     IF  NOT SSPRM-OK
         EXIT SECTION
     END-IF

**  ---> und prüfen
     MOVE SVOL-SOURCE OF SSPARM (1:3) TO D-NUM31
     MOVE SVOL-DEST   OF SSPARM (1:3) TO W-SPER-GRP
     IF  W-USER-GRP = D-NUM31 or = W-SPER-GRP
         IF  W-USER-GRP = W-SPER-GRP AND W-USER-NR = 255
**          ---> nnn,255 ist immer zugelassen
             MOVE HIGH-VALUE TO ROLFKT-FLAG
             EXIT SECTION
         END-IF
     ELSE
         MOVE "OPEN-ERROR #48" TO ZEILE
         PERFORM U010-AUSGABE
         PERFORM U011-AUSGABE-SPACELINE
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF
     .
 M040-99.
     EXIT.

******************************************************************
* setzen OUT-Medium für FUP
******************************************************************
 M050-PARAM-FUP-OUT SECTION.
 M050-00.
     MOVE "PARAM-FUP-OUT"   TO P-PORTION
     ENTER "GETPARAMTEXT"
                          USING P-PORTION
                                P-TEXT
                         GIVING P-ERROR
**  ---> Parameter nicht vorhanden oder leer
     IF  P-ERROR > 0
         IF  P-TEXT = SPACE
             MOVE K-FUP-OUT TO W-FUP-OUT
         ELSE
             MOVE P-TEXT TO W-FUP-OUT
         END-IF
     ELSE
         MOVE K-FUP-OUT TO W-FUP-OUT
     END-IF
     .
 M050-99.
     EXIT.

******************************************************************
* Aufruf Modul HCDAY
******************************************************************
 M140-CALL-HCDAY SECTION.
 M140-00.
     CALL "HCDAY" USING HC-DAY-PARM
     .
 M140-99.
     EXIT.

******************************************************************
* Erstellen Mail Aufhebung der Sicherheitswarnung
******************************************************************
 M500-MAIL-AUFHEBUNG SECTION.
 M500-00.
**  ---> holen Kontaktdaten / öffnen Mail / ausfüllen Adresszeilen
     PERFORM N500-EMAIL-KOPF
     IF  REF-TABS-NOK
         EXIT SECTION
     END-IF

**  ---> Betreffzeile
     MOVE TEM-BETREFF1        TO EM-K5-VALUE
     MOVE PRG-NAME OF ABNAHME TO EM-K5-VALUE (50:)
     WRITE EMAIL-RECORD FROM EM-K5
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> einleitender Text
     MOVE TEM-TEXT11          TO EM-PZ
     MOVE PRG-NAME OF ABNAHME TO EM-PZ (36:)
     MOVE TEM-TEXT12          TO EM-PZ (46:)
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-TEXT13          TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-TEXT14          TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-TEXT15          TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-STRICH
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> erste Text-Gruppe > Programminformationen
     PERFORM N510-PROGRAMMINFORMATIONEN
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> Entwickler (steht in ABNAHME.REL2TEST_VON)
     MOVE SPACES TO EM-PZ
     MOVE TEM-ENTWICKLER          TO EM-PZ-HEADER
     MOVE REL2TEST-VON OF ABNAHME TO EM-PZ-VALUE
     WRITE EMAIL-RECORD FROM EM-PZ

     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-STRICH

**  ---> zweite Text-Gruppe > Aufhebung
     WRITE EMAIL-RECORD FROM EM-LZ
     MOVE TEM-AUFHEBUNG TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> Controller-Test (steht in ABNAHME.NK_VON)
     MOVE SPACES TO EM-PZ
     MOVE TEM-CONTROLLER-TEST TO EM-PZ-HEADER
     MOVE NK-VON OF ABNAHME   TO EM-PZ-VALUE
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> abschliessend das Datum
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-STRICH
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> holen aktuelles Datum
     PERFORM U030-TIMESTAMP
     MOVE TEM-MAIL-DATUM         TO EM-PZ
     MOVE TAL-TT   of TAL-TIME-D TO EM-PZ (08:)
     MOVE "."                    TO EM-PZ (10:1)
     MOVE TAL-MM   of TAL-TIME-D TO EM-PZ (11:2)
     MOVE "."                    TO EM-PZ (13:1)
     MOVE TAL-JHJJ of TAL-TIME-D TO EM-PZ (14:4)
     WRITE EMAIL-RECORD FROM EM-PZ

**  ---> EMail schliessen
     CLOSE EMAIL
     .
 M500-99.
     EXIT.

******************************************************************
* vorbereiten  Mail  Abnahmeantrag
******************************************************************
 M510-MAIL-ABNAHMEANTRAG SECTION.
 M510-00.
**  ---> holen Kontaktdaten / öffnen Mail / ausfüllen Adresszeilen
     PERFORM N500-EMAIL-KOPF
     IF  REF-TABS-NOK
         EXIT SECTION
     END-IF

**  ---> Betreffzeile
     MOVE PRG-NAME OF ABNAHME TO EM-K4-PRG-NAME
     WRITE EMAIL-RECORD FROM EM-K4
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> einleitende Informationen
     MOVE PRG-NAME OF ABNAHME TO TEM-ALLG-PRG-NAME
     MOVE TEM-ALLG-INFO1 TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-ALLG-INFO2 TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> erste Text-Gruppe > Programminformationen
     PERFORM N510-PROGRAMMINFORMATIONEN
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-STRICH

**  ---> zweite Text-Gruppe > Auftragsinformationen
     WRITE EMAIL-RECORD FROM EM-LZ
     MOVE SPACES TO EM-PZ
     MOVE TEM-AUFTR-INFO TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ

     MOVE SPACES TO EM-PZ
     MOVE 1 TO C4-I1
     MOVE TEM-AUFTR           TO EM-PZ-HEADER
**  ---> Schleife über Inhalt Programm-Info
     PERFORM UNTIL C4-I1 > LEN OF AUFTRAG-LINK OF ABNAHME
             OR PRG-ABBRUCH

         MOVE VAL OF AUFTRAG-LINK OF ABNAHME (C4-I1:) TO EM-PZ-VALUE
         WRITE EMAIL-RECORD FROM EM-PZ
         MOVE SPACES TO EM-PZ
         ADD 40 TO C4-I1

     END-PERFORM
     WRITE EMAIL-RECORD FROM EM-LZ

     MOVE TEM-AUFTR-VON          TO EM-PZ-HEADER
     MOVE AUFTRAG-VON OF ABNAHME TO EM-PZ-VALUE
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-AUFTR-DATUM        TO EM-PZ-HEADER
     MOVE AUFTRAG-AM OF ABNAHME (9:2) TO EM-PZ-VALUE
     MOVE "."                         TO EM-PZ-VALUE (3:1)
     MOVE AUFTRAG-AM OF ABNAHME (6:2) TO EM-PZ-VALUE (4:2)
     MOVE "."                         TO EM-PZ-VALUE (6:1)
     MOVE AUFTRAG-AM OF ABNAHME (1:4) TO EM-PZ-VALUE (7:4)
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-STRICH

**  ---> dritte Text-Gruppe > Übernahmeinformationen
     WRITE EMAIL-RECORD FROM EM-LZ
     MOVE TEM-REL-INFO TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ

     MOVE SPACES TO EM-PZ
     MOVE TEM-ENTWICKLER          TO EM-PZ-HEADER
     MOVE REL2TEST-VON OF ABNAHME TO EM-PZ-VALUE
     WRITE EMAIL-RECORD FROM EM-PZ

     MOVE TEM-CONTROLLER-TEST            TO EM-PZ-HEADER
     MOVE FREIGABE-ANTRAG-VON OF ABNAHME TO EM-PZ-VALUE
     WRITE EMAIL-RECORD FROM EM-PZ

**  ---> vierte Text-Gruppe > Einhaltung von Vorschriften
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-STRICH
     WRITE EMAIL-RECORD FROM EM-LZ

     MOVE TEM-EVV-1 TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ
     MOVE TEM-EVV-2 TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-EVV-3 TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-EVV-4 TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-EVV-5 TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-EVV-6 TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ
     MOVE TEM-EVV-7 TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-EVV-8 TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-EVV-9 TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-EVV-10 TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ

**  ---> abschliessend das Datum
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-STRICH
     WRITE EMAIL-RECORD FROM EM-LZ

     MOVE TEM-MAIL-DATUM TO EM-PZ
     MOVE FREIGABE-ANTRAG-AM (9:02) TO EM-PZ (08:)
     MOVE "."                       TO EM-PZ (10:1)
     MOVE FREIGABE-ANTRAG-AM (6:02) TO EM-PZ (11:2)
     MOVE "."                       TO EM-PZ (13:1)
     MOVE FREIGABE-ANTRAG-AM (1:04) TO EM-PZ (14:4)
     WRITE EMAIL-RECORD FROM EM-PZ

**  ---> EMail schliessen
     CLOSE EMAIL
     .
 M510-99.
     EXIT.

******************************************************************
* Erstellen+versenden Sicherheitswarnungsmail
******************************************************************
 M520-MAIL-SICHERHEITSWARUNUNG SECTION.
 M520-00.
**  ---> holen Kontaktdaten / öffnen Mail / ausfüllen Adresszeilen
     PERFORM N500-EMAIL-KOPF
     IF  REF-TABS-NOK
         EXIT SECTION
     END-IF

**  ---> Betreffzeile
     MOVE TEM-BETREFF2        TO EM-K5-VALUE
     MOVE PRG-NAME OF ABNAHME TO EM-K5-VALUE (36:)
     WRITE EMAIL-RECORD FROM EM-K5
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> einleitender Text
     MOVE TEM-TEXT01          TO EM-PZ
     MOVE PRG-NAME OF ABNAHME TO EM-PZ (32:)
     MOVE TEM-TEXT02          TO EM-PZ (41:)
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-TEXT03          TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     MOVE TEM-TEXT04          TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-STRICH
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> erste Text-Gruppe > Programminformationen
     PERFORM N510-PROGRAMMINFORMATIONEN
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-STRICH

**  ---> zweite Text-Gruppe > Bearbeiter
     WRITE EMAIL-RECORD FROM EM-LZ
     MOVE TEM-BEARBEITER TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> Entwickler (steht in ABNAHME.REL2TEST_VON)
     MOVE SPACES TO EM-PZ
     MOVE TEM-ENTWICKLER          TO EM-PZ-HEADER
     MOVE REL2TEST-VON OF ABNAHME TO EM-PZ-VALUE
     WRITE EMAIL-RECORD FROM EM-PZ

**  ---> Controller-Test (steht in ABNAHME.REL2PROD_VON)
     MOVE TEM-CONTROLLER-TEST     TO EM-PZ-HEADER
     MOVE REL2PROD-VON OF ABNAHME TO EM-PZ-VALUE
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ

     MOVE TEM-VERLETZUNG                TO EM-PZ-HEADER
     MOVE REL2PROD-AM OF ABNAHME (9:2)  TO EM-PZ-VALUE
     MOVE "."                           TO EM-PZ-VALUE (3:1)
     MOVE REL2PROD-AM OF ABNAHME (6:2)  TO EM-PZ-VALUE (4:2)
     MOVE "."                           TO EM-PZ-VALUE (6:1)
     MOVE REL2PROD-AM OF ABNAHME (1:4)  TO EM-PZ-VALUE (7:4)
     MOVE " / "                         TO EM-PZ-VALUE (11:3)
     MOVE REL2PROD-AM OF ABNAHME (12:5) TO EM-PZ-VALUE (14:5)
     WRITE EMAIL-RECORD FROM EM-PZ

**  ---> abschliessend das Datum
     WRITE EMAIL-RECORD FROM EM-LZ
     WRITE EMAIL-RECORD FROM EM-STRICH
     WRITE EMAIL-RECORD FROM EM-LZ

     MOVE TEM-MAIL-DATUM TO EM-PZ
     MOVE REL2PROD-AM (9:02) TO EM-PZ (08:)
     MOVE "."                TO EM-PZ (10:1)
     MOVE REL2PROD-AM (6:02) TO EM-PZ (11:2)
     MOVE "."                TO EM-PZ (13:1)
     MOVE REL2PROD-AM (1:04) TO EM-PZ (14:4)
     WRITE EMAIL-RECORD FROM EM-PZ

**  ---> EMail schliessen
     CLOSE EMAIL
     .
 M520-99.
     EXIT.

******************************************************************
* assignen Obey-Datei
******************************************************************
 N010-ASSIGN-SSOBEY SECTION.
 N010-00.
**  ---> ASSIGN auf dynamic Out-Datei
     MOVE AP-DNAME TO ASS-FNAME
     ENTER "COBOLASSIGN" USING  SSOBEY
                                ASS-FNAME
                         GIVING ASS-FSTATUS
     IF  ASS-FSTATUS NOT = ZERO
         DISPLAY "Fehler bei COBOLASSIGN (OUT): "
                 ASS-FNAME " " ASS-FSTATUS
         DISPLAY " ---> Programm-Abbruch <--- "
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF
     .
 N010-99.
     EXIT.

******************************************************************
* öffnen OUT-Datei
******************************************************************
 N020-OPEN-OUT SECTION.
 N020-00.
**  ---> ASSIGN auf dynamic Out-Datei
     MOVE W-OUT TO ASS-FNAME
     ENTER "COBOLASSIGN" USING  LISTE
                                ASS-FNAME
                         GIVING ASS-FSTATUS
     IF  ASS-FSTATUS NOT = ZERO
         DISPLAY "Fehler bei COBOLASSIGN (OUT): "
                 ASS-FNAME " " ASS-FSTATUS
         DISPLAY " ---> Programm-Abbruch <--- "
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     ELSE
**      --->  Öffnen Datei
         OPEN OUTPUT LISTE
         SET FILE-OUT-OPEN TO TRUE
     END-IF
     .
 N020-99.
     EXIT.

******************************************************************
* STARTUP-TEXT entschlüsseln (W-STRING)
******************************************************************
 N030-CHECK-STARTUP SECTION.
 N030-00.
**  ---> diverse Initialisierungen
     MOVE SPACES     TO W-TEILSTRING-TABELLE
     MOVE SPACES     TO W-DELIM-TABELLE
     MOVE LOW-VALUES TO W-COUNT-TABELLE
     MOVE SPACES     TO W-LIST-SUBS

     SET CHECK-OK TO TRUE

**  ---> wenn leere Eingabe einfach zurück zum Prompt
     IF  EINGABE = SPACE
         SET CHECK-NOK TO TRUE
         EXIT SECTION
     END-IF

**  ---> erstmal String zerlegen
     MOVE ZERO TO C4-ANZ
     MOVE 1    TO C4-PTR
     UNSTRING EINGABE DELIMITED BY ALL SPACE or "," or "."
         INTO W-TEILSTRING (1)  DELIMITER IN W-DELIM (1)
                                COUNT     IN W-COUNT (1)
              W-TEILSTRING (2)  DELIMITER IN W-DELIM (2)
                                COUNT     IN W-COUNT (2)
              W-TEILSTRING (3)  DELIMITER IN W-DELIM (3)
                                COUNT     IN W-COUNT (3)
              W-TEILSTRING (4)  DELIMITER IN W-DELIM (4)
                                COUNT     IN W-COUNT (4)
              W-TEILSTRING (5)  DELIMITER IN W-DELIM (5)
                                COUNT     IN W-COUNT (5)
              W-TEILSTRING (6)  DELIMITER IN W-DELIM (6)
                                COUNT     IN W-COUNT (6)
              W-TEILSTRING (7)  DELIMITER IN W-DELIM (7)
                                COUNT     IN W-COUNT (7)
              W-TEILSTRING (8)  DELIMITER IN W-DELIM (8)
                                COUNT     IN W-COUNT (8)
              W-TEILSTRING (9)  DELIMITER IN W-DELIM (9)
                                COUNT     IN W-COUNT (9)
              W-TEILSTRING (10) DELIMITER IN W-DELIM (10)
                                COUNT     IN W-COUNT (10)
         WITH     POINTER C4-PTR
         TALLYING IN      C4-ANZ
     END-UNSTRING

**  ---> wenn erster Teilstring gesetzt, so muss es ein Kommando sein
     IF  C4-ANZ > 0
         MOVE W-TEILSTRING (1) TO CMD-KOMMANDO
         EVALUATE TRUE
             WHEN CMD-CHECKIN    continue
             WHEN CMD-CHECKOUT   continue
             WHEN CMD-DOKUMENT   continue
             WHEN CMD-EMERGENCY-CONTROL
                                 continue
             WHEN CMD-EXIT       continue
             WHEN CMD-HELP       continue
             WHEN CMD-LIST       continue
             WHEN CMD-MODIN      continue
             WHEN CMD-MODIS      continue
             WHEN CMD-PROT       continue
             WHEN CMD-SHOW       continue
             WHEN CMD-STOP       continue
             WHEN CMD-SAVE       continue
             WHEN CMD-REL2PROD   continue
             WHEN CMD-REL2TEST   continue
             WHEN CMD-REL4WEAT   continue
             WHEN CMD-ROLLEN     continue
             WHEN CMD-ACTIVPROD  continue
             WHEN CMD-ACTIVTEST  continue
             WHEN CMD-PRGNEU     continue
             WHEN CMD-VERW       continue
             WHEN CMD-NEW        continue
             WHEN CMD-DEL        continue
**          ---> kein gültiges Kommando, also Fehlermeldung und Ende
             WHEN OTHER
                                 MOVE "FEHLER"   TO BEREICH   OF SSTEXT
                                 MOVE "FEHL-009" TO KATEGORIE OF SSTEXT
**                              ---> anzeigen Fehler- und Hilfstexte
                                 PERFORM R100-SHOW-TEXT
                                 SET CHECK-NOK TO TRUE
                                 EXIT SECTION
         END-EVALUATE
     END-IF

**  ---> mindestens Kommando eingegeben
     SET FKT-STARTUP-ABFRAGE TO TRUE

**  ---> ggf. weitere Parameter holen: der nächste könnte $Volume sein:
     IF  C4-ANZ > 1
         IF  W-TEILSTRING (2) (1:1) = "$"
**          ---> $Volume ist nicht erlaubt, dann geht kein Rename mehr
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-023" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Fehler- und Hilfstexte
             PERFORM R100-SHOW-TEXT
             SET CHECK-NOK TO TRUE
             EXIT SECTION
         ELSE
**          ---> oder Subvol und / oder file sein
             IF  W-DELIM (2) = "."
                 MOVE W-TEILSTRING (2) TO SOURCE-FILE-SUBVOL
                 MOVE W-TEILSTRING (3) TO SOURCE-FILE-NAME
                 MOVE W-TEILSTRING (3) TO W-SOURCE
             ELSE
                 MOVE W-TEILSTRING (2) TO SOURCE-FILE-NAME
                 MOVE W-TEILSTRING (2) TO W-SOURCE
             END-IF
**          ---> Funktionsflag setzen
             SET FKT-STARTUP-FILE TO TRUE
         END-IF
         IF  CMD-LIST
             PERFORM o030-CMD-LIST
         END-IF
     END-IF

**  ---> Source-file-name in einem Feld aufbereiten
     MOVE SPACES TO SOURCE-FILE
     STRING  SOURCE-FILE-VOL       DELIMITED BY SPACE
             "."                   DELIMITED BY SIZE
             SOURCE-FILE-SUBVOL    DELIMITED BY SPACE
             "."                   DELIMITED BY SIZE
             SOURCE-FILE-NAME      DELIMITED BY SPACE
       INTO  SOURCE-FILE
     END-STRING
     .
 N030-99.
     EXIT.

******************************************************************
* Checken User-Eingaben innerhalb einer Funktion
******************************************************************
 N035-CHECK-EINGABE SECTION.
 N035-00.
**  ---> diverse Initialisierungen
     MOVE SPACES     TO W-TEILSTRING-TABELLE
     MOVE SPACES     TO W-DELIM-TABELLE
     MOVE LOW-VALUES TO W-COUNT-TABELLE

     SET CHECK-OK TO TRUE

**  ---> erstmal Eingabe-String zerlegen
     MOVE ZERO TO C4-ANZ
     MOVE 1    TO C4-PTR
     UNSTRING EINGABE DELIMITED BY ALL SPACE or "," or "."
         INTO W-TEILSTRING (1)  DELIMITER IN W-DELIM (1)
                                COUNT     IN W-COUNT (1)
              W-TEILSTRING (2)  DELIMITER IN W-DELIM (2)
                                COUNT     IN W-COUNT (2)
              W-TEILSTRING (3)  DELIMITER IN W-DELIM (3)
                                COUNT     IN W-COUNT (3)
              W-TEILSTRING (4)  DELIMITER IN W-DELIM (4)
                                COUNT     IN W-COUNT (4)
              W-TEILSTRING (5)  DELIMITER IN W-DELIM (5)
                                COUNT     IN W-COUNT (5)
         WITH     POINTER C4-PTR
         TALLYING IN      C4-ANZ
     END-UNSTRING

**  ---> Parameter holen: der nächste könnte $Volume sein:
     IF  C4-ANZ > ZERO
         IF  W-TEILSTRING (1) (1:1) = "$"
**          ---> $Volume ist nicht erlaubt, dann geht kein Rename mehr
             MOVE "FEHLER"   TO BEREICH   OF SSTEXT
             MOVE "FEHL-023" TO KATEGORIE OF SSTEXT
**          ---> anzeigen Fehler- und Hilfstexte
             PERFORM R100-SHOW-TEXT
             SET CHECK-NOK TO TRUE
             EXIT SECTION
         ELSE
**          ---> oder Subvol und / oder file sein
             IF  W-DELIM (1) = "."
                 MOVE W-TEILSTRING (1) TO SOURCE-FILE-SUBVOL
                 MOVE W-TEILSTRING (2) TO SOURCE-FILE-NAME
                 MOVE W-TEILSTRING (2) TO W-SOURCE
             ELSE
                 MOVE W-TEILSTRING (1) TO SOURCE-FILE-NAME
                 MOVE W-TEILSTRING (1) TO W-SOURCE
             END-IF
**          ---> Funktionsflag setzen
             IF  FKT-ABFRAGE
                 SET FKT-EINGABE-FILE TO TRUE
             END-IF
         END-IF
     END-IF

**  ---> Source-file-name in einem Feld aufbereiten
     MOVE SPACES TO SOURCE-FILE
     STRING  SOURCE-FILE-VOL       DELIMITED BY SPACE
             "."                   DELIMITED BY SIZE
             SOURCE-FILE-SUBVOL    DELIMITED BY SPACE
             "."                   DELIMITED BY SIZE
             SOURCE-FILE-NAME      DELIMITED BY SPACE
       INTO  SOURCE-FILE
     END-STRING
     .
 N035-99.
     EXIT.

******************************************************************
* Aufbereiten E-Mail Kopfdaten
******************************************************************
 N500-EMAIL-KOPF SECTION.
 N500-00.
**  ---> holen Mail Kontaktdaten
     MOVE K-MODUL TO MODUL OF EKONTAKT
     MOVE ZERO    TO MDNR  OF EKONTAKT
                     TSNR  OF EKONTAKT
     PERFORM S790-SELECT-EKONTAKT

**  ---> holen Daten aus ABNAHME-Eintrag
     PERFORM S720-OPEN-ABNAHME-CURSOR
     PERFORM S721-FETCH-ABNAHME-CURSOR
     PERFORM S722-CLOSE-ABNAHME-CURSOR
     IF  REF-TABS-NOK
         MOVE "FEHLER"   TO BEREICH   OF SSTEXT
         MOVE "FEHL-040" TO KATEGORIE OF SSTEXT
         PERFORM R100-SHOW-TEXT
         EXIT SECTION
     END-IF

     OPEN OUTPUT EMAIL

**  ---> Adressdaten
     MOVE EMAIL-FROM OF EKONTAKT TO EM-K1-FROM
     WRITE EMAIL-RECORD FROM EM-K1

**  ---> Empfaenger (max. 3 TO's moeglich)
     MOVE SPACE TO ADRESSEN
     UNSTRING EMAIL-TO OF EKONTAKT DELIMITED BY SPACE OR ";"
         INTO ADR-1
              ADR-2
              ADR-3
     END-UNSTRING
     MOVE ADR-1 TO EM-K2-TO
     WRITE EMAIL-RECORD FROM EM-K2
     IF  ADR-2 NOT = SPACE
         MOVE ADR-2 TO EM-K2-TO
         WRITE EMAIL-RECORD FROM EM-K2
     END-IF
     IF  ADR-3 NOT = SPACE
         MOVE ADR-3 TO EM-K2-TO
         WRITE EMAIL-RECORD FROM EM-K2
     END-IF

**  ---> ggf. Kopien an (max. 3 CC's moeglich)
     IF  EMAIL-CC OF EKONTAKT not = SPACE
         MOVE SPACE TO ADRESSEN
         UNSTRING EMAIL-CC OF EKONTAKT DELIMITED BY SPACE OR ";"
             INTO ADR-1
                  ADR-2
                  ADR-3
         END-UNSTRING
         MOVE ADR-1 TO EM-K3-CC
         WRITE EMAIL-RECORD FROM EM-K3
         IF  ADR-2 NOT = SPACE
             MOVE ADR-2 TO EM-K3-CC
             WRITE EMAIL-RECORD FROM EM-K3
         END-IF
         IF  ADR-3 NOT = SPACE
             MOVE ADR-3 TO EM-K3-CC
             WRITE EMAIL-RECORD FROM EM-K3
         END-IF
     END-IF
     .
 N500-99.
     EXIT.

******************************************************************
* Informationen zum Programm für E-Mail
******************************************************************
 N510-PROGRAMMINFORMATIONEN SECTION.
 N510-00.
     MOVE TEM-PRG-INFO TO EM-PZ
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ
**  ---> Programmname
     MOVE SPACES TO EM-PZ
     MOVE TEM-PRG             TO EM-PZ-HEADER
     MOVE PRG-NAME OF ABNAHME TO EM-PZ-VALUE
     WRITE EMAIL-RECORD FROM EM-PZ
**  ---> Version
     MOVE TEM-PRG-VERS        TO EM-PZ-HEADER
     MOVE VERSION OF ABNAHME  TO EM-PZ-VALUE
     WRITE EMAIL-RECORD FROM EM-PZ
**  ---> Datum
     MOVE TEM-PRG-DATUM       TO EM-PZ-HEADER
     MOVE DATUM OF ABNAHME (9:2) TO EM-PZ-VALUE
     MOVE "."                    TO EM-PZ-VALUE (3:1)
     MOVE DATUM OF ABNAHME (6:2) TO EM-PZ-VALUE (4:2)
     MOVE "."                    TO EM-PZ-VALUE (6:1)
     MOVE DATUM OF ABNAHME (1:4) TO EM-PZ-VALUE (7:4)
     WRITE EMAIL-RECORD FROM EM-PZ
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> Programm-Funktion (holen aus =ABNAHME)
     MOVE 1 TO C4-I1
     MOVE TEM-PRG-FKT         TO EM-PZ-HEADER
**  ---> Schleife über Inhalt Programm-Info
     PERFORM UNTIL C4-I1 > LEN OF PRG-INFO OF ABNAHME
             OR    PRG-ABBRUCH

         IF  VAL OF PRG-INFO OF ABNAHME (C4-I1:1) = SPACE
             ADD 1 TO C4-I1
         END-IF
         MOVE VAL OF PRG-INFO OF ABNAHME (C4-I1:) TO EM-PZ-VALUE
         WRITE EMAIL-RECORD FROM EM-PZ
         MOVE SPACES TO EM-PZ
         ADD 40 TO C4-I1

     END-PERFORM
     WRITE EMAIL-RECORD FROM EM-LZ

**  ---> Upd-Beschreibung (holen aus =ABNAHME)
     MOVE 1 TO C4-I1
     MOVE TEM-UPD-BESCHR      TO EM-PZ-HEADER
**  ---> Schleife über Inhalt Programm-Info
     PERFORM UNTIL C4-I1 > LEN OF UPD-INFO OF ABNAHME
             OR    PRG-ABBRUCH

         IF  VAL OF UPD-INFO OF ABNAHME (C4-I1:1) = SPACE
             ADD 1 TO C4-I1
         END-IF
         MOVE VAL OF UPD-INFO OF ABNAHME (C4-I1:) TO EM-PZ-VALUE
         WRITE EMAIL-RECORD FROM EM-PZ
         MOVE SPACES TO EM-PZ
         ADD 40 TO C4-I1

     END-PERFORM
     .
 N510-99.
     EXIT.

******************************************************************
* LIST-Kommando untersuchen
******************************************************************
 o030-CMD-LIST SECTION.
 o030-00.
     MOVE W-TEILSTRING (2) TO W-LIST-SUBCMD
     IF  (W-LIST-SUBCMD = "CHECKEDOUT" or = "NOTINPROD")
     and C4-ANZ > 2
**      ---> es müssen Parameter eingegeben sein
         PERFORM VARYING C4-I1 FROM 3 BY 1
                 UNTIL   C4-I1 > C4-ANZ

             IF  W-COUNT (C4-I1) > ZERO
                 EVALUATE W-TEILSTRING (C4-I1)
                     WHEN "USER"
                                     MOVE W-TEILSTRING (C4-I1) TO W-LIST-SUBPRM1
                                     ADD 1 TO C4-I1
                                     STRING  W-TEILSTRING (C4-I1)
                                             W-DELIM (C4-I1)
                                             W-TEILSTRING(C4-I1 + 1)
                                                 DELIMITED BY SPACE
                                       INTO  W-LIST-SUBPRM1-VAL
                                     END-STRING
                                     ADD 1 TO C4-I1

                     WHEN "MONTH"
                                     MOVE W-TEILSTRING (C4-I1) TO W-LIST-SUBPRM2
                                     ADD 1 TO C4-I1
                                     MOVE W-TEILSTRING (C4-I1) (1 : W-COUNT (C4-I1))
                                         TO W-LIST-SUBPRM2-VALN

                     WHEN OTHER      CONTINUE
                 END-EVALUATE
             END-IF
         END-PERFORM

     END-IF
     .
 o030-99.
     EXIT.
******************************************************************
* Anzeigen Fehler- und Hilstexte aus Tabelle SSTEXT
******************************************************************
 R100-SHOW-TEXT SECTION.
 R100-00.
**  ---> öffnen Cursor auf Tabelle SSTEXT
     PERFORM S600-OPEN-SSTEXT-CURSOR

**  ---> lesen 1. Eintrag
     PERFORM S601-FETCH-SSTEXT-CURSOR

**  ---> Schleife über alle Einträge
     PERFORM U011-AUSGABE-SPACELINE
     PERFORM UNTIL SSTEXT-EOD
         IF  TEXTE OF SSTEXT (1:1) = "@"
             MOVE W-TEXT TO ZEILE
             PERFORM U010-AUSGABE
             MOVE SPACES TO W-TEXT
         ELSE
             MOVE TEXTE OF SSTEXT TO ZEILE
             PERFORM U010-AUSGABE
         END-IF

**      ---> lesen nächsten Eintrag
         PERFORM S601-FETCH-SSTEXT-CURSOR

     END-PERFORM

**  ---> schliessen Cursor auf Tabelle SSTEXT
     PERFORM S602-CLOSE-SSTEXT-CURSOR
     PERFORM U011-AUSGABE-SPACELINE
     .
 R100-99.
     EXIT.

******************************************************************
* Select auf Tabelle SSAFE - Source Programme
******************************************************************
 S100-SELECT-SSAFE SECTION.
 S100-00.
     EXEC SQL
         SELECT  SOURCE_MODUL, SOURCE_STATUS, GROUP_USER, SOURCE_TYP
                 ,FREIGABE_TEST, FREIGABE_PROD
                 ,ZP_CHECKIN, ZP_CHECKOUT, ZPINS
                 ,ZP_FREIGABE_TEST, ZP_FREIGABE_PROD
           INTO   :SOURCE-MODUL  of SSAFE
                 ,:SOURCE-STATUS of SSAFE
                 ,:GROUP-USER    of SSAFE
                 ,:SOURCE-TYP    of SSAFE
                 ,:FREIGABE-TEST of SSAFE
                 ,:FREIGABE-PROD of SSAFE
                 ,:ZP-CHECKIN    of SSAFE
                     TYPE AS DATETIME YEAR TO SECOND
                 ,:ZP-CHECKOUT   of SSAFE
                     TYPE AS DATETIME YEAR TO SECOND
                 ,:ZPINS         of SSAFE
                     TYPE AS DATETIME YEAR TO FRACTION(2)
                 ,:ZP-FREIGABE-TEST
                     TYPE AS DATETIME YEAR TO SECOND
                 ,:ZP-FREIGABE-PROD
                     TYPE AS DATETIME YEAR TO SECOND

           FROM  =SSAFE
          WHERE  SOURCE_MODUL = :SOURCE-MODUL of SSAFE
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSF-OK TO TRUE
         WHEN 100        SET SSF-EOD TO TRUE
         WHEN OTHER      DISPLAY " "
                         MOVE SQLCODE OF SQLCA TO D-NUM4
                         DISPLAY " Fehler beim Select aus Tabelle SSAFE: "
                                 D-NUM4
                         DISPLAY " "
                         SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S100-99.
     EXIT.

******************************************************************
* Update für CHECKIN auf Tabelle SSAFE - Source Programme
******************************************************************
 S110-UPDATE-SSAFE-CHECKIN SECTION.
 S110-00.
     EXEC SQL
         UPDATE  =SSAFE
            SET   SOURCE_STATUS  = :SOURCE-STATUS OF SSAFE
                 ,GROUP_USER     = :GROUP-USER    OF SSAFE
                 ,FREIGABE_PROD  = :FREIGABE-PROD OF SSAFE
                 ,ZP_CHECKIN     = current
          WHERE  SOURCE_MODUL = :SOURCE-MODUL OF SSAFE
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSF-OK TO TRUE
         WHEN 100    PERFORM S130-INSERT-SSAFE
         WHEN OTHER
             DISPLAY "!!! Fehler bei Update (CHECKIN) in SSAFE !!!"
             SET PRG-ABBRUCH TO TRUE

     END-EVALUATE
     .
 S110-99.
     EXIT.

******************************************************************
* Update für CHECKOUT auf Tabelle SSAFE - Source Programme
******************************************************************
 S120-UPDATE-SSAFE-CHECKOUT SECTION.
 S120-00.
     EXEC SQL
         UPDATE  =SSAFE
            SET   SOURCE_STATUS  = :SOURCE-STATUS OF SSAFE
                 ,GROUP_USER     = :GROUP-USER    OF SSAFE
                 ,ZP_CHECKOUT    = current
          WHERE  SOURCE_MODUL = :SOURCE-MODUL OF SSAFE
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSF-OK TO TRUE
         WHEN OTHER
             DISPLAY "!!! Fehler bei Update (CHECKOUT) in SSAFE !!!"
             SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S120-99.
     EXIT.

******************************************************************
* Update für REL2TEST auf Tabelle SSAFE - Source Programme
******************************************************************
 S121-UPDATE-SSAFE-REL2TEST SECTION.
 S121-00.
     EXEC SQL
         UPDATE  =SSAFE
            SET   FREIGABE_TEST      = :FREIGABE-TEST OF SSAFE
                 ,GROUP_USER         = :GROUP-USER    OF SSAFE
                 ,ZP_FREIGABE_TEST   = current
          WHERE  SOURCE_MODUL = :SOURCE-MODUL OF SSAFE
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSF-OK TO TRUE
         WHEN OTHER
             DISPLAY "!!! Fehler bei Update (REL2TEST/ACTTEST) in SSAFE !!!"
             SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S121-99.
     EXIT.

******************************************************************
* Update für REL2PROD auf Tabelle SSAFE - Source Programme
******************************************************************
 S122-UPDATE-SSAFE-REL2PROD SECTION.
 S122-00.
     EXEC SQL
         UPDATE  =SSAFE
            SET   FREIGABE_PROD      = :FREIGABE-PROD OF SSAFE
                 ,GROUP_USER         = :GROUP-USER    OF SSAFE
                 ,ZP_FREIGABE_PROD   = current
          WHERE  SOURCE_MODUL = :SOURCE-MODUL OF SSAFE
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSF-OK TO TRUE
         WHEN OTHER
             DISPLAY "!!! Fehler bei Update (REL2PROD/ACTPROD) in SSAFE !!!"
             SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S122-99.
     EXIT.




******************************************************************
* Insert auf Tabelle SSAFE - Source Programme
******************************************************************
 S130-INSERT-SSAFE SECTION.
 S130-00.
     EXEC SQL
         INSERT
           INTO  =SSAFE
                 (SOURCE_MODUL, SOURCE_STATUS, GROUP_USER, SOURCE_TYP
                 ,FREIGABE_TEST, FREIGABE_PROD
                 )
         VALUES  (
                  :SOURCE-MODUL  of SSAFE
                 ,:SOURCE-STATUS of SSAFE
                 ,:GROUP-USER    of SSAFE
                 ,:SOURCE-TYP    of SSAFE
                 ,:FREIGABE-TEST of SSAFE
                 ,:FREIGABE-PROD of SSAFE
                 )
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSF-OK TO TRUE
         WHEN OTHER
             DISPLAY "!!! Fehler bei Insert in SSAFE !!!"
             SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S130-99.
     EXIT.

******************************************************************
* OPEN Cursor
******************************************************************
 S140-OPEN-SSAFE-CURSOR SECTION.
 S140-00.
     MOVE ZERO TO C4-COUNT
     IF  CURS-SSAFE
         EXEC SQL
             OPEN SSAFE_CURS
         END-EXEC
     ELSE
         EXEC SQL
             OPEN SSAFE_CURS2
         END-EXEC
     END-IF
     .
 S140-99.
     EXIT.

******************************************************************
* Fetch Texte aus Tabelle SSAFE
******************************************************************
 S141-FETCH-SSAFE-CURSOR SECTION.
 S141-00.
     IF  CURS-SSAFE
         EXEC SQL
             FETCH SSAFE_CURS
              INTO    :SOURCE-MODUL  of SSAFE
                     ,:SOURCE-STATUS of SSAFE
                     ,:GROUP-USER    of SSAFE
                     ,:SOURCE-TYP    of SSAFE
                     ,:FREIGABE-TEST of SSAFE
                     ,:FREIGABE-PROD of SSAFE
                     ,:ZP-CHECKIN    of SSAFE
                         TYPE AS DATETIME YEAR TO SECOND
                     ,:ZP-CHECKOUT   of SSAFE
                         TYPE AS DATETIME YEAR TO SECOND
                     ,:ZP-FREIGABE-TEST of SSAFE
                         TYPE AS DATETIME YEAR TO SECOND
                     ,:ZP-FREIGABE-PROD of SSAFE
                         TYPE AS DATETIME YEAR TO SECOND
         END-EXEC
     ELSE
         EXEC SQL
             FETCH SSAFE_CURS2
              INTO    :SOURCE-MODUL  of SSAFE
                     ,:SOURCE-STATUS of SSAFE
                     ,:GROUP-USER    of SSAFE
                     ,:SOURCE-TYP    of SSAFE
                     ,:FREIGABE-TEST of SSAFE
                     ,:FREIGABE-PROD of SSAFE
                     ,:ZP-CHECKIN    of SSAFE
                         TYPE AS DATETIME YEAR TO SECOND
                     ,:ZP-CHECKOUT   of SSAFE
                         TYPE AS DATETIME YEAR TO SECOND
                     ,:ZP-FREIGABE-TEST of SSAFE
                         TYPE AS DATETIME YEAR TO SECOND
                     ,:ZP-FREIGABE-PROD of SSAFE
                         TYPE AS DATETIME YEAR TO SECOND
         END-EXEC
     END-IF

     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET SSF-OK  TO TRUE
                     ADD 1 TO C4-COUNT
         WHEN OTHER  SET SSF-EOD TO TRUE
     END-EVALUATE
     .
 S141-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S142-CLOSE-SSAFE-CURSOR SECTION.
 S142-00.
     IF  CURS-SSAFE
         EXEC SQL
             CLOSE SSAFE_CURS
         END-EXEC
     ELSE
         EXEC SQL
             CLOSE SSAFE_CURS2
         END-EXEC
     END-IF
     .
 S142-99.
     EXIT.

******************************************************************
* Insert auf Tabelle SSPROT - Protokoll Aktionen im SourceSafe
******************************************************************
 S200-INSERT-SSPROT SECTION.
 S200-00.
     EXEC SQL
         INSERT
           INTO  =SSPROT
                 (SOURCE_MODUL, AKTION, GROUP_USER, KZ_FREIGABE
                 )
         VALUES  (
                  :SOURCE-MODUL of SSPROT
                 ,:AKTION       of SSPROT
                 ,:GROUP-USER   of SSPROT
                 ,:KZ-FREIGABE  of SSPROT
                 )
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSF-OK TO TRUE
         WHEN OTHER
             DISPLAY "!!! Fehler bei Insert in SSPROT !!!"
             SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S200-99.
     EXIT.

******************************************************************
* OPEN Cursor
******************************************************************
 S210-OPEN-SSPROT-CURSOR SECTION.
 S210-00.
     MOVE ZERO TO C4-COUNT
     EXEC SQL
         OPEN SSPROT_CURS
     END-EXEC
     .
 S210-99.
     EXIT.

******************************************************************
* Fetch Texte aus Tabelle SSPROT
******************************************************************
 S211-FETCH-SSPROT-CURSOR SECTION.
 S211-00.
     EXEC SQL
         FETCH SSPROT_CURS
          INTO    :SOURCE-MODUL of SSPROT
                 ,:ZPINS        of SSPROT
                     TYPE AS DATETIME YEAR TO FRACTION(2)
                 ,:AKTION       of SSPROT
                 ,:GROUP-USER   of SSPROT
                 ,:KZ-FREIGABE  of SSPROT
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET SSPROT-OK TO TRUE
                     ADD 1 TO C4-COUNT
         WHEN OTHER  SET SSPROT-EOD TO TRUE
     END-EVALUATE
     .
 S211-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S212-CLOSE-SSPROT-CURSOR SECTION.
 S212-00.
     EXEC SQL
         CLOSE SSPROT_CURS
     END-EXEC
     .
 S212-99.
     EXIT.

******************************************************************
* select auf Tabelle SSPROT (max ZPINS )
******************************************************************
 S220-SELECT-SSPROT-MAX SECTION.
 S220-00.
     EXEC SQL
         SELECT  max(zpins)
           INTO   :ZPINS of SSPROT
                     TYPE AS DATETIME YEAR TO FRACTION(2)
           FROM  =SSPROT
           WHERE SOURCE_MODUL, KZ_FREIGABE
                 =  :SOURCE-MODUL of SSPROT
                   ,:KZ-FREIGABE  of SSPROT
       BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSPROT-OK TO TRUE
         WHEN 100        SET SSPROT-EOD TO TRUE
         WHEN OTHER      DISPLAY " "
                         MOVE SQLCODE OF SQLCA TO D-NUM4
                         DISPLAY " Fehler beim Select (MAX) aus Tabelle SSPROT: "
                                 D-NUM4
                         DISPLAY " "
                         SET SSPROT-EOD TO TRUE
     END-EVALUATE
     .
 S220-99.
     EXIT.

******************************************************************
* select auf Tabelle SSPROT (alles)
******************************************************************
 S222-SELECT-SSPROT-ALL SECTION.
 S222-00.
     EXEC SQL
         SELECT  SOURCE_MODUL, ZPINS, AKTION, GROUP_USER, KZ_FREIGABE
           INTO   :SOURCE-MODUL  of SSPROT
                 ,:ZPINS         of SSPROT
                     TYPE AS DATETIME YEAR TO FRACTION(2)
                 ,:AKTION        of SSPROT
                 ,:GROUP-USER    of SSPROT
                 ,:KZ-FREIGABE   of SSPROT
           FROM  =SSPROT
           WHERE SOURCE_MODUL, ZPINS
                 =  :SOURCE-MODUL of SSPROT
                   ,:ZPINS        of SSPROT
                         TYPE as DATETIME YEAR TO FRACTION(2)
       BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSPROT-OK TO TRUE
         WHEN 100        SET SSPROT-EOD TO TRUE
         WHEN OTHER      DISPLAY " "
                         MOVE SQLCODE OF SQLCA TO D-NUM4
                         DISPLAY " Fehler beim Select (ALL) aus Tabelle SSPROT: "
                                 D-NUM4
                         DISPLAY " "
                         SET SSPROT-EOD TO TRUE
     END-EVALUATE
     .
 S222-99.
     EXIT.

******************************************************************
* select auf Tabelle SSPROT (max ZPINS )
******************************************************************
 S223-SELECT-SSPROT-MAX-ZP SECTION.
 S223-00.
     EXEC SQL
         SELECT  max(zpins)
           INTO   :ZPINS of SSPROT
                     TYPE AS DATETIME YEAR TO FRACTION(2)
           FROM  =SSPROT
          WHERE  SOURCE_MODUL, AKTION
                 =  :SOURCE-MODUL of SSPROT
                   ,:AKTION       of SSPROT
       BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSPROT-OK TO TRUE
         WHEN 100        SET SSPROT-EOD TO TRUE
         WHEN OTHER      DISPLAY " "
                         MOVE SQLCODE OF SQLCA TO D-NUM4
                         DISPLAY " Fehler beim Select (MAX-ZP) aus Tabelle SSPROT: "
                                 D-NUM4
                         DISPLAY " "
                         SET SSPROT-EOD TO TRUE
     END-EVALUATE
     .
 S223-99.
     EXIT.

******************************************************************
* select auf Tabelle SSPROT (max ZPINS ) Last-Checkin
******************************************************************
 S224-SELECT-SSPROT-MAX-CI SECTION.
 S224-00.
     EXEC SQL
         SELECT  GROUP_USER
           INTO  :GROUP-USER OF SSPROT
           FROM  =SSPROT
           WHERE SOURCE_MODUL, AKTION, ZPINS
                 =  :SOURCE-MODUL of SSPROT
                   ,:AKTION       of SSPROT
                   ,:ZPINS        of SSPROT
                         TYPE AS DATETIME YEAR TO FRACTION(2)
       BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSPROT-OK TO TRUE
         WHEN 100        SET SSPROT-EOD TO TRUE
         WHEN OTHER      DISPLAY " "
                         MOVE SQLCODE OF SQLCA TO D-NUM4
                         DISPLAY " Fehler beim Select (S224 - MAX-CI) aus Tabelle SSPROT: "
                                 D-NUM4
                         DISPLAY " "
                         SET SSPROT-EOD TO TRUE
     END-EVALUATE
     .
 S224-99.
     EXIT.

*****************************************************************
* Select auf Tabelle SSPARM - Parameter
******************************************************************
 S300-SELECT-SSPARM SECTION.
 S300-00.
     EXEC SQL
         SELECT  AKTION, SVOL_SOURCE, SVOL_DEST
           INTO   :AKTION       of SSPARM
                 ,:SVOL-SOURCE  of SSPARM
                 ,:SVOL-DEST    of SSPARM
           FROM  =SSPARM
          WHERE  AKTION = :AKTION of SSPARM
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSPRM-OK TO TRUE
         WHEN 100        SET SSPRM-EOD TO TRUE
         WHEN OTHER      DISPLAY " "
                         MOVE SQLCODE OF SQLCA TO D-NUM4
                         DISPLAY " Fehler beim Select aus Tabelle SSPARM: "
                                 D-NUM4
                         DISPLAY " "
                         SET SSPRM-EOD TO TRUE
     END-EVALUATE
     .
 S300-99.
     EXIT.

******************************************************************
* Update auf Tabelle SSPARM - Parameter
******************************************************************
 S310-UPDATE-SSPARM SECTION.
 S310-00.
     EXEC SQL
         UPDATE  =SSPARM
            SET   SVOL_SOURCE      = :SVOL-SOURCE  of SSPARM
                 ,SVOL_DEST        = :SVOL-DEST    of SSPARM
          WHERE  AKTION = :AKTION of SSPARM
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSPRM-OK TO TRUE
         WHEN OTHER  continue
     END-EVALUATE
     .
 S310-99.
     EXIT.

******************************************************************
* Select auf Tabelle SSPARM - Parameter
******************************************************************
 S320-SELECT-SSPARM-USER SECTION.
 S320-00.
     EXEC SQL
         SELECT  AKTION, SVOL_SOURCE, SVOL_DEST, ZPINS
           INTO   :AKTION      of SSPARM
                 ,:SVOL-SOURCE of SSPARM
                 ,:SVOL-DEST   of SSPARM
                 ,:ZPINS       of SSPARM
                     TYPE AS DATETIME YEAR TO FRACTION(2)
           FROM  =SSPARM
          WHERE   AKTION, SVOL_SOURCE
                 =    :AKTION      of SSPARM
                     ,:SVOL-SOURCE of SSPARM
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSPRM-OK  TO TRUE
         WHEN 100        SET SSPRM-EOD TO TRUE
         WHEN OTHER      DISPLAY " "
                         MOVE SQLCODE OF SQLCA TO D-NUM4
                         DISPLAY " Fehler beim Select aus Tabelle SSPARM: "
                                 D-NUM4
                         DISPLAY " "
                         SET SSPRM-EOD TO TRUE
     END-EVALUATE
     .
 S320-99.
     EXIT.

******************************************************************
* OPEN Cursor
******************************************************************
 S330-OPEN-SSPARM-CURSOR SECTION.
 S330-00.
     MOVE ZERO TO C4-COUNT
     EXEC SQL
         OPEN SSPARM_CURS
     END-EXEC
     .
 S330-99.
     EXIT.

******************************************************************
* Fetch Texte aus Tabelle SSPARM
******************************************************************
 S331-FETCH-SSPARM-CURSOR SECTION.
 S331-00.
     EXEC SQL
         FETCH SSPARM_CURS
          INTO    :AKTION      of SSPARM
                 ,:SVOL-SOURCE of SSPARM
                 ,:SVOL-DEST   of SSPARM
                 ,:ZPINS       of SSPARM
                     TYPE AS DATETIME YEAR TO FRACTION(2)
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET SSPRM-OK TO TRUE
                     ADD 1 TO C4-COUNT
         WHEN OTHER  SET SSPRM-EOD TO TRUE
     END-EVALUATE
     .
 S331-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S332-CLOSE-SSPARM-CURSOR SECTION.
 S332-00.
     EXEC SQL
         CLOSE SSPARM_CURS
     END-EXEC
     .
 S332-99.
     EXIT.

******************************************************************
* Insert auf Tabelle SSPROT - Protokoll Aktionen im SourceSafe
******************************************************************
 S340-INSERT-SSPARM SECTION.
 S340-00.
     EXEC SQL
         INSERT
           INTO  =SSPARM
                 (AKTION, SVOL_SOURCE, SVOL_DEST
                 )
         VALUES  (
                  :AKTION      of SSPARM
                 ,:SVOL-SOURCE of SSPARM
                 ,:SVOL-DEST   of SSPARM
                 )
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSPRM-OK TO TRUE
         WHEN OTHER
             DISPLAY "!!! Fehler bei Insert in SSPARM !!!"
             SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S340-99.
     EXIT.

******************************************************************
* Löschen Eintrag aus Tabelle SSPARM
******************************************************************
 S350-DELETE-SSPARM SECTION.
 S350-00.
     EXEC SQL
         DELETE
           FROM  =SSPARM
          WHERE  AKTION, SVOL_SOURCE
                 =  :AKTION      of SSPARM
                   ,:SVOL-SOURCE of SSPARM
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSPRM-OK TO TRUE
         WHEN 100    SET SSPRM-EOD TO TRUE
         WHEN OTHER  SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION
     END-EVALUATE
     .
 S350-99.
     EXIT.

******************************************************************
* Insert auf Tabelle WVERSION
******************************************************************
 S400-INSERT-WVERSION SECTION.
 S400-00.
     EXEC SQL
         EXECUTE IMMEDIATE :DYN-STATEMENT-BUFFER
**  ---> dynamisches SQL ersetzt folgendes:
*         INSERT
*           INTO  =VIEWVERS
*                 (PROGRAMM, VERSION, USER
*                 )
*         VALUES  (
*                  :PROGRAMM of WVERSION
*                 ,:VERSION  of WVERSION
*                 ,:USER     of WVERSION
*                 )

     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   continue
         WHEN OTHER
             MOVE SQLCODE OF SQLCA TO D-NUM4
             DISPLAY "!!! Fehler bei Insert in WVERSION ("
                     D-NUM4
                     ") !!!"
             SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S400-99.
     EXIT.

******************************************************************
* OPEN Cursor
******************************************************************
 S500-OPEN-DEFCAT-CURSOR SECTION.
 S500-00.
     MOVE ZERO TO C9-COUNT

**  ---> dynamischen SQL-Cursor definieren
     MOVE SPACE TO DYN-STATEMENT-BUFFER
     STRING  "SELECT "
             "DEF_NAME, DEF_FILE "
             ", DEF_KATALOG, DEF_TYP "
             "FROM  =DEFCAT "
             "WHERE  DEF_KATALOG = ""$WSOFT.TWCA"""
             "AND  DEF_TYP IN "
             "(""TA"", ""CA"", ""PV"")"
             "BROWSE ACCESS"
                 DELIMITED BY SIZE
       INTO  DYN-STATEMENT-BUFFER
     END-STRING

**  ---> Prepare auf Select (Cursor)
     EXEC SQL
         PREPARE S1 FROM :DYN-STATEMENT-BUFFER
     END-EXEC

**  ---> Cursor deklarieren
     EXEC SQL
         DECLARE C1 CURSOR FOR S1
     END-EXEC

**  ---> und öffnen
     EXEC SQL
         OPEN C1
     END-EXEC
     .
 S500-99.
     EXIT.

******************************************************************
* Fetch aus Tabelle DEFCAT
******************************************************************
 S510-FETCH-DEFCAT-CURSOR SECTION.
 S510-00.
     EXEC SQL
         FETCH C1
          INTO  :DEF-NAME    of DEFCAT
               ,:DEF-FILE    of DEFCAT
               ,:DEF-KATALOG of DEFCAT
               ,:DEF-TYP     of DEFCAT
     END-EXEC

     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET DEFCAT-OK  TO TRUE
                     ADD 1 TO C9-COUNT
         WHEN OTHER  SET DEFCAT-NOK TO TRUE
     END-EVALUATE
     .
 S510-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S520-CLOSE-DEFCAT-CURSOR SECTION.
 S520-00.
     EXEC SQL
         CLOSE C1
     END-EXEC
     .
 S520-99.
     EXIT.

******************************************************************
* OPEN Cursor
******************************************************************
 S600-OPEN-SSTEXT-CURSOR SECTION.
 S600-00.
     EXEC SQL
         OPEN SSTEXT_CURS
     END-EXEC
     .
 S600-99.
     EXIT.

******************************************************************
* Fetch Texte aus Tabelle SSTEXT
******************************************************************
 S601-FETCH-SSTEXT-CURSOR SECTION.
 S601-00.
     EXEC SQL
         FETCH SSTEXT_CURS
          INTO   :TEXTE OF SSTEXT
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET SSTEXT-OK TO TRUE
         WHEN OTHER  SET SSTEXT-EOD TO TRUE
     END-EVALUATE
     .
 S601-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S602-CLOSE-SSTEXT-CURSOR SECTION.
 S602-00.
     EXEC SQL
         CLOSE SSTEXT_CURS
     END-EXEC
     .
 S602-99.
     EXIT.

******************************************************************
* Öffnen Cursor auf Join für =SSUSER und =SSROLES
******************************************************************
 S620-OPEN-RECHTE-CURSOR SECTION.
 S620-00.
     MOVE ZERO TO C4-COUNT
     EXEC SQL
         OPEN RECHTE_CURS
     END-EXEC
     .
 S620-99.
     EXIT.

******************************************************************
* Fetch Funktionen für die Rollen des Users
******************************************************************
 S621-FETCH-RECHTE-CURSOR SECTION.
 S621-00.
     EXEC SQL
         FETCH RECHTE_CURS
          INTO    :USER       of SSUSER
                 ,:ROLLE      of SSUSER
                 ,:FLAG       of SSUSER
                 ,:ZPINS      of SSUSER
                     TYPE AS DATETIME YEAR TO FRACTION(2)
                 ,:FUNKTION   of SSROLES
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET USER-OK  TO TRUE
                     ADD 1 TO C4-COUNT
         WHEN OTHER  SET USER-EOD TO TRUE
     END-EVALUATE
     .
 S621-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S622-CLOSE-RECHTE-CURSOR SECTION.
 S622-00.
     EXEC SQL
         CLOSE RECHTE_CURS
     END-EXEC
     .
 S622-99.
     EXIT.

******************************************************************
* Select auf Tabelle =SSUSER
******************************************************************
 S623-SELECT-SSUSER SECTION.
 S623-00.
     EXEC SQL
         SELECT   USER, ROLLE
           INTO   :USER  of SSUSER
                 ,:ROLLE of SSUSER
           FROM  =SSUSER
          WHERE  USER, ROLLE
                 =    :USER  of SSUSER
                     ,:ROLLE of SSUSER
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET USER-OK  TO TRUE
         WHEN OTHER  SET USER-EOD TO TRUE
     END-EVALUATE
     .
 S623-99.
     EXIT.

******************************************************************
* Insert in Tabelle =SSUSER
******************************************************************
 S624-INSERT-SSUSER SECTION.
 S624-00.
     EXEC SQL
         INSERT
           INTO  =SSUSER
                 (USER, ROLLE
                 )
         VALUES  (
                  :USER  of SSUSER
                 ,:ROLLE of SSUSER
                 )
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET USER-OK  TO TRUE
         WHEN OTHER  SET USER-EOD TO TRUE
     END-EVALUATE
     .
 S624-99.
     EXIT.

******************************************************************
* Insert in Tabelle =SSUSER
******************************************************************
 S625-DELETE-SSUSER SECTION.
 S625-00.
     EXEC SQL
         DELETE
           FROM  =SSUSER
          WHERE  USER     = :USER  OF SSUSER
            AND  ROLLE LIKE :ROLLE OF SSUSER
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET USER-OK  TO TRUE
         WHEN OTHER  SET USER-EOD TO TRUE
     END-EVALUATE
     .
 S625-99.
     EXIT.

******************************************************************
* Öffnen Cursor auf =SSUSER
******************************************************************
 S630-OPEN-USER-CURSOR SECTION.
 S630-00.
     MOVE ZERO TO C4-COUNT
     EXEC SQL
         OPEN USER_CURS
     END-EXEC
     .
 S630-99.
     EXIT.

******************************************************************
* Fetch Funktionen für die Rollen des Users
******************************************************************
 S631-FETCH-USER-CURSOR SECTION.
 S631-00.
     EXEC SQL
         FETCH USER_CURS
          INTO    :USER       of SSUSER
                 ,:ROLLE      of SSUSER
                 ,:FLAG       of SSUSER
                 ,:ZPINS      of SSUSER
                     TYPE AS DATETIME YEAR TO FRACTION(2)
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET USER-OK  TO TRUE
                     ADD 1 TO C4-COUNT
         WHEN OTHER  SET USER-EOD TO TRUE
     END-EVALUATE
     .
 S631-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S632-CLOSE-USER-CURSOR SECTION.
 S632-00.
     EXEC SQL
         CLOSE USER_CURS
     END-EXEC
     .
 S632-99.
     EXIT.

******************************************************************
* Öffnen Cursor auf =SSROLES
******************************************************************
 S640-OPEN-ROLLEN-CURSOR SECTION.
 S640-00.
     MOVE ZERO TO C4-COUNT
     EXEC SQL
         OPEN ROLLEN_CURS
     END-EXEC
     .
 S640-99.
     EXIT.

******************************************************************
* Fetch Funktionen auf Rollen
******************************************************************
 S641-FETCH-ROLLEN-CURSOR SECTION.
 S641-00.
     EXEC SQL
         FETCH ROLLEN_CURS
          INTO    :ROLLE      of SSROLES
                 ,:FUNKTION   of SSROLES
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET USER-OK  TO TRUE
                     ADD 1 TO C4-COUNT
         WHEN OTHER  SET USER-EOD TO TRUE
     END-EVALUATE
     .
 S641-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S642-CLOSE-ROLLEN-CURSOR SECTION.
 S642-00.
     EXEC SQL
         CLOSE ROLLEN_CURS
     END-EXEC
     .
 S642-99.
     EXIT.

******************************************************************
* Select auf Tabelle =SSROLES
******************************************************************
 S645-SELECT-SSROLES SECTION.
 S645-00.
     EXEC SQL
         SELECT  distinct ROLLE
           INTO  :ROLLE OF SSROLES
           FROM  =SSROLES
          WHERE  ROLLE = :ROLLE OF SSROLES
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET USER-OK  TO TRUE
         WHEN OTHER  SET USER-EOD TO TRUE
     END-EVALUATE
     .
 S645-99.
     EXIT.

******************************************************************
* Einfügen initialen Eintrag in Tabelle =ABNAHME
*    über dynamisches SQL, da Tab. auf Prod.Maschine und die
*    Catalog-Tab. TRANSIDS von hier nicht zugreifba ist
******************************************************************
 S700-INSERT-ABNAHME SECTION.
 S700-00.
**  ---> Insert aufbereiten
     MOVE SPACE TO DYN-STATEMENT-BUFFER
     STRING  "INSERT INTO =ABNAHME "         delimited by size
             "(PRG_NAME, VERSION, DATUM, "   delimited by size
             "PRG_INFO, UPD_INFO, "          delimited by size
             "REL2TEST_VON, REL2TEST_AM"     delimited by size
             ") VALUES "                     delimited by size
             "("""                           delimited by size
             PRG-NAME OF ABNAHME             delimited by space
             ""","""                         delimited by size
             VERSION  OF ABNAHME             delimited by space
             """,?DATUM,"""                  delimited by size
             VAL OF PRG-INFO OF ABNAHME      DELIMITED BY K-SPACES32
             ""","""                         delimited by size
             VAL OF UPD-INFO OF ABNAHME      delimited by K-SPACES32
             ""","""                         delimited by size
             REL2TEST-VON OF ABNAHME         delimited by space
             """, current year to minute"    delimited by size
             ")"                             delimited by size
       INTO  DYN-STATEMENT-BUFFER
     END-STRING

**  ---> Insert ausführen
     PERFORM U100-BEGIN
     EXEC SQL
         PREPARE INS1 FROM :DYN-STATEMENT-BUFFER
     END-EXEC
     EXEC SQL
         EXECUTE INS1 USING
                      :DATUM       OF ABNAHME TYPE AS DATETIME YEAR TO DAY
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   CONTINUE
                     PERFORM U110-COMMIT
         when -8227
                     MOVE "FEHLER"   TO BEREICH   OF SSTEXT
                     MOVE "FEHL-039" TO KATEGORIE OF SSTEXT
                     SET PRG-ABBRUCH TO TRUE
                     PERFORM U120-ROLLBACK
         WHEN OTHER
             MOVE SQLCODE OF SQLCA TO D-NUM4
             DISPLAY "!!! Fehler bei Insert in =ABNAHME ("
                     D-NUM4
                     ") !!!"
             SET PRG-ABBRUCH TO TRUE
             PERFORM U120-ROLLBACK
     END-EVALUATE
     .
 S700-99.
     EXIT.

******************************************************************
* Update auf Tabelle =ABNAHME für Aktivierung TEST (SSF: AT)
******************************************************************
 S710-UPDATE-ABNAHME-WE1 SECTION.
 S710-00.
**  ---> hier sollen die Felder ACT2TEST_VON, ACT2TEST_AM
**  ---> eingefügt werden.
     MOVE SPACE TO DYN-STATEMENT-BUFFER
     STRING  "UPDATE =ABNAHME "              delimited by size
             "SET   ACT2TEST_VON = """       delimited by size
             ACT2TEST-VON OF ABNAHME         delimited by space
             """,ACT2TEST_AM  = current "    delimited by size
             "WHERE  PRG_NAME, VERSION = """ delimited by size
             PRG-NAME OF ABNAHME             delimited by space
             ""","""                         delimited by size
             VERSION  OF ABNAHME             delimited by space
             """"                            delimited by size
       INTO  DYN-STATEMENT-BUFFER
     END-STRING

**  ---> Update ausführen
     EXEC SQL
         EXECUTE IMMEDIATE :DYN-STATEMENT-BUFFER
     END-EXEC

     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSF-OK TO TRUE
         WHEN OTHER  MOVE SQLCODE OF SQLCA TO D-NUM4
                     DISPLAY "!!! Fehler bei Update (WE1) =ABNAHME ("
                             D-NUM4 ") !!!"
                     SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S710-99.
     EXIT.

******************************************************************
* Update auf Tabelle =ABNAHME für Freigabe-Antrag (SSF: R4W)
******************************************************************
 S712-UPDATE-ABNAHME-WE2 SECTION.
 S712-00.
**  ---> hier sollen die Felder freigabe_antrag_von, freigabe_antrag_am
**                            , upd_info, auftrag_link, auftrag_am
**                            , auftrag_von, konzept_link, testprot_link
**  ---> eingefügt werden.
     MOVE SPACE TO DYN-STATEMENT-BUFFER
     STRING  "UPDATE =ABNAHME "              delimited by size
             "SET FREIGABE_ANTRAG_VON = """  delimited by size
             FREIGABE-ANTRAG-VON OF ABNAHME  delimited by space
             """,FREIGABE_ANTRAG_AM"         delimited by size
             " = current year to minute, "   delimited by size
             "AUFTRAG_LINK = """             delimited by size
             VAL OF AUFTRAG-LINK OF ABNAHME  delimited by "   "
             """, AUFTRAG_AM = "             delimited by size
             "?AUFDATUM, "                   delimited by size
             "AUFTRAG_VON = """              delimited by size
             AUFTRAG-VON of ABNAHME          delimited by "   "
             """, KONZEPT_LINK = """         delimited by size
             VAL OF KONZEPT-LINK OF ABNAHME  delimited by "   "
             """, TESTPROT_LINK = """        delimited by size
             VAL OF TESTPROT-LINK OF ABNAHME delimited by "   "
             """ WHERE PRG_NAME, VERSION = """ delimited by size
             PRG-NAME OF ABNAHME             delimited by space
             ""","""                         delimited by size
             VERSION  OF ABNAHME             delimited by space
             """"                            delimited by size
       INTO  DYN-STATEMENT-BUFFER
     END-STRING

**  ---> Update ausführen
     EXEC SQL
         PREPARE UPD2 FROM :DYN-STATEMENT-BUFFER
     END-EXEC
     EXEC SQL
         EXECUTE UPD2 USING
                      :AUFTRAG-AM  OF ABNAHME TYPE AS DATETIME YEAR TO DAY
     END-EXEC

     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSF-OK TO TRUE
         WHEN OTHER  MOVE SQLCODE OF SQLCA TO D-NUM4
                     DISPLAY "!!! Fehler bei Update (WE2) =ABNAHME ("
                             D-NUM4 ") !!!"
                     SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S712-99.
     EXIT.

******************************************************************
* Update auf Tabelle =ABNAHME für Freigabe-Produktion (SSF: R2P)
******************************************************************
 S714-UPDATE-ABNAHME-WE3 SECTION.
 S714-00.
**  ---> hier sollen die Felder FREIGABE_LINK, GRUND_SOS,
**  --->                        REL2PROD_VON und REL2PROD_AM
**  ---> eingefügt werden.
     MOVE SPACE TO DYN-STATEMENT-BUFFER
     STRING  "UPDATE =ABNAHME "              delimited by size
             "SET FREIGABE_LINK = """        delimited by size
             VAL OF FREIGABE-LINK OF ABNAHME delimited by space
             """, GRUND_SOS = """            delimited by size
             VAL OF GRUND-SOS OF ABNAHME     delimited by "   "
             """, NK_STATUS = """            delimited by size
             NK-STATUS OF ABNAHME            delimited by space
             """, REL2PROD_VON = """         delimited by size
             REL2PROD-VON OF ABNAHME         delimited by space
             """, REL2PROD_AM "              delimited by size
             "= current YEAR to MINUTE"      delimited by size
             " WHERE PRG_NAME, VERSION = """ delimited by size
             PRG-NAME OF ABNAHME             delimited by space
             ""","""                         delimited by size
             VERSION  OF ABNAHME             delimited by space
             """"                            delimited by size
       INTO  DYN-STATEMENT-BUFFER
     END-STRING

**  ---> Update ausführen
     EXEC SQL
         EXECUTE IMMEDIATE :DYN-STATEMENT-BUFFER
     END-EXEC

     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSF-OK TO TRUE
         WHEN OTHER  MOVE SQLCODE OF SQLCA TO D-NUM4
                     DISPLAY "!!! Fehler bei Update (WE3) =ABNAHME !!! ("
                             D-NUM4 ")"
                     SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S714-99.
     EXIT.

******************************************************************
* Update auf Tabelle =ABNAHME für Freigabe-Produktion (SSF: R2P)
******************************************************************
 S716-UPDATE-ABNAHME-WE4 SECTION.
 S716-00.
**  ---> hier sollen die Felder FREIGABE_LINK, GRUND_SOS,
**  --->                        REL2PROD_VON und REL2PROD_AM
**  ---> eingefügt werden.
     MOVE SPACE TO DYN-STATEMENT-BUFFER
     STRING  "UPDATE =ABNAHME "              delimited by size
             "SET NK_STATUS = """            delimited by size
             NK-STATUS OF ABNAHME            delimited by space
             """, NK_VON = """               delimited by size
             NK-VON OF ABNAHME               delimited by space
             """, NK_AM "                    delimited by size
             "= current YEAR to MINUTE"      delimited by size
             " WHERE PRG_NAME, VERSION = """ delimited by size
             PRG-NAME OF ABNAHME             delimited by space
             ""","""                         delimited by size
             VERSION  OF ABNAHME             delimited by space
             """"                            delimited by size
       INTO  DYN-STATEMENT-BUFFER
     END-STRING

**  ---> Update ausführen
     EXEC SQL
         EXECUTE IMMEDIATE :DYN-STATEMENT-BUFFER
     END-EXEC

     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSF-OK TO TRUE
         WHEN OTHER  MOVE SQLCODE OF SQLCA TO D-NUM4
                     DISPLAY "!!! Fehler bei Update (WE4) =ABNAHME !!! ("
                             D-NUM4 ")"
                     SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S716-99.
     EXIT.

******************************************************************
* Select auf Tabelle =ABNAHME
******************************************************************
 S720-OPEN-ABNAHME-CURSOR SECTION.
 S720-00.
     MOVE ZERO TO C9-COUNT

**  ---> dynamischen SQL-Cursor definieren
     MOVE SPACE TO DYN-STATEMENT-BUFFER
     STRING  "SELECT "                             delimited by size
             "PRG_NAME, VERSION, DATUM,"           delimited by size
             "PRG_INFO, UPD_INFO, "                delimited by size
             "FREIGABE_VON, FREIGABE_AM, "         delimited by size
             "AUFTRAG_LINK, AUFTRAG_AM, "          delimited by size
             "AUFTRAG_VON, REL2TEST_VON, "         delimited by size
             "FREIGABE_ANTRAG_VON, "               delimited by size
             "FREIGABE_ANTRAG_AM, "                delimited by size
             "FREIGABE_VON, "                      delimited by size
             "FREIGABE_AM, "                       delimited by size
             "FREIGABE_LINK, "                     delimited by size
             "GRUND_SOS, "                         delimited by size
             "REL2PROD_VON, "                      delimited by size
             "REL2PROD_AM "                        delimited by size
             "FROM  =ABNAHME "                     delimited by size
             "WHERE  PRG_NAME, VERSION = """       delimited by size
             PRG-NAME OF ABNAHME                   delimited by space
             ""","""                               delimited by size
             VERSION  OF ABNAHME                   delimited by space
             """ BROWSE ACCESS"                    delimited by size
       INTO  DYN-STATEMENT-BUFFER
     END-STRING

**  ---> Prepare auf Select (Cursor)
     EXEC SQL
         PREPARE S2 FROM :DYN-STATEMENT-BUFFER
     END-EXEC

**  ---> Cursor deklarieren
     EXEC SQL
         DECLARE C2 CURSOR FOR S2
     END-EXEC

**  ---> und öffnen
     EXEC SQL
         OPEN C2
     END-EXEC
     .
 S720-99.
     EXIT.

******************************************************************
* Fetch aus Tabelle =ABNAHME
******************************************************************
 S721-FETCH-ABNAHME-CURSOR SECTION.
 S721-00.
     EXEC SQL
         FETCH C2
          INTO  :PRG-NAME            of ABNAHME
               ,:VERSION             of ABNAHME
               ,:DATUM               of ABNAHME
                     TYPE AS DATETIME YEAR TO DAY
               ,:PRG-INFO            of ABNAHME
               ,:UPD-INFO            of ABNAHME
               ,:FREIGABE-VON        of ABNAHME
               ,:FREIGABE-AM         of ABNAHME
                     TYPE AS DATETIME YEAR TO MINUTE
               ,:AUFTRAG-LINK        of ABNAHME
               ,:AUFTRAG-AM          of ABNAHME
                     TYPE AS DATETIME YEAR TO DAY
               ,:AUFTRAG-VON         of ABNAHME
               ,:REL2TEST-VON        of ABNAHME
               ,:FREIGABE-ANTRAG-VON of ABNAHME
               ,:FREIGABE-ANTRAG-AM  of ABNAHME
                     TYPE AS DATETIME YEAR TO MINUTE
               ,:FREIGABE-VON        of ABNAHME
               ,:FREIGABE-AM         of ABNAHME
                     TYPE AS DATETIME YEAR TO MINUTE
               ,:FREIGABE-LINK       of ABNAHME
               ,:GRUND-SOS           of ABNAHME
               ,:REL2PROD-VON        of ABNAHME
               ,:REL2PROD-AM         of ABNAHME
                     TYPE AS DATETIME YEAR TO MINUTE
     END-EXEC

     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET REF-TABS-OK  TO TRUE
                     ADD 1 TO C9-COUNT
         WHEN 100    SET REF-TABS-NOK TO TRUE
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
     END-EVALUATE
     .
 S721-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S722-CLOSE-ABNAHME-CURSOR SECTION.
 S722-00.
     EXEC SQL
         CLOSE C2
     END-EXEC
     .
 S722-99.
     EXIT.

******************************************************************
* Löschen Eintrag aus Tabelle ABNAHME
******************************************************************
 S730-DELETE-ABNAHME SECTION.
 S730-00.
     MOVE SPACE TO DYN-STATEMENT-BUFFER
     STRING  "DELETE "                             delimited by size
             "FROM  =ABNAHME "                     delimited by size
             "WHERE PRG_NAME, VERSION = """        delimited by size
             PRG-NAME OF ABNAHME                   delimited by space
             ""","""                               delimited by size
             VERSION  OF ABNAHME                   delimited by space
             """"                                  delimited by size
       INTO  DYN-STATEMENT-BUFFER
     END-STRING

**  ---> Delete ausführen
     PERFORM U100-BEGIN
     EXEC SQL
         EXECUTE IMMEDIATE :DYN-STATEMENT-BUFFER
     END-EXEC

     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSF-OK TO TRUE
                     PERFORM U110-COMMIT
         WHEN OTHER  MOVE SQLCODE OF SQLCA TO D-NUM4
                     DISPLAY "!!! Fehler bei Delete =ABNAHME !!!  ("
                             D-NUM4 ")"
                     SET PRG-ABBRUCH TO TRUE
                     PERFORM U120-ROLLBACK
     END-EVALUATE
     .
 S730-99.
     EXIT.

******************************************************************
* Select auf Tabelle =ABNAHME wg. Anzeigen offene Freigabeanträge
******************************************************************
 S740-OPEN-ABNAHME-A-CURSOR SECTION.
 S740-00.
     MOVE ZERO TO C4-COUNT

**  ---> dynamischen SQL-Cursor definieren
     MOVE SPACE TO DYN-STATEMENT-BUFFER
     STRING  "SELECT "                             delimited by size
             "PRG_NAME, VERSION, DATUM, "          delimited by size
             "FREIGABE_ANTRAG_VON, "               delimited by size
             "FREIGABE_ANTRAG_AM "                 delimited by size
             "FROM =ABNAHME "                      delimited by size
             "WHERE FREIGABE_ANTRAG_VON <> "" """  delimited by size
             " and FREIGABE_ANTRAG_AM <> "         delimited by size
             "?DATUM"                              delimited by size
*             " type as datetime year to minute"    delimited by size
             " and FREIGABE_VON = "" """           delimited by size
*             """ and FREIGABE_VON = "" """         delimited by size
             " and FREIGABE_AM  = "                delimited by size
             "?DATUM"                              delimited by size
*             " type as datetime year to minute"    delimited by size
             " ORDER BY PRG_NAME"                  delimited by size
*             """ ORDER BY PRG_NAME"                delimited by size
             " BROWSE ACCESS"                      delimited by size
       INTO  DYN-STATEMENT-BUFFER
     END-STRING

**  ---> Prepare auf Select (Cursor)
     EXEC SQL
         PREPARE S3 FROM :DYN-STATEMENT-BUFFER
     END-EXEC

*    Beschreibung input-Paramaeter durch sql
     EXEC SQL
          DESCRIBE INPUT S3
          INTO :IN-SQLDA NAMES INTO :INPARAM-NAMESBUFF
     END-EXEC

*    input/output des Statements mit SQLADDR verpointern
     ENTER TAL "SQLADDR" USING H-DEFAULT-DATUM
                GIVING VAR-PTR OF SQLVAR OF IN-SQLDA (1)

**  ---> Cursor deklarieren
     EXEC SQL
         DECLARE C3 CURSOR FOR S3
     END-EXEC

**  ---> und öffnen
     EXEC SQL
         OPEN C3 USING DESCRIPTOR :IN-SQLDA
     END-EXEC
     .
 S740-99.
     EXIT.

******************************************************************
* Fetch aus Tabelle =ABNAHME
******************************************************************
 S741-FETCH-ABNAHME-A-CURSOR SECTION.
 S741-00.
     EXEC SQL
         FETCH C3
          INTO  :PRG-NAME            of ABNAHME
               ,:VERSION             of ABNAHME
               ,:DATUM               of ABNAHME
                     TYPE AS DATETIME YEAR TO DAY
               ,:FREIGABE-ANTRAG-VON of ABNAHME
               ,:FREIGABE-ANTRAG-AM  of ABNAHME
                     TYPE AS DATETIME YEAR TO MINUTE
     END-EXEC

     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET SSF-OK  TO TRUE
                     ADD 1 TO C4-COUNT
         WHEN 100    SET SSF-EOD TO TRUE
         WHEN OTHER  SET SSF-EOD TO TRUE
     END-EVALUATE
     .
 S741-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S742-CLOSE-ABNAHME-A-CURSOR SECTION.
 S742-00.
     EXEC SQL
         CLOSE C3
     END-EXEC
     .
 S742-99.
     EXIT.

******************************************************************
* Select auf Tabelle =ABNAHME
******************************************************************
 S750-OPEN-ABNAHME-S-CURSOR SECTION.
 S750-00.
     MOVE ZERO TO C9-COUNT

**  ---> dynamischen SQL-Cursor definieren
     MOVE SPACE TO DYN-STATEMENT-BUFFER
     STRING  "SELECT "                             delimited by size
             "PRG_NAME, VERSION, DATUM,"           delimited by size
             "PRG_INFO, UPD_INFO, "                delimited by size
             "FREIGABE_VON, FREIGABE_AM, "         delimited by size
             "AUFTRAG_LINK, AUFTRAG_AM, "          delimited by size
             "AUFTRAG_VON, REL2TEST_VON, "         delimited by size
             "FREIGABE_ANTRAG_VON, "               delimited by size
             "FREIGABE_ANTRAG_AM, "                delimited by size
             "FREIGABE_VON, "                      delimited by size
             "FREIGABE_AM, "                       delimited by size
             "FREIGABE_LINK, "                     delimited by size
             "GRUND_SOS, "                         delimited by size
             "REL2PROD_VON, "                      delimited by size
             "REL2PROD_AM "                        delimited by size
             "FROM  =ABNAHME "                     delimited by size
             "WHERE  NK_STATUS = """               delimited by size
             NK-STATUS OF ABNAHME                  delimited by space
             """ and PRG_NAME like """             delimited by size
             PRG-NAME OF ABNAHME                   delimited by space
             """ and VERSION like """              delimited by size
             VERSION OF ABNAHME                    delimited by space
             """ BROWSE ACCESS"                    delimited by size
       INTO  DYN-STATEMENT-BUFFER
     END-STRING

**  ---> Prepare auf Select (Cursor)
     EXEC SQL
         PREPARE S4 FROM :DYN-STATEMENT-BUFFER
     END-EXEC

**  ---> Cursor deklarieren
     EXEC SQL
         DECLARE C4 CURSOR FOR S4
     END-EXEC

**  ---> und öffnen
     EXEC SQL
         OPEN C4
     END-EXEC
     .
 S750-99.
     EXIT.

******************************************************************
* Fetch aus Tabelle =ABNAHME
******************************************************************
 S751-FETCH-ABNAHME-S-CURSOR SECTION.
 S751-00.
     EXEC SQL
         FETCH C4
          INTO  :PRG-NAME            of ABNAHME
               ,:VERSION             of ABNAHME
               ,:DATUM               of ABNAHME
                     TYPE AS DATETIME YEAR TO DAY
               ,:PRG-INFO            of ABNAHME
               ,:UPD-INFO            of ABNAHME
               ,:FREIGABE-VON        of ABNAHME
               ,:FREIGABE-AM         of ABNAHME
                     TYPE AS DATETIME YEAR TO MINUTE
               ,:AUFTRAG-LINK        of ABNAHME
               ,:AUFTRAG-AM          of ABNAHME
                     TYPE AS DATETIME YEAR TO DAY
               ,:AUFTRAG-VON         of ABNAHME
               ,:REL2TEST-VON        of ABNAHME
               ,:FREIGABE-ANTRAG-VON of ABNAHME
               ,:FREIGABE-ANTRAG-AM  of ABNAHME
                     TYPE AS DATETIME YEAR TO MINUTE
               ,:FREIGABE-VON        of ABNAHME
               ,:FREIGABE-AM         of ABNAHME
                     TYPE AS DATETIME YEAR TO MINUTE
               ,:FREIGABE-LINK       of ABNAHME
               ,:GRUND-SOS           of ABNAHME
               ,:REL2PROD-VON        of ABNAHME
               ,:REL2PROD-AM         of ABNAHME
                     TYPE AS DATETIME YEAR TO MINUTE
     END-EXEC

     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET DYNCURS-OK  TO TRUE
                     ADD 1 TO C9-COUNT
         WHEN 100    SET DYNCURS-EOD TO TRUE
         WHEN OTHER  SET DYNCURS-EOD TO TRUE
     END-EVALUATE
     .
 S751-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S752-CLOSE-ABNAHME-S-CURSOR SECTION.
 S752-00.
     EXEC SQL
         CLOSE C4
     END-EXEC
     .
 S752-99.
     EXIT.

******************************************************************
* lesen Tabelle EKONTAKT
******************************************************************
 S790-SELECT-EKONTAKT SECTION.
 S790-00.
     EXEC SQL
         SELECT  EMAIL_TO, EMAIL_CC, EMAIL_FROM
           INTO   :EMAIL-TO   OF EKONTAKT
                 ,:EMAIL-CC   OF EKONTAKT
                 ,:EMAIL-FROM OF EKONTAKT
           FROM  =EKONTAKT
          WHERE  MODUL, MDNR, TSNR
                 =  :MODUL OF EKONTAKT
                   ,:MDNR  OF EKONTAKT
                   ,:TSNR  OF EKONTAKT
         BROWSE  ACCESS
     END-EXEC

     EVALUATE SQLCODE OF SQLCA
         WHEN 0      continue
         WHEN OTHER  SET PRG-ABBRUCH TO TRUE
                     DISPLAY " !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                     DISPLAY " !!!!!    Keine EKONTAKT Daten vorhanden     !!!!!"
                     DISPLAY " !!!!! Ausgabe unverschlüsselt nicht möglich !!!!!"
                     DISPLAY " !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                     EXIT SECTION
     END-EVALUATE
     .
 S790-99.
      EXIT.

******************************************************************
* Löschen Referenztabellen einträge
******************************************************************
 S800-DELETE-REF-TABS SECTION.
 S800-00.
     SET REF-TABS-OK TO TRUE
     EXEC SQL
         DELETE
           FROM  =PROGRAMS
          WHERE  PROGRAMM = :PROGRAMM OF PROGRAMS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   CONTINUE
         WHEN 100    CONTINUE
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
                     EXIT SECTION
     END-EVALUATE

     EXEC SQL
         DELETE
           FROM  =PROGRAMX
          WHERE  PROGRAMM = :PROGRAMM OF PROGRAMX
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   CONTINUE
         WHEN 100    CONTINUE
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
                     EXIT SECTION
     END-EVALUATE

     EXEC SQL
         DELETE
           FROM  =LIBS
          WHERE  PROGRAMM = :PROGRAMM OF LIBS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   CONTINUE
         WHEN 100    CONTINUE
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
                     EXIT SECTION
     END-EVALUATE

     EXEC SQL
         DELETE
           FROM  =TABS
          WHERE  PROGRAMM = :PROGRAMM OF TABS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   CONTINUE
         WHEN 100    CONTINUE
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
                     EXIT SECTION
     END-EVALUATE
     .
 S800-99.
     EXIT.

******************************************************************
* Insert in Ref-Tab PROGRAMS
******************************************************************
 S810-INSERT-PROGRAMS SECTION.
 S810-00.
     PERFORM U100-BEGIN
     EXEC SQL
         INSERT
           INTO  =PROGRAMS
                 (PROGRAMM, SPRACHE
                 )
         VALUES  (
                   :PROGRAMM  OF PROGRAMS
                  ,:SPRACHE   OF PROGRAMS
                 )
     END-EXEC

     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   PERFORM U110-COMMIT
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
                     PERFORM U120-ROLLBACK
                     DISPLAY " !!! Insert in PROGRAMS fehlgeschlagen - Fkt.-Abbruch !!!"
                     EXIT SECTION
     END-EVALUATE
     .
 S810-99.
     EXIT.

******************************************************************
* Einfuegen in Ref-Tabelle PROGRAMX
******************************************************************
 S820-INSERT-PROGRAMX SECTION.
 S820-00.
     PERFORM U100-BEGIN
     EXEC SQL
        INSERT
          INTO   =PROGRAMX
                 (PROGRAMM, PMODUL
                 )
        VALUES   (
                  :PROGRAMM  OF PROGRAMX
                 ,:PMODUL    OF PROGRAMX
                 )
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   PERFORM U110-COMMIT
         WHEN -8227  PERFORM U110-COMMIT
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
                     PERFORM U120-ROLLBACK
                     DISPLAY " !!! Insert in PROGRAMX fehlgeschlagen - Fkt.-Abbruch !!!"
                     EXIT SECTION
     END-EVALUATE
     .
 S820-99.
     EXIT.

******************************************************************
* Lesen Tabelle PROGRAMX
******************************************************************
 S825-SELECT-PROGRAMX SECTION.
 S825-00.
     SET REF-TABS-OK TO TRUE
     EXEC SQL
         SELECT  PROGRAMM, PMODUL
           INTO   :PROGRAMM  of PROGRAMX
                 ,:PMODUL    of PROGRAMX
           FROM  =PROGRAMX
          WHERE  PROGRAMM, PMODUL
                 = :PROGRAMM of PROGRAMX
                  ,:PMODUL   of PROGRAMX
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   continue
         WHEN -8222  continue
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
     END-EVALUATE
     .
 S825-99.
     EXIT.

******************************************************************
* Einfuegen in Ref-Tabelle LIBS
******************************************************************
 S830-INSERT-LIBS SECTION.
 S830-00.
     PERFORM U100-BEGIN

     EXEC SQL
        INSERT
          INTO   =LIBS
                 (LIB, CMODUL, PROGRAMM
                 )
        VALUES   (
                  :LIB       OF LIBS
                 ,:CMODUL    OF LIBS
                 ,:PROGRAMM  OF LIBS
                 )
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   PERFORM U110-COMMIT
         WHEN -8227  PERFORM U110-COMMIT
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
                     PERFORM U120-ROLLBACK
                     DISPLAY " !!! Insert in LIBS fehlgeschlagen - Fkt.-Abbruch !!!"
                     EXIT SECTION
     END-EVALUATE
       .
 S830-99.
     EXIT.

******************************************************************
* Lesen Tabelle PROGRAMS
******************************************************************
 S840-SELECT-PROGRAMS SECTION.
 S840-00.
     EXEC SQL
         SELECT  PROGRAMM, VERSION, VERS_DAT, SPRACHE, BESCHREIBUNG
           INTO   :PROGRAMM     OF PROGRAMS
                 ,:VERSION      OF PROGRAMS
                 ,:VERS-DAT     OF PROGRAMS
                     TYPE AS DATETIME YEAR TO DAY
                 ,:SPRACHE      OF PROGRAMS
                 ,:BESCHREIBUNG OF PROGRAMS
           FROM  =PROGRAMS
          WHERE  PROGRAMM = :PROGRAMM OF PROGRAMS
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   continue
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
     END-EVALUATE
     .
 S840-99.
     EXIT.

******************************************************************
* Ändern Ref-Tabelle PROGRAMS
******************************************************************
 S845-UPDATE-PRG-AEND SECTION.
 S845-00.
     PERFORM U100-BEGIN

     EXEC SQL
         UPDATE  =PROGRAMS
            SET  VERS_DAT = :VERS-DAT OF PROGRAMS
                                 TYPE AS DATETIME YEAR TO DAY
          WHERE  PROGRAMM = :PROGRAMM OF PROGRAMS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   PERFORM U110-COMMIT
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
                     PERFORM U120-ROLLBACK
                     DISPLAY " !!! Update in PROGRAMS-VDAT fehlgeschlagen - Fkt.-Abbruch !!!"
                     EXIT SECTION
     END-EVALUATE
     .
 S845-99.
     EXIT.

******************************************************************
* Ändern Ref-Tabelle PROGRAMS
******************************************************************
 S846-UPDATE-PRG-VERS SECTION.
 S846-00.
     PERFORM U100-BEGIN

     EXEC SQL
         UPDATE  =PROGRAMS
            SET  VERSION = :VERSION OF PROGRAMS
          WHERE  PROGRAMM = :PROGRAMM OF PROGRAMS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   PERFORM U110-COMMIT
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
                     PERFORM U120-ROLLBACK
                     DISPLAY " !!! Update in PROGRAMS-VERS fehlgeschlagen - Fkt.-Abbruch !!!"
                     EXIT SECTION
     END-EVALUATE
     .
 S846-99.
     EXIT.

******************************************************************
* Ändern Ref-Tabelle PROGRAMS
******************************************************************
 S847-UPDATE-PRG-DESCR SECTION.
 S847-00.
     PERFORM U100-BEGIN

     EXEC SQL
         UPDATE  =PROGRAMS
            SET  BESCHREIBUNG = :BESCHREIBUNG OF PROGRAMS
          WHERE  PROGRAMM = :PROGRAMM OF PROGRAMS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   PERFORM U110-COMMIT
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
                     PERFORM U120-ROLLBACK
                     DISPLAY " !!! Update in PROGRAMS-DESCR fehlgeschlagen - Fkt.-Abbruch !!!"
                     EXIT SECTION
     END-EVALUATE
     .
 S847-99.
     EXIT.

******************************************************************
* Einfügen in Ref-Tabelle TABS
******************************************************************
 S850-INSERT-TABS SECTION.
 S850-00.
     PERFORM U100-BEGIN

     EXEC SQL
        INSERT
          INTO   =TABS
                 (PROGRAMM, TABELLE
                 )
        VALUES   (
                  :PROGRAMM  OF TABS
                 ,:TABELLE   OF TABS
                 )
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   PERFORM U110-COMMIT
         WHEN -8227  PERFORM U110-COMMIT
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
                     PERFORM U120-ROLLBACK
                     DISPLAY " !!! Insert in TABS fehlgeschlagen - Fkt.-Abbruch !!!"
                     EXIT SECTION
     END-EVALUATE
     .
 S850-99.
      EXIT.

******************************************************************
* öffnen Cursor für Funktion MODIS, Referenzen Modul in Programmen
******************************************************************
 S860-OPEN-MODIS-CURSOR SECTION.
 S860-00.
     EXEC SQL
         OPEN MODIS_CURS
     END-EXEC
     MOVE ZERO TO C4-COUNT
     .
 S860-99.
     EXIT.

******************************************************************
* Fetch Referenzinfos für Funktion MODIS
******************************************************************
 S861-FETCH-MODIS-CURSOR SECTION.
 S861-00.
     EXEC SQL
         FETCH MODIS_CURS
          INTO    :PROGRAMM     OF PROGRAMS
                 ,:VERSION      OF PROGRAMS
                 ,:VERS-DAT     OF PROGRAMS
                     TYPE AS DATETIME YEAR TO DAY
                 ,:SPRACHE      OF PROGRAMS
                 ,:BESCHREIBUNG OF PROGRAMS
                 ,:PMODUL       OF PROGRAMX
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET REFTABS-OK  TO TRUE
                     ADD 1 TO C4-COUNT
         WHEN OTHER  SET REFTABS-EOD TO TRUE
     END-EVALUATE
     .
 S861-99.
     EXIT.

******************************************************************
* CLOSE Cursor für Funktion MODIS
******************************************************************
 S862-CLOSE-MODIS-CURSOR SECTION.
 S862-00.
     EXEC SQL
         CLOSE MODIS_CURS
     END-EXEC
     .
 S862-99.
     EXIT.

******************************************************************
* öffnen Cursor für Funktion MODIN, Referenzen Modul in Programmen
******************************************************************
 S870-OPEN-MODIN-CURSOR SECTION.
 S870-00.
     EXEC SQL
         OPEN MODIN_CURS
     END-EXEC
     MOVE ZERO TO C4-COUNT
     .
 S870-99.
     EXIT.

******************************************************************
* Fetch Referenzinfos für Funktion MODIN
******************************************************************
 S871-FETCH-MODIN-CURSOR SECTION.
 S871-00.
     EXEC SQL
         FETCH MODIN_CURS
          INTO    :PROGRAMM     OF PROGRAMS
                 ,:VERSION      OF PROGRAMS
                 ,:VERS-DAT     OF PROGRAMS
                     TYPE AS DATETIME YEAR TO DAY
                 ,:SPRACHE      OF PROGRAMS
                 ,:BESCHREIBUNG OF PROGRAMS
                 ,:PMODUL       OF PROGRAMX
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET REFTABS-OK  TO TRUE
                     ADD 1 TO C4-COUNT
         WHEN OTHER  SET REFTABS-EOD TO TRUE
     END-EVALUATE
     .
 S871-99.
     EXIT.

******************************************************************
* CLOSE Cursor für Funktion MODIN
******************************************************************
 S872-CLOSE-MODIN-CURSOR SECTION.
 S872-00.
     EXEC SQL
         CLOSE MODIN_CURS
     END-EXEC
     .
 S872-99.
     EXIT.

******************************************************************
* lesen Eintrag Referenztabelle für Programm
******************************************************************
 S875-SELECT-PROGRAMS SECTION.
 S875-00.
     EXEC SQL
         SELECT  PROGRAMM, VERSION, VERS_DAT, SPRACHE, BESCHREIBUNG
           INTO   :PROGRAMM     OF PROGRAMS
                 ,:VERSION      OF PROGRAMS
                 ,:VERS-DAT     OF PROGRAMS
                     TYPE AS DATETIME YEAR TO DAY
                 ,:SPRACHE      OF PROGRAMS
                 ,:BESCHREIBUNG OF PROGRAMS
           FROM  =PROGRAMS
          WHERE  PROGRAMM like :PROGRAMM OF PROGRAMS
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET REF-TABS-OK  TO TRUE
         WHEN OTHER  SET REF-TABS-NOK TO TRUE
     END-EVALUATE
  .
 S875-99.
     EXIT.

******************************************************************
* Eingabe
******************************************************************
 U000-EINGABE SECTION.
 U000-00.
     MOVE EINGABE TO EINGABE-ALT
     MOVE C4-INLEN TO C4-INLEN-A
     READ HTERMINAL
          WITH PROMPT K-PROMPT-ELE (PROMPT-FLAG)
          TIME LIMIT C9-TIME-OUT
          AT END
                    PERFORM V200-PURGE-OBEYDATEI
                    SET PRG-ABBRUCH TO TRUE
                    STOP RUN
     END-READ
     MOVE HTERM-IN TO EINGABE
     MOVE ZERO TO C4-ANZ
     INSPECT EINGABE TALLYING C4-ANZ
             FOR CHARACTERS BEFORE INITIAL " "

**  ---> suchen erstes Zeichen <> Space (von hinten)
     PERFORM VARYING FC-I1 FROM 128 BY -1
             UNTIL   FC-I1 < 1
         IF  EINGABE (FC-I1:1) NOT = SPACE
             EXIT PERFORM
         END-IF
     END-PERFORM
     MOVE FC-I1 TO C4-INLEN

**  ---> für Eingabe PW Gross-/Kleinschrebung zulassen
     IF  PROMPT-PASSWORT or EIN-KLEIN-GROSS
         EXIT SECTION
     END-IF

**  ---> alle anderen Eingaben ggf. von Klein- auf Grossschrift umsetzen
     INSPECT EINGABE CONVERTING "abcdefghijklmnopqrstuvwxyz"
                             TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

     IF  EINGABE = "FC" AND C4-ANZ = 2
         MOVE PROMPT-FLAG TO PROMPT-FLAG-A
         MOVE EINGABE-ALT TO FC-DATA
         MOVE C4-INLEN-A  TO FC-DATA-LEN
         MOVE 9999 TO FC-STATUS
         PERFORM V000-FC UNTIL FC-STATUS = 0
         MOVE FC-DATA (1:FC-DATA-LEN) TO EINGABE
         MOVE FC-DATA-LEN             TO C4-ANZ
                                         C4-INLEN
         MOVE PROMPT-FLAG-A TO PROMPT-FLAG
     END-IF

     IF  EIN-ASCII
**      ---> alpha Eingabe gefordert
         EXIT SECTION
     END-IF

**  ---> numerische  Eingabe gefordert
**  ---> nichts eingegeben also zurueck
     IF  C4-ANZ = ZERO
         MOVE ZERO TO C18-VAL
         EXIT SECTION
     END-IF

**  ---> Eingabe ueberpruefen, ggf. Neueingabe
     IF  EIN-ALPHA-NUM
         IF  EINGABE (1:1) = "E" and C4-ANZ = 1
             PERFORM U011-AUSGABE-SPACELINE
             EXIT SECTION
         END-IF
     ELSE
         EXIT SECTION
     END-IF
     IF  EINGABE (1:C4-ANZ) NOT NUMERIC
         MOVE " !!! numerische Eingabe erforderlich !!!" TO ZEILE
         PERFORM U010-AUSGABE
         GO TO U000-00
     END-IF
     .
 U000-99.
     EXIT.

******************************************************************
* Ausgabe
******************************************************************
 U010-AUSGABE SECTION.
 U010-00.
     IF  AUSGABE-DATEI
         WRITE LISTE-SATZ FROM ZEILE
     ELSE
         DISPLAY ZEILE
     END-IF
     MOVE SPACES TO ZEILE
        .
 U010-99.
     EXIT.

******************************************************************
* Ausgabe Leerzeile
******************************************************************
 U011-AUSGABE-SPACELINE SECTION.
 U011-00.
     MOVE SPACES TO ZEILE
     IF  AUSGABE-DATEI
         WRITE LISTE-SATZ FROM ZEILE
     ELSE
         DISPLAY ZEILE
     END-IF
        .
 U011-99.
     EXIT.

******************************************************************
* aktuelle zeit holen und in Prompt einstellen
******************************************************************
 U020-ZEIT SECTION.
 U020-00.
     ACCEPT AKT-ZEIT FROM TIME
     MOVE AKT-ZEIT (1:2) TO K-PROMPT-CMD-T (1:2)
     MOVE ":"            TO K-PROMPT-CMD-T (3:1)
     MOVE AKT-ZEIT (3:2) TO K-PROMPT-CMD-T (4:2)
     MOVE ":"            TO K-PROMPT-CMD-T (6:1)
     MOVE AKT-ZEIT (5:2) TO K-PROMPT-CMD-T (7:2)
     .
 U020-99.
     EXIT.

******************************************************************
* TIMESTAMP erstellen
******************************************************************
 U030-TIMESTAMP SECTION.
 U030-00.
     ENTER TAL "TIME" USING TAL-TIME
     MOVE CORR TAL-TIME TO TAL-TIME-D
     MOVE TAL-TT OF TAL-TIME-D TO W-HEUTE-TT
     .
 U030-99.
     EXIT.


******************************************************************
* Transactionsbegrenzungen
******************************************************************
 U100-BEGIN SECTION.
 U100-00.
     EXEC SQL
          BEGIN WORK
     END-EXEC
     .
 U100-99.
     EXIT.


 U110-COMMIT SECTION.
 U110-00.
     EXEC SQL
          COMMIT WORK
     END-EXEC
     .
 U110-99.
     EXIT.

 U120-ROLLBACK SECTION.
 U120-00.
     EXEC SQL
          ROLLBACK WORK
     END-EXEC
     .
 U120-99.
     EXIT.

******************************************************************
* Erstellen Obey Datei
*
* Eingabeparameter: AP-DNAME (muss mit dem Dateinamen besetzt sein)
******************************************************************
 U200-ERSTELLEN-OBEYDATEI SECTION.
 U200-00.
**  ---> erstmal die Ausgabe vom FUP nach $BIT bzw. gem PARAM lenken
**  ---> startup STRING erstellen
     MOVE "OUT"     TO P-PORTION
     MOVE W-FUP-OUT TO P-TEXT
     PERFORM V100-STARTUP
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> dann sicherstellen, dass Datei die Obey Datei nicht vorhanden ist
     MOVE ZERO       TO AP-STATUS
     ENTER TAL "WT^FINFOBYNAME"  USING AP-STATUS
                                       AP-DNAME

     IF  AP-STATUS = ZERO
**      ---> ist vorhanden: also löschen
         PERFORM V200-PURGE-OBEYDATEI
     END-IF

**  ---> Obey Datei erstellen dafür
**  ---> startup STRING erstellen
     MOVE "STRING" TO P-PORTION
     MOVE SPACES TO P-TEXT
     STRING  "CREATE "       DELIMITED BY SIZE
             AP-DNAME        DELIMITED BY SPACE
             ", CODE 101"    DELIMITED BY SIZE
       INTO P-TEXT
     END-STRING

     ENTER "PUTSTARTUPTEXT"  USING   P-PORTION
                                     P-TEXT
                                     P-LIST
                             GIVING  P-RESULT
     EVALUATE P-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus PUTSTARTUPTEXT
                     MOVE P-RESULT TO D-NUM4
                     STRING  "PUTSTARTUPTEXT (STRING) fehlerhaft: "
                             D-NUM4
                                 DELIMITED BY SIZE
                       INTO  ZEILE
                     END-STRING
                     DISPLAY zeile
                     EXIT SECTION

         WHEN OTHER
                     continue
     END-EVALUATE

**  ---> und nun den FPU-Prozess starten
     MOVE K-FUP TO W-PROGRAM
     PERFORM W030-CREATEPROCESS
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> abwarten bis OPEN-Flag nicht mehr gesetzt ist
     PERFORM W200-OPENINFO
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF
     .
 U200-99.
     EXIT.

******************************************************************
* Starten FUP mit Obey-Datei
*
* Eingabeparameter: AP-DNAME (muss mit dem Dateinamen besetzt sein)
******************************************************************
 U210-FUP SECTION.
 U210-00.
**  ---> startup STRING erstellen
     MOVE "STRING" TO P-PORTION
     MOVE SPACES TO P-TEXT
     STRING  "OBEY "     DELIMITED BY SIZE
             AP-DNAME    DELIMITED BY SPACE
       INTO  P-TEXT
     END-STRING

     ENTER "PUTSTARTUPTEXT"  USING   P-PORTION
                                     P-TEXT
                                     P-LIST
                             GIVING  P-RESULT
     EVALUATE P-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus PUTSTARTUPTEXT
                     MOVE P-RESULT TO D-NUM4
                     STRING  "PUTSTARTUPTEXT (STRING) fehlerhaft: "
                             D-NUM4
                                 DELIMITED BY SIZE
                       INTO  ZEILE
                     END-STRING
                     DISPLAY zeile
                     EXIT SECTION

         WHEN OTHER
                     continue
     END-EVALUATE

**  ---> und nun den FUP-Prozess starten
     MOVE K-FUP TO W-PROGRAM
     PERFORM W030-CREATEPROCESS
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF
     .
 U210-99.
     EXIT.

******************************************************************
*
******************************************************************
 U310-DECR SECTION.
 U310-00.
     MOVE SPACES TO P-HEX16
     MOVE W-UMSCHL-IN TO P-HEX8
     ENTER TAL "WT^UNHEX" USING P-HEX8
                                P-HEX16
     MOVE P-HEX16 (1:8) TO W-UMSCHL1
     MOVE P-HEX16 (9:8) TO W-UMSCHL2
     MOVE SPACES TO P-HEX16
     MOVE 1 TO C4-I2
     PERFORM VARYING C4-I1 FROM 1 BY 1
             UNTIL   C4-I1 > 8
             OR      W-UMSCHL1 (C4-I1:1) = SPACE
         MOVE W-UMSCHL1 (C4-I1:1) TO P-HEX16 (C4-I2:1)
         ADD 1 TO C4-I2
         MOVE W-UMSCHL2 (C4-I1:1) TO P-HEX16 (C4-I2:1)
         ADD 1 TO C4-I2
     END-PERFORM
     ENTER TAL "WT^HEX" USING P-HEX8
                              P-HEX16
     MOVE P-HEX8 TO W-UMSCHL-OUT
     .
 U310-99.
     EXIT.

******************************************************************
*
******************************************************************
 U320-ENCR SECTION.
 U320-00.
     MOVE SPACES TO W-UMSCHL1
                    W-UMSCHL2
     MOVE W-UMSCHL-IN TO P-HEX8
     ENTER TAL "WT^UNHEX" USING P-HEX8
                                P-HEX16
     MOVE 1 TO C4-I2
     PERFORM VARYING C4-I1 FROM 1 BY 1
             UNTIL   C4-I1 > 8
         MOVE P-HEX16 (C4-I2:1) TO W-UMSCHL1 (C4-I1:1)
         ADD 1 TO C4-I2
         MOVE P-HEX16 (C4-I2:1) TO W-UMSCHL2 (C4-I1:1)
         ADD 1 TO C4-I2
     END-PERFORM
     MOVE W-UMSCHL1 TO P-HEX16
     MOVE W-UMSCHL2 TO P-HEX16 (9:)
     ENTER TAL "WT^HEX" USING P-HEX8
                              P-HEX16
     MOVE P-HEX8 TO W-UMSCHL-OUT
     .
 U320-99.
     EXIT.

******************************************************************
* Aufbereiten Programmnamen von Source nach Object
*
*    Eingabe:    IN-SOURCE
*    Ausgabe:    OUT-SOURCE
******************************************************************
 U400-OBJECT-NAME SECTION.
 U400-00.
     MOVE ZERO TO C4-I1
     MOVE IN-SOURCE TO OUT-SOURCE
     INSPECT IN-SOURCE TALLYING C4-I1
         FOR CHARACTERS BEFORE INITIAL " "

     EVALUATE SOURCE-TYP OF SSAFE
         WHEN "CS"   MOVE "S" TO OUT-SOURCE (C4-I1:1)
         WHEN "CO"   MOVE "O" TO OUT-SOURCE (C4-I1:1)
         WHEN "CX"   MOVE " " TO OUT-SOURCE (C4-I1:1)
         WHEN OTHER
**                  ---> Fehler: Unbekannter Sourcetyp
                     MOVE "FEHLER"   TO BEREICH   OF SSTEXT
                     MOVE "FEHL-027" TO KATEGORIE OF SSTEXT
**                  ---> anzeigen Hilfstext
                     PERFORM R100-SHOW-TEXT
                     EXIT SECTION
     END-EVALUATE
     .
 U400-99.
     EXIT.

******************************************************************
* Fix Command
******************************************************************
 V000-FC SECTION.
 V000-00.
     IF  FC-DATA = SPACE
         DISPLAY "  > es gibt nichts zu korrigieren < "
         MOVE ZERO TO FC-STATUS
         EXIT SECTION
     END-IF
     MOVE PROMPT-FLAG-A TO PROMPT-FLAG

**  ---> anzeigen zu modifizierender String
     DISPLAY K-PROMPT-ELE (PROMPT-FLAG)
             FC-DATA (1:FC-DATA-LEN)
     MOVE SPACES TO HTERM-IN

**  ---> lesen modification template
     SET PROMPT-FC TO TRUE
     READ HTERMINAL
          WITH PROMPT K-PROMPT-ELE (PROMPT-FLAG)
          TIME LIMIT C9-TIME-OUT
          AT END    SET PRG-ABBRUCH TO TRUE
                    STOP RUN
     END-READ
     MOVE HTERM-IN TO FC-TEMPLATE

**  ---> suchen erstes Zeichen <> Space (von hinten)
     PERFORM VARYING FC-I1 FROM 128 BY -1
             UNTIL   FC-I1 < 1
         IF  FC-TEMPLATE (FC-I1:1) NOT = SPACE
             EXIT PERFORM
         END-IF
     END-PERFORM
     MOVE FC-I1 TO FC-TEMPLATE-LEN

     INSPECT FC-TEMPLATE CONVERTING "abcdefghijklmnopqrstuvwxyz"
                                 TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

     ENTER TAL "FIXSTRING" USING     FC-TEMPLATE
                                     FC-TEMPLATE-LEN
                                     FC-DATA
                                     FC-DATA-LEN
                                     OMITTED
                                     FC-STATUS
     .
 V000-99.
     EXIT.

******************************************************************
* ausführen STARTUPTEXT
******************************************************************
 V100-STARTUP SECTION.
 V100-00.
     ENTER "PUTSTARTUPTEXT"  USING   P-PORTION
                                     P-TEXT
                                     P-LIST
                             GIVING  P-RESULT
     EVALUATE P-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus PUTSTARTUPTEXT
                     MOVE P-RESULT TO D-NUM4
                     STRING  "PUTSTARTUPTEXT "
                             P-PORTION
                             " fehlerhaft: "
                             D-NUM4
                                 DELIMITED BY SIZE
                       INTO  ZEILE
                     END-STRING
                     DISPLAY ZEILE
                     SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION

         WHEN OTHER
                     continue
     END-EVALUATE
     .
 V100-99.
     EXIT.

******************************************************************
* Löschen Obey Datei
*
* Eingabeparameter: AP-DNAME (muss mit dem Dateinamen besetzt sein)
******************************************************************
 V200-PURGE-OBEYDATEI SECTION.
 V200-00.
**  ---> erstmal sehen, ob die Datei noch geöffnet ist
     PERFORM W200-OPENINFO
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> startup STRING erstellen
     MOVE "STRING"       TO P-PORTION

     MOVE SPACES TO P-TEXT
     STRING  "PURGE ! "  DELIMITED BY SIZE
             AP-DNAME    DELIMITED BY SPACE
       INTO  P-TEXT
     END-STRING

     ENTER "PUTSTARTUPTEXT"  USING   P-PORTION
                                     P-TEXT
                                     P-LIST
                             GIVING  P-RESULT
     EVALUATE P-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus PUTSTARTUPTEXT
                     MOVE P-RESULT TO D-NUM4
                     STRING  "PUTSTARTUPTEXT (STRING) fehlerhaft: "
                             D-NUM4
                                 DELIMITED BY SIZE
                       INTO  ZEILE
                     END-STRING
                     DISPLAY zeile
                     EXIT SECTION

         WHEN OTHER
                     continue
     END-EVALUATE

**  ---> und nun den FPU-Prozess starten
     MOVE K-FUP TO W-PROGRAM
     PERFORM W030-CREATEPROCESS
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF
     .
 V200-99.
     exit.

******************************************************************
* Aufruf PROCESSNAME_CREATE_
******************************************************************
 W010-PROCESSNAME-CREATE SECTION.
 W010-00.
     ENTER TAL "PROCESSNAME_CREATE_"  USING  P-PROC-NAME (1:P-PROC-NAME-LEN20)
                                             P-PROC-NAME-LEN
                                             K-VALUE-1
                                      GIVING P-ERROR
     IF  P-ERROR > ZERO
         EVALUATE P-ERROR
             WHEN 44     DISPLAY "No names of the specified type are available"
             WHEN 201    DISPLAY "Unable to communicate with the specified node"
             WHEN 563    DISPLAY "Output buffer is too small"
             WHEN 590    DISPLAY "Parameter or bounds error"
             WHEN OTHER  DISPLAY "sonstiger Fehler bei PROCESSNAME_CREATE_"
         END-EVALUATE
         DISPLAY " "
         SET PRG-ABBRUCH TO TRUE
     END-IF
     .
 W010-99.
     EXIT.

******************************************************************
* Aufruf COBOLFILEINFO
******************************************************************
 W020-COBOLFILEINFO SECTION.
 W020-00.
     ENTER "COBOLFILEINFO" USING
                                 HTERMINAL
                                 CFI-ERROR
                                 OMITTED
                                 CFI-FNUM
     IF  CFI-ERROR > ZERO
         MOVE CFI-ERROR TO D-NUM4
         DISPLAY " "
         DISPLAY " Fehler bei COBOLFILEINFO: "
                 D-NUM4
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF
     .
 W020-99.
     EXIT.

******************************************************************
* Starten eines neuen Prozesse
*    Eingabe-Parameter: W-PROGRAM (aufzurufendes Programm)
******************************************************************
 W030-CREATEPROCESS SECTION.
 W030-00.
**  ---> abwarten bis OPEN-Flag nicht mehr auf SSOBEY gesetzt ist
     PERFORM W200-OPENINFO
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     MOVE ZERO TO C4-OPT
                  C4-PERROR
     IF  PROC-NAMED
         ENTER "CREATEPROCESS" USING  W-PROGRAM
                                      P-PROC-NAME (1:P-PROC-NAME-LEN)
                                      C4-OPT
                               GIVING C4-PERROR
         SET PROC-NO-NAME TO TRUE
         if  c4-perror > zero
             move c4-perror to d-num4
             display " create-error "  d-num4
             move zero to c4-perror
         end-if
     ELSE
         ENTER "CREATEPROCESS" USING  W-PROGRAM
                                      OMITTED
                                      C4-OPT
                               GIVING C4-PERROR
     END-IF
     IF  C4-PERROR = ZERO
         MOVE SPACES TO MSG-SATZ
         READ MSG-DATEI
         IF  MSG-STATUS = -101
             continue
         ELSE
             MOVE MSG-STATUS TO D-NUM4
             STRING  "Prozess "      DELIMITED BY SIZE
                     W-PROGRAM       DELIMITED BY SPACE
                     " abgebrochen mit Status: "
                                     DELIMITED BY SIZE
                     D-NUM4          DELIMITED BY SPACE
               INTO  ZEILE
             DISPLAY ZEILE
             DISPLAY " "
             SET PRG-ABBRUCH TO TRUE
         END-IF
     ELSE
         MOVE C4-PERROR TO D-NUM4
         DISPLAY " "
         STRING  "!!! Aufruf von "           DELIMITED BY SIZE
                 W-PROGRAM                   DELIMITED BY SPACE
                 " hat nicht geklappt ("     DELIMITED BY SIZE
                 D-NUM4                      DELIMITED BY SIZE
                 ") !!!"                     DELIMITED BY SIZE
           INTO ZEILE
         END-STRING
         DISPLAY ZEILE
         DISPLAY " "
         SET PRG-ABBRUCH TO TRUE
     END-IF
     .
 W030-99.
     EXIT.

******************************************************************
* warten bis DATEI geschlossen ist
*
* Eingabeparameter: AP-DNAME (muss mit dem Dateinamen besetzt sein)
******************************************************************
 W200-OPENINFO section.
 W200-00.
     MOVE ZERO       TO AP-PREVTAGN
                        AP-STATUS

**  ---> schleifen bis Datei geschlossen ist
     PERFORM UNTIL AP-STATUS > ZERO
**      ---> pruefen, ob geoeffnet
         ENTER TAL "WT^OPENINFO"  USING AP-STATUS
                                        AP-DNAME
                                        AP-PREVTAG
         EVALUATE AP-STATUS
             WHEN 0      IF  AP-DELAY-OFF
                             EXIT PERFORM
                         ELSE
                             ENTER TAL "DELAY" USING C9-DELAY-TIME
                         END-IF
             WHEN 1      continue
             WHEN OTHER
                         MOVE AP-STATUS TO D-NUM4
                         DISPLAY "*** WT^OPENINFO fehlerhaft ("
                                 D-NUM4
                                 ") beendet ***"
                         SET PRG-ABBRUCH TO TRUE
                         EXIT SECTION
         END-EVALUATE
     END-PERFORM
     SET AP-DELAY-ON TO TRUE
     .
 W200-99.
     exit.

******************************************************************
* Eingabe-Parameter: P-PORTION (IN / OUT / STRING)
******************************************************************
 W350-PUTSTARTUPTEXT SECTION.
 W350-00.
**  ---> startup STRING erstellen
     ENTER "PUTSTARTUPTEXT"  USING   P-PORTION
                                     P-TEXT
                                     P-LIST
                             GIVING  P-RESULT
     EVALUATE P-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus PUTSTARTUPTEXT
                     MOVE P-RESULT TO D-NUM4
                     DISPLAY "PUTSTARTUPTEXT ("
                             P-PORTION (1:6)
                             ") fehlerhaft: "
                             D-NUM4
                     SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION

         WHEN OTHER
                     continue
     END-EVALUATE
     .
 W350-99.
     EXIT.

******************************************************************
* Eingabe-Parameter: P-PORTION (IN / OUT / STRING)
******************************************************************
 W360-DELETESTARTUP SECTION.
 W360-00.
**  ---> startup STRING erstellen
     ENTER "DELETESTARTUP"  USING   P-PORTION
                                    P-LIST
                            GIVING  P-RESULT
     EVALUATE P-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus PUTSTARTUPTEXT
                     MOVE P-RESULT TO D-NUM4
                     DISPLAY "DELETESTARTUP ("
                             P-PORTION (1:6)
                             ") fehlerhaft: "
                             D-NUM4
                     SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION

         WHEN OTHER
                     continue
     END-EVALUATE
     .
 W360-99.
     EXIT.

******************************************************************
* Löschen Define
******************************************************************
 W400-DELETEDEFINE SECTION.
 W400-00.
     ENTER TAL "DEFINEDELETE"    USING P-DEFINE
                                GIVING P-RESULT
     IF  P-RESULT = ZERO or = 2051
         EXIT SECTION
     END-IF

     MOVE P-RESULT TO D-NUM4
     DISPLAY " ---> Fehler vom DEFINEDELETE - "
             D-NUM4
             " > "
             P-DEFINE
     SET PRG-ABBRUCH TO TRUE
     EXIT SECTION
     .
 W400-99.
     EXIT.

******************************************************************
* Setzen Define-Attribute
******************************************************************
 W410-DEFINESETATTR SECTION.
 W410-00.
     ENTER TAL "DEFINESETATTR"   USING P-ATTRIBUT
                                       P-VALUE
                                       P-VALUELEN
                                GIVING P-RESULT
     IF  P-RESULT NOT = ZERO
         MOVE P-RESULT TO D-NUM4
         DISPLAY " ---> Fehler vom DEFINESETATTR - "
                 D-NUM4
                 " > "
                 P-VALUE
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF
     .
 W410-99.
     EXIT.

******************************************************************
* Setzen Define
******************************************************************
 W420-ADDDEFINE SECTION.
 W420-00.
     ENTER TAL "DEFINEADD"   USING P-DEFINE
                            GIVING P-RESULT
     IF  P-RESULT NOT = ZERO
         MOVE P-RESULT TO D-NUM4
         DISPLAY " ---> Fehler vom DEFINEADD - "
                 D-NUM4
                 " > "
                 P-DEFINE
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF
     .
 W420-99.
     EXIT.

******************************************************************
* Info Define
******************************************************************
 W430-DEFINEINFO SECTION.
 W430-00.
     ENTER TAL "DEFINEINFO" USING  P-DEFINE
                                   P-CLASS
                                   P-ATTRIBUT
                                   P-VALUE
                                   P-VALUE-BUFLEN
                                   P-VALUELEN
                            GIVING P-RESULT
     IF  P-RESULT NOT = ZERO
         MOVE P-RESULT TO D-NUM4
         DISPLAY " ---> Fehler vom DEFINEINFO - "
                 D-NUM4
                 " > "
                 P-DEFINE
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF

     MOVE SPACES TO ZEILE
     STRING  P-DEFINE                DELIMITED BY SPACE
             " "                     DELIMITED BY SIZE
             P-CLASS                 DELIMITED BY SPACE
             " "                     DELIMITED BY SIZE
             P-ATTRIBUT              DELIMITED BY SPACE
             " "                     DELIMITED BY SIZE
             P-VALUE (1:P-VALUELEN)  DELIMITED BY SIZE
       INTO ZEILE
     END-STRING
     DISPLAY zeile
     .
 W430-99.
     EXIT.




?CONSULT $SYSTEM.SYSTEM.COBOLEX0
?SEARCH  $SYSTEM.SYSTEM.COBOLLIB
?CONSULT  =TALLIB
?CONSULT  =ASC2EBC
?CONSULT  =EBC2ASC
?CONSULT  =WSYS022
?NOLMAP, SYMBOLS, INSPECT
?SAVE ALL
?SAVEABEND
?LINES 66
?CHECK 3
?SQL

 IDENTIFICATION DIVISION.

 PROGRAM-ID. SSFPHD1M.

 DATE-COMPILED.


*****************************************************************
* Letzte Aenderung :: 2018-03-09
* Letzte Version   :: G.00.00
* Kurzbeschreibung :: Invoker fuer Tandem-Systemprogramme
* Kurzbeschreibung :: (Modulversion)
*
* Aenderungen (Version und Datum in Variable K-PROG-START aendern)
*              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*----------------------------------------------------------------*
* Vers. | Datum    | von | Kommentar                             *
*-------|----------|-----|---------------------------------------*
*G.00.00|2018-03-06| kl  | Neuerstellung aus SSFPHD0 als Modul
*----------------------------------------------------------------*
*
* Programmbeschreibung
* --------------------
*
* Dieses Modul ist ein Klon des Servers SSFPHD0S. Es bietet 
* die gleichen Funktionen, arbeitet jedoch als Modul. Das 
* Modul kann in unterschiedliche Programme eingebunden werden,
* womit das im SSFPHD0 erforderliche (und noch zu implementierende)
* Environmenthandling entfaellt. Die weitere Beschreibung der
* Serverversion gilt auch fuer dieses Modul.
*
* Dieser Server dient als "Universelle" Schnittstelle zu den
* HP-System- und Dienstprogrammen. Es stellt für registrierte
* Programme die Cobol-Utility CREATEPROCESS zur Verfügung.
*
* Im Vorlauf werden aus der Tabelle =SSFRSYPR alle verfügbaren
* Programme in eine interne Speichertabelle geladen. Zur Zeit
* unterstützt dieser Server maxmal 100 registrierte Programme.
*
* Der Server erhält seinen Auftrag über die NDATEN der internen
* Schnittstelle. Dieser Auftrag enthält
*
* - das zu verwendende Programm (Name oder dedizierter Pfad)
* - den zu verwendenden Startup-Text
* - ggf. ein zu verwendendendes INFILE
* - ggf. ein zu verwendendendes OUTFILE
* - ggf. ein zu verwendendes Obey-File
*
* Nach einigen Prüfungen (z.B. ob das registrierte Porgramm
* Obey-Files unterstützt) wird das COBOL-Utility CREATEPROZESS
* aufgerufen- Das Ergebnis wird aus $RECEIVE gelesen (hier ein
* REDEFINE auf INT-SCHNITTSTELLE-C) und über die Interne Schnitt-
* stelle an das aufrufende Programm zurückgegeben.
*
* Es empfiehlt sich, für diesen Server Anwendungsspezifische
* Adaptermodule zu bauen.
*
******************************************************************

 ENVIRONMENT DIVISION.
 CONFIGURATION SECTION.
 SPECIAL-NAMES.
     SWITCH-1 IS TRACE-FLAG
         ON  STATUS IS TRACE-ON
         OFF STATUS IS TRACE-OFF
     SWITCH-15 IS ANZEIGE-VERSION
         ON STATUS IS SHOW-VERSION
     CLASS ALPHNUM IS "0123456789"
                      "abcdefghijklmnopqrstuvwxyz"
                      "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                      " .,;-_!§$%&/=*+"
     DECIMAL-POINT IS COMMA.
     
 INPUT-OUTPUT SECTION.
 FILE-CONTROL.
     SELECT MSG-DATEI    ASSIGN TO $RECEIVE.

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

 WORKING-STORAGE SECTION.
*--------------------------------------------------------------------*
* Comp-Felder: Präfix Cn mit n = Anzahl Digits
*--------------------------------------------------------------------*
 01          COMP-FELDER.
     05      C4-ANZ              PIC S9(04) COMP.
     05      C4-COUNT            PIC S9(04) COMP.
     05      C4-I1               PIC S9(04) COMP.
     05      C4-I2               PIC S9(04) COMP.
     05      C4-LEN              PIC S9(04) COMP.
     05      C4-PTR              PIC S9(04) COMP.

     05      C4-X.
      10                         PIC X value low-value.
      10     C4-X2               PIC X.
     05      C4-NUM redefines C4-X
                                 PIC S9(04) COMP.

     05      C9-ANZ              PIC S9(09) COMP.
     05      C9-COUNT            PIC S9(09) COMP.

     05      C18-VAL             PIC S9(18) COMP.

     05      REPLY-LAENGE        PIC  9(04) COMP.

*--------------------------------------------------------------------*
* Display-Felder: Präfix D
*--------------------------------------------------------------------*
 01          DISPLAY-FELDER.
     05      D-NUM1              PIC  9.
     05      D-NUM2              PIC  9(02).
     05      D-NUM3              PIC  9(03).
     05      D-NUM4              PIC -9(04).
     05      D-NUM6              PIC  9(06).
     05      D-NUM9              PIC  9(09).

*--------------------------------------------------------------------*
* Felder mit konstantem Inhalt: Präfix K
*--------------------------------------------------------------------*
 01          KONSTANTE-FELDER.
     05      K-MODUL             PIC X(08)          VALUE "SSFPHD1M".
     05      K-VALUE-1           PIC S9(04)    COMP VALUE 1.
     05      K-DELAY-TIME        PIC S9(09)    COMP VALUE 10.

*----------------------------------------------------------------*
* Conditional-Felder
*----------------------------------------------------------------*
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

*     05      MSG-STATUS          PIC 9       VALUE ZERO.
*          88 MSG-OK                          VALUE ZERO.
*          88 MSG-EOF                         VALUE 1.

     05      MSG-OPEN-STATUS     PIC 9       VALUE ZERO.
          88 MSG-CLOSED                      VALUE ZERO.
          88 MSG-OPEN                        VALUE 1.

     05      PRG-STATUS          PIC 9.
          88 PRG-OK                          VALUE ZERO.
          88 PRG-NOK                         VALUE 1 THRU 9.
          88 PRG-ENDE                        VALUE 1.
          88 PRG-ABBRUCH                     VALUE 2.

     05      ENDE-FLAG           PIC 9       VALUE ZERO.
          88 ENDE-OFF                        VALUE ZERO.
          88 ENDE                            VALUE 1.

     05      SSFRSYPR-FLAG           PIC 9     VALUE ZERO.
          88 SSFRSYPR-OK                       VALUE ZERO.
          88 SSFRSYPR-EOF                      VALUE 1.
          88 SSFRSYPR-NOK                      VALUE 9.

     05      RECEIVE-READ-FLAG      PIC 9      VALUE ZERO.
          88 RD-IIFC                           VALUE ZERO.
          88 RD-MSG                            VALUE 1.

     05      PRG-USAGE-FLAG      PIC 9         VALUE ZERO.
          88 PRG-USE-NAME                      VALUE ZERO.
          88 PRG-USE-FILE                      VALUE 1.

 01          PERM-SCHALTER.
     05      INIT-STATUS         PIC 9       VALUE ZERO.
          88 INIT-NOK                        VALUE ZERO.
          88 INIT-OK                         VALUE 1.

*--------------------------------------------------------------------*
* Uebergabe aus IMSG-NDATEN: Alle erforderlichen Aufrufdaten
*--------------------------------------------------------------------*
 01          IMSG-UEBERGABE.
*--> Daten des Aufrufs aus IMSG-NDATEN
     05      IMSG-INVOKE-DATA.
*            Programmname fuer Aufruf ueber interne Programmtabelle
        10   IMSG-PRG-NAME             PIC X(08)  VALUE SPACES.
*            Alternatives Programmfile (ggf. fuer Testzwecke)
        10   IMSG-ALT-PFILE            PIC X(36)  VALUE SPACES.
*            Startuptext (wenn fuer PUTSTARTUPTEXT länger wird, anpassen)
        10   IMSG-PRG-STU              PIC X(128) VALUE SPACES.
*            Optional: IN-File
        10   IMSG-PRG-INF              PIC X(36)  VALUE SPACES.
*            Optional: OUT-File
        10   IMSG-PRG-OUTF             PIC X(36)  VALUE SPACES.
*            Optional: OBEY-File
        10   IMSG-PRG-OBF              PIC X(36)  VALUE SPACES.
*       Reserve FFU (und wg. 1K Ndaten)
        10   IMSG-FFU                  PIC X(744) VALUE SPACES.
*--> Laenge des Aufrufs aus IMSG-DATLEN (sicher ist sicher)
     05      IMSG-ID-LEN               PIC S9(04) COMP VALUE ZERO.

*--------------------------------------------------------------------*
* weitere Arbeitsfelder
*--------------------------------------------------------------------*
 01          WORK-FELDER.
     05      W-DUMMY             PIC X(02).

 01          ZEILE               PIC X(80).    
*--------------------------------------------------------------------*
* Datm-Uhrzeitfelder (für TAL-Routine)
*--------------------------------------------------------------------*
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

 01          TAL-JUL-DAY         PIC S9(09) COMP.

*--------------------------------------------------------------------*
* Parameter für Untermodulaufrufe - COPY-Module
*--------------------------------------------------------------------*
**          ---> fuer Fehlerbeh.
     COPY    WSYS022C OF "=MSGLIB".

**          ---> Application Monitoring
     COPY    PCAPM01C OF "=MSGLIB"
             REPLACING =="*"== BY ==PCAP==.


*--------------------------------------------------------------------*
* Parameter für Untermodulaufrufe: Präfix P
*--------------------------------------------------------------------*
 01          PARAMETER-FELDER.
     05      P-DUMMY             PIC X(02).

**          ---> ChangeCode mit ASC2EBC und EBC2ASC
 01          P-CC-LEN            PIC S9(04) COMP.
 01          P-CC-IN             PIC X(64).
 01          P-CC-OUT            PIC X(64).

**          ---> für WT^HEX und WT^UNHEX Routinen
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

**          ---> für COBOL-Utilities GET-/PUT-STARTUPTEXT
**          --->                     GET-/PUT-PARAMTEXT
 01          STUP-PARAMETER.
     05      STUP-RESULT         PIC S9(04) COMP VALUE ZERO.
     05      STUP-CPLIST         PIC  9(09) COMP VALUE ZERO.
     05      STUP-PORTION        PIC  X(30) VALUE "STRING".
     05      STUP-TEXT           PIC X(128).

**          ---> für COBOL-Utility CREATEPROCESS
 01          CREP-PARAMETER.
     05      CREP-RESULT         PIC S9(04) COMP VALUE ZERO.
     05      CREP-OPTION         PIC S9(04) COMP VALUE ZERO.
     05      CREP-PROGRAM        PIC  X(36).

* 01          MSG-SATZ.
*     05      MSG-STATUS          PIC S9(04) COMP.
*     05      MSG-PHANDLE         PIC  X(20).
*     05      MSG-CPU-TIME        PIC S9(18) COMP.
*     05      MSG-JOBID           PIC S9(04) COMP.
*     05      MSG-COMPLETION-CODE PIC S9(04) COMP.
*     05      MSG-TERMINATION-CODE PIC S9(04) COMP.
*     05      MSG-SUBSYSTEM       PIC  X(12).
*     05      MSG-PHANDLE-KILLER  PIC  X(20).
*     05      MSG-TERMTEXT-LEN    PIC S9(04) COMP.
*     05      MSG-PROCNAME.
*      10     MSG-ZOFFSET         PIC S9(04) COMP.
*      10     MSG-ZLEN            PIC S9(04) COMP.
*     05      MSG-FLAGS           PIC S9(04) COMP.
*     05      MSG-RESERVE         PIC  X(06).
*     05      MSG-DATA            PIC  X(112).
*     05      MSG-REST            PIC  X(06).

 EXTENDED-STORAGE SECTION.

 EXEC SQL
     INCLUDE STRUCTURES ALL VERSION 315
 END-EXEC

 EXEC SQL
     INCLUDE SQLCA
 END-EXEC

 EXEC SQL
     BEGIN DECLARE SECTION
 END-EXEC

******************************************************************
* Im Folgenden zunächst Host-Variable, die Bestandteil von
* SQL - Tabellen sind
******************************************************************
 01          HOST-VARIABLEN.
     05      H-DUMMY             PIC X(02).
     05      H-SYSKEY            PIC S9(18) COMP.

******************************************************************
* Im Folgenden mit dem INVOKE-Befehl die Tabellenstruktur-
* definitonen der benötigten Tabellen einfügen
******************************************************************
**  ---> Struktur der Tabelle SSFRSYPR
 EXEC SQL
    INVOKE =SSFRSYPR AS SSFRSYPR
 END-EXEC

******************************************************************

 EXEC SQL
     END DECLARE SECTION
 END-EXEC

******************************************************************
* Im Folgenden werden die benöetigten CURSOR auf die
* verschiedenen SQL - Tabellen definiert
******************************************************************
**  ---> Cursor auf Tabelle SSFRSYPR
 EXEC SQL
     DECLARE SSFRSYPR_CURS CURSOR FOR
         SELECT   PRG_NAME, PRGFILE, PRGTYPE, ZPINS,
                  PRG_STU, PRG_INF, PRG_OUTF, PRG_OBF
           FROM  =SSFRSYPR
*         WHERE
*         ORDER  BY
         BROWSE  ACCESS
 END-EXEC

******************************************************************
* Ende der SQL - Definitionen
******************************************************************

 01   PROG-TABLE.
      05     PROGRAMS-USED        OCCURS 100.
         10  PRG-NAME             PIC X(08).
         10  PRGFILE              PIC X(36).
         10  PRGTYPE              PIC X(08).
         10  PRG-FLAGS.
          15 PRG-STU              PIC 9.
          15 PRG-INF              PIC 9.
          15 PRG-OUTF             PIC 9.
          15 PRG-OBF              PIC 9.

*   ---> Bei Vergroesserung (OCCURS) bitte anpassen <---
 01      PRG-MAX-ENTRIES          PIC S9(04) COMP VALUE 100.

*   ---> Gefundenes Programm fuer diesen Aufruf
 01      AKT-PROGRAM.
         05  AKT-NAME             PIC X(08).
         05  AKTFILE              PIC X(36).
         05  AKTTYPE              PIC X(08).
         05  AKT-FLAGS.
          10 AKT-STU              PIC 9.
          10 AKT-INF              PIC 9.
          10 AKT-OUTF             PIC 9.
          10 AKT-OBF              PIC 9.
*       Parameter
         05  AKT-PARAMETER.
          10 AKT-STARTUP          PIC X(128).
          10 AKT-INFILE           PIC X(36).
          10 AKT-OUTFILE          PIC X(36).
          10 AKT-OBEYFILE         PIC X(36).

** --> Zur Sicherung der Eingangsschnittstelle
 01          SV-INTERN-MESSAGE.
             COPY    INT-SCHNITTSTELLE-C OF  "=MSGLIB"
                     REPLACING =="*"== BY ==SV==.
                     
 LINKAGE SECTION.
**          ---> FREGAT-Satz + interner Zusatz (Laenge = 4096)
 01          INTERN-MESSAGE.
             COPY    INT-SCHNITTSTELLE-C OF  "=MSGLIB"
                     REPLACING =="*"== BY ==IMSG==.

 PROCEDURE DIVISION USING INTERN-MESSAGE.
******************************************************************
* Die folgenden WHENEVER-Anweisungen legen Fehlerbehandlungen fest
******************************************************************
* A000-WHENEVER SECTION.
* A000-00.
*     EXEC SQL
*         WHENEVER SQLERROR       PERFORM :Z001-SQLERROR
*     END-EXEC
*
*     EXEC SQL
*         WHENEVER SQLWARNING     PERFORM :Z001-SQLERROR
*     END-EXEC
*     .
* A000-99.
*     EXIT.

******************************************************************
* Steuerungs-Section
******************************************************************
 A100-STEUERUNG SECTION.
 A100-00.
**  ---> wenn SWICH-15 gesetzt ist
**  ---> nur Umwandlungszeitpunkt zeigen und dann beenden
     IF  SHOW-VERSION
         DISPLAY K-MODUL " vom: " FUNCTION WHEN-COMPILED
         CALL "WSYS022" USING GEN-ERROR SQLCA
         STOP RUN
     END-IF

**  ---> Vorlauf: oeffnen Dateien etc.
     PERFORM B000-VORLAUF

**  ---> holen momentanen Zeitpunkt
     PERFORM U200-TIMESTAMP

     PERFORM B100-VERARBEITUNG


**  ---> Nachlauf: Dateien schiessen
     PERFORM B090-ENDE
     .
 A100-99.
     EXIT PROGRAM.
*    Hier ist auf jeden Fall Schluss!     
     STOP RUN.

     
******************************************************************
* Vorlauf
******************************************************************
 B000-VORLAUF SECTION.
 B000-00.
**  ---> Initialisierung Felder
     PERFORM C000-INIT
     
**  ---> Message-Datei fuer Systemmeldungen (CREATEPROCESS)
*        Oeffnen
     OPEN INPUT MSG-DATEI
*     SET MSG-OPEN TO TRUE
     
     .
 B000-99.
     EXIT.

******************************************************************
* Ende
******************************************************************
 B090-ENDE SECTION.
 B090-00.

*    Aufrufergebnis zurueckgeben
     MOVE ALL SPACES            TO IMSG-NDATEN
     MOVE MSG-SATZ              TO IMSG-NDATEN
     ENTER TAL "String^Laenge"  USING MSG-SATZ, 200
                                GIVING IMSG-DATLEN
                                
*    IF MSG-OPEN
       CLOSE MSG-DATEI
*    END-IF

     .
 B090-99.
     EXIT.

******************************************************************
* Verarbeitung
******************************************************************
 B100-VERARBEITUNG SECTION.
 B100-00.

*--> NDATEN in Arbeitstruktur uebernehmen
     MOVE    IMSG-NDATEN(1:IMSG-DATLEN)     TO IMSG-INVOKE-DATA
     MOVE    IMSG-DATLEN                    TO IMSG-ID-LEN

*--> Inhaltliche Pruefung der Ausfrufdaten und Bauen aktuellen
*    Aufruf-Buffer mit Parametern
     PERFORM C100-PRUEFEN-UEBERGABE
     IF ENDE
        EXIT SECTION
     END-IF

*--> Zusammenstellen grundlegende Parameter fuer Procedure-Calls
*    PUTSTARTUPTEXT
     MOVE SPACES    TO STUP-TEXT, STUP-PORTION
     MOVE ZERO      TO STUP-CPLIST
     
     IF AKT-STARTUP = SPACES
        CONTINUE
     ELSE
        MOVE    AKT-STARTUP      TO STUP-TEXT
        MOVE    "String"         TO STUP-PORTION
     END-IF

*    CREATEPROCESS
     MOVE AKTFILE               TO CREP-PROGRAM
     MOVE ZERO                  TO CREP-OPTION

******************** PROZESS CREATE *****************************

*--> Startup-Text erstellen
     IF AKT-STARTUP = SPACE
        CONTINUE
     ELSE
        PERFORM P130-PUTSTARTUPTEXT
        IF ENDE
           EXIT SECTION
        END-IF
     END-IF
     
*---> Pruefen OBEYFILE
*      IF AKT-OBEYFILE = SPACE
*         Startup-Text hat Vorrang
*      OR STUP-PORTION = "String"
*         CONTINUE
*      ELSE
*        Existiert das OBEY-File überhaupt?
****** FILE EXISTS ****      
*         IF ENDE
*            EXIT SECTION
*         END-IF

*        OBEY <File> als Startup-Text setzen
*         STRING  "OBEY "            DELIMITED BY SIZE,
*                 AKT-OBEYFILE       DELIMITED BY SPACE
*         INTO STUP-TEXT
*         MOVE "String" TO STUP-PORTION
*         MOVE ZERO     TO STUP-CPLIST
*         PERFORM P130-PUTSTARTUPTEXT
*         IF ENDE
*            EXIT SECTION
*         END-IF
*     END-IF
    
*---> Prozess starten
     PERFORM P100-CREATEPROCESS
     
*---> Auf jeden Fall STARTUP loeschen
     MOVE "*ALL*" TO STUP-PORTION
     PERFORM P140-DELETESTARTUP
     
     .
 B100-99.
     EXIT.

******************************************************************
* Initialisierung von Feldern und Strukturen
******************************************************************
 C000-INIT SECTION.
 C000-00.
     INITIALIZE SCHALTER
                GEN-ERROR
                IMSG-UEBERGABE

     IF INIT-NOK
        PERFORM C010-LOAD-PROGRAMS
        IF PRG-ABBRUCH
           EXIT SECTION
        ELSE
           SET INIT-OK TO TRUE
        END-IF
     END-IF

*    Aktuelles Programm und Parameter intialisieren
     INITIALIZE AKT-PROGRAM
     MOVE "0000" TO AKT-FLAGS OF AKT-PROGRAM

     .
 C000-99.
     EXIT.

******************************************************************
* Initialisierung von Feldern und Strukturen
******************************************************************
 C010-LOAD-PROGRAMS SECTION.
 C010-00.

     PERFORM S100-OPEN-SSFRSYPR-CURSOR
     IF SQLCODE OF SQLCA = ZERO
        CONTINUE
     ELSE
        INITIALIZE GEN-ERROR
        MOVE SQLCODE OF SQLCA TO D-NUM4
        STRING "Laden Programme: FEHLER OPEN CURSOR: ",
               D-NUM4,
               " --> SQL-Meldung"
        DELIMITED BY SIZE INTO DATEN-BUFFER1
        MOVE   "  <<< ABBRUCH! >>> "  TO DATEN-BUFFER2
        PERFORM Z002-PROGERR
        PERFORM Z001-SQLERROR
        SET PRG-ABBRUCH TO TRUE
        EXIT SECTION
     END-IF

*--> Erstes Lesen Cursor
     PERFORM S110-FETCH-SSFRSYPR-CURSOR
     EVALUATE SQLCODE OF SQLCA

        WHEN ZERO        CONTINUE
        WHEN 100         INITIALIZE GEN-ERROR
                         MOVE "Keine Daten in =SSFRSYPR" TO DATEN-BUFFER1
                         MOVE   "  <<< ABBRUCH! >>> "    TO DATEN-BUFFER2
                         PERFORM Z002-PROGERR
                         SET PRG-ABBRUCH TO TRUE
                         PERFORM S120-CLOSE-SSFRSYPR-CURSOR
                         EXIT SECTION
        WHEN OTHER       INITIALIZE GEN-ERROR
                         MOVE SQLCODE OF SQLCA TO D-NUM4
                         STRING "Laden Programme: FEHLER LESEN CURSOR: ",
                         D-NUM4,
                         " --> SQL-Meldung"
                         DELIMITED BY SIZE INTO DATEN-BUFFER1
                         MOVE   "  <<< ABBRUCH! >>> "  TO DATEN-BUFFER2
                         PERFORM Z002-PROGERR
                         PERFORM Z001-SQLERROR
                         SET PRG-ABBRUCH TO TRUE
                         PERFORM S120-CLOSE-SSFRSYPR-CURSOR
                         EXIT SECTION

     END-EVALUATE

     PERFORM    UNTIL SSFRSYPR-NOK
                   OR SSFRSYPR-EOF
                   OR C9-COUNT > PRG-MAX-ENTRIES

         MOVE PRG-NAME  OF SSFRSYPR  TO  PRG-NAME OF PROGRAMS-USED(C9-COUNT)
         MOVE PRGFILE   OF SSFRSYPR  TO  PRGFILE  OF PROGRAMS-USED(C9-COUNT)
         MOVE PRGTYPE   OF SSFRSYPR  TO  PRGTYPE  OF PROGRAMS-USED(C9-COUNT)
         MOVE PRG-STU   OF SSFRSYPR  TO  PRG-STU  OF PROGRAMS-USED(C9-COUNT)
         MOVE PRG-INF   OF SSFRSYPR  TO  PRG-INF  OF PROGRAMS-USED(C9-COUNT)
         MOVE PRG-OUTF  OF SSFRSYPR  TO  PRG-OUTF OF PROGRAMS-USED(C9-COUNT)
         MOVE PRG-OBF   OF SSFRSYPR  TO  PRG-OBF  OF PROGRAMS-USED(C9-COUNT)

**--> Nachlesen des Cursors
         PERFORM S110-FETCH-SSFRSYPR-CURSOR
         IF SSFRSYPR-NOK
            INITIALIZE GEN-ERROR
            MOVE SQLCODE OF SQLCA TO D-NUM4
            STRING "Laden Programme: FEHLER LESEN CURSOR: ",
                    D-NUM4,
                    " --> SQL-Meldung"
            DELIMITED BY SIZE INTO DATEN-BUFFER1
            MOVE   "  <<< ABBRUCH! >>> "  TO DATEN-BUFFER2
            PERFORM Z002-PROGERR
            PERFORM Z001-SQLERROR
            SET PRG-ABBRUCH TO TRUE
         END-IF

     END-PERFORM

**--> Schliessen Cursor
     PERFORM S120-CLOSE-SSFRSYPR-CURSOR
     .
 C010-99.
     EXIT.

******************************************************************
* PRUEFEN UERBGABE
******************************************************************
 C100-PRUEFEN-UEBERGABE SECTION.
 C100-00.

*--> Aufzurufendes Programm
     IF     IMSG-PRG-NAME  = SPACE
     AND    IMSG-ALT-PFILE = SPACE
*           Kein Programm uebergeben - Keine Verarbeitung
            INITIALIZE GEN-ERROR
            MOVE "Kein Programm fuer Aufruf uebergeben!"  TO DATEN-BUFFER1
            STRING "Aufgerufen von: ",
                  IMSG-MONNAME
            DELIMITED BY SIZE INTO DATEN-BUFFER2
            MOVE ">> KEINE VERARBEITUNG <<"               TO DATEN-BUFFER3
            PERFORM Z002-PROGERR
            SET ENDE TO TRUE
            EXIT SECTION
     END-IF

*--> Alternatives Programm UND registriertes Programm
     IF     IMSG-PRG-NAME  not = SPACE
     AND    IMSG-ALT-PFILE not = SPACE
*           Warnung: Registriertes Programm wird ignoriert
            INITIALIZE GEN-ERROR
            MOVE "Registriertes Programm UND alternatives Prg.File:"
                  TO DATEN-BUFFER1
            STRING "Registriert: "      DELIMITED BY SIZE,
                   IMSG-PRG-NAME        DELIMITED BY SPACE,
                   " / Alternativ: "    DELIMITED BY SIZE,
                   IMSG-ALT-PFILE       DELIMITED BY SPACE
            INTO DATEN-BUFFER2
            STRING ">> Alternative "    DELIMITED BY SIZE,
                   IMSG-ALT-PFILE,      DELIMITED BY SPACE,
                   " << wird verwendet" DELIMITED BY SIZE
            INTO DATEN-BUFFER3
            STRING "Aufgerufen von: ",
                   IMSG-MONNAME
            DELIMITED BY SIZE INTO DATEN-BUFFER4
            PERFORM Z002-PROGERR
            SET     PRG-USE-FILE      TO TRUE
     ELSE   IF  IMSG-PRG-NAME = SPACE
                SET PRG-USE-FILE TO TRUE
            ELSE
                SET PRG-USE-NAME TO TRUE
            END-IF
     END-IF

*--> Alternatives Programmfile soll benutzt werden ...
     IF     PRG-USE-FILE
            MOVE   IMSG-ALT-PFILE       TO AKTFILE
            MOVE   IMSG-PRG-STU         TO AKT-STARTUP
            MOVE   IMSG-PRG-INF         TO AKT-INFILE
            MOVE   IMSG-PRG-INF         TO AKT-OUTFILE
            MOVE   IMSG-PRG-OBF         TO AKT-OBEYFILE
            EXIT SECTION
     END-IF

*--> Registriertes Programm suchen
     PERFORM C110-LOOKUP-REGISTRIERT
     IF ENDE
*       Nichts gefunden
        EXIT SECTION
     END-IF

*--> Optionen pruefen (muessen durch "1" im Flag zugelassen sein)

*    Startup (sollte bei den verwendeten Programme eigentlich immer
*             gehen)
     IF   IMSG-PRG-STU not = SPACE
          IF AKT-STU OF AKT-PROGRAM = 1
             CONTINUE
          ELSE
             INITIALIZE GEN-ERROR
             STRING "Startup-String nicht erlaubt fuer < ",
                  IMSG-PRG-NAME,
                  " >"
             DELIMITED BY SIZE INTO DATEN-BUFFER1
             STRING "Aufgerufen von: ",
                   IMSG-MONNAME
             DELIMITED BY SIZE INTO DATEN-BUFFER2
             MOVE ">> KEINE VERARBEITUNG <<"   TO DATEN-BUFFER3
             PERFORM Z002-PROGERR
             SET ENDE TO TRUE
             EXIT SECTION
          END-IF
     END-IF

*    IN-File
     IF   IMSG-PRG-INF not = SPACE
          IF AKT-INF OF AKT-PROGRAM = 1
             CONTINUE
          ELSE
             INITIALIZE GEN-ERROR
             STRING "IN-File nicht erlaubt fuer < ",
                  IMSG-PRG-NAME,
                  " >"
             DELIMITED BY SIZE INTO DATEN-BUFFER1
             STRING "Aufgerufen von: ",
                   IMSG-MONNAME
             DELIMITED BY SIZE INTO DATEN-BUFFER2
             MOVE ">> KEINE VERARBEITUNG <<"   TO DATEN-BUFFER3
             PERFORM Z002-PROGERR
             SET ENDE TO TRUE
             EXIT SECTION
          END-IF
     END-IF

*    OUT-File
     IF   IMSG-PRG-OUTF not = SPACE
          IF AKT-OUTF OF AKT-PROGRAM = 1
             CONTINUE
          ELSE
             INITIALIZE GEN-ERROR
             STRING "OUT-File nicht erlaubt fuer < ",
                  IMSG-PRG-NAME,
                  " >"
             DELIMITED BY SIZE INTO DATEN-BUFFER1
             STRING "Aufgerufen von: ",
                   IMSG-MONNAME
             DELIMITED BY SIZE INTO DATEN-BUFFER2
             MOVE ">> KEINE VERARBEITUNG <<"   TO DATEN-BUFFER3
             PERFORM Z002-PROGERR
             SET ENDE TO TRUE
             EXIT SECTION
          END-IF
     END-IF

*    OBEY-File
     IF   IMSG-PRG-OBF not = SPACE
          IF AKT-OBF OF AKT-PROGRAM = 1
             CONTINUE
          ELSE
             INITIALIZE GEN-ERROR
             STRING "OBEY-File nicht erlaubt fuer < ",
                  IMSG-PRG-NAME,
                  " >"
             DELIMITED BY SIZE INTO DATEN-BUFFER1
             STRING "Aufgerufen von: ",
                   IMSG-MONNAME
             DELIMITED BY SIZE INTO DATEN-BUFFER2
             MOVE ">> KEINE VERARBEITUNG <<"   TO DATEN-BUFFER3
             PERFORM Z002-PROGERR
             SET ENDE TO TRUE
             EXIT SECTION
          END-IF
     END-IF

*--> Alles in Ordnung: Parameter uebernehmen
     MOVE   IMSG-PRG-STU         TO AKT-STARTUP
     MOVE   IMSG-PRG-INF         TO AKT-INFILE
     MOVE   IMSG-PRG-OUTF        TO AKT-OUTFILE
     MOVE   IMSG-PRG-OBF         TO AKT-OBEYFILE

     .
 C100-99.
     EXIT.
******************************************************************
* SUCHEN REGISTRIERTES PRGRAMM
******************************************************************
 C110-LOOKUP-REGISTRIERT SECTION.
 C110-00.

      PERFORM VARYING C4-I1 FROM 1 BY 1 UNTIL
*              PRG-NAME OF PROGRAMS-USED(C4-I1) = IMSG-PRG-NAME OR
              PRG-NAME OF PROGRAMS-USED(C4-I1) = SPACES        OR
              C4-I1 > PRG-MAX-ENTRIES

              IF PRG-NAME OF PROGRAMS-USED(C4-I1) = IMSG-PRG-NAME
                 MOVE  PROGRAMS-USED(C4-I1) TO AKT-PROGRAM
                 EXIT PERFORM
              END-IF

       END-PERFORM

       IF   AKT-NAME OF AKT-PROGRAM = SPACE
            STRING "> "                    DELIMITED BY SIZE,
                    IMSG-PRG-NAME          DELIMITED BY SPACE,
                    " < nicht registriert" DELIMITED BY SIZE
            INTO DATEN-BUFFER1
            STRING "Aufgerufen von: ",
                   IMSG-MONNAME
            DELIMITED BY SIZE INTO DATEN-BUFFER2
            MOVE ">> KEINE VERARBEITUNG <<"  TO DATEN-BUFFER3
            PERFORM Z002-PROGERR
            SET ENDE TO TRUE
       END-IF

     .
 C110-99.
     EXIT.

******************************************************************
* Aufruf COBOL-Utility: CREATEPROCESS
*
*              Eingabe: crep-program
*              Ausgabe: crep-result  (=0:OK, >0:NOK)
*                       crep-option
*
******************************************************************
 P100-CREATEPROCESS SECTION.
 P100-00.
     
     ENTER "CREATEPROCESS" USING  CREP-PROGRAM
                                  omitted
                                  CREP-OPTION
                           GIVING CREP-RESULT
                           
*     IF  CREP-RESULT = ZERO
*         continue
*     ELSE
*         SET PRG-ABBRUCH TO TRUE
*     END-IF
     
     IF  CREP-RESULT = ZERO
         MOVE SPACES TO MSG-SATZ
         READ MSG-DATEI
         IF  MSG-STATUS = -101
             continue
         ELSE
             MOVE MSG-STATUS TO D-NUM4
             STRING  "Prozess "      DELIMITED BY SIZE
                     CREP-PROGRAM    DELIMITED BY SPACE
                     " abgebrochen mit Status: "
                                     DELIMITED BY SIZE
                     D-NUM4          DELIMITED BY SPACE
               INTO  ZEILE
             DISPLAY ZEILE
             DISPLAY " "
             SET PRG-ABBRUCH TO TRUE
         END-IF
     ELSE
         MOVE CREP-RESULT TO D-NUM4
         DISPLAY " "
         STRING  "!!! Aufruf von "           DELIMITED BY SIZE
                 CREP-PROGRAM                DELIMITED BY SPACE
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
 P100-99.
     EXIT.

******************************************************************
* Aufruf COBOL-Utility: DELETEPARAM
*
*              Eingabe: stup-portion (parametername)
*                       stup-cplist
*              Ausgabe: stup-result  (-1:NOK, >=0:OK länge von text)
*
******************************************************************
 P110-DELETEPARAM SECTION.
 P110-00.
     ENTER "DELETEPARAM" USING   STUP-PORTION
                                 STUP-CPLIST
                         GIVING  STUP-RESULT
     EVALUATE STUP-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus DeleteParam
                     MOVE STUP-RESULT TO D-NUM4

*** =>
*** => weitere Verarbeitung hier einfügen
*** =>

         WHEN OTHER
**                  ---> Parameter gelöscht

                     continue
     END-EVALUATE
     .
 P110-99.
     EXIT.

******************************************************************
* Aufruf COBOL-Utility: PUTPARAMTEXT
*
*              Eingabe: stup-portion (parametername)
*                       stup-text    (value von ..-portion)
*              Ausgabe: stup-result  (-1:NOK, >=0:OK länge von text)
*
******************************************************************
 P120-PUTPARAMTEXT SECTION.
 P120-00.
     MOVE SPACE TO STUP-TEXT
*     ENTER "PUTPARAMTEXT"    USING   STUP-PORTION
*                                     STUP-TEXT
*                             GIVING  STUP-RESULT
     EVALUATE STUP-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus PutParamText
**                  ---> oder Parameter nicht vorhanden
                     MOVE STUP-RESULT TO D-NUM4

*** =>
*** => weitere Verarbeitung hier einfügen
*** =>

         WHEN OTHER
**                  ---> ParamText gesetzt

                     continue
     END-EVALUATE
     .
 P120-99.
     EXIT.

******************************************************************
* Aufruf COBOL-Utility: PUTSTARTUPTEXT
*
*              Eingabe: stup-portion (VOLUME,IN,OUT,STRING)
*                       stup-text
*              Ausgabe: stup-result  (-1:NOK, >=0:OK)
*                       stup-cplist  (iierelevant)
*
******************************************************************
 P130-PUTSTARTUPTEXT SECTION.
 P130-00.
     ENTER "PUTSTARTUPTEXT"  USING   STUP-PORTION
                                     STUP-TEXT
                                     STUP-CPLIST
                             GIVING  STUP-RESULT
     EVALUATE STUP-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus PutStartUpText
                     INITIALIZE GEN-ERROR
                     MOVE STUP-RESULT TO D-NUM4
                     STRING "PUTSTARTUP fehlgeschlagen: STUP-RESULT = "
                            D-NUM4
                     DELIMITED BY SIZE INTO DATEN-BUFFER1
                     IF IMSG-PRG-NAME  = SPACE
                        STRING "Aufruf >"           DELIMITED BY SIZE,
                               IMSG-ALT-PFILE       DELIMITED BY SPACE,
                               "< von >"            DELIMITED BY SIZE,
                               IMSG-MONNAME         DELIMITED BY SPACE,
                               "<"                  DELIMITED BY SIZE
                        INTO DATEN-BUFFER2
                     ELSE
                        STRING "Aufruf >"           DELIMITED BY SIZE,
                               IMSG-PRG-NAME        DELIMITED BY SPACE,
                               "< von >"            DELIMITED BY SIZE,
                               IMSG-MONNAME          DELIMITED BY SPACE,
                               "<"                  DELIMITED BY SIZE
                        INTO DATEN-BUFFER2
                     END-IF
                     PERFORM Z002-PROGERR
                     SET ENDE TO TRUE
*                     EXIT SECTION
                     
         WHEN OTHER
                     continue
                     
     END-EVALUATE
     .
 P130-99.
     EXIT.

******************************************************************
* Eingabe-Parameter: P-PORTION (IN / OUT / STRING)
******************************************************************
 P140-DELETESTARTUP SECTION.
 P140-00.
**  ---> startup STRING loeschen
     ENTER "DELETESTARTUP"  USING   STUP-PORTION
                                    STUP-CPLIST
                            GIVING  STUP-RESULT
     EVALUATE STUP-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus DELETESTARTUP
                     MOVE STUP-RESULT TO D-NUM4
                     INITIALIZE GEN-ERROR
                     STRING "DELETESTARTUP ("
                             STUP-PORTION (1:6)
                             ") fehlerhaft: "
                             D-NUM4
                     DELIMITED BY SIZE INTO DATEN-BUFFER1
                     IF IMSG-PRG-NAME  = SPACE
                        STRING "Aufruf >"           DELIMITED BY SIZE,
                               IMSG-ALT-PFILE       DELIMITED BY SPACE,
                               "< von >"            DELIMITED BY SIZE,
                               IMSG-MONNAME          DELIMITED BY SPACE,
                               "<"                  DELIMITED BY SIZE,
                        INTO DATEN-BUFFER2
                     ELSE
                        STRING "Aufruf >"           DELIMITED BY SIZE,
                               IMSG-PRG-NAME        DELIMITED BY SPACE,
                               "< von >"            DELIMITED BY SIZE,
                               IMSG-MONNAME          DELIMITED BY SPACE,
                               "<"                  DELIMITED BY SIZE,
                        INTO DATEN-BUFFER2
                     END-IF
                     PERFORM Z002-PROGERR

         WHEN OTHER
                     continue
     END-EVALUATE
     .
 P140-99.
     EXIT.
     
******************************************************************
* Aufruf PROCESSNAME_CREATE_
******************************************************************
* P200-PROCESSNAME-CREATE SECTION.
* P200-00.
*     ENTER TAL "PROCESSNAME_CREATE_"  USING  P-PROC-NAME (1:P-PROC-NAME-LEN20)
*                                             P-PROC-NAME-LEN
*                                             K-VALUE-1
*                                      GIVING P-ERROR
*     IF  P-ERROR > ZERO
*         EVALUATE P-ERROR
*             WHEN 44     DISPLAY "No names of the specified type are available"
*             WHEN 201    DISPLAY "Unable to communicate with the specified node"
*             WHEN 563    DISPLAY "Output buffer is too small"
*             WHEN 590    DISPLAY "Parameter or bounds error"
*             WHEN OTHER  DISPLAY "sonstiger Fehler bei PROCESSNAME_CREATE_"
*         END-EVALUATE
*         DISPLAY " "
*         SET PRG-ABBRUCH TO TRUE
*     END-IF
*     .
* P200-99.
*     EXIT.

******************************************************************
* OPEN Cursor
******************************************************************
 S100-OPEN-SSFRSYPR-CURSOR SECTION.
 S100-00.
     MOVE ZERO TO C9-COUNT
     SET  SSFRSYPR-OK TO TRUE
     EXEC SQL
         OPEN SSFRSYPR_CURS
     END-EXEC
     .
 S100-99.
     EXIT.

******************************************************************
* Fetch aus Tabelle SSFRSYPR
******************************************************************
 S110-FETCH-SSFRSYPR-CURSOR SECTION.
 S110-00.
     EXEC SQL
         FETCH SSFRSYPR_CURS
          INTO  :PRG-NAME of SSFRSYPR
               ,:PRGFILE of SSFRSYPR
               ,:PRGTYPE of SSFRSYPR
               ,:ZPINS of SSFRSYPR
                   TYPE AS DATETIME YEAR TO FRACTION(2)
               ,:PRG-STU of SSFRSYPR
               ,:PRG-INF of SSFRSYPR
               ,:PRG-OUTF of SSFRSYPR
               ,:PRG-OBF of SSFRSYPR
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET SSFRSYPR-OK  TO TRUE
                     ADD 1 TO C9-COUNT
         WHEN 100    SET SSFRSYPR-EOF TO TRUE
         WHEN OTHER  SET SSFRSYPR-NOK TO TRUE
     END-EVALUATE
     .
 S110-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S120-CLOSE-SSFRSYPR-CURSOR SECTION.
 S120-00.
     EXEC SQL
         CLOSE SSFRSYPR_CURS
     END-EXEC
     .
 S120-99.
     EXIT.

******************************************************************
* Transaktionsbegrenzungen
******************************************************************
 U100-BEGIN SECTION.
 U100-00.
     EXEC SQL
         BEGIN WORK
     END-EXEC
     .
 U100-99.
     EXIT.

 U101-BEGINTRANSACTION SECTION.
 U101-00.
     ENTER TAL BEGINTRANSACTION
     .
 U101-99.
     EXIT.

 U110-COMMIT SECTION.
 U110-00.
     EXEC SQL
         COMMIT WORK
     END-EXEC
     .
 U110-99.
     EXIT.

 U111-ENDTRANSACTION SECTION.
 U111-00.
     ENTER TAL ENDTRANSACTION
        .
 U111-99.
     EXIT.

 U120-ROLLBACK SECTION.
 U120-00.
     EXEC SQL
         ROLLBACK WORK
     END-EXEC
     .
 U120-99.
     EXIT.

 U121-ABORTTRANSACTION SECTION.
 U121-00.
     ENTER TAL ABORTTRANSACTION
     .
 U121-99.
     EXIT.

******************************************************************
* TIMESTAMP erstellen
******************************************************************
 U200-TIMESTAMP SECTION.
 U200-00.
     ENTER TAL "TIME" USING TAL-TIME
     MOVE CORR TAL-TIME TO TAL-TIME-D
     .
 U200-99.
     EXIT.






******************************************************************
* SQL-Fehlerbehandlung
******************************************************************
 Z001-SQLERROR SECTION.
 Z001-00.

**  ---> holen Daten für Fehlertabelle
     MOVE 1 TO ERR-STAT OF GEN-ERROR

     IF  IMSG-MDNR NUMERIC
         MOVE IMSG-MDNR TO MDNR OF GEN-ERROR
     ELSE
         MOVE ZERO      TO MDNR OF GEN-ERROR
     END-IF
     IF  IMSG-TSNR NUMERIC
         MOVE IMSG-TSNR TO TSNR OF GEN-ERROR
     ELSE
         MOVE ZERO      TO TSNR OF GEN-ERROR
     END-IF

     MOVE K-MODUL TO MODUL-NAME OF GEN-ERROR
     MOVE "SE"    TO ERROR-KZ   OF GEN-ERROR

**  ---> Einstellen in Fehlertabelle
     PERFORM Z999-ERRLOG
     SET ENDE TO TRUE
     .
 Z001-99.
     EXIT.

******************************************************************
* Programm-Fehlerbehandlung
******************************************************************
 Z002-PROGERR SECTION.
 Z002-00.

**  ---> holen Daten für Fehlertabelle
     MOVE 1 TO ERR-STAT OF GEN-ERROR

     IF  IMSG-MDNR NUMERIC
         MOVE IMSG-MDNR TO MDNR OF GEN-ERROR
     ELSE
         MOVE ZERO      TO MDNR OF GEN-ERROR
     END-IF
     IF  IMSG-TSNR NUMERIC
         MOVE IMSG-TSNR TO TSNR OF GEN-ERROR
     ELSE
         MOVE ZERO      TO TSNR OF GEN-ERROR
     END-IF

     MOVE K-MODUL TO MODUL-NAME OF GEN-ERROR
     MOVE "PE"    TO ERROR-KZ   OF GEN-ERROR

**  ---> Einstellen in Fehlertabelle
     PERFORM Z999-ERRLOG
     .
 Z002-99.
     EXIT.

******************************************************************
* Fehler in Tabelle ERRLOG schreiben
******************************************************************
 Z999-ERRLOG SECTION.
 Z999-00.
**  ---> Einstellen in Fehlertabelle
     CALL "WSYS022" USING GEN-ERROR
                          SQLCA
     INITIALIZE GEN-ERROR
     .
 Z999-99.
      EXIT.

******************************************************************
* ENDE Source-Programm
******************************************************************

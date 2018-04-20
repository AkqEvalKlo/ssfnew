?CONSULT  $SYSTEM.SYSTEM.COBOLEX0
?SEARCH   $SYSTEM.SYSTEM.COBOLLIB
?CONSULT  =TALLIB
?CONSULT  =ASC2EBC
?CONSULT  =EBC2ASC
?CONSULT  =WSYS022

*-->    Module vom neuen Source-Safe

* Prozesshandler
?CONSULT =SSFPHD1

?NOLMAP, SYMBOLS, INSPECT
?SAVE ALL
?SAVEABEND
?LINES 66
?CHECK 3
?SQL

 IDENTIFICATION DIVISION.

 PROGRAM-ID. SSFRCI0M.

 DATE-COMPILED.


*****************************************************************
* Letzte Aenderung :: 2018-03-16
* Letzte Version   :: G.00.00
* Kurzbeschreibung :: Sicherung/Wiederherstellung Repository-
* Kurzbeschreibung :: Index (SSFRARCH) in/aus CSV-Dateien
*
* Aenderungen (Version und Datum in Variable K-PROG-START aendern)
*              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*----------------------------------------------------------------*
* Vers. | Datum    | von | Kommentar                             *
*-------|----------|-----|---------------------------------------*
*G.00.00|2018-03-16| kl  | Neuerstellung
*----------------------------------------------------------------*
*
* Programmbeschreibung
* --------------------
*
* Dieses Modul dient dem Sichern/Wiederherstellen des Repository-
* Index SSFRARCH in/aus CSV-Dateien, die im jeweiligen Programm-
* Repository (ZIP-Datei [PRGNAME]R) gespeichert werden.
*
* Funktion Save:
* --------------
*
* - Einlesen Cursor fuer SOURCE_MODUL = [Uebergabe.SOURCE_MODUL]
* -    Verketten Einzelfelder in WRITE-REC
* -    Schreiben WRITE-REC in CSV-Datei [PRGNAME]H.
*
* - ZIP -mjq [PRGNAME]R [PRGNAME]H
*
* UNZIP und PURGEDATA sind hier nicht erforderlich. Das Hist-File
* soll jedes mal NEU erstellt werden und ZIP ersetzt Files default-
* maessig im Archiv.
*
*
* Funktion Recover
* ----------------
*
* - ggf. Loeschen aller SSFRARCH-Eintraege fuer [Uebergabe.SOURCE_MODUL]
* - ggf. (falls noch da): WT^PURGE [PRGNAME]H
* - ggf. UNZIP -q [PRGNAME]R [PRGNAME]H
*
* -     Einlesen [PRGNAME]H
* -     Unstring delimited by ";" into SSFRARCH-Buffer.Felder
* -     Insert/Update into SSFRARCH
*
* - WT^PURGE [PRGNAME]H
*
*
******************************************************************

 ENVIRONMENT DIVISION.
 CONFIGURATION SECTION.
 SPECIAL-NAMES.
     SWITCH-15 IS ANZEIGE-VERSION
         ON STATUS IS SHOW-VERSION
     CLASS ALPHNUM IS "0123456789"
                      "abcdefghijklmnopqrstuvwxyz"
                      "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                      " .,;-_!§$%&/=*+"
     DECIMAL-POINT IS COMMA.

 INPUT-OUTPUT SECTION.
 FILE-CONTROL.

 SELECT HISTF      ASSIGN TO #DYNAMIC.

 DATA DIVISION.
 FILE SECTION.

 FD  HISTF
     RECORD  IS VARYING IN SIZE
             FROM 0 TO 128 CHARACTERS
             DEPENDING ON REC-LEN.
 01  HISTF-RECORD              PIC X(128).

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

 01          REC-LEN             PIC  9(04) COMP.

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
     05      K-MODUL             PIC X(08)          VALUE "SSFRCI0M".
     05      K-CR                PIC X              VALUE x"0D".
     05      K-LF                PIC X              VALUE x"0A".
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

     05      PRG-STATUS          PIC 9.
          88 PRG-OK                          VALUE ZERO.
          88 PRG-NOK                         VALUE 1 THRU 9.
          88 PRG-ENDE                        VALUE 1.
          88 PRG-ABBRUCH                     VALUE 2.

     05      SSFRMETA-FLAG           PIC 9     VALUE ZERO.
          88 SSFRMETA-OK                       VALUE ZERO.
          88 SSFRMETA-NOK                      VALUE 1.

     05      SSFRARCH-FLAG           PIC 9     VALUE ZERO.
          88 SSFRARCH-OK                       VALUE ZERO.
          88 SSFRARCH-NOK                      VALUE 1.

     05      SSFRARCH-CURSOR-FLAG    PIC 9     VALUE ZERO.
          88 SSFRARCH-CLOSED                   VALUE ZERO.
          88 SSFRARCH-OPEN                     VALUE 1.

     05      SSFRFDEF-FLAG           PIC 9     VALUE ZERO.
          88 SSFRFDEF-OK                       VALUE ZERO.
          88 SSFRFDEF-NOK                      VALUE 1.

*            Funktionsschalter
     05      FKT-FLAG                PIC X(15) VALUE SPACES.
          88 FKT-NO-FKT                        VALUE SPACES.
          88 FKT-SAVE                          VALUE "SAVEIND        ".
          88 FKT-RECOVER                       VALUE "RECIND         ".

 01          PERM-SCHALTER.
     05      INIT-STATUS         PIC 9       VALUE ZERO.
          88 INIT-NOK                        VALUE ZERO.
          88 INIT-OK                         VALUE 1.

*--------------------------------------------------------------------*
* weitere Arbeitsfelder
*--------------------------------------------------------------------*
 01          WORK-FELDER.
     05      W-DUMMY             PIC X(02).

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

**          ---> Parameter fuer COBOLLIB: ASSIGN
 01          ASS-FNAME           PIC X(34).
 01          ASS-FSTATUS         PIC S9(04) COMP.

**          ---> Fuer Dateihandling
 01          REPSITORY.
*            R-File = Repository fuer [Source]E
        05   REP-VOL            PIC X(08).
        05   REP-SVOL           PIC X(08).
        05   REP-FILE           PIC X(08).

 01          HISTORY.
*            H-File = History fuer [Source]E = SSFRARCH
*                     als CSV
        05   HST-VOL            PIC X(08).
        05   HST-SVOL           PIC X(08).
        05   HST-FILE           PIC X(08).

 01          SRCFILE.
*            E-File = [Source]E = SSFRARCH
        05   SRC-VOL            PIC X(08).
        05   SRC-SVOL           PIC X(08).
        05   SRC-FILE           PIC X(08).

 01          ARCFILE.
*            Archivdatei = SSFRARCH
        05   ARC-VOL            PIC X(08).
        05   ARC-SVOL           PIC X(08).
        05   ARC-FILE           PIC X(08).

*            Zieldatenamen
 01          P-REP-FILE          PIC X(36).
 01          P-SRC-FILE          PIC X(36).
 01          P-ARC-FILE          PIC X(36).
 01          P-HST-FILE          PIC X(36).

 01          STUP-DEC-BUF.
      05     STUP-PARTS.
         10  STUP-P-TXT1         PIC X(40).
         10  STUP-P-PRM1         PIC X(40).
         10  STUP-P-TXT2         PIC X(40).
         10  STUP-P-PRM2         PIC X(40).
         10  STUP-P-TXT3         PIC X(40).
         10  STUP-P-PRM3         PIC X(40).
         10  STUP-P-TXT4         PIC X(40).
         10  STUP-P-PRM4         PIC X(40).
         10  STUP-P-TXT5         PIC X(40).
         10  STUP-P-PRM5         PIC X(40).

 01          STUP-DEC-TAB       REDEFINES STUP-DEC-BUF.
      05     STUP-DEC-CMD       OCCURS 5.
         10  STUP-DEC           OCCURS 5.
          15  STUP-DEC-TXT       PIC X(40).
          15  STUP-DEC-PRM       PIC X(40).

 01          CI                  PIC S9(04) COMP.
 01          CIP                 PIC S9(04) COMP.

**--> Startup-Text fuer SSFPHDx
 01         AKT-STARTUP-TEXT     PIC X(128) VALUE SPACES.


**--> Uebergabedaten fuer Prozess-Handler
 01          PHD-UEBERGABE.
*--> Daten des Aufrufs aus IMSG-NDATEN
     05      PHD-INVOKE-DATA.
*            Programmname fuer Aufruf ueber interne Programmtabelle
        10   PHD-PRG-NAME             PIC X(08)  VALUE SPACES.
*            Alternatives Programmfile (ggf. fuer Testzwecke)
        10   PHD-ALT-PFILE            PIC X(36)  VALUE SPACES.
*            Startuptext (wenn fuer PUTSTARTUPTEXT länger wird, anpassen)
        10   PHD-PRG-STU              PIC X(128) VALUE SPACES.
*            Optional: IN-File
        10   PHD-PRG-INF              PIC X(36)  VALUE SPACES.
*            Optional: OUT-File
        10   PHD-PRG-OUTF             PIC X(36)  VALUE SPACES.
*            Optional: OBEY-File
        10   PHD-PRG-OBF              PIC X(36)  VALUE SPACES.
*       Reserve FFU (und wg. 1K Ndaten)
        10   PHD-FFU                  PIC X(744) VALUE SPACES.
*--> Laenge des Aufrufs aus IMSG-DATLEN (sicher ist sicher)
     05      PHD-ID-LEN               PIC S9(04) COMP VALUE ZERO.

**--> Rueckgabe CREATEPROZESS im Prozess-Handler
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
**  ---> Struktur der Tabelle SSFRMETA
 EXEC SQL
    INVOKE =SSFRMETA AS SSFRMETA
 END-EXEC

**  ---> Struktur der Tabelle SSFRARCH
 EXEC SQL
    INVOKE =SSFRARCH AS SSFRARCH
 END-EXEC

**  ---> Struktur der Tabelle SSFRFDEF
 EXEC SQL
    INVOKE =SSFRFDEF AS SSFRFDEF
 END-EXEC

******************************************************************

 EXEC SQL
     END DECLARE SECTION
 END-EXEC

******************************************************************
* Im Folgenden werden die benöetigten CURSOR auf die
* verschiedenen SQL - Tabellen definiert
******************************************************************
**  ---> Cursor auf Tabelle SSFRARCH - Fuer Funktion SAVEIND
 EXEC SQL
     DECLARE SSFRARCH_CURS CURSOR FOR
         SELECT   SOURCE_MODUL, VERSION, FILE_TYPE
                , SOURCE_DATE, ARCHIV_MODUL
                , AUFTRAG, GROUP_USER, PROD_STATE
                , ZPINS
           FROM  =SSFRARCH
         WHERE    SOURCE_MODUL = :SOURCE-MODUL   OF SSFRARCH
         BROWSE  ACCESS
 END-EXEC

******************************************************************
* Ende der SQL - Definitionen
******************************************************************

*-->    Fuer Uebergabe Kommandos etc. an SSFPHD1
 01          INTERN-MESSAGE.
             COPY    INT-SCHNITTSTELLE-C OF  "=MSGLIB"
                     REPLACING =="*"== BY ==PHD==.

 LINKAGE SECTION.

*-->    Uebergabe aus Hauptprogramm
 01     LINK-REC.
    05  LINK-HDR.
     10 LINK-CMD                PIC X(02).
*       "RI" = Recover Index (HFILE -> TAB)
*       "SI" = Save Index (TAB -> HFILE)
     10 LINK-RC                 PIC S9(04) COMP.
*       0    = OK
*       9999 = Programmabbruch - Hauptprogramm muss reagieren
    05  LINK-DATA.
*       Name des Repository-Files (z.b. PFCSIP7R)
     10 LINK-REP-FILE           PIC X(36).
     10 LINK-REP-FILE-LEN       PIC S9(04) COMP.

 PROCEDURE DIVISION USING LINK-REC.

******************************************************************
* Die folgenden WHENEVER-Anweisungen legen Fehlerbehandlungen fest
******************************************************************
 A000-WHENEVER SECTION.
 A000-00.
     EXEC SQL
         WHENEVER SQLERROR       PERFORM :Z001-SQLERROR
     END-EXEC

     EXEC SQL
         WHENEVER SQLWARNING     PERFORM :Z001-SQLERROR
     END-EXEC
     .
 A000-99.
     EXIT.

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
     IF PRG-ABBRUCH
        CONTINUE
     ELSE
        PERFORM B100-VERARBEITUNG
     END-IF

**  ---> Nachlauf: Dateien schiessen
     PERFORM B090-ENDE
     EXIT PROGRAM
     .
 A100-99.
     EXIT.

******************************************************************
* Vorlauf
******************************************************************
 B000-VORLAUF SECTION.
 B000-00.
**  ---> Initialisierung Felder
     PERFORM C000-INIT

**  ---> Beim ersten Mal holen SSFR-Metadaten
     IF INIT-OK
        CONTINUE
     ELSE
        PERFORM S100-SELECT-SSFRMETA
        IF SSFRMETA-OK
           SET INIT-OK TO TRUE
        ELSE
           MOVE SQLCODE OF SQLCA TO D-NUM4
           DISPLAY "Fehler bei SELECT Metadaten (SSFRMETA): ",
                   D-NUM4
           DISPLAY "Funktion nicht möglich"
*          Fuer Abschiessen Hauptprogramm
           SET PRG-ABBRUCH TO TRUE
           EXIT SECTION
        END-IF
     END-IF

     .
 B000-99.
     EXIT.

******************************************************************
* Ende
******************************************************************
 B090-ENDE SECTION.
 B090-00.

     IF PRG-ABBRUCH
        DISPLAY "   >>> ABBRUCH !!! <<< aus >",
                K-MODUL,
                "<"
        MOVE 9999           TO LINK-RC
     END-IF
     .
 B090-99.
     EXIT.

******************************************************************
* Verarbeitung
******************************************************************
 B100-VERARBEITUNG SECTION.
 B100-00.

**--> Funktionsaufruf untersuchen
     EVALUATE LINK-CMD

        WHEN "RI"       SET FKT-RECOVER    TO TRUE
        WHEN "SI"       SET FKT-SAVE       TO TRUE
        WHEN OTHER      DISPLAY "Falsches Kommando für ",
                                 K-MODUL,
                                 ": ",
                                 LINK-CMD
                        DISPLAY  "Verarbeitung nicht möglich!"
                        SET PRG-ABBRUCH TO TRUE
                        EXIT SECTION

     END-EVALUATE

**--> Erstellen Dateinamen
     PERFORM H100-FILENAMES

**--> Vorabreiten OK, weiter mit eigentlicher Verarbeitung
     EVALUATE TRUE

        WHEN FKT-SAVE       PERFORM C100-SAVEIND
        WHEN FKT-RECOVER    PERFORM C200-RECIND
*       WHEN OTHER          OBSOLET (s.o)

     END-EVALUATE

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

     IF INIT-STATUS = ZERO
     OR INIT-STATUS = 1
        CONTINUE
     ELSE
*       Falls nicht initialisiert (" ")
        SET INIT-NOK TO TRUE
     END-IF
     .
 C000-99.
     EXIT.

******************************************************************
* Sichern Indexeintraege in CSV-Datei
******************************************************************
 C100-SAVEIND SECTION.
 C100-00.

**--> Oeffnen History-File (hier Schreiben)
      PERFORM F100-OPEN-HISTFILE
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Erstes Oeffnen SSFRARCH-Cursor
      PERFORM S110-OPEN-SSFRARCH-CURSOR
      IF SSFRARCH-OPEN
         CONTINUE
      ELSE
         EXIT SECTION
      END-IF

**--> Erstes Lesen Cursor
      PERFORM S120-FETCH-SSFRARCH-CURSOR

**--> Verarbeitungsschleife uber alle gefundenen Eintraege
      PERFORM UNTIL SSFRARCH-NOK
                 OR PRG-ABBRUCH

*       Erstellen Schreibpuffer
        PERFORM D100-WRITE-BUFFER
*       Schreiben
        WRITE HISTF-RECORD
*       WRITE HISTF FROM HISTF-RECORD
*       Nachlesen Cursor
        PERFORM S120-FETCH-SSFRARCH-CURSOR

      END-PERFORM

*     Schliessen Cursor
      IF SSFRARCH-OPEN
         PERFORM S130-CLOSE-SSFRARCH-CURSOR
      END-IF

*     Schliessen Hist-File
      CLOSE HISTF
      
*@Debug
*      DISPLAY " "
*      DISPLAY "@DEBUG: Abbruch"
*      DISPLAY "Bitte prüfen: " HST-FILE
*      SET PRG-ABBRUCH TO TRUE
*      EXIT SECTION
*@Debug      

***********************************************************************
*  Jetzt wird es interessant: Histfile verschieben ins Repository     *
***********************************************************************

**--> Holen erstes Kommando
      MOVE K-MODUL      TO MODUL        OF SSFRFDEF
      MOVE FKT-FLAG     TO FUNKTION     OF SSFRFDEF
      MOVE 1            TO LFDNR        OF SSFRFDEF,
                           CI
**--> Kommandodefinition lesen
      PERFORM S200-SELECT-SSFRFDEF
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Kommando zerlegen und STARTUP fuer SSFPHD1 bauen
      PERFORM H200-CREATE-STUP

**--> Jetzt zusammenstellen Aufruf SSFPHD1
      MOVE    PROG     OF SSFRFDEF      TO PHD-PRG-NAME
      MOVE    SPACES                    TO PHD-ALT-PFILE
      MOVE    AKT-STARTUP-TEXT          TO PHD-PRG-STU
      MOVE    SPACES                    TO PHD-PRG-INF,
                                           PHD-PRG-OUTF,
                                           PHD-PRG-OBF,
                                           PHD-FFU
      MOVE    1024                      TO PHD-ID-LEN

*    INTERNE Schnittstelle basteln
     INITIALIZE INTERN-MESSAGE
     MOVE   PHD-INVOKE-DATA             TO PHD-NDATEN
     MOVE   1024                        TO PHD-SENDLEN,
                                           PHD-DATLEN
     MOVE   K-MODUL                     TO PHD-MONNAME
     MOVE   "SSFPHD1M"                  TO PHD-NEXTSERV
     
     CALL   "SSFPHD1M"   USING INTERN-MESSAGE
     


     .
 C100-99.
     EXIT.

******************************************************************
* Zurueckholen Indexeintraege aus CSV-Datei
******************************************************************
 C200-RECIND SECTION.
 C200-00.

**--> Holen erstes Kommando
      MOVE K-MODUL      TO MODUL        OF SSFRFDEF
      MOVE FKT-FLAG     TO FUNKTION     OF SSFRFDEF
      MOVE 1            TO LFDNR        OF SSFRFDEF,
                           CI
**--> Kommandodefinition lesen
      PERFORM S200-SELECT-SSFRFDEF
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Kommando zerlegen und STARTUP fuer SSFPHD1 bauen
      PERFORM H200-CREATE-STUP

**--> Jetzt zusammenstellen Aufruf SSFPHD1
      MOVE    PROG     OF SSFRFDEF      TO PHD-PRG-NAME
      MOVE    SPACES                    TO PHD-ALT-PFILE
      MOVE    AKT-STARTUP-TEXT          TO PHD-PRG-STU
      MOVE    SPACES                    TO PHD-PRG-INF,
                                           PHD-PRG-OUTF,
                                           PHD-PRG-OBF,
                                           PHD-FFU
      MOVE    1024                      TO PHD-ID-LEN

*    INTERNE Schnittstelle basteln
     INITIALIZE INTERN-MESSAGE
     MOVE   PHD-INVOKE-DATA             TO PHD-NDATEN
     MOVE   1024                        TO PHD-SENDLEN,
                                           PHD-DATLEN
     MOVE   K-MODUL                     TO PHD-MONNAME
     MOVE   "SSFPHD1M"                  TO PHD-NEXTSERV
     
     CALL   "SSFPHD1M"   USING INTERN-MESSAGE
*    Uebernehmen Rueckgabe Systemprozess
     MOVE PHD-NDATEN(1:PHD-DATLEN) TO MSG-SATZ
*    Aufrufergebnis
     IF  MSG-STATUS          = -101
     AND MSG-COMPLETION-CODE = ZERO
         CONTINUE
     ELSE
          SET PRG-ABBRUCH TO TRUE
          EXIT SECTION
     END-IF
     
**  ---> Oeffnen HIST-File fuer Eingabe
     PERFORM F100-OPEN-HISTFILE
     IF PRG-ABBRUCH
        EXIT SECTION
     END-IF
     
**   ---> Erstes Lesen HIST-FILE
     READ HISTF at end set file-eof to true end-read  

**   ---> Verarbeitungsschleife ueber      
     PERFORM   UNTIL FILE-EOF
                  OR PRG-ABBRUCH
                  OR SSFRARCH-NOK
                  
*       Tabellenbuffer aus CSV-Satz
        PERFORM D200-TABLE-BUFFER
        
*       Insert into SSFRRARCH
        PERFORM U100-BEGIN
        PERFORM S140-INSERT-SSFRARCH
        IF  SSFRARCH-NOK
        OR  PRG-ABBRUCH
            PERFORM U120-ROLLBACK
            EXIT PERFORM
        ELSE
            PERFORM U110-COMMIT
        END-IF
        
*       Nachlesen HIST-FILE
        READ HISTF at end set file-eof to true end-read          
        
     END-PERFORM
     
**   ---> Auf jeden Fall Hist-File schliessen und Loeschen
     CLOSE HISTF
     
**   ---> Und Loeschen
     PERFORM F999-PURGE-HISTFILE     
     
     .
 C200-99.
     EXIT.


******************************************************************
* Erstellen Write Buffer
******************************************************************
 D100-WRITE-BUFFER SECTION.
 D100-00.

    INITIALIZE HISTF-RECORD

    STRING
        SOURCE-MODUL    OF SSFRARCH DELIMITED BY SPACE
      , ";"                         DELIMITED BY SIZE
      , VERSION         OF SSFRARCH DELIMITED BY SPACE
      , ";"                         DELIMITED BY SIZE
      , FILE-TYPE       OF SSFRARCH DELIMITED BY SPACE
      , ";"                         DELIMITED BY SIZE
      , SOURCE-DATE     OF SSFRARCH DELIMITED BY SIZE
      , ";"                         DELIMITED BY SIZE
      , ARCHIV-MODUL    OF SSFRARCH DELIMITED BY SPACE
      , ";"                         DELIMITED BY SIZE
      , AUFTRAG         OF SSFRARCH DELIMITED BY SPACE
      , ";"                         DELIMITED BY SIZE
      , GROUP-USER      OF SSFRARCH DELIMITED BY SPACE
      , ";"                         DELIMITED BY SIZE
      , PROD-STATE      OF SSFRARCH DELIMITED BY SPACE
      , ";"                         DELIMITED BY SIZE
      , ZPINS           OF SSFRARCH DELIMITED BY SIZE
      , ";"                         DELIMITED BY SIZE
*      , K-LF                        DELIMITED BY SIZE
    INTO HISTF-RECORD

    ENTER TAL "String^Laenge" USING HISTF-RECORD, 128
                              GIVING REC-LEN

    .
 D100-99.
    EXIT.

******************************************************************
* Erstellen Table Buffer
******************************************************************
 D200-TABLE-BUFFER SECTION.
 D200-00.

    INITIALIZE SSFRARCH

    UNSTRING HISTF-RECORD DELIMITED BY ";" INTO
        SOURCE-MODUL    OF SSFRARCH
      , VERSION         OF SSFRARCH
      , FILE-TYPE       OF SSFRARCH
      , SOURCE-DATE     OF SSFRARCH
      , ARCHIV-MODUL    OF SSFRARCH
      , AUFTRAG         OF SSFRARCH
      , GROUP-USER      OF SSFRARCH
      , PROD-STATE      OF SSFRARCH
      , ZPINS           OF SSFRARCH

    .
 D200-99.
    EXIT.

******************************************************************
* Oeffnen CSV-Datei (Lesen/Schreiben je nach Funktion)
******************************************************************
 F100-OPEN-HISTFILE SECTION.
 F100-00.

     MOVE  P-HST-FILE       TO ASS-FNAME
     MOVE  ZERO             TO ASS-FSTATUS

**  ---> erst mal Sourcefile assignen
     ENTER "COBOLASSIGN" USING  HISTF
                                ASS-FNAME
                         GIVING ASS-FSTATUS

     IF  ASS-FSTATUS NOT = ZERO
         DISPLAY "Fehler bei COBOLASSIGN: "
                 ASS-FNAME " " ASS-FSTATUS
         DISPLAY " ---> Programm-Abbruch <--- "
         SET PRG-ABBRUCH TO TRUE
     ELSE
         IF FKT-SAVE
**          --->  Öffnen Datei im Schreibmodus (SAVEIND)
            OPEN OUTPUT HISTF
         ELSE
**          --->  Öffnen Datei im Lesemodus (RECIND)
            OPEN INPUT  HISTF
         END-IF
     END-IF

     .
 F100-99.
     EXIT.
******************************************************************
* Loeschen CSV-Datei
******************************************************************
 F999-PURGE-HISTFILE SECTION.
 F999-00.

*     vorsichtshalber Purge wt^purge
      MOVE  P-HST-FILE        To ASS-FNAME
      ENTER TAL "WT^PURGE" USING ASS-FSTATUS,
                                 ASS-FNAME

     IF  ASS-FSTATUS NOT = ZERO
         DISPLAY "Fehler bei WT^PURGE: "
                 ASS-FNAME " " ASS-FSTATUS
         DISPLAY " ---> Programm-Abbruch <--- "
         SET PRG-ABBRUCH TO TRUE
     END-IF
     .
 F999-99.
     EXIT.

******************************************************************
* Uebergabe-File umsetzen auf benoetigte Dateinamen
******************************************************************
 H100-FILENAMES SECTION.
 H100-00.

*P-REP-FILE = REPOSITORY FILE   AUS LINK-REP-FILE
     UNSTRING LINK-REP-FILE DELIMITED BY "."
     INTO    REP-VOL
           , REP-SVOL
           , REP-FILE

     IF  REP-SVOL = SPACE
     AND REP-FILE = SPACE
*        PFCSIP7R
         MOVE     REP-VOL        TO REP-FILE
         MOVE     SRCA-VOLUME    TO REP-VOL
         MOVE     SRCA-SUBVOL    TO REP-SVOL
     ELSE
         IF REP-FILE = SPACE
*           SSRCREPO.PFCSIP7R
            MOVE   REP-VOL       TO REP-SVOL
            MOVE   REP-SVOL      TO REP-FILE
            MOVE   SRCA-VOLUME   TO REP-VOL
         ELSE
*           $WSOFT.SSRCREPO.PFCSIP7R
            CONTINUE
         END-IF
     END-IF
*    Ersetzen Suffix
     ENTER TAL "String^Laenge" USING  REP-FILE, 8
                               GIVING LINK-REP-FILE-LEN
     MOVE  SRCA-FLETTER        TO REP-FILE(LINK-REP-FILE-LEN:1)
*    Vollen Dateiname bauen
     STRING REP-VOL      DELIMITED BY SPACE,
            "."          DELIMITED BY SIZE,
            REP-SVOL     DELIMITED BY SPACE,
            "."          DELIMITED BY SIZE,
            REP-FILE     DELIMITED BY SPACE
     INTO   P-REP-FILE

*P-HST-FILE = HISTORY FILE      AUS LINK-REPFILE
     UNSTRING LINK-REP-FILE DELIMITED BY "."
     INTO    HST-VOL
           , HST-SVOL
           , HST-FILE

     IF  HST-SVOL = SPACE
     AND HST-FILE = SPACE
*        PFCSIP7H
         MOVE     HST-VOL        TO HST-FILE
         MOVE     SRCA-VOLUME    TO HST-VOL
         MOVE     SRCA-SUBVOL    TO HST-SVOL
     ELSE
         IF HST-FILE = SPACE
*           SSRCREPO.PFCSIP7H
            MOVE   HST-VOL       TO HST-SVOL
            MOVE   HST-SVOL      TO HST-FILE
            MOVE   SRCA-VOLUME   TO HST-VOL
         ELSE
*           $WSOFT.SSRCREPO.PFCSIP7H
            CONTINUE
         END-IF
     END-IF
*    Ersetzen Suffix
     ENTER TAL "String^Laenge" USING  HST-FILE, 8
                               GIVING LINK-REP-FILE-LEN
     MOVE  "H"                 TO HST-FILE(LINK-REP-FILE-LEN:1)
*    Vollen Dateiname bauen
     STRING HST-VOL      DELIMITED BY SPACE,
            "."          DELIMITED BY SIZE,
            HST-SVOL     DELIMITED BY SPACE,
            "."          DELIMITED BY SIZE,
            HST-FILE     DELIMITED BY SPACE
     INTO   P-HST-FILE

*P-SRC-FILE = SOURCE_FILE       aus LINK-REPFILE1
     UNSTRING LINK-REP-FILE DELIMITED BY "."
     INTO    SRC-VOL
           , SRC-SVOL
           , SRC-FILE

     IF  SRC-SVOL = SPACE
     AND SRC-FILE = SPACE
*        PFCSIP7E
         MOVE     SRC-VOL        TO SRC-FILE
         MOVE     SRCA-VOLUME    TO SRC-VOL
         MOVE     SRCA-SUBVOL    TO SRC-SVOL
     ELSE
         IF SRC-FILE = SPACE
*           SSRCREPO.PFCSIP7E
            MOVE   SRC-VOL       TO SRC-SVOL
            MOVE   SRC-SVOL      TO SRC-FILE
            MOVE   SRCA-VOLUME   TO SRC-VOL
         ELSE
*           $WSOFT.SSRCREPO.PFCSIP7E
            CONTINUE
         END-IF
     END-IF
*    Vollen Dateiname bauen
     STRING SRC-VOL      DELIMITED BY SPACE,
            "."          DELIMITED BY SIZE,
            SRC-SVOL     DELIMITED BY SPACE,
            "."          DELIMITED BY SIZE,
            SRC-FILE     DELIMITED BY SPACE
     INTO   P-SRC-FILE

*P-ARC-FILE = ARCHIV_FILE       -- ffu --

     .
 H100-99.
     EXIT.
******************************************************************
* Zerlegen von SSFRFDEF.PRG_STU in Einzelteile, Parameterersetzung
* und Zusammenbau des STARTUP-Textes fuer das Kommando.
******************************************************************
 H200-CREATE-STUP SECTION.
 H200-00.

      IF PRG-STU OF SSFRFDEF = SPACES
         EXIT SECTION
      END-IF

*     Erstmal Parmeter separieren
      INITIALIZE STUP-DEC-BUF
      UNSTRING VAL OF PRG-STU OF SSFRFDEF DELIMITED BY "@"
      INTO     STUP-P-TXT1,
               STUP-P-PRM1,
               STUP-P-TXT2,
               STUP-P-PRM2,
               STUP-P-TXT3,
               STUP-P-PRM3,
               STUP-P-TXT4,
               STUP-P-PRM4,
               STUP-P-TXT5,
               STUP-P-PRM5

*     -mjq @REPFILE@ @HISTFILE@ wird zu
*     -mjq $WSOFT.SSRCREPO.PFCSIP7R  PFCSIP7H

*     Parameter durch Werte ersetzen
      MOVE    LFDNR OF SSFRFDEF        TO CI
      PERFORM VARYING CIP FROM 1 BY 1 UNTIL CIP     > 5
                                         OR STUP-DEC-PRM(CI, CIP) = SPACE

        EVALUATE STUP-DEC-PRM(CI, CIP)

            WHEN "REPFILE"  MOVE   P-REP-FILE   TO STUP-DEC-PRM(CI, CIP)

            WHEN "SRCFILE"  MOVE   P-SRC-FILE   TO STUP-DEC-PRM(CI, CIP)

            WHEN "ARCHFILE" MOVE   P-ARC-FILE   TO STUP-DEC-PRM(CI, CIP)

            WHEN "HISTFILE" MOVE   P-HST-FILE   TO STUP-DEC-PRM(CI, CIP)

            WHEN OTHER      MOVE    CI    TO D-NUM2
                            DISPLAY "  Unbekannter Parameter >",
                                    STUP-DEC-PRM(CI, CIP),
                                    "<"
                            DISPLAY "Fuer: ",
                                    PROG OF SSFRFDEF
                            DISPLAY "Funktion: ",
                                    FUNKTION OF SSFRFDEF,
                                    ", Index (Lfdnr): ",
                                    D-NUM2

        END-EVALUATE

      END-PERFORM

*     Bauen konkreten STARTUP-String
      STRING    STUP-DEC-TXT(CI, 1)         DELIMITED BY SPACE,
                " "                         DELIMITED BY SIZE,
                STUP-DEC-PRM(CI, 1)         DELIMITED BY SPACE,
                " "                         DELIMITED BY SIZE,
                STUP-DEC-TXT(CI, 2)         DELIMITED BY SPACE,
                " "                         DELIMITED BY SIZE,
                STUP-DEC-PRM(CI, 2)         DELIMITED BY SPACE,
                " "                         DELIMITED BY SIZE,
                STUP-DEC-TXT(CI, 3)         DELIMITED BY SPACE,
                " "                         DELIMITED BY SIZE,
                STUP-DEC-PRM(CI, 3)         DELIMITED BY SPACE,
                " "                         DELIMITED BY SIZE,
                STUP-DEC-TXT(CI, 4)         DELIMITED BY SPACE,
                " "                         DELIMITED BY SIZE,
                STUP-DEC-PRM(CI, 4)         DELIMITED BY SPACE,
                " "                         DELIMITED BY SIZE,
                STUP-DEC-TXT(CI, 5)         DELIMITED BY SPACE,
                " "                         DELIMITED BY SIZE,
                STUP-DEC-PRM(CI, 5)         DELIMITED BY SPACE,              
      INTO AKT-STARTUP-TEXT

     .
 H200-99.
     EXIT.
******************************************************************
* Select auf Tabelle SSFRMETA
******************************************************************
 S100-SELECT-SSFRMETA SECTION.
 S100-00.
     EXEC SQL
         SELECT    SRCA_VOLUME, SRCA_SUBVOL, SRCA_FNUM,
                   SRCA_FLETTER, PROCESS_HANDLER, PHD_ANCNAME
           INTO   :SRCA-VOLUME of SSFRMETA
                 ,:SRCA-SUBVOL of SSFRMETA
                 ,:SRCA-FNUM of SSFRMETA
                 ,:SRCA-FLETTER OF SSFRMETA
                 ,:PROCESS-HANDLER of SSFRMETA
                 ,:PHD-ANCNAME of SSFRMETA
           FROM  =SSFRMETA
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSFRMETA-OK  TO TRUE
         WHEN 100        SET SSFRMETA-NOK TO TRUE
         WHEN OTHER      SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S100-99.
     EXIT.

******************************************************************
* OPEN Cursor
******************************************************************
 S110-OPEN-SSFRARCH-CURSOR SECTION.
 S110-00.
     MOVE SRC-FILE TO SOURCE-MODUL OF SSFRARCH
     MOVE ZERO TO C9-COUNT
     SET SSFRARCH-OPEN TO TRUE
     EXEC SQL
         OPEN SSFRARCH_CURS
     END-EXEC
     .
 S110-99.
     EXIT.

******************************************************************
* Fetch aus Tabelle SSFRARCH
******************************************************************
 S120-FETCH-SSFRARCH-CURSOR SECTION.
 S120-00.
     EXEC SQL
         FETCH SSFRARCH_CURS
          INTO  :SOURCE-MODUL of SSFRARCH
               ,:VERSION of SSFRARCH
               ,:FILE-TYPE of SSFRARCH
               ,:SOURCE-DATE of SSFRARCH
                   TYPE AS DATETIME YEAR TO DAY
               ,:ARCHIV-MODUL of SSFRARCH
               ,:AUFTRAG of SSFRARCH
               ,:GROUP-USER of SSFRARCH
               ,:PROD-STATE of SSFRARCH
               ,:ZPINS of SSFRARCH
                   TYPE AS DATETIME YEAR TO FRACTION(2)
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET SSFRARCH-OK  TO TRUE
                     ADD 1 TO C9-COUNT
         WHEN OTHER  SET SSFRARCH-NOK TO TRUE
     END-EVALUATE
     .
 S120-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S130-CLOSE-SSFRARCH-CURSOR SECTION.
 S130-00.
     IF SSFRARCH-OPEN
        EXEC SQL
            CLOSE SSFRARCH_CURS
        END-EXEC
        SET SSFRARCH-CLOSED TO TRUE
     END-IF
     .
 S130-99.
     EXIT.

******************************************************************
* Insert auf Tabelle SSFRARCH
******************************************************************
 S140-INSERT-SSFRARCH SECTION.
 S140-00.
     EXEC SQL
         INSERT
           INTO  =SSFRARCH
                 ( SOURCE_MODUL, VERSION, FILE_TYPE, SOURCE_DATE
                 , ARCHIV_MODUL, AUFTRAG, GROUP_USER, PROD_STATE
                 , ZPINS
                 )
         VALUES  (
                  :SOURCE-MODUL of SSFRARCH
                 ,:VERSION of SSFRARCH
                 ,:FILE-TYPE of SSFRARCH
                 ,:SOURCE-DATE of SSFRARCH
                     TYPE AS DATETIME YEAR TO DAY
                 ,:ARCHIV-MODUL of SSFRARCH
                 ,:AUFTRAG of SSFRARCH
                 ,:GROUP-USER of SSFRARCH
                 ,:PROD-STATE of SSFRARCH
                 ,:ZPINS of SSFRARCH
                     TYPE AS DATETIME YEAR TO FRACTION(2)
                 )
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSFRARCH-OK  TO TRUE
         WHEN -8227  PERFORM S150-UPDATE-SSFRARCH
         WHEN OTHER  SET SSFRARCH-NOK TO TRUE
                     SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S140-99.
     EXIT.

******************************************************************
* Update auf SSFRARCH
******************************************************************
 S150-UPDATE-SSFRARCH  SECTION.
 S150-00.
     EXEC SQL
         UPDATE  =SSFRARCH
           SET   SOURCE_DATE = :SOURCE-DATE of SSFRARCH
                    TYPE AS DATETIME YEAR TO DAY
                ,ARCHIV_MODUL = :ARCHIV-MODUL of SSFRARCH
                ,AUFTRAG = :AUFTRAG of SSFRARCH
                ,GROUP_USER =:GROUP-USER of SSFRARCH
                ,PROD_STATE = :PROD-STATE of SSFRARCH
                ,ZPINS = :ZPINS of SSFRARCH
                   TYPE AS DATETIME YEAR TO FRACTION(2)
         WHERE SOURCE_MODUL, VERSION, FILE_TYPE =
              :SOURCE-MODUL OF SSFRARCH
             ,:VERSION      OF SSFRARCH
             ,:FILE-TYPE    OF SSFRARCH
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET SSFRARCH-OK        TO TRUE
         WHEN OTHER  SET SSFRARCH-NOK       TO TRUE
                     SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S150-99.
     EXIT.

******************************************************************
* Select auf Tabelle SSFRFDEF
******************************************************************
 S200-SELECT-SSFRFDEF SECTION.
 S200-00.
     EXEC SQL
         SELECT    PROG, ALT_PROG,
                   PRG_STU, PRG_INF, PRG_OUTF, PRG_OBF
           INTO   :PROG of SSFRFDEF
                 ,:ALT-PROG of SSFRFDEF
                 ,:PRG-STU of SSFRFDEF
                 ,:PRG-INF of SSFRFDEF
                 ,:PRG-OUTF of SSFRFDEF
                 ,:PRG-OBF of SSFRFDEF
           FROM  =SSFRFDEF
         WHERE   MODUL, FUNKTION, LFDNR =
*                Anwendung hier nicht erforderlich
*                :ANWENDUNG of SSFRFDEF
                :MODUL of SSFRFDEF
               ,:FUNKTION of SSFRFDEF
               ,:LFDNR of SSFRFDEF
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSFRFDEF-OK  TO TRUE
         WHEN 100        SET SSFRFDEF-NOK TO TRUE
         WHEN OTHER      SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S200-99.
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

         MOVE ZERO      TO MDNR OF GEN-ERROR
         MOVE ZERO      TO TSNR OF GEN-ERROR

     MOVE K-MODUL TO MODUL-NAME OF GEN-ERROR
     MOVE "SE"    TO ERROR-KZ   OF GEN-ERROR

**  ---> Einstellen in Fehlertabelle
     PERFORM Z999-ERRLOG
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

         MOVE ZERO      TO MDNR OF GEN-ERROR
         MOVE ZERO      TO TSNR OF GEN-ERROR

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

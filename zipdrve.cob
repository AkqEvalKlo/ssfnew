?CONSULT $SYSTEM.SYSTEM.COBOLEX0
?SEARCH  $SYSTEM.SYSTEM.COBOLLIB
?SEARCH  =TALLIB
?SEARCH  =ASC2EBC
?SEARCH  =EBC2ASC
?SEARCH  =WSYS022
?NOLMAP, SYMBOLS, INSPECT
?SAVE ALL
?SAVEABEND
?LINES 66
?CHECK 3
?SQL

 IDENTIFICATION DIVISION.

 PROGRAM-ID. ZIPDRV  .

 DATE-COMPILED.


*****************************************************************
* Letzte Aenderung :: 2017-11-30
* Letzte Version   :: A.00.00
* Kurzbeschreibung :: Driver fuer SSF-Ziproutinen
*
* Aenderungen (Version und Datum in Variable K-PROG-START aendern)
*              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*----------------------------------------------------------------*
* Vers. | Datum    | von | Kommentar                             *
*-------|----------|-----|---------------------------------------*
*A.01.|2011  |  |
*       |          |     |
*-------|----------|-----|---------------------------------------*
*A.00.00|2017-11-30| LOR | Neuerstellung
*----------------------------------------------------------------*
*
* Programmbeschreibung
* --------------------
*
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


 DATA DIVISION.
 FILE SECTION.


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
     05      D-NUM7              PIC  9(07).
     05      D-NUM9              PIC  9(09).

*--------------------------------------------------------------------*
* Felder mit konstantem Inhalt: Präfix K
*--------------------------------------------------------------------*
 01          KONSTANTE-FELDER.
     05      K-MODUL             PIC X(08)          VALUE "ZIPDRV  ".

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

     05      MSG-STATUS          PIC 9       VALUE ZERO.
          88 MSG-OK                          VALUE ZERO.
          88 MSG-EOF                         VALUE 1.

     05      PRG-STATUS          PIC 9.
          88 PRG-OK                          VALUE ZERO.
          88 PRG-NOK                         VALUE 1 THRU 9.
          88 PRG-ENDE                        VALUE 1.
          88 PRG-ABBRUCH                     VALUE 2.

     05      SSPROT-FLAG           PIC 9     VALUE ZERO.
          88 SSPROT-OK                       VALUE ZERO.
          88 SSPROT-NOK                      VALUE 1.

     05      SSFRARCH-FLAG           PIC 9     VALUE ZERO.
          88 SSFRARCH-OK                       VALUE ZERO.
          88 SSFRARCH-NOK                      VALUE 1.

     05      SSFRMETA-FLAG           PIC 9     VALUE ZERO.
          88 SSFRMETA-OK                       VALUE ZERO.
          88 SSFRMETA-NOK                      VALUE 1.

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
     05      H-ARCHIV-MODUL      PIC X(26).
     05      H-SOURCE-MODUL      PIC X(26).
     05      H-ZPINS             PIC X(22).

******************************************************************
* Im Folgenden mit dem INVOKE-Befehl die Tabellenstruktur-
* definitonen der benötigten Tabellen einfügen
******************************************************************
**  ---> Struktur der Tabelle SSPROT
 EXEC SQL
    INVOKE =SSPROT AS SSPROT
 END-EXEC

**  ---> Struktur der Tabelle SSFRARCH
 EXEC SQL
    INVOKE =SSFRARCH AS SSFRARCH
 END-EXEC

**  ---> Struktur der Tabelle SSFRMETA
 EXEC SQL
    INVOKE =SSFRMETA AS SSFRMETA
 END-EXEC

******************************************************************

 EXEC SQL
     END DECLARE SECTION
 END-EXEC

******************************************************************
* Im Folgenden werden die benöetigten CURSOR auf die
* verschiedenen SQL - Tabellen definiert
******************************************************************
******************************************************************
* Ende der SQL - Definitionen
******************************************************************

 PROCEDURE DIVISION.

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
     IF  PRG-ABBRUCH
         STOP RUN
     END-IF

*** =>
*** => weitere Verarbeitung hier einfügen
*** =>

**  ---> Nachlauf: Dateien schiessen
     PERFORM B090-ENDE
     STOP RUN
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

*** =>
*** => weitere Verarbeitung hier einfügen
*** =>

     .
 B000-99.
     EXIT.

******************************************************************
* Ende
******************************************************************
 B090-ENDE SECTION.
 B090-00.
     continue
*** =>
*** => weitere Verarbeitung hier einfügen
*** =>

     .
 B090-99.
     EXIT.

******************************************************************
* Verarbeitung
******************************************************************
 B100-VERARBEITUNG SECTION.
 B100-00.
*** =>
*** => weitere Verarbeitung hier einfügen
*** =>
     continue
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
*** =>
*** => weitere Verarbeitung hier einfügen
*** =>
     .
 C000-99.
     EXIT.


******************************************************************
* Initialisierung von Feldern und Strukturen
******************************************************************
 H100-CREATE-FILENAME SECTION.
 H100-00.
    
        PERFORM S120-SELECT-SSFRMETA
        IF SSFRMETA-OK
           CONTINUE
        ELSE
           DISPLAY " "
           DISPLAY "SSFRMETA nicht gefunden"
           DISPLAY "Filename kann nicht gebildet werden"
           DISPLAY ">>> ABBRUCH <<<"
           DISPLAY "<EOF>"
           DISPLAY " "
           SET PRG-ABBRUCH TO TRUE
        END-IF
        
*       Zusammensetzen des Filenames
        MOVE    SRCA-FNUM              TO D-NUM7
        STRING  SRCA-VOLUME   OF SSFRMETA DELIMITED BY SPACE,
                "."                       DELIMITED BY SIZE,
                SRCA-SUBVOL   OF SSFRMETA DELIMITED BY SPACE,
                "."                       DELIMITED BY SIZE,
                SRCA-FLETTER  OF SSFRMETA DELIMITED BY SIZE,
                SRCA-FNUM     OF SSFRMETA DELIMITED BY SIZE
        INTO    H-ARCHIV-MODUL
        
*       Hochzaehlen FNUM und Update META-Tabelle
        PERFORM U100-BEGIN
        IF SRCA-FNUM = 9999999
*          Neuen Buchstaben vergeben
           EVALUATE SRCA-FLETTER
             WHEN   "A"     MOVE "B"    TO SRCA-FLETTER
             WHEN   "B"     MOVE "C"    TO SRCA-FLETTER
             WHEN   "C"     MOVE "D"    TO SRCA-FLETTER
             WHEN   "D"     MOVE "E"    TO SRCA-FLETTER
*            .
*            .
*            .
             WHEN   "W"     MOVE "X"    TO SRCA-FLETTER
             WHEN   "X"     MOVE "Y"    TO SRCA-FLETTER
             WHEN   "Y"     MOVE "Z"    TO SRCA-FLETTER             
*            ---> 26 * 100000 = 2,6 Mio. Versionen !!!
*            ---> dann wieder mit A weiter
             WHEN   "Z"     MOVE "A"    TO SRCA-FLETTER             
           END-EVALUATE
*          Und wieder bei ZERO anfangen           
           MOVE    ZERO                 TO SRCA-FNUM
        ELSE
           ADD   1    TO SRCA-FNUM
        END-IF

        PERFORM S130-UPDATE-SSFRMETA
        
        IF SSFRMETA-OK
           PERFORM U110-COMMIT
        ELSE
           PERFORM U120-ROLLBACK
        END-IF

     .
 H100-99.
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
     MOVE ZERO TO CREP-OPTION
     ENTER "CREATEPROCESS" USING  CREP-PROGRAM
                                  omitted
                                  CREP-OPTION
                           GIVING CREP-RESULT
     IF  CREP-RESULT = ZERO
         continue

**  --->
**  ---> hier sollte das Handling mit der Status-Abfrage
**  ---> aus der Message-Datei eingefügt werden
**  --->

     ELSE
         SET PRG-ABBRUCH TO TRUE
     END-IF
     .
 P100-99.
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
 P110-PUTSTARTUPTEXT SECTION.
 P110-00.
     ENTER "PUTSTARTUPTEXT"  USING   STUP-PORTION
                                     STUP-TEXT
                                     STUP-CPLIST
                             GIVING  STUP-RESULT
     EVALUATE STUP-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus PutStartUpText
                     MOVE STUP-RESULT TO D-NUM4

*** =>
*** => weitere Verarbeitung hier einfügen
*** =>

                     SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION
         WHEN OTHER
                     continue
     END-EVALUATE
     .
 P110-99.
     EXIT.

******************************************************************
* Aufruf COBOL-Utility: GETSTARTUPTEXT
*
*              Eingabe: stup-portion (VOLUME,IN,OUT,STRING)
*              Ausgabe: stup-result  (-1:NOK, >=0:OK)
*                       stup-text
*
******************************************************************
 P120-GETSTARTUPTEXT SECTION.
 P120-00.
     MOVE SPACE TO STUP-TEXT
     ENTER "GETSTARTUPTEXT"  USING   STUP-PORTION
                                     STUP-TEXT
                             GIVING  STUP-RESULT
     EVALUATE STUP-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus GetStartUpText
                     MOVE STUP-RESULT TO D-NUM4

*** =>
*** => weitere Verarbeitung hier einfügen
*** =>

                     SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION
         WHEN ZERO
**                  ---> kein StartUpText vorhanden
                     continue

         WHEN OTHER
**                  ---> StartUpText ist vorhanden in STUP-TEXT

                     continue
     END-EVALUATE
     .
 P120-99.
     EXIT.     
******************************************************************
* Select auf Tabelle SSPROT
******************************************************************
 S100-SELECT-SSPROT SECTION.
 S100-00.
     EXEC SQL
         SELECT SOURCE_MODUL, VERSION, TICKET, GROUP_USER 
           INTO   :SOURCE-MODUL of SSPROT
                 ,:VERSION      of SSPROT
                 ,:TICKET       of SSPROT
                 ,:GROUP-USER   of SSPROT
           FROM  =SSPROT
         WHERE
           SOURCE_MODUL     = :SOURCE-MODUL   of SSPROT
           AND
           ZPINS = (SELECT MAX(ZPINS) FROM =SSPROT
                    WHERE SOURCE_MODUL = :SOURCE-MODUL   of SSPROT 
                    BROWSE ACCESS)
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSPROT-OK  TO TRUE
         WHEN 100        SET SSPROT-NOK TO TRUE
         WHEN OTHER      SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S100-99.
     EXIT.

******************************************************************
* Insert auf Tabelle SSFRARCH
******************************************************************
 S110-INSERT-SSFRARCH SECTION.
 S110-00.
     EXEC SQL
         INSERT
           INTO  =SSFRARCH
                 ( SOURCE_MODUL, ZPINS, ARCHIV_MODUL, TICKET
                 , VERSION, GROUP_USER, ZIP_FLAG
                 )
         VALUES  (
                  :SOURCE-MODUL of SSPROT
                 ,CURRENT
                 ,:H-ARCHIV-MODUL
                 ,:TICKET of SSPROT
                 ,:VERSION of SSPROT
                 ,:GROUP-USER of SSFRARCH
                 ,"J"
                 )
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSFRARCH-OK  TO TRUE
         WHEN OTHER  SET SSFRARCH-NOK TO TRUE
                     SET ENDE TO TRUE
     END-EVALUATE
     .
 S110-99.
     EXIT.

******************************************************************
* Select auf Tabelle SSFRMETA
******************************************************************
 S120-SELECT-SSFRMETA SECTION.
 S120-00.
     EXEC SQL
         SELECT    SYSKEY, SRCA_VOLUME, SRCA_SUBVOL, SRCA_FNUM
                 , SRCA_FLETTER, ZIP_PROG, UNZIP_PROG
           INTO   :H-SYSKEY
                 ,:SRCA-VOLUME of SSFRMETA
                 ,:SRCA-SUBVOL of SSFRMETA
                 ,:SRCA-FNUM of SSFRMETA
                 ,:SRCA-FLETTER of SSFRMETA
                 ,:ZIP-PROG of SSFRMETA
                 ,:UNZIP-PRG of SSFRMETA
           FROM  =SSFRMETA
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSFRMETA-OK  TO TRUE
         WHEN 100        SET SSFRMETA-NOK TO TRUE
         WHEN OTHER      SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S120-99.
     EXIT.

******************************************************************
* Select auf Tabelle SSFRMETA
******************************************************************
 S130-UPDATE-SSFRMETA SECTION.
 S130-00.
     EXEC SQL
          UPDATE =SSFRMETA
          SET    SRCA_FNUM      = :SRCA-FNUM       OF SSFRMETA,
                 SRCA_FLETTER   = :SRCA-FLETTER    OF SSFRMETA
          WHERE  SYSKEY = :H-SYSKEY
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSFRMETA-OK  TO TRUE
         WHEN 100        SET SSFRMETA-NOK TO TRUE
         WHEN OTHER      SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
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

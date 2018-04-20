?CONSULT $SYSTEM.SYSTEM.COBOLEX0
?SEARCH  $SYSTEM.SYSTEM.COBOLLIB
?SEARCH  =TALLIB
?SEARCH  =ASC2EBC
?SEARCH  =EBC2ASC
?SEARCH  =WSYS022

* Sourcesafe-Module
?SEARCH  =SSFEIN0

?NOLMAP, SYMBOLS, INSPECT
?SAVE ALL
?SAVEABEND
?LINES 66
?CHECK 3
?SQL

 IDENTIFICATION DIVISION.

 PROGRAM-ID. EINDRV0O.

 DATE-COMPILED.


*****************************************************************
* Letzte Aenderung :: 2018-03-23
* Letzte Version   :: G.00.00
* Kurzbeschreibung :: Testdriver fuer SSF-Modul SSFRCI0
* Auftrag          :: SSFNEW-3
*
* Aenderungen (Version und Datum in Variable K-PROG-START aendern)
*              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*----------------------------------------------------------------*
* Vers. | Datum    | von | Kommentar                             *
*-------|----------|-----|---------------------------------------*
*A.01.|2011  |  |
*       |          |     |
*-------|----------|-----|---------------------------------------*
*G.00.00|2018-03-23| kl  | Neuerstellung
*----------------------------------------------------------------*
*
* Programmbeschreibung
* --------------------
*
* Testdriver fuer SSF-Modul SSFEIN0 (Holen Environment-Infos) 

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

     05      CD4-X.
      10                         PIC X value low-value.
      10     CD4-X2              PIC X.
     05      CD4-NUM redefines CD4-X
                                 PIC S9(04) COMP.
     
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
     05      K-MODUL             PIC X(08)          VALUE "EINDRV0O".

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

*--------------------------------------------------------------------*
* weitere Arbeitsfelder
*--------------------------------------------------------------------*
 01          WORK-FELDER.
     05      W-DUMMY             PIC X(02).
 01          ZEILE               PIC X(80) VALUE SPACES.
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
     
 01          STUP-CONTENT-DECOMPOSE.
     05      STUP-EIN-CMD        PIC X(02)  VALUE SPACES.
     05      STUP-EIN-FILE       PIC X(36)  VALUE SPACES.
     
*-->    Uebergabe aus Hauptprogramm
 01     LINK-REC.
    05  LINK-HDR.
     10 LINK-CMD                PIC X(02).
*       "EI" = Environment Info
*       "FI" = Fileinfo
     10 LINK-RC                 PIC S9(04) COMP.
*       0    = OK
*       aus FILE_GETINFO...
*       10   = FILE Exists
*       11   = FILE doesn't exsist
*       12   = FILE in use
*       9999 = Programmabbruch - Hauptprogramm muss reagieren
    05  LINK-DATA.
*************************************************************
*                    FILE-Definition                        *
*************************************************************
*       Name des Repository-Files (z.b. PFCSIP7R)
     10 LINK-REP-FILE           PIC X(36).
     10 LINK-REP-FILE-LEN       PIC S9(04) COMP.
*************************************************************
*                 ENVIRONMENT-Informationen                 *
*************************************************************
**          ---> User-Name 
     10 LINK-USER-NAME          PIC X(32).
     10 LINK-USER-CURLEN        PIC S9(04) COMP.
**          ---> numerische Werte für Gruppe und User
     10 LINK-USER-GRP           PIC  9(03).
     10 LINK-USER-NR            PIC  9(03).
**          ---> Aktuelles Volume/Subvolume
     10 LINK-VOLUME             PIC X(08).
     10 LINK-SUBVOL             PIC X(08).
*************************************************************
*                    FILE-Informationen                     *
*************************************************************
**          ---> Security-String
     10 LINK-SECURITY           PIC X(04).
**          ---> Last Modify     
     10 LINK-MODI               PIC 9(16).
**          ---> User-ID / Owner     
     10 LINK-OWNER-GROUP        PIC 9(03).
     10 LINK-OWNER-NR           PIC 9(03).
**          ---> User-Name / Owner
     10 LINK-OWNER-NAME         PIC X(32).
     10 LINK-OWNER-CURLEN       PIC S9(04) COMP.
**          Filecode (101 - Edit / 100 = Object / 1001 =Zip)     
     10 LINK-FCODE              PIC S9(04) COMP.

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
     05      H-ARCH-COUNT        PIC S9(04) COMP.
     
******************************************************************
* Im Folgenden mit dem INVOKE-Befehl die Tabellenstruktur-
* definitonen der benötigten Tabellen einfügen
******************************************************************
**  ---> Struktur der Tabelle SSFRARCH
 EXEC SQL
    INVOKE =SSFRARCH AS SSFRARCH
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

 01     SRC-LINES-BUFFER IS EXTERNAL.
    05  SRC-LINE  OCCURS 750.
     10 SL-VAL               PIC X(128).
     10 SL-LEN               PIC S9(04).
     
 01     MAX-SRC-LINES        PIC S9(04) COMP VALUE 750.
 01     SRC-LINES-COUNT      PIC S9(04) COMP VALUE ZERO.
 
 PROCEDURE DIVISION.

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
**  ---> Verarbeitung     
     IF  PRG-ABBRUCH
         CONTINUE
     ELSE
         PERFORM B100-VERARBEITUNG
     END-IF


**  ---> Nachlauf: Dateien schliessen etc.
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

**  ---> Holen Startup-Text
     PERFORM P100-GETSTARTUPTEXT     
     .
 B000-99.
     EXIT.

******************************************************************
* Ende
******************************************************************
 B090-ENDE SECTION.
 B090-00.

     IF PRG-ABBRUCH
        DISPLAY ">>> ABBRUCH !!! <<< "
        DISPLAY "<EOF>"
        DISpLAY " "
     ELSE
        STRING ">>> Verarbeitung "     DELIMITED BY SIZE,
                "OK <<< "              DELIMITED BY SIZE
        INTO ZEILE
        DISPLAY ZEILE     
        MOVE SPACES TO ZEILE
        
        IF LINK-CMD = "EI"
        
           MOVE LINK-USER-CURLEN   TO D-NUM4
           STRING "USER (NAME): " DELIMITED BY SIZE,
                  LINK-USER-NAME DELIMITED BY SPACE
                  " / Laenge: "  DELIMITED BY SIZE,
                  D-NUM4 DELIMITED BY SIZE 
           INTO ZEILE
           DISPLAY ZEILE
           MOVE SPACES TO ZEILE
        
          STRING "USER (ID  ): " DELIMITED BY SIZE,
                  LINK-USER-GRP  DELIMITED BY SIZE,
                  ","            DELIMITED BY SIZE,
                  LINK-USER-NR   DELIMITED BY SIZE
          INTO ZEILE
          DISPLAY ZEILE
          MOVE SPACES TO ZEILE
        
          STRING "(Sub)-Vol. : " DELIMITED BY SIZE,
                  LINK-VOLUME    DELIMITED BY SPACE,
                  "."            DELIMITED BY SIZE,
                  LINK-SUBVOL    DELIMITED BY SPACE
          INTO ZEILE
          DISPLAY ZEILE
          MOVE SPACES TO ZEILE
          
        ELSE
        
           STRING "OWNER (ID  ): "   DELIMITED BY SIZE,
                   LINK-OWNER-GROUP  DELIMITED BY SIZE,
                   ","               DELIMITED BY SIZE,
                   LINK-OWNER-NR     DELIMITED BY SIZE
           INTO ZEILE
           DISPLAY ZEILE
           MOVE SPACES TO ZEILE
        
           MOVE LINK-OWNER-CURLEN   TO D-NUM4
           STRING "OWNER (NAME): " DELIMITED BY SIZE,
                  LINK-OWNER-NAME  DELIMITED BY SPACE
                  " / Laenge: "    DELIMITED BY SIZE,
                  D-NUM4           DELIMITED BY SIZE 
           INTO ZEILE
           DISPLAY ZEILE
           MOVE SPACES TO ZEILE
        
           STRING "SECURITY    : " DELIMITED BY SIZE,
                  LINK-SECURITY    DELIMITED BY SPACE
           INTO ZEILE
           DISPLAY ZEILE
           MOVE SPACES TO ZEILE
        
           STRING "Last Modify : " DELIMITED BY SIZE,
                  LINK-MODI        DELIMITED BY SIZE
           INTO ZEILE
           DISPLAY ZEILE
           MOVE SPACES TO ZEILE
        
           MOVE LINK-FCODE   TO D-NUM4
           STRING "File Code  : "  DELIMITED BY SIZE,
                  D-NUM4           DELIMITED BY SIZE
           INTO ZEILE
           DISPLAY ZEILE
           MOVE SPACES TO ZEILE      
          
        END-IF

        DISPLAY "<EOF>"
        DISPLAY " "
     END-IF

     .
 B090-99.
     EXIT.

******************************************************************
* Verarbeitung
******************************************************************
 B100-VERARBEITUNG SECTION.
 B100-00.

     MOVE STUP-TEXT(1:2)    TO LINK-CMD
     MOVE ZERO              TO LINK-RC
     INITIALIZE LINK-DATA
     IF LINK-CMD = "EI"
        CONTINUE
     ELSE
        MOVE STUP-EIN-FILE TO LINK-REP-FILE
        ENTER TAL "String^Laenge" USING LINK-REP-FILE, 36
                                  GIVING LINK-REP-FILE-LEN
     END-IF
     
**  --> Aufrufen SSFEIN0
     CALL "SSFEIN0M"     USING LINK-REC
     EVALUATE LINK-RC
     
        WHEN   ZERO   CONTINUE
        
        WHEN   10     DISPLAY LINK-REP-FILE " gibt es schon!"
        
        WHEN   11     DISPLAY LINK-REP-FILE " gibt es nicht!"
        
        WHEN   12     DISPLAY LINK-REP-FILE ": File in use!"
        
        WHEN   9999   DISPLAY " RC 9999 = PRG-ABBRUCH aus SSFEIN0 "
                      SET PRG-ABBRUCH TO TRUE
                      
        WHEN   OTHER  MOVE LINK-RC TO D-NUM4
                      DISPLAY " unbekannter RC: ",
                                D-NUM4,
                              " aus SSFEIN0"
                      DISPLAY " (< ZERO = SQL-Fehler"
                      SET PRG-ABBRUCH TO TRUE
                      
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
     .
 C000-99.
     EXIT.

******************************************************************
* Aufruf COBOL-Utility: GETSTARTUPTEXT
*
*              Eingabe: stup-portion (VOLUME,IN,OUT,STRING)
*              Ausgabe: stup-result  (-1:NOK, >=0:OK)
*                       stup-text
*
******************************************************************
 P100-GETSTARTUPTEXT SECTION.
 P100-00.
     MOVE SPACE TO STUP-TEXT
     ENTER "GETSTARTUPTEXT"  USING   STUP-PORTION
                                     STUP-TEXT
                             GIVING  STUP-RESULT
     EVALUATE STUP-RESULT
         WHEN -9999 THRU -1
**                  ---> Fehler aus GetStartUpText
                     MOVE STUP-RESULT TO D-NUM4
                     DISPLAY "Lesen STARTUP fehlgeschlagen: "
                             D-NUM4
                     DISPLAY ">>> Verarbeitung nicht moeglich <<<"
                     SET PRG-ABBRUCH TO TRUE

         WHEN ZERO
**                  ---> kein StartUpText vorhanden
                     DISPLAY "Lesen STARTUP fehlgeschlagen: "
                             D-NUM4
                     DISPLAY ">>> Verarbeitung nicht moeglich <<<"
                     SET PRG-ABBRUCH TO TRUE
                     
         WHEN OTHER
                     INSPECT STUP-TEXT 
                        CONVERTING "abcdefghijklmnopqrstuvwxyz"
                                TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"                             
                     UNSTRING STUP-TEXT DELIMITED BY " "
                     INTO     STUP-EIN-CMD,
                              STUP-EIN-FILE

     END-EVALUATE
     .
 P100-99.
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

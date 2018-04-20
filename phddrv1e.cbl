?CONSULT $SYSTEM.SYSTEM.COBOLEX0
?SEARCH  $SYSTEM.SYSTEM.COBOLLIB
?SEARCH  =TALLIB
?SEARCH  =ASC2EBC
?SEARCH  =EBC2ASC
?SEARCH  =WSYS022

?SEARCH  =SSFPHD1

?NOLMAP, SYMBOLS, INSPECT
?SAVE ALL
?SAVEABEND
?LINES 66
?CHECK 3
?SQL

 IDENTIFICATION DIVISION.

 PROGRAM-ID. PHDDRV1O.

 DATE-COMPILED.


*****************************************************************
* Letzte Aenderung :: 2018-04-19
* Letzte Version   :: G.00.00
* Kurzbeschreibung :: Driver für Prozess-Handler SSFPHD1M
* Auftrag          :: SSFNEW1
* Package          :: TOOL
*
* Aenderungen (Version und Datum in Variable K-PROG-START aendern)
*              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*----------------------------------------------------------------*
* Vers. | Datum    | von | Kommentar                             *
*-------|----------|-----|---------------------------------------*
*A.01.|2011  |  |
*       |          |     |
*-------|----------|-----|---------------------------------------*
*G.00.00|2018-04-19| kl  | Neuerstellung
*----------------------------------------------------------------*
*
* Programmbeschreibung
* --------------------
*
* Dieses Programm dient als Driver für das Prozesshandler-Modul
* SSFPHD1M. 
*
* Aufruf: RUN(D) PHDDRV1O [Funktion] [Delay]
*                                    
* Mit:    Funktion = SSFRFDEF.Funktion
*         Delay    = Verzoegerung in 1/100 Sekunden (nur Aufruf-
*                    ketten, also lfdnr 1 - X)
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
     05      C9-DELAY-TIME       PIC S9(09) COMP.

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
     05      K-MODUL             PIC X(08)          VALUE "PHDDRV1O".

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

     05      SSFRFDEF-FLAG           PIC 9     VALUE ZERO.
          88 SSFRFDEF-OK                       VALUE ZERO.
          88 SSFRFDEF-NOK                      VALUE 1.
          88 SSFRFDEF-EOD                      VALUE 9.

     05      SSFRFDEF-CURS-FLAG      PIC 9     VALUE ZERO.
          88 SSFRFDEF-CLOSED                   VALUE ZERO.
          88 SSFRFDEF-OPEN                     VALUE 1.
          
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
     
 01         STUP-DECOMPOSE.
     05     STUP-DEC-FUNKTION    PIC X(15)  VALUE SPACES.
     05     STUP-DEC-DELAY       PIC 9(09)  VALUE ZERO.
     
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

**          ---> Fuer Rueckgabe Ergebnis "CREATEPROCESS"     
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
**  ---> Cursor auf Tabelle SSFRFDEF
 EXEC SQL
     DECLARE SSFRFDEF_CURS CURSOR FOR
         SELECT   ANWENDUNG, MODUL, FUNKTION, LFDNR, PROG
                , ALT_PROG, PRG_STU, PRG_INF, PRG_OUTF, PRG_OBF
                , ZPINS
           FROM  =SSFRFDEF
          WHERE   ANWENDUNG, MODUL, FUNKTION =
                 :ANWENDUNG        OF SSFRFDEF
                ,:MODUL            OF SSFRFDEF
                ,:FUNKTION         OF SSFRFDEF
          ORDER  BY LFDNR
         BROWSE  ACCESS
 END-EXEC

******************************************************************
* Ende der SQL - Definitionen
******************************************************************
** --> Schnittstelle zum Modul
 01          INTERN-MESSAGE.
             COPY    INT-SCHNITTSTELLE-C OF  "=MSGLIB"
                     REPLACING =="*"== BY ==PHD==.
                     

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
     IF  PRG-ABBRUCH
         STOP RUN
     END-IF

**  ---> Aufruf verarbeiten
     PERFORM B100-VERARBEITUNG
     
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
     
**  ---> Parameter holen
     PERFORM P100-GETSTARTUPTEXT     

     .
 B000-99.
     EXIT.

******************************************************************
* Ende
******************************************************************
 B090-ENDE SECTION.
 B090-00.

     IF SSFRFDEF-OPEN
        PERFORM S120-CLOSE-SSFRFDEF-CURSOR
     END-IF
     
     IF PRG-ABBRUCH
        DISPLAY " "
        DISPLAY " ENDE mit ABBRUCH"
        DISPLAY " "
     ELSE
        DISPLAY " "
        DISPLAY "Verarbeitung OK"
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

**--> Vorbereiten Cursor
      MOVE K-MODUL                     TO ANWENDUNG    OF SSFRFDEF
      MOVE SPACES                      TO MODUL        OF SSFRFDEF
      MOVE STUP-DEC-FUNKTION           TO FUNKTION     OF SSFRFDEF
      
**--> Oeffnen Cursor      
      PERFORM S100-OPEN-SSFRFDEF-CURSOR
      IF SSFRFDEF-OPEN 
         CONTINUE
      ELSE
         MOVE SQLCODE OF SQLCA TO D-NUM4
         DISPLAY " "
         STRING " OPEN Cursor fehlgeschlagen mit SQLCODE: ",
                  D-NUM4
         DELIMITED BY SIZE INTO ZEILE
         DISPLAY ZEILE
         DISPLAY " >>> ABBRUCH! <<<"
         DISPLAY " "
         SET PRG-ABBRUCH TO TRUE
         MOVE ALL SPACES TO ZEILE
         EXIT SECTION
      END-IF
      
**--> 1. Lesen Cursor
      PERFORM S110-FETCH-SSFRFDEF-CURSOR
      
**--> Verarbeitungsschleife ueber alle Einträge LFDNR 1 - X
      PERFORM UNTIL SSFRFDEF-EOD
                 OR SSFRFDEF-NOK
                 OR PRG-ABBRUCH

*       Aufruf Prozesshandler        
        PERFORM C100-MAKE-PROCESS
*       Interpretieren MSG-SATZ
        PERFORM C200-INTERPRET-SYSMSG
*       Ggf. Delay
        IF C9-DELAY-TIME > ZERO
           ENTER TAL "DELAY" USING C9-DELAY-TIME
        END-IF
*       Nachlesen Cursor
        PERFORM S110-FETCH-SSFRFDEF-CURSOR
        
     END-PERFORM
      
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
                SSFRFDEF
                INTERN-MESSAGE

     .
 C000-99.
     EXIT.
     
******************************************************************
* Neuen Prozess mit [PROG]/[ALT-PROG] generieren
******************************************************************
 C100-MAKE-PROCESS SECTION.
 C100-00.
    
**--> Jetzt zusammenstellen Aufruf SSFPHD1
      MOVE    PROG            OF SSFRFDEF      TO PHD-PRG-NAME
      MOVE    VAL OF ALT-PROG OF SSFRFDEF      TO PHD-ALT-PFILE
      MOVE    VAL OF PRG-STU  OF SSFRFDEF      TO PHD-PRG-STU
      MOVE    VAL OF PRG-INF  OF SSFRFDEF      TO PHD-PRG-INF
      MOVE    VAL OF PRG-OUTF OF SSFRFDEF      TO PHD-PRG-OUTF
      MOVE    VAL OF PRG-OBF  OF SSFRFDEF      TO PHD-PRG-OBF
      MOVE    SPACES                           TO PHD-FFU
      MOVE    1024                             TO PHD-ID-LEN

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
* Rueckgabe MSG-SATZ (Systemmessage) untersuchen
******************************************************************
 C200-INTERPRET-SYSMSG SECTION.
 C200-00.
    
**--> MSG-SATZ initialisieren
      INITIALIZE MSG-SATZ
      
**--> MSG-Satz aus der internen Schnittstelle fuellen, falls
*     vorhanden
      IF PHD-NDATEN = SPACE
      OR PHD-DATLEN  = ZERO
         EXIT SECTION
      ELSE
         MOVE    PHD-NDATEN(1:PHD-DATLEN)  TO MSG-SATZ
      END-IF
      
**--> Jetzt ist die Rueckgabe da; machen, was auch immer man will
*     (z.B. behandeln Completion-Code)
      CONTINUE  

**          ---> Fuer Rueckgabe Ergebnis "CREATEPROCESS"     
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
      
    .
 C200-99.
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
                     DISPLAY " "
                     DISPLAY "Fehler bei GETSTARTUPTEXT: " D-NUM4
                     DISPLAY ">> ABBRUCH <<"
                     DISPLAY " "
                     SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION
         WHEN ZERO
**                  ---> kein StartUpText vorhanden
                     DISPLAY " "
                     DISPLAY "GETSTARTUPTEXT: Startup-Text fehlt! "
                     DISPLAY ">> ABBRUCH <<"
                     DISPLAY " "
                     SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION

         WHEN OTHER
**                  ---> StartUpText ist vorhanden in STUP-TEXT
                     INSPECT STUP-TEXT 
                        CONVERTING "abcdefghijklmnopqrstuvwxyz"
                                TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"                             
                     UNSTRING STUP-TEXT DELIMITED BY ALL SPACES
                     INTO     STUP-DEC-FUNKTION,
                              STUP-DEC-DELAY
                     IF STUP-DEC-DELAY NUMERIC
                        MOVE  STUP-DEC-DELAY    TO C9-DELAY-TIME
                     ELSE
                        MOVE  ZEROES            TO C9-DELAY-TIME
                     END-IF

     END-EVALUATE
     .
 P100-99.
     EXIT.

******************************************************************
* OPEN Cursor
******************************************************************
 S100-OPEN-SSFRFDEF-CURSOR SECTION.
 S100-00.
     MOVE ZERO TO C9-COUNT
     EXEC SQL
         OPEN SSFRFDEF_CURS
     END-EXEC
     IF SQLCODE OF SQLCA = ZERO
        SET SSFRFDEF-OPEN TO TRUE
     END-IF
     .
 S100-99.
     EXIT.

******************************************************************
* Fetch aus Tabelle SSFRFDEF
******************************************************************
 S110-FETCH-SSFRFDEF-CURSOR SECTION.
 S110-00.
     EXEC SQL
         FETCH SSFRFDEF_CURS
          INTO  :ANWENDUNG of SSFRFDEF
               ,:MODUL of SSFRFDEF
               ,:FUNKTION of SSFRFDEF
               ,:LFDNR of SSFRFDEF
               ,:PROG of SSFRFDEF
               ,:ALT-PROG of SSFRFDEF
               ,:PRG-STU of SSFRFDEF
               ,:PRG-INF of SSFRFDEF
               ,:PRG-OUTF of SSFRFDEF
               ,:PRG-OBF of SSFRFDEF
               ,:ZPINS of SSFRFDEF
                   TYPE AS DATETIME YEAR TO FRACTION(2)
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET SSFRFDEF-OK  TO TRUE
                     ADD 1 TO C9-COUNT
         WHEN OTHER  SET SSFRFDEF-NOK TO TRUE
     END-EVALUATE
     .
 S110-99.
     EXIT.

******************************************************************
* CLOSE Cursor
******************************************************************
 S120-CLOSE-SSFRFDEF-CURSOR SECTION.
 S120-00.
     EXEC SQL
         CLOSE SSFRFDEF_CURS
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

?CONSULT $SYSTEM.SYSTEM.COBOLEX0
?SEARCH  $SYSTEM.SYSTEM.COBOLLIB
?SEARCH  =TALLIB
?SEARCH  =ASC2EBC
?SEARCH  =EBC2ASC
?SEARCH  =WSYS022

* Sourcesafe-Module
?SEARCH  =SSFCMP0
?SEARCH  =SSFPHD1
?SEARCH  =SSFEIN0

?NOLMAP, SYMBOLS, INSPECT
?SAVE ALL
?SAVEABEND
?LINES 66
?CHECK 3
?SQL

 IDENTIFICATION DIVISION.

 PROGRAM-ID. SRCCOMP.

 DATE-COMPILED.


*****************************************************************
* Letzte Aenderung :: 2018-04-24
* Letzte Version   :: G.00.00
* Kurzbeschreibung :: Wie PRGCOMP auf Basis des neuen Frameworks
*
* Aenderungen (Version und Datum in Variable K-PROG-START aendern)
*              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*----------------------------------------------------------------*
* Vers. | Datum    | von | Kommentar                             *
*-------|----------|-----|---------------------------------------*
*A.01.|2011  |  |
*       |          |     |
*-------|----------|-----|---------------------------------------*
*G.00.00|2018-04-24| kl  | Neuerstellung
*----------------------------------------------------------------*
*
* Programmbeschreibung
* --------------------
*
* Dieses Programm ruft je nach Auswahl ALLE verfügbaren Compiler
* ueber das Funktionsmodul SSFCMP0 und den Prozess-Handler 
* SSFPHD1 auf.
*
* Beispielaufrufe
* ---------------
*
* PRG -COB Source Object          COBOL85 + SQLCOMP
* PRG -COB Source Object NOSQL    COBOL85 ohne SQLCOMP 
* PRG -TAL Source Object          TAL + SQLCOMP
* PRG -C   Source Object          C + SQLCOMP
* MOD -COB Source Object          COBOL85 ohne SQLCOMP 
* SQL      Source                 nur SQLCOMP
*
* Default (-COB)
* --------------
* PRG Source Object               COBOL85 + SQLCOMP
*
*
*
* Beispiel fuer Makro PRGC85
* --------------------------
* SRCCOMP PRG Source Object
* 
* Beispiel fuer (neues) Makro PRGCC
* ---------------------------------
* SRCCOMP PRG -C Source Object
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
     05      D-NUM9              PIC  9(09).

*--------------------------------------------------------------------*
* Felder mit konstantem Inhalt: Präfix K
*--------------------------------------------------------------------*
 01          KONSTANTE-FELDER.
     05      K-MODUL             PIC X(08)          VALUE "SRCCOMP".

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
     05      STUP-DEC-CMD        PIC X(08)  VALUE SPACES.
         88  STUP-DEC-PRG                   VALUE "PRG".
         88  STUP-DEC-SQL                   VALUE "SQL".
         88  STUP-DEC-MOD                   VALUE "MOD".
         88  STUP-DEC-PRT2FL                VALUE "PRT2FL".
         88  STUP-DEC-VALID                 VALUE "PRG", 
                                                  "SQL", 
                                                  "MOD",
                                                  "PRT2FL".
     05      STUP-DEC-COMPILER   PIC X(36)  VALUE SPACES.
     05      STUP-DEC-SRCFILE    PIC X(36)  VALUE SPACES.
     05      STUP-DEC-OBJFILE    PIC X(36)  VALUE SPACES.
     05      STUP-DEC-SQLFLAG    PIC X(05)  VALUE SPACES.
         88  STUP-DEC-NOSQL                 VALUE "NOSQL".
     
*-->    Uebergabe an Unterprogramm
 01     LINK-REC.
    05  LINK-HDR.
     10 LINK-CMD                PIC X(06).
*       "COB"           = Cobol85
*       "C"             = C
*       "TAL"           = TAL
*       "SQL"           = SQLCOMP
*       "PRTCMP"        = PERUSE (Anzeige Compile-Liste)
*       "PRT2FL"        = PERUSE (Ausgabe in (Edit)-Datei)
     10 LINK-RC                 PIC S9(04) COMP.
*       0    = OK
*       9999 = Programmabbruch - Hauptprogramm muss reagieren
    05  LINK-DATA.
*       Name des aufrufenden Programmes
     10 LINK-CALLER             PIC X(08).    
*       Name des Source-Files
     10 LINK-SRC-FILE           PIC X(36).
     10 LINK-SRC-FILE-LEN       PIC S9(04) COMP.
*       Name des Object-Files
     10 LINK-OBJ-FILE           PIC X(36).
     10 LINK-OBJ-FILE-LEN       PIC S9(04) COMP.

     
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

**  ---> Aufrufendes Programm setzen
     MOVE    K-MODUL                    TO LINK-CALLER     
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
        DISPLAY " "
     ELSE
        STRING ">>> Verarbeitung >"     DELIMITED BY SIZE,
                LINK-CMD                DELIMITED BY SPACE,
                " "                     DELIMITED BY SIZE,
                LINK-SRC-FILE           DELIMITED BY SPACE,
                "< OK <<< "             DELIMITED BY SIZE
        INTO ZEILE
        DISPLAY ZEILE
     END-IF
     
     .
 B090-99.
     EXIT.

******************************************************************
* Verarbeitung
******************************************************************
 B100-VERARBEITUNG SECTION.
 B100-00.
      
     IF STUP-DEC-VALID  
        CONTINUE
     ELSE
        DISPLAY " >> Ungueltiges Kommando: " STUP-DEC-CMD " <<"
        DISPLAY " !ABBRUCH! "
        SET PRG-ABBRUCH TO TRUE
        EXIT SECTION
     END-IF
  
     EVALUATE TRUE

        WHEN STUP-DEC-PRG           PERFORM C100-PRG
        WHEN STUP-DEC-MOD           PERFORM C200-MOD
        WHEN STUP-DEC-SQL           PERFORM C300-SQL
        WHEN STUP-DEC-PRT2FL        PERFORM C400-PRT2Fl
*       Obsolet wg. Prüfung
*       WHEN OTHER                  EXIT SECTION

     END-EVALUATE
     
     .
 B100-99.
     EXIT.
******************************************************************
* Verarbeitung PRG - Sprachcompiler + SQCompiler
******************************************************************
 C100-PRG SECTION.
 C100-00.
*----------------------------------------------------------------*
*                    Aufruf Sprach-Compiler                      *
*----------------------------------------------------------------*
**  --> Zusammenbauen der Schnittstelle
     MOVE    ZERO               TO LINK-RC
     MOVE    STUP-DEC-COMPILER  TO LINK-CMD
     MOVE    STUP-DEC-SRCFILE   TO LINK-SRC-FILE
     ENTER   TAL "String^Laenge"   USING LINK-SRC-FILE, 36
                                   GIVING LINK-SRC-FILE-LEN     
     MOVE    STUP-DEC-OBJFILE   TO LINK-OBJ-FILE
     ENTER   TAL "String^Laenge"   USING LINK-OBJ-FILE, 36
                                   GIVING LINK-OBJ-FILE-LEN
         
     
**  --> Aufrufen SSFCMP0
     CALL "SSFCMP0M"     USING LINK-REC
     EVALUATE LINK-RC
     
        WHEN   ZERO   CONTINUE
        
        WHEN   1      DISPLAY ">>!! es erfolgt KEINE SQL-Compilierung !!"
                      EXIT SECTION
        
        WHEN   2      DISPLAY ">>!! es erfolgt KEINE SQL-Compilierung !!"
                      EXIT SECTION
                
        WHEN   9999   DISPLAY " RC 9999 = PRG-ABBRUCH aus SSFCMP0 "
                      SET PRG-ABBRUCH TO TRUE
                      
        WHEN   OTHER  MOVE LINK-RC TO D-NUM4
                      DISPLAY " unbekannter RC: ",
                                D-NUM4,
                              " aus SSFCMP0"
                      DISPLAY " (< ZERO = SQL-Fehler"
                      SET PRG-ABBRUCH TO TRUE
                      
      END-EVALUATE
      
*----------------------------------------------------------------*
*                    Aufruf SQL-Compiler                         *
*----------------------------------------------------------------*

**  --> Fuer den Fall, dass NOSQL gesetzt ist, hier nichts mehr tun
     IF STUP-DEC-NOSQL
        EXIT SECTION
     END-IF
     
**  --> Zusammenbauen der Schnittstelle
     MOVE    ZERO               TO LINK-RC
     MOVE    "SQL"              TO LINK-CMD
     MOVE    STUP-DEC-SRCFILE   TO LINK-SRC-FILE
     ENTER   TAL "String^Laenge"   USING LINK-SRC-FILE, 36
                                   GIVING LINK-SRC-FILE-LEN     
     MOVE    STUP-DEC-OBJFILE   TO LINK-OBJ-FILE
     ENTER   TAL "String^Laenge"   USING LINK-OBJ-FILE, 36
                                   GIVING LINK-OBJ-FILE-LEN
             
**  --> Aufrufen SSFCMP0
     CALL "SSFCMP0M"     USING LINK-REC
     EVALUATE LINK-RC
     
        WHEN   ZERO   CONTINUE
        
        WHEN   9999   DISPLAY " RC 9999 = PRG-ABBRUCH aus SSFCMP0 "
                      SET PRG-ABBRUCH TO TRUE
                      
        WHEN   OTHER  MOVE LINK-RC TO D-NUM4
                      DISPLAY " unbekannter RC: ",
                                D-NUM4,
                              " aus SSFCMP0"
                      DISPLAY " (< ZERO = SQL-Fehler"
                      SET PRG-ABBRUCH TO TRUE
                      
      END-EVALUATE
     .
 C100-99.
     EXIT.
     
******************************************************************
* Verarbeitung MOD - nur Sprachcompiler
******************************************************************
 C200-MOD SECTION.
 C200-00.
*----------------------------------------------------------------*
*                    Aufruf Sprach-Compiler                      *
*----------------------------------------------------------------*
**  --> Zusammenbauen der Schnittstelle
     MOVE    ZERO               TO LINK-RC
     MOVE    STUP-DEC-COMPILER  TO LINK-CMD
     MOVE    STUP-DEC-SRCFILE   TO LINK-SRC-FILE
     ENTER   TAL "String^Laenge"   USING LINK-SRC-FILE, 36
                                   GIVING LINK-SRC-FILE-LEN     
     MOVE    STUP-DEC-OBJFILE   TO LINK-OBJ-FILE
     ENTER   TAL "String^Laenge"   USING LINK-OBJ-FILE, 36
                                   GIVING LINK-OBJ-FILE-LEN
         
     
**  --> Aufrufen SSFCMP0
     CALL "SSFCMP0M"     USING LINK-REC
     EVALUATE LINK-RC
     
        WHEN   ZERO   CONTINUE
        
        WHEN   9999   DISPLAY " RC 9999 = PRG-ABBRUCH aus SSFCMP0 "
                      SET PRG-ABBRUCH TO TRUE
                      
        WHEN   OTHER  MOVE LINK-RC TO D-NUM4
                      DISPLAY " unbekannter RC: ",
                                D-NUM4,
                              " aus SSFCMP0"
                      DISPLAY " (< ZERO = SQL-Fehler"
                      SET PRG-ABBRUCH TO TRUE
                      
      END-EVALUATE      
     .
 C200-99.
     EXIT.
   
******************************************************************
* Verarbeitung SQL - nur Sprachcompiler
******************************************************************
 C300-SQL SECTION.
 C300-00.
*----------------------------------------------------------------*
*                    Aufruf SQL-Compiler                         *
*----------------------------------------------------------------*
**  --> Zusammenbauen der Schnittstelle
     MOVE    ZERO               TO LINK-RC
     MOVE    "SQL"              TO LINK-CMD
     MOVE    STUP-DEC-SRCFILE   TO LINK-SRC-FILE
     ENTER   TAL "String^Laenge"   USING LINK-SRC-FILE, 36
                                   GIVING LINK-SRC-FILE-LEN     
     MOVE    STUP-DEC-OBJFILE   TO LINK-OBJ-FILE
     ENTER   TAL "String^Laenge"   USING LINK-OBJ-FILE, 36
                                   GIVING LINK-OBJ-FILE-LEN
             
**  --> Aufrufen SSFCMP0
     CALL "SSFCMP0M"     USING LINK-REC
     EVALUATE LINK-RC
     
        WHEN   ZERO   CONTINUE
        
        WHEN   9999   DISPLAY " RC 9999 = PRG-ABBRUCH aus SSFCMP0 "
                      SET PRG-ABBRUCH TO TRUE
                      
        WHEN   OTHER  MOVE LINK-RC TO D-NUM4
                      DISPLAY " unbekannter RC: ",
                                D-NUM4,
                              " aus SSFCMP0"
                      DISPLAY " (< ZERO = SQL-Fehler"
                      SET PRG-ABBRUCH TO TRUE
                      
      END-EVALUATE
     .
 C300-99.
     EXIT.
   
******************************************************************
* Verarbeitung PRT2FL - Ausgabe aktuelle Compile-Liste als EDIT
******************************************************************
 C400-PRT2FL SECTION.
 C400-00.            
*----------------------------------------------------------------*
*                    Aufruf PERUSE-Ausgabe                       *
*----------------------------------------------------------------*
**  --> Zusammenbauen der Schnittstelle
     MOVE    ZERO               TO LINK-RC
     MOVE    "PRT2FL"           TO LINK-CMD
     MOVE    STUP-DEC-SRCFILE   TO LINK-SRC-FILE
     ENTER   TAL "String^Laenge"   USING LINK-SRC-FILE, 36
                                   GIVING LINK-SRC-FILE-LEN     
     MOVE    SPACES             TO LINK-OBJ-FILE
     MOVE    ZERO               TO LINK-OBJ-FILE-LEN
             
**  --> Aufrufen SSFCMP0
     CALL "SSFCMP0M"     USING LINK-REC
     EVALUATE LINK-RC
     
        WHEN   ZERO   CONTINUE
        
        WHEN   9999   DISPLAY " RC 9999 = PRG-ABBRUCH aus SSFCMP0 "
                      SET PRG-ABBRUCH TO TRUE
                      
        WHEN   OTHER  MOVE LINK-RC TO D-NUM4
                      DISPLAY " unbekannter RC: ",
                                D-NUM4,
                              " aus SSFCMP0"
                      DISPLAY " (< ZERO = SQL-Fehler"
                      SET PRG-ABBRUCH TO TRUE
                      
      END-EVALUATE

     .
 C400-99.
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
                     INTO     STUP-DEC-CMD,
                              STUP-DEC-COMPILER,
                              STUP-DEC-SRCFILE,
                              STUP-DEC-OBJFILE,
                              STUP-DEC-SQLFLAG

     END-EVALUATE
     
**---> Entfernen Compiler-Indikator "-" bzw. Ergaenzen
*      optionalen Compiler "COB"     
     IF STUP-DEC-COMPILER(1:1) = "-"
        MOVE STUP-DEC-COMPILER(2:) TO STUP-DEC-COMPILER(1:)
     ELSE
        MOVE STUP-DEC-OBJFILE    TO STUP-DEC-SQLFLAG
        MOVE STUP-DEC-SRCFILE    TO STUP-DEC-OBJFILE
        MOVE STUP-DEC-COMPILER   TO STUP-DEC-SRCFILE
        MOVE "COB"               TO STUP-DEC-COMPILER
     END-IF
 
**---> Pruefen Kommando
     IF STUP-DEC-VALID
        CONTINUE
     ELSE
        DISPLAY " "
        DISPLAY " UNGUELTIGES KOMMANDO: ", STUP-DEC-CMD
        DISPLAY " >>> ABBRUCH <<<"
        DISPLAY " "
        SET PRG-ABBRUCH TO TRUE
     END-IF
     .
 P100-99.
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

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

 PROGRAM-ID. SQLDRV0E.

 DATE-COMPILED.


*****************************************************************
* Letzte Aenderung :: 2018-03-26
* Letzte Version   :: A.00.00
* Kurzbeschreibung :: ??? ProgGen ??
*
* Aenderungen (Version und Datum in Variable K-PROG-START aendern)
*              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*----------------------------------------------------------------*
* Vers. | Datum    | von | Kommentar                             *
*-------|----------|-----|---------------------------------------*
*A.01.|2011  |  |
*       |          |     |
*-------|----------|-----|---------------------------------------*
*A.00.00|2018-03-26| kl  | Neuerstellung
*----------------------------------------------------------------*
*
* Programmbeschreibung
* --------------------
*
* Driver fuer Dyn. SQL fuer neue Sourceverwaltung.
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
     05      K-MODUL             PIC X(08)          VALUE "SQLDRV0O".

*-->  SQLO-Tokens fuer dynamisches SQL
     COPY    DYN-SQL-TOK OF "=SSFLIBTM".
     
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

     05      SSFRARCH-FLAG           PIC 9     VALUE ZERO.
          88 SSFRARCH-OK                       VALUE ZERO.
          88 SSFRARCH-NOK                      VALUE 1.
          
     05      BRANCH-FLAG           PIC 9     VALUE ZERO.
          88 BRANCH-OK                       VALUE ZERO.
          88 BRANCH-NOK                      VALUE 1.
          
     05      OPT-FLAG                PIC X     VALUE SPACE.
          88 OPT-CURRENT                       VALUE SPACE.
          88 OPT-VERSION                       VALUE "V".
          88 OPT-DATE                          VALUE "D".
          88 OPT-AUFTRAG                       VALUE "A".
          88 OPT-BRANCH                        VALUE "B".

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
     05      STUP-MOD-CMD        PIC X(02)  VALUE SPACES.
     05      STUP-MOD-FILE       PIC X(08)  VALUE SPACES.
     05      STUP-MOD-OPT        PIC X(02)  VALUE SPACES.
     05      STUP-MOD-OPTVAL     PIC X(25)  VALUE SPACES.
     
*            GET PFCSIP7E
*            GET PFCSIP7E -V G.01.04
*            GET PFCSIP7E -D 2018-03-20
*            GET PFCSIP7E -A R7-296

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
     05      H-VERSION           PIC X(08).
     05      H-VERSION-ALT       PIC X(08).
     05      H-AUFTRAG           PIC X(25).
     05      H-SOURCE-DATE       PIC X(10).
     05      H-ZPINS-MAX         PIC X(22).
     05      H-ZPI               PIC S9(04) COMP.
     05      H-SOURCE-MODUL      PIC X(08).
     05      H-ARCHIV-MODUL      PIC X(36).

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

**  ---> Cursor auf Tabelle FCPARAM
 EXEC SQL
     DECLARE BRANCH_CURS CURSOR FOR
         SELECT   SOURCE_MODUL, VERSION, FILE_TYPE, SOURCE_DATE
                , ARCHIV_MODUL, AUFTRAG, GROUP_USER, PROD_STATE
                , ZPINS, COUT_FLAG
          FROM    =SSFRARCH
          WHERE   SOURCE_MODUL = :H-SOURCE-MODUL
          AND     VERSION      > :H-VERSION     
        FOR BROWSE ACCESS
 END-EXEC
 
******************************************************************
* Ende der SQL - Definitionen
******************************************************************

*-->    Fuer Uebergabe Kommandos etc. an SSFPHD1
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

     PERFORM P100-GETSTARTUPTEXT
     IF PRG-ABBRUCH 
        EXIT SECTION
     END-IF
     
**  ---> Kommandostruktur feststellen
*       Mit Option? Auswerten und Hostvariable besetzen
    IF  STUP-MOD-OPT(1:1) = "-"
        MOVE STUP-MOD-OPT(2:1)   TO OPT-FLAG
        EVALUATE TRUE
        
            WHEN OPT-VERSION   MOVE STUP-MOD-OPTVAL      TO H-VERSION
            WHEN OPT-DATE      MOVE STUP-MOD-OPTVAL      TO H-SOURCE-DATE
            WHEN OPT-AUFTRAG   MOVE ALL "%"              TO H-AUFTRAG
                               STRING PZ                 DELIMITED BY SIZE,
                                      STUP-MOD-OPTVAL    DELIMITED BY SPACE,
                                      PZ                 DELIMITED BY SIZE
                                INTO H-AUFTRAG
            WHEN OPT-BRANCH    MOVE STUP-MOD-OPTVAL      TO H-VERSION
            WHEN OTHER         SET  OPT-CURRENT TO TRUE
            
        END-EVALUATE
    ELSE
        SET OPT-CURRENT TO TRUE
    END-IF
    
*       Und noch das Source-Modul ...
    MOVE STUP-MOD-FILE   TO H-SOURCE-MODUL
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
 
     EVALUATE TRUE

       WHEN OPT-CURRENT     PERFORM C110-CURRENT
       WHEN OPT-VERSION     PERFORM C120-VERSION
       WHEN OPT-DATE        PERFORM C130-DATE
       WHEN OPT-AUFTRAG     PERFORM C140-AUFTRAG
       WHEN OPT-BRANCH      PERFORM C200-MAKE-BRANCH
*      WHEN OTHER           -- Gibt's hier nicht mehr

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
* Holen Source: Aktuelles File (MAX(ZPINS))
******************************************************************
 C110-CURRENT SECTION.
 C110-00.
      
    PERFORM S110-SELECT-SSFRARCH-CURRENT
    IF PRG-ABBRUCH
       EXIT SECTION
    END-IF
    
    IF SSFRARCH-OK
       DISPLAY "Archiv-Modul = " ARCHIV-MODUL OF SSFRARCH
    END-IF
    
    .
 C110-99.
    EXIT.

******************************************************************
* Holen Source: Angeforderte Version
******************************************************************
 C120-VERSION SECTION.
 C120-00.
 
    PERFORM S120-SELECT-SSFRARCH-VERSION
    IF PRG-ABBRUCH
       EXIT SECTION
    END-IF
    
    IF SSFRARCH-OK
       DISPLAY "Archiv-Modul = " ARCHIV-MODUL OF SSFRARCH
    END-IF
     
    .
 C120-99.
    EXIT.
    
******************************************************************
* Holen Source: Angefordertes Source-Date (LETZTE AENDERUNG::)
******************************************************************
 C130-DATE SECTION.
 C130-00.
     
    PERFORM S130-SELECT-SSFRARCH-DATE
    IF PRG-ABBRUCH
       EXIT SECTION
    END-IF
    
    IF SSFRARCH-OK
       DISPLAY "Archiv-Modul = " ARCHIV-MODUL OF SSFRARCH
    END-IF   
         
    .
 C130-99.
    EXIT.
    
******************************************************************
* Holen Source: Angefordertes Ticket (AUFTAG::)
******************************************************************
 C140-AUFTRAG SECTION.
 C140-00.
     
    PERFORM S140-SELECT-SSFRARCH-AUFTRAG
    IF PRG-ABBRUCH
       EXIT SECTION
    END-IF
    
    IF SSFRARCH-OK
       DISPLAY "Archiv-Modul = " ARCHIV-MODUL OF SSFRARCH
    END-IF
     
    .
 C140-99.
    EXIT.
******************************************************************
* Öffnen neuen Entwicklungszweig
******************************************************************
 C200-MAKE-BRANCH SECTION.
 C200-00.

*--> Oeffnen Branch-Cursor 
     PERFORM   S200-OPEN-BRANCH-CURSOR
     IF PRG-ABBRUCH
        EXIT SECTION
     END-IF

*--> Transaktion oeffnen fuer alle Versionen
     PERFORM U100-BEGIN
     
*--> Erstes Lesen Branch-Cursor
     PERFORM   S210-FETCH-BRANCH-CURSOR
     
*---> Verarbeitungsschleife
     PERFORM UNTIL BRANCH-NOK
                OR PRG-ABBRUCH
             
*      Wenn Version bereits Branch ignorieren
       IF VERSION OF SSFRARCH(8:1) = SPACE
          CONTINUE
       ELSE
*         Wenn Tabelle.Version(8:1) < Uebergabe.Version(8:1)  
*         weiter wg. neuem Zweig
          IF VERSION OF SSFRARCH(8:1) < STUP-MOD-OPTVAL(8:1)
             CONTINUE
          ELSE
*         Vorhandener Zweig: Alles bleibt wie es ist       
             PERFORM S210-FETCH-BRANCH-CURSOR
             EXIT PERFORM CYCLE
          END-IF
       END-IF
       
*      Wenn Tabelle.Version(8:1) < Uebergabe.Version(8:1) weiter 
*      wg. neuem Zweig
       IF VERSION OF SSFRARCH(8:1) < STUP-MOD-OPTVAL(8:1)
       OR VERSION OF SSFRARCH(8:1) = STUP-MOD-OPTVAL(8:1)
          CONTINUE
       ELSE
*      Vorhandener Zweig: Alles bleibt wie es ist       
          PERFORM S210-FETCH-BRANCH-CURSOR
          EXIT PERFORM CYCLE
       END-IF
                                
*      Insert mit neuer Version
       MOVE STUP-MOD-OPTVAL(8:1)    TO VERSION OF SSFRARCH(8:1)
       PERFORM S220-INSERT-BRANCH
       IF PRG-ABBRUCH
          EXIT PERFORM
       END-IF
       
*      Gut gegangen, Loeschen alte Version
       PERFORM S230-DELETE-VERSION
       IF PRG-ABBRUCH
          EXIT PERFORM
       END-IF
       
*      Nachlesen des Cursors
       PERFORM S210-FETCH-BRANCH-CURSOR       
       
     END-PERFORM
     
*--> Transaktion fuer Alle beenden
     IF PRG-ABBRUCH
        DISPLAY " "
        DISPLAY " >>> Abbruch >>>"     
        DISPLAY " --- Kein Zweig erzeugt --"
        DISPLAY " "
        PERFORM U120-ROLLBACK
        PERFORM S999-SQLCI
     ELSE
        DISPLAY " "
        DISPLAY " --- Zweig erzeugt fuer ",
                H-SOURCE-MODUL,
                " ---"
        DISPLAY " "
        PERFORM U110-COMMIT
        PERFORM S999-SQLCI
     END-IF
     
*--> Cursor Schließen
     PERFORM S299-CLOSE-BRANCH-CURSOR
     
*    IF SSFRARCH-OK
*       DISPLAY "Archiv-Modul = " ARCHIV-MODUL OF SSFRARCH
*    END-IF
     
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
                     INTO     STUP-MOD-CMD,
                              STUP-MOD-FILE,
                              STUP-MOD-OPT,                             
                              STUP-MOD-OPTVAL

     END-EVALUATE
     .
 P100-99.
     EXIT.
     
******************************************************************
* Select auf Tabelle SSFRARCH - Letzter ZPINS
******************************************************************
 S110-SELECT-SSFRARCH-CURRENT SECTION.
 S110-00.
     EXEC SQL
         SELECT    MAX(ZPINS)
           INTO   :H-ZPINS-MAX INDICATOR :H-ZPI
                     TYPE AS DATETIME YEAR TO FRACTION(2)
           FROM  =SSFRARCH
         WHERE SOURCE_MODUL, FILE_TYPE = 
               :H-SOURCE-MODUL
               ,"SRC"
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSFRARCH-OK  TO TRUE
         WHEN 100        SET SSFRARCH-NOK TO TRUE
         WHEN OTHER      SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     
     IF H-ZPI < ZERO
        STRING  " >>> "                     DELIMITED BY SIZE,
                H-SOURCE-MODUL              DELIMITED BY SPACE,
                " <<< nicht im Repository"  DELIMITED BY SIZE
        INTO ZEILE
        DISPLAY ZEILE
        SET PRG-ABBRUCH TO TRUE
        EXIT SECTION
     END-IF
     
     EXEC SQL
        SELECT ARCHIV_MODUL
        INTO   :ARCHIV-MODUL    OF SSFRARCH
        FROM  =SSFRARCH        
        WHERE  SOURCE_MODUL, ZPINS =
              :H-SOURCE-MODUL
             ,:H-ZPINS-MAX
                 TYPE AS DATETIME YEAR TO FRACTION(2)
        BROWSE ACCESS
     END-EXEC
     
     .
 S110-99.
     EXIT.

******************************************************************
* Select auf Tabelle SSFRARCH.archiv_modul: VERSION
******************************************************************
 S120-SELECT-SSFRARCH-VERSION SECTION.
 S120-00.
     
     EXEC SQL
        SELECT ARCHIV_MODUL
        INTO   :ARCHIV-MODUL    OF SSFRARCH
        FROM  =SSFRARCH        
        WHERE  SOURCE_MODUL, VERSION, FILE_TYPE =
              :H-SOURCE-MODUL
             ,:H-VERSION
             ,"SRC"
        BROWSE ACCESS
     END-EXEC

     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET SSFRARCH-OK TO TRUE
         WHEN 100    STRING
                     " >>> "                     DELIMITED BY SIZE
                     H-SOURCE-MODUL              DELIMITED BY SPACE,
                     " / "                       DELIMITED BY SIZE,
                     H-VERSION                   DELIMITED BY SPACE,
                     " <<< nicht im Repository"  DELIMITED BY SIZE
                     INTO ZEILE
                     DISPLAY ZEILE
                     DISPLAY " "
                     PERFORM S999-SQLCI
                     DISPLAY " "
                     SET PRG-ABBRUCH TO TRUE

         WHEN OTHER  MOVE SQLCODE OF SQLCA TO D-NUM4
                     DISPLAY "!!! Fehler bei Select =SSFRARCH ("
                             D-NUM4 ") !!!"       
                     SET PRG-ABBRUCH, SSFRARCH-NOK TO TRUE
     END-EVALUATE

    .
 S120-99.
    EXIT SECTION.
    
******************************************************************
* Select auf Tabelle SSFRARCH.archiv_modul: SOURCE_DATE
******************************************************************
 S130-SELECT-SSFRARCH-DATE SECTION.
 S130-00.
     
     EXEC SQL
         SELECT    MAX(ZPINS)
           INTO   :H-ZPINS-MAX INDICATOR :H-ZPI
                     TYPE AS DATETIME YEAR TO FRACTION(2)
           FROM  =SSFRARCH
        WHERE  SOURCE_MODUL, SOURCE_DATE, FILE_TYPE =
              :H-SOURCE-MODUL
             ,:H-SOURCE-DATE
               TYPE AS DATETIME YEAR TO DAY
             , "SRC"
        BROWSE ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSFRARCH-OK  TO TRUE
         WHEN 100        SET SSFRARCH-NOK TO TRUE
         WHEN OTHER      SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     
     IF H-ZPI < ZERO
        STRING  " >>> "                     DELIMITED BY SIZE,
                H-SOURCE-MODUL              DELIMITED BY SPACE,
                " v. "                      DELIMITED BY SIZE,
                H-SOURCE-DATE               DELIMITED BY SIZE,
                " <<< nicht im Repository"  DELIMITED BY SIZE
        INTO ZEILE
        DISPLAY ZEILE
        DISPLAY " "
        PERFORM S999-SQLCI
        DISPLAY " "        
        SET PRG-ABBRUCH TO TRUE
        EXIT SECTION
     END-IF
     
     EXEC SQL
        SELECT ARCHIV_MODUL
        INTO   :ARCHIV-MODUL    OF SSFRARCH
        FROM  =SSFRARCH        
        WHERE  SOURCE_MODUL, ZPINS =
              :H-SOURCE-MODUL
             ,:H-ZPINS-MAX
                 TYPE AS DATETIME YEAR TO FRACTION(2)
        BROWSE ACCESS
     END-EXEC
     
    .
 S130-99.
    EXIT SECTION.
    
******************************************************************
* Select auf Tabelle SSFRARCH.archiv_modul: AUFTRAG
******************************************************************
 S140-SELECT-SSFRARCH-AUFTRAG SECTION.
 S140-00.
     
     EXEC SQL
         SELECT    MAX(ZPINS)
           INTO   :H-ZPINS-MAX INDICATOR :H-ZPI
                     TYPE AS DATETIME YEAR TO FRACTION(2)
           FROM  =SSFRARCH
          WHERE  SOURCE_MODUL, FILE_TYPE = 
                 :H-SOURCE-MODUL 
                , "SRC"
                  AND AUFTRAG LIKE   :H-AUFTRAG
        BROWSE ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSFRARCH-OK  TO TRUE
         WHEN 100        SET SSFRARCH-NOK TO TRUE
         WHEN OTHER      SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     
     IF H-ZPI < ZERO
        STRING  " >>> "                     DELIMITED BY SIZE,
                H-SOURCE-MODUL              DELIMITED BY SPACE,
                " / "                       DELIMITED BY SIZE,
                STUP-MOD-OPTVAL             DELIMITED BY SPACE,
                " <<< nicht im Repository"  DELIMITED BY SIZE
        INTO ZEILE
        DISPLAY ZEILE
*        DISPLAY " >>> ABBRUCH <<< "
*        DISPLAY " "
        DISPLAY " "
        PERFORM S999-SQLCI
        DISPLAY " "        
        SET PRG-ABBRUCH TO TRUE
        EXIT SECTION
     END-IF
     
     EXEC SQL
        SELECT ARCHIV_MODUL
        INTO   :ARCHIV-MODUL    OF SSFRARCH
        FROM  =SSFRARCH        
        WHERE  SOURCE_MODUL, ZPINS =
              :H-SOURCE-MODUL
             ,:H-ZPINS-MAX
                 TYPE AS DATETIME YEAR TO FRACTION(2)
        BROWSE ACCESS
     END-EXEC                
    .
 S140-99.
    EXIT SECTION.
    
******************************************************************
* OPEN Cursor
******************************************************************
 S200-OPEN-BRANCH-CURSOR SECTION.
 S200-00.
     MOVE ZERO TO C9-COUNT
     EXEC SQL
         OPEN BRANCH_CURS
     END-EXEC
     .
 S200-99.
     EXIT.

******************************************************************
* Fetch aus Tabelle SSFRARCH
******************************************************************
 S210-FETCH-BRANCH-CURSOR SECTION.
 S210-00.
     EXEC SQL
         FETCH BRANCH_CURS
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
               ,:COUT-FLAG of SSFRARCH
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN 0      SET BRANCH-OK  TO TRUE
                     ADD 1 TO C9-COUNT
*                    Sichern Altversion (fuer Delete Alt)
                     MOVE   VERSION OF SSFRARCH    TO H-VERSION-ALT
                     
         WHEN OTHER  SET BRANCH-NOK TO TRUE
                     IF SQLCODE OF SQLCA = 100
                        CONTINUE
                     ELSE
                        SET PRG-ABBRUCH TO TRUE
                     END-IF
     END-EVALUATE
     .
 S210-99.
     EXIT.
     
******************************************************************
* Insert auf Tabelle SSFRARCH - Branch-Version für neuen Zweig
******************************************************************
 S220-INSERT-BRANCH SECTION.
 S220-00.
     EXEC SQL
         INSERT
           INTO  =SSFRARCH
                 ( SOURCE_MODUL, VERSION, FILE_TYPE, SOURCE_DATE
                 , ARCHIV_MODUL, AUFTRAG, GROUP_USER, PROD_STATE
                 , ZPINS, COUT_FLAG
                 )
         VALUES  (
                  :SOURCE-MODUL of SSFRARCH
                 ,:VERSION      OF SSFRARCH
                 ,:FILE-TYPE of SSFRARCH
                 ,:SOURCE-DATE of SSFRARCH
                     TYPE AS DATETIME YEAR TO DAY
                 ,:ARCHIV-MODUL of SSFRARCH
                 ,:AUFTRAG of SSFRARCH
                 ,:GROUP-USER of SSFRARCH
                 ,:PROD-STATE of SSFRARCH
                 ,:ZPINS of SSFRARCH
                     TYPE AS DATETIME YEAR TO FRACTION(2)
                 ,:COUT-FLAG of SSFRARCH
                 )
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO   SET BRANCH-OK  TO TRUE
         WHEN OTHER  SET BRANCH-NOK TO TRUE
                     SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S220-99.
     EXIT.
     
******************************************************************
* Löschen SSFRARCH - Alte Standardversion
******************************************************************
 S230-DELETE-VERSION SECTION.
 S230-00.
     EXEC SQL
         DELETE
           FROM  =SSFRARCH
         WHERE   SOURCE_MODUL, VERSION =
                :H-SOURCE-MODUL
               ,:H-VERSION-ALT
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET BRANCH-OK  TO TRUE
         WHEN OTHER      SET BRANCH-NOK TO TRUE
                         SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S230-99.
     EXIT.
     
******************************************************************
* CLOSE Cursor
******************************************************************
 S299-CLOSE-BRANCH-CURSOR SECTION.
 S299-00.
     EXEC SQL
         CLOSE BRANCH_CURS
     END-EXEC
     .
 S299-99.
     EXIT.
     
******************************************************************
* Anzeige ueber SQLCI
******************************************************************
 S999-SQLCI SECTION.
 S999-00.
 
**--> Aufbereiten Parmeter
    STRING    ";"                                DELIMITED BY SIZE,
              "SELECT "                          DELIMITED BY SIZE,
              "SOURCE_MODUL, "                   DELIMITED BY SIZE,
              "VERSION, "                        DELIMITED BY SIZE,
              "SOURCE_DATE, "                    DELIMITED BY SIZE,
              "AUFTRAG "                         DELIMITED BY SIZE,
              " FROM =SSFRARCH "                 DELIMITED BY SIZE,
              "WHERE SOURCE_MODUL = "            DELIMITED BY SIZE,
              HK                                 DELIMITED BY SIZE,
              STUP-MOD-FILE                      DELIMITED BY SPACE,
              HK                                 DELIMITED BY SIZE,
              " BROWSE ACCESS; EXIT;"            DELIMITED BY SIZE
     INTO PHD-PRG-STU
     
     MOVE "SQLCI"   TO PHD-PRG-NAME    
     MOVE 1024      TO PHD-ID-LEN

*    INTERNE Schnittstelle basteln
     INITIALIZE INTERN-MESSAGE
     MOVE   PHD-INVOKE-DATA             TO PHD-NDATEN
     MOVE   1024                        TO PHD-SENDLEN,
                                           PHD-DATLEN
     MOVE   K-MODUL                     TO PHD-MONNAME
     MOVE   "SSFPHD1M"                  TO PHD-NEXTSERV
     
     CALL   "SSFPHD1M"   USING INTERN-MESSAGE
    .
 S999-00.
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

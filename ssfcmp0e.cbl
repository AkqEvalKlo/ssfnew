?CONSULT  $SYSTEM.SYSTEM.COBOLEX0
?SEARCH   $SYSTEM.SYSTEM.COBOLLIB
?CONSULT  =TALLIB
?CONSULT  =ASC2EBC
?CONSULT  =EBC2ASC
?CONSULT  =WSYS022
?CONSULT  =WSYS960

*-->    Module vom neuen Source-Safe
?CONSULT =SSFPHD1
?CONSULT =SSFEIN0

?NOLMAP, SYMBOLS, INSPECT
?SAVE ALL
?SAVEABEND
?LINES 66
?CHECK 3
?SQL

 IDENTIFICATION DIVISION.

 PROGRAM-ID. SSFCMP0M.

 DATE-COMPILED.


*****************************************************************
* Letzte Aenderung :: 2018-04-24
* Letzte Version   :: G.00.00
* Kurzbeschreibung :: Kapselt alle Compileraufrufe ueber 
* Kurzbeschreibung :: Prozess-Handler SSFPHD1
* Package          :: TOOL
* Auftrag          :: SSFNEW-1
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

 SELECT LOCKF      ASSIGN TO #DYNAMIC.

 DATA DIVISION.
 FILE SECTION.

 FD  LOCKF
     RECORD  IS VARYING IN SIZE
             FROM 0 TO 80 CHARACTERS
             DEPENDING ON REC-LEN.
 01  LOCK-RECORD              PIC X(80).

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
     05      K-MODUL             PIC X(08)          VALUE "SSFCMP0M".
     05      K-CR                PIC X              VALUE x"0D".
     05      K-LF                PIC X              VALUE x"0A".
     
     05      K-COBOL85           PIC X(08)          VALUE "COBOL85 ".
     05      K-C                 PIC X(08)          VALUE "C       ".
     05      K-TAL               PIC X(08)          VALUE "TAL     ".
     05      K-SQLCOMP           PIC X(08)          VALUE "SQLCOMP ".
     
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

     05      SSFRFDEF-FLAG           PIC 9     VALUE ZERO.
          88 SSFRFDEF-OK                       VALUE ZERO.
          88 SSFRFDEF-NOK                      VALUE 1.

*            Sperrstatus Repository 
     05      REP-LOCK-STATE          PIC 9     VALUE ZERO.
          88 REP-UNLOCKED                      VALUE ZERO.
          88 REP-NEW                           VALUE 1.
          88 REP-LOCKED                        VALUE 2.
          88 REP-INCONSISTENT                  VALUE 9.
          
*            Funktionsschalter
     05      FKT-FLAG                PIC X(15) VALUE SPACES.
          88 FKT-NO-FKT                        VALUE SPACES.
          88 FKT-COBOL                         VALUE "COB            ".
          88 FKT-C                             VALUE "C              ".
          88 FKT-TAL                           VALUE "TAL            ".
          88 FKT-SQL                           VALUE "SQL            ".           
          88 FKT-PRTCMP                        VALUE "PRTCMP         ".
          88 FKT-PRT2FL                        VALUE "PRT2FL         ".
          
     05      W-PRTCMP-FLG             PIC X    VALUE "N".
          88 W-PRT-NO                          VALUE "N" "n".
          88 W-PRT-YES                         VALUE " " "J" "j" "Y" "y".
          
 01          PERM-SCHALTER.
     05      INIT-STATUS         PIC 9       VALUE ZERO.
          88 INIT-NOK                        VALUE ZERO.
          88 INIT-OK                         VALUE 1.

*--------------------------------------------------------------------*
* weitere Arbeitsfelder
*--------------------------------------------------------------------*
 01          WORK-FELDER.
     05      W-DUMMY             PIC X(02).

 01          W-VERSION-BUFFER.     
     05      W-ARC-REL           PIC X      VALUE "G".
     05      W-ARC-H-VERSION     PIC X(02)  VALUE "00".            
     05      W-ARC-S-VERSION.
         10  W-ARC-SV-VERSION    PIC X(02)  VALUE "00".
         10  W-ARC-SV-BRANCH     PIC X      VALUE SPACE.
*                 Maximal 10 Zweige             
          88 IS-BRANCH                 VALUE "A" "B" "C" "D"
                                             "F" "G" "H" "I"
                                             "J" "K".
             
 01          W-ARC-FNAME         PIC X(08)  VALUE "G0000   ".
 
 01          W-SPOOL-LOC.
     05      W-LOC               PIC X(16).
     05      W-LOC-LEN           PIC S9(04) COMP.
     
 01          W-COMPILER          PIC X(08)   VALUE "COBOL85 ".

 
* Fuer Fehlerausgabe
 01          ZEILE               PIC X(80)  VALUE SPACES. 
                                                   
* Wer bin ich ...
 01          MY-VOLUME           PIC X(08)          VALUE "$WSOFT".
 01          MY-SUBVOL           PIC X(08)          VALUE "SSRCREPO".
 01          MY-UGRP             PIC 9(03)          VALUE 130.
 01          MY-UID              PIC 9(03)          VALUE 255.
 01          MY-UNAME            PIC X(32)          VALUE "WD.SUPER".
 01          MY-CURLEN           PIC S9(04) COMP    VALUE ZERO.
                                                   
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

     COPY    WSYS960C OF "=MSGLIB"
             REPLACING =="*"== BY ==TC==.

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

**          ---> für Define-Handling 
 01          P-DEFINE            PIC X(24).
 01          P-ATTRIBUT          PIC X(16).
 01          P-VALUE             PIC X(20).
 01          P-VALUELEN          PIC S9(04) comp.
 01          P-DEF-NAMES         PIC X(16).
 01          P-RESULT            PIC S9(04) COMP VALUE ZERO.

**          ---> Parameter fuer COBOLLIB: ASSIGN
 01          ASS-FNAME           PIC X(34).
 01          ASS-FNAME-LEN       PIC S9(04) COMP.
 01          ASS-FSTATUS         PIC S9(04) COMP.

**          ---> Fuer Dateihandling
 01          REPOSITORY.
*            R-File = Repository fuer [Source]E
        05   REP-VOL            PIC X(08).
        05   REP-SVOL           PIC X(08).
        05   REP-FILE           PIC X(08).
        
**          ---> Eigenschaften des Repositorys
 01          REPOSITORY-PROPERTIES.
**          ---> Security-String
        05   REP-SECURITY           PIC X(04).
**          ---> Last Modify     
        05   REP-MODI               PIC 9(16).
**          ---> User-ID / Owner     
        05   REP-OWNER-GROUP        PIC 9(03).
        05   REP-OWNER-NR           PIC 9(03).
**          ---> User-Name / Owner
        05   REP-OWNER-NAME         PIC X(32).
        05   REP-OWNER-CURLEN       PIC S9(04) COMP.
**          Filecode (101 - Edit / 100 = Object / 1001 =Zip)     
        05   REP-FCODE              PIC S9(04) COMP.
        05   REP-EXISTANCE          PIC 9             VALUE ZERO.
          88 REP-NO-EXIST                             VALUE ZERO.
          88 REP-EXIST                                VALUE 1.

 01          SRCFILE.
*            Source-File
        05   SRC-VOL            PIC X(08).
        05   SRC-SVOL           PIC X(08).
        05   SRC-FILE           PIC X(08).

 01          OBJFILE.
*            Object-File
        05   OBJ-VOL            PIC X(08).
        05   OBJ-SVOL           PIC X(08).
        05   OBJ-FILE           PIC X(08).

*            Zieldatenamen
 01          P-SRC-FILE          PIC X(36).
 01          P-OBJ-FILE          PIC X(36).
 01          P-TMP-FILE          PIC X(36).
 01          P-PRT-FILE          PIC X(36).
 01          P-PRT-TEMPL         PIC X(36).

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
     
*-->    Fuer Environment- und Fileinfos
 01     ENV-REC.
    05  ENV-HDR.
     10 ENV-CMD                PIC X(02).
*       "EI" = Environment Info
*       "FI" = Fileinfo
     10 ENV-RC                 PIC S9(04) COMP.
*       0    = OK
*       aus FILE_GETINFO...
*       10   = FILE Exists
*       11   = FILE doesn't exsist
*       12   = FILE in use
*       9999 = Programmabbruch - Hauptprogramm muss reagieren
    05  ENV-DATA.
*************************************************************
*                    FILE-Definition                        *
*************************************************************
*       Name des Repository-Files (z.b. PFCSIP7R)
     10 ENV-REP-FILE           PIC X(36).
     10 ENV-REP-FILE-LEN       PIC S9(04) COMP.
*************************************************************
*                 ENVIRONMENT-Informationen                 *
*************************************************************
**          ---> User-Name 
     10 ENV-USER-NAME          PIC X(32).
     10 ENV-USER-CURLEN        PIC S9(04) COMP.
**          ---> numerische Werte für Gruppe und User
     10 ENV-USER-GRP           PIC  9(03).
     10 ENV-USER-NR            PIC  9(03).
**          ---> Aktuelles Volume/Subvolume
     10 ENV-VOLUME             PIC X(08).
     10 ENV-SUBVOL             PIC X(08).
*************************************************************
*                    FILE-Informationen                     *
*************************************************************
**          ---> Security-String
     10 ENV-SECURITY           PIC X(04).
**          ---> Last Modify     
     10 ENV-MODI               PIC 9(16).
**          ---> User-ID / Owner     
     10 ENV-OWNER-GROUP        PIC 9(03).
     10 ENV-OWNER-NR           PIC 9(03).
**          ---> User-Name / Owner
     10 ENV-OWNER-NAME         PIC X(32).
     10 ENV-OWNER-CURLEN       PIC S9(04) COMP.
**          Filecode (101 - Edit / 100 = Object / 1001 =Zip)     
     10 ENV-FCODE              PIC S9(04) COMP.    
    
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

** --> Annotations-Werte fuer =SSFRARCH
     05      H-VERSION           PIC X(08).
     05      H-SOURCE-DATE       PIC X(10).
     05      H-AUFTRAG           PIC X(25).
** --> Archiv-File     
     05      H-ARCHIV-MODUL      PIC X(26). 

** --> Zaehler SSFRARCH
     05      H-ARC-COUNT         PIC S9(04) COMP. 

** --> Fuer Spoolsteuerung
     05      H-CSSPOOL           PIC X(06).
*            z.B. $WE   - Prozess von CSSPOOL fuer C100     
     05      H-SPOOL             PIC X(06).
*            z.B. $WELS - Prozess von SPOOL   fuer C200     
******************************************************************
* Im Folgenden mit dem INVOKE-Befehl die Tabellenstruktur-
* definitonen der benötigten Tabellen einfügen
******************************************************************
**  ---> Struktur der Tabelle SSFRMETA
 EXEC SQL
    INVOKE =SSFRMETA AS SSFRMETA
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
******************************************************************
* Ende der SQL - Definitionen
******************************************************************

 01     SRC-LINES-BUFFER IS EXTERNAL.
    05  SRC-LINE  OCCURS 750.
     10 SL-VAL               PIC X(128).
     10 SL-LEN               PIC S9(04).

*-->    Fuer Uebergabe Kommandos etc. an SSFPHD1
 01          INTERN-MESSAGE.
             COPY    INT-SCHNITTSTELLE-C OF  "=MSGLIB"
                     REPLACING =="*"== BY ==PHD==.

 LINKAGE SECTION.

*-->    Uebergabe aus Hauptprogramm
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

 PROCEDURE DIVISION USING LINK-REC.

******************************************************************
* Die folgenden WHENEVER-Anweisungen legen Fehlerbehandlungen fest
******************************************************************
*A000-WHENEVER SECTION.
*A000-00.
*    EXEC SQL
*        WHENEVER SQLERROR       PERFORM :Z001-SQLERROR
*    END-EXEC 
*
*    EXEC SQL
*        WHENEVER SQLWARNING     PERFORM :Z001-SQLERROR
*    END-EXEC
*    .
*A000-99.
*    EXIT.

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

**  ---> Holen des momentanen Environments
     PERFORM H000-MYENV
     .
 B000-99.
     EXIT.

******************************************************************
* Ende
******************************************************************
 B090-ENDE SECTION.
 B090-00.

     IF PRG-ABBRUCH
        MOVE 9999                TO LINK-RC
     ELSE
*       Zur Steuerung der weiteren Verarbeitung im Hauptprogramm     
        MOVE MSG-COMPLETION-CODE TO LINK-RC
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

        WHEN "COB"      SET FKT-COBOL      TO TRUE
                        MOVE K-COBOL85     TO W-COMPILER
                        
        WHEN "C"        SET FKT-C          TO TRUE
                        MOVE K-C           TO W-COMPILER
                        
        WHEN "TAL"      SET FKT-TAL        TO TRUE
                        MOVE K-TAL         TO W-COMPILER
                        
        WHEN "SQL"      SET FKT-SQL        TO TRUE
                        MOVE K-SQLCOMP     TO W-COMPILER
                        
        WHEN "PRTCMP"   SET FKT-PRTCMP     TO TRUE
        
        WHEN "PRT2FL"   SET FKT-PRT2FL     TO TRUE
        
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
     IF PRG-ABBRUCH
        EXIT SECTION
     END-IF

**--> Vorarbeiten OK, weiter mit eigentlicher Verarbeitung
     EVALUATE TRUE

        WHEN FKT-COBOL      PERFORM C100-COMPILE
        WHEN FKT-C          PERFORM C100-COMPILE
        WHEN FKT-TAL        PErFORM C100-COMPILE
        WHEN FKT-SQL        PERFORM C100-COMPILE
        WHEN FKT-PRTCMP     PERFORM C200-SPOOL
        WHEN FKT-PRT2FL     PERFORM C300-SPOOL-EDIT
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
* Aufruf Compiler
******************************************************************
 C100-COMPILE SECTION.
 C100-00.

      INITIALIZE SSFRFDEF
      SET W-PRT-NO TO TRUE
      
**--> Holen Kommando
      MOVE LINK-CALLER  TO ANWENDUNG    OF SSFRFDEF
      MOVE K-MODUL      TO MODUL        OF SSFRFDEF
      MOVE FKT-FLAG     TO FUNKTION     OF SSFRFDEF
      MOVE 1            TO LFDNR        OF SSFRFDEF
                           CI
**--> Kommandodefinition lesen
      PERFORM S010-SELECT-SSFRFDEF
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Kommando zerlegen und STARTUP fuer SSFPHD1 bauen
      PERFORM H200-CREATE-STUP
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Setzen Temporaeres Define fuer Spooler
      PERFORM H300-DEFINE
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF
      
**--> Aufruf Prozess-Handler      
      PERFORM M100-SSFPHD1M
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF
      
**--> Spoolerdefine wieder loeschen
     PERFORM H310-DELETEDEFINE
     
**--> Auswerten Completion-Code
**    --> Compile-Ergebnis anzeigen
      EVALUATE MSG-COMPLETION-CODE
          WHEN 0     DISPLAY ">> keine Fehler/Warnungen vom " W-COMPILER
                     EXIT SECTION
          WHEN 1     DISPLAY ">>!! Warnungen vom " W-COMPILER "!!"
          WHEN 2     DISPLAY ">>!! Fehler vom " W-COMPILER "!!"
          WHEN OTHER MOVE MSG-COMPLETION-CODE TO D-NUM4
                     DISPLAY ">>!! sonstige Fehler ("
                             D-NUM4
                             ") vom " W-COMPILER "!!"
      END-EVALUATE
      
**--> Abfrage Spool-Anzeige
      DISPLAY "Anzeige Compileliste       ( /J/N): " WITH NO ADVANCING 
      ACCEPT W-PRTCMP-FLG     
      IF W-PRT-YES
         SET FKT-PRTCMP TO TRUE
         PERFORM C200-SPOOL
         IF PRG-ABBRUCH
            EXIT SECTION
         END-IF
      END-IF
      
*--> Abfrage Spool-Ausgabe in Edit-Datei
      DISPLAY " "
      DISPLAY "Compileliste -> Edit-File  ( /N/J): " WITH NO ADVANCING
      ACCEPT W-PRTCMP-FLG
      IF W-PRT-YES
         SET FKT-PRT2FL TO TRUE
         PERFORM C300-SPOOL-EDIT
      END-IF
     .
 C100-99.
     EXIT.

******************************************************************
* Spooler-Anzeige
******************************************************************
 C200-SPOOL SECTION.
 C200-00.
     
      INITIALIZE SSFRFDEF
      
**--> Holen Kommando
      MOVE LINK-CALLER  TO ANWENDUNG    OF SSFRFDEF
      MOVE K-MODUL      TO MODUL        OF SSFRFDEF
      MOVE FKT-FLAG     TO FUNKTION     OF SSFRFDEF
      MOVE 1            TO LFDNR        OF SSFRFDEF
                           CI
**--> Kommandodefinition lesen
      PERFORM S010-SELECT-SSFRFDEF
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Kommando zerlegen und STARTUP fuer SSFPHD1 bauen
      PERFORM H200-CREATE-STUP
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Aufruf Prozess-Handler      
      PERFORM M100-SSFPHD1M
      
     .
 C200-99.
     EXIT.
******************************************************************
* Spooler-Ausgabe in Edit-Datei
******************************************************************
 C300-SPOOL-EDIT SECTION.
 C300-00.

*----------------------------------------------------------------*
*                   PERUSE: Ausgabe in Datei                     *
*----------------------------------------------------------------*
      INITIALIZE SSFRFDEF
      
**--> Holen Kommando
      MOVE LINK-CALLER  TO ANWENDUNG    OF SSFRFDEF
      MOVE K-MODUL      TO MODUL        OF SSFRFDEF
      MOVE FKT-FLAG     TO FUNKTION     OF SSFRFDEF
      MOVE 1            TO LFDNR        OF SSFRFDEF
                           CI
**--> Kommandodefinition lesen
      PERFORM S010-SELECT-SSFRFDEF
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Kommando zerlegen und STARTUP fuer SSFPHD1 bauen
      PERFORM H200-CREATE-STUP
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Aufruf Prozess-Handler
      PERFORM M100-SSFPHD1M
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF
*----------------------------------------------------------------*
*                   FUP: Druck-Template (101) nach PRTFLIE       *
*----------------------------------------------------------------*
      INITIALIZE SSFRFDEF
      
**--> Holen Kommando
      MOVE LINK-CALLER  TO ANWENDUNG    OF SSFRFDEF
      MOVE K-MODUL      TO MODUL        OF SSFRFDEF
      MOVE FKT-FLAG     TO FUNKTION     OF SSFRFDEF
      MOVE 2            TO LFDNR        OF SSFRFDEF
                           CI
**--> Kommandodefinition lesen
      PERFORM S010-SELECT-SSFRFDEF
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Kommando zerlegen und STARTUP fuer SSFPHD1 bauen
      PERFORM H200-CREATE-STUP
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Aufruf Prozess-Handler
      PERFORM M100-SSFPHD1M
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF
*----------------------------------------------------------------*
*                   FUP: Peruse-Ausgabe --> PRTFILE              *
*----------------------------------------------------------------*
      INITIALIZE SSFRFDEF
      
**--> Holen Kommando
      MOVE LINK-CALLER  TO ANWENDUNG    OF SSFRFDEF
      MOVE K-MODUL      TO MODUL        OF SSFRFDEF
      MOVE FKT-FLAG     TO FUNKTION     OF SSFRFDEF
      MOVE 3            TO LFDNR        OF SSFRFDEF
                           CI
**--> Kommandodefinition lesen
      PERFORM S010-SELECT-SSFRFDEF
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Kommando zerlegen und STARTUP fuer SSFPHD1 bauen
      PERFORM H200-CREATE-STUP
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF

**--> Aufruf Prozess-Handler
      PERFORM M100-SSFPHD1M      
      IF PRG-ABBRUCH
         EXIT SECTION
      END-IF      
*----------------------------------------------------------------*
*                   Loeschen Peruse-Ausgabe                      *
*----------------------------------------------------------------*

      ENTER TAL "WT^PURGE" USING    P-RESULT,
                                    P-PRT-FILE
                                    
      .
 C300-99.
     EXIT.  
     
******************************************************************
* Uebergabe-File umsetzen auf benoetigte Dateinamen
******************************************************************
 H000-MYENV SECTION.
 H000-00.

     MOVE "EI"              TO ENV-CMD
     MOVE ZERO              TO ENV-RC
     INITIALIZE ENV-DATA
     
**  --> Aufrufen SSFEIN0
     CALL "SSFEIN0M"     USING ENV-REC
     EVALUATE ENV-RC
     
        WHEN   ZERO   CONTINUE
        
        WHEN   100    DISPLAY " RC 100 aus SSFEIN0 "
        
        WHEN   9999   DISPLAY " RC 9999 = PRG-ABBRUCH aus SSFEIN0 "
                      SET PRG-ABBRUCH TO TRUE
                      
        WHEN   OTHER  MOVE ENV-RC TO D-NUM4
                      DISPLAY " unbekannter RC: ",
                                D-NUM4,
                              " aus SSFEIN0"
                      DISPLAY " (< ZERO = SQL-Fehler"
                      SET PRG-ABBRUCH TO TRUE
                      EXIT SECTION
                      
      END-EVALUATE

*--> Gefundenes Environment sichern      
      MOVE ENV-VOLUME       TO   MY-VOLUME
      MOVE ENV-SUBVOL       TO   MY-SUBVOL
      MOVE ENV-USER-NAME    TO   MY-UNAME
      MOVE ENV-USER-CURLEN  TO   MY-CURLEN
      MOVE ENV-USER-GRP     TO   MY-UGRP
      MOVE ENV-USER-NR      TO   MY-UID 
      
     .
 H000-99.
    EXIT.
******************************************************************
* Uebergabe-File umsetzen auf benoetigte Dateinamen
******************************************************************
 H100-FILENAMES SECTION.
 H100-00.

*P-SRC-FILE = SOURCE_FILE       aus LINK-REPFILE1
     UNSTRING LINK-SRC-FILE DELIMITED BY "."
     INTO    SRC-VOL
           , SRC-SVOL
           , SRC-FILE

     IF  SRC-SVOL = SPACE
     AND SRC-FILE = SPACE
*        PFCSIP7E
         MOVE     SRC-VOL        TO SRC-FILE
         MOVE     MY-VOLUME      TO SRC-VOL
         MOVE     MY-SUBVOL      TO SRC-SVOL
     ELSE
         IF SRC-FILE = SPACE
*           SSRCREPO.PFCSIP7E
            MOVE   SRC-VOL       TO SRC-SVOL
            MOVE   SRC-SVOL      TO SRC-FILE
            MOVE   MY-VOLUME      TO SRC-VOL
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

*    Vollen Dateiname bauen
     UNSTRING LINK-OBJ-FILE DELIMITED BY "."
     INTO    OBJ-VOL
           , OBJ-SVOL
           , OBJ-FILE

     IF  OBJ-SVOL = SPACE
     AND OBJ-FILE = SPACE
*        PFCSIP7E
         MOVE     OBJ-VOL        TO OBJ-FILE
         MOVE     MY-VOLUME      TO OBJ-VOL
         MOVE     MY-SUBVOL      TO OBJ-SVOL
     ELSE
         IF OBJ-FILE = SPACE
*           SSRCREPO.PFCSIP7E
            MOVE   OBJ-VOL       TO OBJ-SVOL
            MOVE   OBJ-SVOL      TO OBJ-FILE
            MOVE   MY-VOLUME     TO OBJ-VOL
         ELSE
*           $WSOFT.SSRCREPO.PFCSIP7E
            CONTINUE
         END-IF
     END-IF

     STRING OBJ-VOL      DELIMITED BY SPACE,
            "."          DELIMITED BY SIZE,
            OBJ-SVOL     DELIMITED BY SPACE,
            "."          DELIMITED BY SIZE,
            OBJ-FILE     DELIMITED BY SPACE
     INTO   P-OBJ-FILE

**-> P-TMP-FILE fuer Peruse
     MOVE P-SRC-FILE     TO P-TMP-FILE
     ENTER TAL "String^Laenge"   USING   P-TMP-FILE, 36
                                 GIVING  C4-I1
     MOVE  "T"   TO P-TMP-FILE(C4-I1:1)
     
**-> P-PRT-FILE fuer Peruse
     MOVE P-SRC-FILE     TO P-PRT-FILE
     ENTER TAL "String^Laenge"   USING   P-TMP-FILE, 36
                                 GIVING  C4-I1
     MOVE  "P"   TO P-PRT-FILE(C4-I1:1)
     
**--> Druck-Template fuer DUP
     STRING SRCA-VOLUME  OF SSFRMETA        DELIMITED BY SPACE,
            "."                             DELIMITED BY SIZE,
            SRCA-SUBVOL  OF SSFRMETA        DELIMITED BY SPACE,
            "."                             DELIMITED BY SIZE,
            "PRTOUT"                        DELIMITED BY SIZE
     INTO P-PRT-TEMPL   
     
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

*     Parameter durch Werte ersetzen
      MOVE    1   TO CI
      
      PERFORM VARYING CIP FROM 1 BY 1 UNTIL CIP     > 5
                                         OR STUP-DEC-PRM(CI, CIP) = SPACE

          EVALUATE STUP-DEC-PRM(CI, CIP)  

              WHEN "SRCFILE"  MOVE   P-SRC-FILE       TO STUP-DEC-PRM(CI, CIP)

              WHEN "OBJFILE"  MOVE   P-OBJ-FILE       TO STUP-DEC-PRM(CI, CIP) 
              
              WHEN "CSSPOOL"  MOVE   H-CSSPOOL        TO STUP-DEC-PRM(CI, CIP)
*                             Spool-Location
                              STRING H-CSSPOOL        DELIMITED BY SPACE,
                                     STUP-DEC-TXT(CI, CIP + 1)
                                                      DELIMITED BY "/"
                              INTO   W-LOC
                              ENTER TAL "String^Laenge" USING W-LOC, 16
                                                       GIVING W-LOC-LEN
*                             Parameter neu bauen (wg. Location) und
*                             Folgetext loeschen
                              MOVE   W-LOC            TO STUP-DEC-PRM(CI, CIP)
*                              MOVE   "=Mydefine/"      TO STUP-DEC-PRM(CI, CIP)
                              MOVE   "/"   TO STUP-DEC-PRM(CI, CIP)(W-LOC-LEN + 1:1)            
                              MOVE   SPACES           TO STUP-DEC-TXT(CI, CIP + 1)
                              
              WHEN "SPOOL"    MOVE   H-SPOOL          TO STUP-DEC-PRM(CI, CIP)

              WHEN "TMPFILE"  MOVE   P-TMP-FILE       TO STUP-DEC-PRM(CI, CIP)
              
              WHEN "PRTFILE"  MOVE   P-PRT-FILE       TO STUP-DEC-PRM(CI, CIP)
              
              WHEN "PRTTEMPL"  MOVE  P-PRT-TEMPL      TO STUP-DEC-PRM(CI, CIP)
              
              WHEN OTHER      MOVE    CI    TO D-NUM2
                              DISPLAY "  Unbekannter Parameter >",
                                      STUP-DEC-PRM(CI, CIP),
                                    "<"
                              DISPLAY "Fuer: ",
                                      PROG OF SSFRFDEF
                              DISPLAY "Funktion: ",
                                      FUNKTION OF SSFRFDEF

          END-EVALUATE
        
      END-PERFORM
      
*     Text und Paratemer Terminieren      
      PERFORM VARYING C4-I1 FROM 1 BY 1
                            UNTIL C4-I1 > 5
                            
        ENTER TAL "String^Laenge" USING STUP-DEC-TXT(CI, C4-I1), 39
                                  GIVING C4-I2
        IF C4-I2 > ZERO
           MOVE "\0"        TO STUP-DEC-TXT(CI, C4-I1)(C4-I2 + 1:2)
        ELSE
           MOVE "\0"        TO STUP-DEC-TXT(CI, C4-I1)
        END-IF
        
        ENTER TAL "String^Laenge" USING STUP-DEC-PRM(CI, C4-I1), 39
                                  GIVING C4-I2
        IF C4-I2 > ZERO
           MOVE "\0"        TO STUP-DEC-PRM(CI, C4-I1)(C4-I2 + 1:2)
        ELSE
           MOVE "\0"        TO STUP-DEC-PRM(CI, C4-I1)
        END-IF     
        
      END-PERFORM
              
*     Bauen konkreten STARTUP-String
      MOVE ALL SPACES TO AKT-STARTUP-TEXT
      STRING    STUP-DEC-TXT(CI, 1)         DELIMITED BY "\0",
                " "                         DELIMITED BY SIZE,
                STUP-DEC-PRM(CI, 1)         DELIMITED BY "\0",
                " "                         DELIMITED BY SIZE,
                STUP-DEC-TXT(CI, 2)         DELIMITED BY "\0",
                " "                         DELIMITED BY SIZE,
                STUP-DEC-PRM(CI, 2)         DELIMITED BY "\0",
                " "                         DELIMITED BY SIZE,
                STUP-DEC-TXT(CI, 3)         DELIMITED BY "\0",
                " "                         DELIMITED BY SIZE,
                STUP-DEC-PRM(CI, 3)         DELIMITED BY "\0",
                " "                         DELIMITED BY SIZE,
                STUP-DEC-TXT(CI, 4)         DELIMITED BY "\0",
                " "                         DELIMITED BY SIZE,
                STUP-DEC-PRM(CI, 4)         DELIMITED BY "\0",
                " "                         DELIMITED BY SIZE,
                STUP-DEC-TXT(CI, 5)         DELIMITED BY "\0",
                " "                         DELIMITED BY SIZE,
                STUP-DEC-PRM(CI, 5)         DELIMITED BY "\0"              
      INTO AKT-STARTUP-TEXT
     .
 H200-99.
     EXIT.
     
******************************************************************
* Setzen Define für Spooler-Ausgabe
******************************************************************
 H300-DEFINE SECTION.
 H300-00.
**  ---> erstmal DEFINE löschen
     MOVE ZERO        TO P-RESULT
     MOVE "=MYDEFINE" TO P-DEFINE

     PERFORM H310-DELETEDEFINE
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> dann diverse Parameter setzen
     MOVE "CLASS" TO P-ATTRIBUT
     MOVE "SPOOL" TO P-VALUE
     MOVE 5       TO P-VALUELEN
     PERFORM H320-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     MOVE "LOC"      TO P-ATTRIBUT
     MOVE W-LOC      TO P-VALUE
     MOVE W-LOC-LEN  TO P-VALUELEN

     PERFORM H320-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

     MOVE "REPORT"     TO P-ATTRIBUT
     MOVE OBJ-FILE     TO P-VALUE
     ENTER TAL "String^Laenge" USING  OBJ-FILE, 8
                               GIVING P-VALUELEN
     PERFORM H320-DEFINESETATTR
     IF  PRG-ABBRUCH
         EXIT SECTION
     END-IF

**  ---> und nun den DEFINE setzen
     PERFORM H330-ADDDEFINE
     .
 H300-99.
     EXIT.

******************************************************************
* Löschen Define
******************************************************************
 H310-DELETEDEFINE SECTION.
 H310-00.
     ENTER TAL "DEFINEDELETE"    USING P-DEFINE
                                GIVING P-RESULT
     IF  P-RESULT = ZERO or = 2051
         EXIT SECTION
     END-IF

     MOVE P-RESULT TO D-NUM4
     DISPLAY " ---> Fehler vom DEFINEDELETE - "
             D-NUM4
     SET PRG-ABBRUCH TO TRUE
     .
 H310-99.
     EXIT.
 
******************************************************************
* Setzen Define-Attribute
******************************************************************
 H320-DEFINESETATTR SECTION.
 H320-00.
     ENTER TAL "DEFINESETATTR"   USING P-ATTRIBUT
                                       P-VALUE
                                       P-VALUELEN
                                GIVING P-RESULT
     IF  P-RESULT NOT = ZERO
         MOVE P-RESULT TO D-NUM4
         DISPLAY " ---> Fehler vom DEFINESETATTR - "
                 D-NUM4
         SET PRG-ABBRUCH TO TRUE
     END-IF
     .
 H320-99.
     EXIT.

******************************************************************
* Setzen Define
******************************************************************
 H330-ADDDEFINE SECTION.
 H330-00.
     ENTER TAL "DEFINEADD"   USING P-DEFINE
                            GIVING P-RESULT
     IF  P-RESULT NOT = ZERO
         MOVE P-RESULT TO D-NUM4
         DISPLAY " ---> Fehler vom DEFINEADD - "
                 D-NUM4
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF
     .
 H330-99.
     EXIT.
 
******************************************************************
* Aufruf PHD1
******************************************************************
 M100-SSFPHD1M SECTION.
 M100-00.

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

**--> Uebernehmen MSG-DATZ
     IF PHD-DATLEN = ZERO
     OR PHD-NDATEN = SPACES
        DISPLAY " >> Keine Rückgabe vom SSFPHD1 <<"
        SET PRG-ABBRUCH TO TRUE
        EXIT SECTION
     END-IF
     
     MOVE PHD-NDATEN(1:PHD-DATLEN) TO MSG-SATZ

     .
 M100-99.
     EXIT.
 
******************************************************************
* Select auf Tabelle SSFRFDEF
******************************************************************
 S010-SELECT-SSFRFDEF SECTION.
 S010-00.
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
         WHERE   ANWENDUNG, MODUL, FUNKTION, LFDNR =
                :ANWENDUNG of SSFRFDEF
               ,:MODUL of SSFRFDEF
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
 S010-99.
     EXIT.   
******************************************************************
* Select auf Tabelle SSFRMETA
******************************************************************
 S100-SELECT-SSFRMETA SECTION.
 S100-00.
     EXEC SQL
         SELECT    SRCA_VOLUME, SRCA_SUBVOL, SRCA_FNUM,
                   SRCA_FLETTER, PROCESS_HANDLER, PHD_ANCNAME
*                 ,SRCA_CSSPOOL, SRCA,SPOOL
           INTO   :SRCA-VOLUME of SSFRMETA
                 ,:SRCA-SUBVOL of SSFRMETA
                 ,:SRCA-FNUM of SSFRMETA
                 ,:SRCA-FLETTER OF SSFRMETA
                 ,:PROCESS-HANDLER of SSFRMETA
                 ,:PHD-ANCNAME of SSFRMETA
*                 ,:SRCA-CSSPOOL of SSFRMETA
*                 ,:SRCA-SPOOL   of SSRCMETA
           FROM  =SSFRMETA
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSFRMETA-OK  TO TRUE
*        TEMPORAER bis Anpassung =SSFRMETA
                         MOVE "$WE"       TO H-CSSPOOL
                         MOVE "$WELS"     TO H-SPOOL
         WHEN 100        SET SSFRMETA-NOK TO TRUE
         WHEN OTHER      SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S100-99.
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

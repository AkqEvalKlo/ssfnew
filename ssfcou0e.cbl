?CONSULT  $SYSTEM.SYSTEM.COBOLEX0
?SEARCH   $SYSTEM.SYSTEM.COBOLLIB
?CONSULT  =TALLIB
?CONSULT  =ASC2EBC
?CONSULT  =EBC2ASC
?CONSULT  =WSYS022

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

 PROGRAM-ID. SSFCOU0M.

 DATE-COMPILED.


*****************************************************************
* Letzte Aenderung :: 2018-04-10
* Letzte Version   :: G.00.00
* Kurzbeschreibung :: Checkout / Get
* Package          :: TOOL
* Auftrag          :: SSFNEW-1
*
* Aenderungen (Version und Datum in Variable K-PROG-START aendern)
*              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*----------------------------------------------------------------*
* Vers. | Datum    | von | Kommentar                             *
*-------|----------|-----|---------------------------------------*
*G.00.00|2018-04-10| kl  | Neuerstellung
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
     05      K-MODUL             PIC X(08)          VALUE "SSFCOU0M".
     05      K-CR                PIC X              VALUE x"0D".
     05      K-LF                PIC X              VALUE x"0A".
     05      MY-VOLUME           PIC X(08)          VALUE "$WSOFT".
     05      MY-SUBVOL           PIC X(08)          VALUE "SSRCREPO".
     05      MY-UGRP             PIC 9(03)          VALUE 130.
     05      MY-UID              PIC 9(03)          VALUE 255.
     05      MY-UNAME            PIC X(32)          VALUE "WD.SUPER".
     05      MY-CURLEN           PIC S9(04) COMP    VALUE ZERO.
     
*--> SQL-Tokens fuer dynamisches SQL
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
          88 FKT-CHECKOUT                      VALUE "CHECKOUT       "
                                                     "CO".
          88 FKT-GET                           VALUE "GET            "
                                                     "GT".
     05      OPT-FLAG                PIC X     VALUE SPACE.
          88 OPT-CURRENT                       VALUE SPACE.
          88 OPT-VERSION                       VALUE "V".
          88 OPT-DATE                          VALUE "D".
          88 OPT-AUFTRAG                       VALUE "A".
          88 OPT-BRANCH                        VALUE "B".

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
 
* Fuer Fehlerausgabe
 01          ZEILE               PIC X(80)  VALUE SPACES. 
                                                   
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

 01          COUFILE.
*            Checked-Out-Datei = REPOSITORY in SSRCCOUT
        05   COU-VOL            PIC X(08).
        05   COU-SVOL           PIC X(08).
        05   COU-FILE           PIC X(08).

**          ---> Eigenschaften des Lockfiles (COUt-FILE)
 01          COUFILE-PROPERTIES.
**          ---> Security-String
        05   COU-SECURITY           PIC X(04).
**          ---> Last Modify     
        05   COU-MODI               PIC 9(16).
**          ---> User-ID / Owner     
        05   COU-OWNER-GROUP        PIC 9(03).
        05   COU-OWNER-NR           PIC 9(03).
**          ---> User-Name / Owner
        05   COU-OWNER-NAME         PIC X(32).
        05   COU-OWNER-CURLEN       PIC S9(04) COMP.
**          Filecode (101 - Edit / 100 = Object / 1001 =Zip)     
        05   COU-FCODE              PIC S9(04) COMP.
        05   COU-EXISTANCE          PIC 9             VALUE ZERO.
          88 COU-NO-EXIST                             VALUE ZERO.
          88 COU-EXIST                                VALUE 1.
        
*            Zieldatenamen
 01          P-REP-FILE          PIC X(36).
 01          P-SRC-FILE          PIC X(36).
 01          P-ARC-FILE          PIC X(36).
 01          P-HST-FILE          PIC X(36).
 01          P-COU-FILE          PIC X(36).

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
          
*G.00.03
*-->    Erweitert um FI(FileInfo)-Funktion/-Felder
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
*G.00.03
     
    
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
     05      H-SOURCE-MODUL      PIC X(08).

** --> Zaehler SSFRARCH
     05      H-ZPINS-MAX         PIC X(22).
     05      H-ZPI               PIC S9(04) COMP.
     
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
     10 LINK-CMD                PIC X(02).
*       "CO" = Checkin
*       "GT" = Get        
     10 LINK-RC                 PIC S9(04) COMP.
*       0    = OK
*       9999 = Programmabbruch - Hauptprogramm muss reagieren
    05  LINK-DATA.
*       Name des Source-Files (z.b. PFCSIP7E)
     10 LINK-REP-FILE           PIC X(36).
     10 LINK-REP-FILE-LEN       PIC S9(04) COMP.
     10 LINK-OPTION             PIC X(02).
     10 LINK-OPTVAL             PIC X(25).

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
        DISPLAY "   >>> ABBRUCH !!! <<< aus >",
                K-MODUL,
                "<"
        MOVE 9999           TO LINK-RC
     ELSE
        MOVE ZERO           TO LINK-RC
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

        WHEN "CO"       SET FKT-CHECKOUT   TO TRUE
        WHEN "GT"       SET FKT-GET        TO TRUE
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

*---> Holen Properties Repository und/oder Checkout
     PERFORM H110-FILE-PROPERTIES
     IF PRG-ABBRUCH 
        EXIT SECTION
     END-IF

**--> Status Eingechecked/Augechecked/Neu/Inkonsistent
     PERFORM H120-LOCK-STATE
     IF PRG-ABBRUCH
        EXIT SECTION
     END-IF
          
**--> Vorarbeiten OK, weiter mit eigentlicher Verarbeitung
     EVALUATE TRUE

        WHEN FKT-CHECKOUT   PERFORM C100-CHECKOUT
        WHEN FKT-GET        PERFORM C200-GET
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
* Holen des Archivfiles aus Repository
******************************************************************
 C100-CHECKOUT SECTION.
 C100-00.

*--> Unzip Archiv
    PERFORM D110-UNZIP
    IF PRG-ABBRUCH
       EXIT SECTION
    END-IF
    
*--> Umbenennen in Sourcefile
    PERFORM D120-RENAME
    IF PRG-ABBRUCH
       EXIT SECTION
    END-IF

*--> Sperren Sourcefile und Repository
    PERFORM D130-LOCK-FILE
    IF PRG-ABBRUCH
       EXIT SECTION
    END-IF

*--> Index pflegen - In D130-LOCK-File
*    PERFORM D300-SSFRARCH
    
     .
 C100-99.
     EXIT.

******************************************************************
* Nur holen der Source (z.B. zum ansehen)
******************************************************************
 C200-GET SECTION.
 C200-00.

*--> Unzip Archiv
    PERFORM D110-UNZIP
    IF PRG-ABBRUCH
       EXIT SECTION
    END-IF
    
*--> Verschieben Archiv > Repository
    PERFORM D120-RENAME
    IF PRG-ABBRUCH
       EXIT SECTION
    END-IF

*--> Index pflegen - Hier nicht erforderlich
*    PERFORM D300-SSFRARCH
    
     .
 C200-99.
     EXIT.
     
******************************************************************
* Archiv-File aus dem Archiv
******************************************************************
 D110-UNZIP SECTION.
 D110-00.
    
      INITIALIZE SSFRFDEF    

**--> Holen Kommando
      MOVE K-MODUL      TO MODUL        OF SSFRFDEF
      MOVE FKT-FLAG     TO FUNKTION     OF SSFRFDEF
      MOVE 1            TO LFDNR        OF SSFRFDEF,
                           CI
**--> Kommandodefinition lesen
      PERFORM S010-SELECT-SSFRFDEF
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
 D110-99.
    EXIT. 
******************************************************************
* Archivfile umbenenn in Source-File
******************************************************************
 D120-RENAME SECTION.
 D120-00.
 
      INITIALIZE SSFRFDEF
    
**--> Holen Kommando
      MOVE K-MODUL      TO MODUL        OF SSFRFDEF
      MOVE FKT-FLAG     TO FUNKTION     OF SSFRFDEF
      MOVE 2            TO LFDNR        OF SSFRFDEF,
                           CI
**--> Kommandodefinition lesen
      PERFORM S010-SELECT-SSFRFDEF
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
 D120-99.
    EXIT. 
******************************************************************
* File sperren bei Chekcout
******************************************************************
 D130-LOCK-FILE SECTION.
 D130-00.
 
      INITIALIZE SSFRFDEF 
    
**--> Holen Kommando
      MOVE K-MODUL      TO MODUL        OF SSFRFDEF
      MOVE FKT-FLAG     TO FUNKTION     OF SSFRFDEF
      MOVE 3            TO LFDNR        OF SSFRFDEF,
                           CI
**--> Kommandodefinition lesen
      PERFORM S010-SELECT-SSFRFDEF
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
     IF PRG-ABBRUCH 
        EXIT SECTION
     END-IF
    
**--> Als ausgechecked markieren
     PERFORM D300-SSFRARCH    
    .
 D130-99.
    EXIT. 
    
******************************************************************
* Verschieben ins Repository
******************************************************************
 D300-SSFRARCH SECTION.
 D300-00.
    
    MOVE   SRC-FILE         TO SOURCE-MODUL      OF SSFRARCH
    MOVE   H-VERSION        TO VERSION           OF SSFRARCH
    MOVE   "SRC"            TO FILE-TYPE         OF SSFRARCH
    MOVE   MY-UNAME         TO GROUP-USER        OF SSFRARCH
       
    PERFORM U100-BEGIN
    
*   Update COU-FLAG + USER + ZPINS
    PERFORM S250-UPDATE-SSFRARCH
    IF SSFRARCH-OK
       PERFORM U110-COMMIT
    ELSE
       PERFORM U120-ROLLBACK
       SET PRG-ABBRUCH TO TRUE       
    END-IF
     .
 D300-99.
    EXIT SECTION.
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
      
      MOVE ENV-VOLUME       TO   MY-VOLUME
      MOVE ENV-SUBVOL       TO   MY-SUBVOL
      MOVE ENV-USER-GRP     TO   MY-UGRP
      MOVE ENV-USER-NR      TO   MY-UID
      MOVE ENV-USER-NAME    TO   MY-UNAME
      MOVE ENV-USER-CURLEN  TO   MY-CURLEN

     .
 H000-99.
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

*P-COU-FILE = Checked_out_FILE = REPFILE mit Svol COUT_SUBVOL
     MOVE    REPOSITORY                 TO COUFILE
     MOVE    COUT-SUBVOL OF SSFRMETA    TO COU-SVOL
*    Vollen Dateiname bauen
     STRING COU-VOL      DELIMITED BY SPACE,
            "."          DELIMITED BY SIZE,
            COU-SVOL     DELIMITED BY SPACE,
            "."          DELIMITED BY SIZE,
            COU-FILE     DELIMITED BY SPACE
     INTO   P-COU-FILE
     
*P-ARC-FILE --> Uber SQL in nächster Section
     PERFORM H101-GET-ARCFILE

     .
 H100-99.
     EXIT.
******************************************************************
* Holen Archiv-File aus SSFRARCH
******************************************************************
 H101-GET-ARCFILE SECTION.
 H101-00.
    
    MOVE SRC-FILE       TO H-SOURCE-MODUL
        
**  ---> Kommandostruktur feststellen
*        Mit Option? Auswerten und Hostvariable besetzen
    IF  LINK-OPTION(1:1) = "-"
        MOVE LINK-OPTION(2:1)   TO OPT-FLAG
    ELSE
        SET OPT-CURRENT TO TRUE
    END-IF
        
    EVALUATE TRUE
    
       WHEN  OPT-CURRENT   PERFORM S210-SELECT-SSFRARCH-CURRENT
       
       WHEN  OPT-VERSION   MOVE LINK-OPTVAL TO H-VERSION
                           PERFORM S220-SELECT-SSFRARCH-VERSION
                           
       WHEN  OPT-DATE      MOVE LINK-OPTVAL TO H-SOURCE-DATE
                           PERFORM S230-SELECT-SSFRARCH-DATE
                           
       WHEN  OPT-AUFTRAG   MOVE ALL "%"              TO H-AUFTRAG
                           STRING PZ                 DELIMITED BY SIZE,
                                  LINK-OPTVAL    DELIMITED BY SPACE,
                                  PZ                 DELIMITED BY SIZE
                           INTO H-AUFTRAG
                           PERFORM S240-SELECT-SSFRARCH-AUFTRAG
                           
       WHEN  OTHER         DISPLAY " "
                           STRING  "Unbekannte Option >> " 
                                   DELIMITED BY SIZE,
                                   OPT-FLAG
                                   DELIMITED BY SIZE,
                                   " << fuer CHECKOUT: "
                                   DELIMITED BY SIZE,
                                   SRC-FILE 
                                   DELIMITED BY SPACE
                                   INTO ZEILE
                           DISPLAY ZEILE
                           DISPLAY " >> ABBRUCH <<"
                           DISPLAY " "
                           SET PRG-ABBRUCH TO TRUE
                           
    END-EVALUATE
    
    IF PRG-ABBRUCH
       EXIT SECTION
    END-IF
    
**---> Zusammenbauen Archiv-File
    MOVE     MY-VOLUME                     TO ARC-VOL
    MOVE     MY-SUBVOL                     TO ARC-SVOL
    MOVE     ARCHIV-MODUL OF SSFRARCH      TO ARC-FILE
    
*    Vollen Dateiname bauen
    STRING ARC-VOL      DELIMITED BY SPACE,
           "."          DELIMITED BY SIZE,
           ARC-SVOL     DELIMITED BY SPACE,
           "."          DELIMITED BY SIZE,
           ARC-FILE     DELIMITED BY SPACE
    INTO   P-ARC-FILE

    .
 H101-99.
    EXIT.
******************************************************************
* Uebergabe-File umsetzen auf benoetigte Dateinamen
******************************************************************
 H110-FILE-PROPERTIES SECTION.
 H110-00.

*   Holen Properties Repository
    MOVE  P-REP-FILE TO ENV-REP-FILE 
    ENTER TAL "String^Laenge"     USING  ENV-REP-FILE, 36
                                  GIVING ENV-REP-FILE-LEN
    MOVE  "FI"                    TO     ENV-CMD
    CALL "SSFEIN0M"  USING ENV-REC
    EVALUATE  ENV-RC
    
        WHEN ZERO    MOVE ENV-SECURITY      TO REP-SECURITY
                     MOVE ENV-MODI          TO REP-MODI
                     MOVE ENV-OWNER-GROUP   TO REP-OWNER-GROUP
                     MOVE ENV-OWNER-NR      TO REP-OWNER-NR
                     MOVE ENV-OWNER-NAME    TO REP-OWNER-NAME
                     MOVE ENV-OWNER-CURLEN  TO REP-OWNER-CURLEN
                     MOVE ENV-FCODE         TO REP-FCODE
                     SET  REP-EXIST         TO TRUE
                     
        WHEN 11      SET  REP-NO-EXIST      TO TRUE
        
        WHEN OTHER   MOVE ENV-RC TO D-NUM4
                     DISPLAY " "
                     DISPLAY " Fehler Properties ", ENV-REP-FILE, ": " D-NUM4
                     DISPLAY " >>> ABBRUCH <<<"
                     SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION
                     
    END-EVALUATE
                    
*   Holen Properties Check-Out-File
    MOVE  P-COU-FILE TO ENV-REP-FILE 
    ENTER TAL "String^Laenge"     USING  ENV-REP-FILE, 36
                                  GIVING ENV-REP-FILE-LEN
    MOVE  "FI"                    TO     ENV-CMD
    CALL "SSFEIN0M"  USING ENV-REC
    EVALUATE  ENV-RC
    
        WHEN ZERO    MOVE ENV-SECURITY      TO COU-SECURITY
                     MOVE ENV-MODI          TO COU-MODI
                     MOVE ENV-OWNER-GROUP   TO COU-OWNER-GROUP
                     MOVE ENV-OWNER-NR      TO COU-OWNER-NR
                     MOVE ENV-OWNER-NAME    TO COU-OWNER-NAME
                     MOVE ENV-OWNER-CURLEN  TO COU-OWNER-CURLEN
                     MOVE ENV-FCODE         TO COU-FCODE
                     SET  COU-EXIST         TO TRUE
                     
        WHEN 11      SET  COU-NO-EXIST      TO TRUE
        
        WHEN OTHER   MOVE ENV-RC TO D-NUM4
                     DISPLAY " "
                     DISPLAY " Fehler Properties ", ENV-REP-FILE, ": " D-NUM4
                     DISPLAY " >>> ABBRUCH <<<"
                     SET PRG-ABBRUCH TO TRUE
                     EXIT SECTION
                     
    END-EVALUATE
                    
    .
 H110-99.
    EXIT.
    
******************************************************************
* Ermitteln NEU/ CHECKED IN / CHECKED OUT / INCONSISTENT
******************************************************************
 H120-LOCK-STATE SECTION.
 H120-00.

*            Sperrstatus Repository 
*    05      REP-LOCK-STATE          PIC 9     VALUE ZERO.
*         88 REP-UNLOCKED                      VALUE ZERO.
*         88 REP-NEW                           VALUE 1.
*         88 REP-LOCKED                        VALUE 2.
*         88 REP-INCONSISTENT                  VALUE 9.

**---> Gibt es das Repository File?
     IF  REP-NO-EXIST
     AND COU-NO-EXIST
         SET REP-NEW     TO TRUE
         EXIT SECTION
     END-IF
                 
**---> Ausgechecked
     IF  REP-EXIST
     AND COU-EXIST
     AND REP-FCODE = 101
     AND COU-FCODE = 1001
         SET REP-LOCKED TO TRUE
         EXIT SECTION
     END-IF
         
**---> Eingechecked
     IF  REP-EXIST
     AND COU-NO-EXIST
     AND REP-FCODE = 1001
         SET REP-UNLOCKED TO TRUE
         EXIT SECTION
     END-IF
         
**---> Alles andere ist Inkonsistent
     SET REP-INCONSISTENT TO TRUE
     
     CONTINUE
     .
 H120-99.
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
      MOVE ALL SPACES TO AKT-STARTUP-TEXT
      
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

              WHEN "REPFILE"  IF  REP-LOCKED
                              AND FKT-GET
                                  MOVE   P-COU-FILE   TO STUP-DEC-PRM(CI, CIP)
                              ELSE
                                  MOVE   P-REP-FILE   TO STUP-DEC-PRM(CI, CIP)
                              END-IF

              WHEN "SRCFILE"  MOVE   SRC-FILE     TO STUP-DEC-PRM(CI, CIP)

              WHEN "ARCHFILE" MOVE   ARC-FILE     TO STUP-DEC-PRM(CI, CIP)

              WHEN "HISTFILE" MOVE   HST-FILE     TO STUP-DEC-PRM(CI, CIP)
              
              WHEN "COFILE"   MOVE   P-COU-FILE   TO STUP-DEC-PRM(CI, CIP) 

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
 S010-99.
     EXIT.   
******************************************************************
* Select auf Tabelle SSFRMETA
******************************************************************
 S100-SELECT-SSFRMETA SECTION.
 S100-00.
     EXEC SQL
         SELECT    SRCA_VOLUME, SRCA_SUBVOL, SRCA_FNUM,
                   SRCA_FLETTER, PROCESS_HANDLER, PHD_ANCNAME,
                   COUT_SUBVOL
           INTO   :SRCA-VOLUME of SSFRMETA
                 ,:SRCA-SUBVOL of SSFRMETA
                 ,:SRCA-FNUM of SSFRMETA
                 ,:SRCA-FLETTER OF SSFRMETA
                 ,:PROCESS-HANDLER of SSFRMETA
                 ,:PHD-ANCNAME of SSFRMETA
                 ,:COUT-SUBVOL of SSFRMETA
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
* Select auf Tabelle SSFRARCH - Letzter ZPINS
******************************************************************
 S210-SELECT-SSFRARCH-CURRENT SECTION.
 S210-00.
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
        SELECT ARCHIV_MODUL, VERSION
        INTO   :ARCHIV-MODUL    OF SSFRARCH
              ,:H-VERSION
        FROM  =SSFRARCH        
        WHERE  SOURCE_MODUL, ZPINS =
              :H-SOURCE-MODUL
             ,:H-ZPINS-MAX
                 TYPE AS DATETIME YEAR TO FRACTION(2)
        BROWSE ACCESS
     END-EXEC
     
     .
 S210-99.
     EXIT.

******************************************************************
* Select auf Tabelle SSFRARCH.archiv_modul: VERSION
******************************************************************
 S220-SELECT-SSFRARCH-VERSION SECTION.
 S220-00.
     
     EXEC SQL
        SELECT ARCHIV_MODUL, VERSION
        INTO   :ARCHIV-MODUL    OF SSFRARCH
              ,:H-VERSION
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
 S220-99.
    EXIT SECTION.
    
******************************************************************
* Select auf Tabelle SSFRARCH.archiv_modul: SOURCE_DATE
******************************************************************
 S230-SELECT-SSFRARCH-DATE SECTION.
 S230-00.
     
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
        SELECT ARCHIV_MODUL, VERSION
        INTO   :ARCHIV-MODUL    OF SSFRARCH
              ,:H-VERSION
        FROM  =SSFRARCH        
        WHERE  SOURCE_MODUL, ZPINS =
              :H-SOURCE-MODUL
             ,:H-ZPINS-MAX
                 TYPE AS DATETIME YEAR TO FRACTION(2)
        BROWSE ACCESS
     END-EXEC
     
    .
 S230-99.
    EXIT SECTION.
    
******************************************************************
* Select auf Tabelle SSFRARCH.archiv_modul: AUFTRAG
******************************************************************
 S240-SELECT-SSFRARCH-AUFTRAG SECTION.
 S240-00.
     
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
                LINK-OPTVAL                 DELIMITED BY SPACE,
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
        SELECT ARCHIV_MODUL, VERSION
        INTO   :ARCHIV-MODUL    OF SSFRARCH
              ,:H-VERSION
        FROM  =SSFRARCH        
        WHERE  SOURCE_MODUL, ZPINS =
              :H-SOURCE-MODUL
             ,:H-ZPINS-MAX
                 TYPE AS DATETIME YEAR TO FRACTION(2)
        BROWSE ACCESS
     END-EXEC                
    .
 S240-99.
    EXIT SECTION.
    
******************************************************************
* Update auf SSFRARCH - Checked Out
******************************************************************
 S250-UPDATE-SSFRARCH  SECTION.
 S250-00.
     EXEC SQL
         UPDATE  =SSFRARCH
           SET   COUT_FLAG  = "Y",
                 GROUP_USER = :GROUP-USER    OF SSFRARCH
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
 S250-99.
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
              SRC-FILE                           DELIMITED BY SPACE,
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

?CONSULT $SYSTEM.SYSTEM.COBOLEX0
?SEARCH  $SYSTEM.SYSTEM.COBOLLIB
?SEARCH  =TALLIB
?SEARCH  =ASC2EBC
?SEARCH  =EBC2ASC
?NOLMAP, SYMBOLS, INSPECT
?SAVE ALL
?SAVEABEND
?LINES 66
?CHECK 3

 IDENTIFICATION DIVISION.

 PROGRAM-ID. SSFEIN0M.

 DATE-COMPILED.


*****************************************************************
* Letzte Aenderung :: 2018-03-28
* Letzte Version   :: G.00.01
* Kurzbeschreibung :: User-Infos (Name, aktuelles Subvolume)
* Kurzbeschreibung :: und Fileinfos holen
*
* Aenderungen (Version und Datum in Variable K-PROG-START aendern)
*              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*----------------------------------------------------------------*
* Vers. | Datum    | von | Kommentar                             *
*-------|----------|-----|---------------------------------------*
*G.01.|2011  |  |
*       |          |     |
*-------|----------|-----|---------------------------------------*
*G.00.01|2018-03-28| kl  | Neue Funktion FI integriert
*-------|----------|-----|---------------------------------------*
*G.00.00|2018-03-23| kl  | Neuerstellung (Nur ENV = EI)
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
     05      D-FILE-GROUP        PIC  9(03).
     05      D-FILE-OWNER        PIC  9(03).
     05      D-SEC-STRING        PIC  X(04).    

*--------------------------------------------------------------------*
* Felder mit konstantem Inhalt: Präfix K
*--------------------------------------------------------------------*
 01          KONSTANTE-FELDER.
     05      K-MODUL             PIC X(08)          VALUE "SSFEIN0M".

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

*            Funktionsschalter
     05      FKT-FLAG                PIC X(15) VALUE SPACES.
          88 FKT-NO-FKT                        VALUE SPACES.
          88 FKT-MYENV                         VALUE "MYENV          "
                                                     "EI".
          88 FKT-FILEINFO                      VALUE "FILEINFO       "
                                                     "FI".
          
*--------------------------------------------------------------------*
* weitere Arbeitsfelder
*--------------------------------------------------------------------*
 01          WORK-FELDER.
     05      W-DUMMY             PIC X(02).    
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
**          ---> hier steht das Programmobject
     05      W-PROG-OBJECT       PIC X(08).
**          ---> hier steht jetzt mein HomeTerminal
     05      W-MY-HOMETERM       PIC X(26).
**          ---> hier steht das ausgeführte Programmfile
     05      W-MY-PROG-FNAME     PIC X(47).    
     
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
 
**          ---> zum Zeitpunkt berechnen
 01          LAST-MODIFY-X       PIC X(8).
 01          LAST-MODIFY-N REDEFINES LAST-MODIFY-X
                                 PIC S9(18) COMP.

*--------------------------------------------------------------------*
* Parameter für Untermodulaufrufe - COPY-Module
*--------------------------------------------------------------------*

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

 
 01  Define-Info-Parameter.
     05 DefInf-Name                    PIC X(024)      VALUE "=_DEFAULTS".
     05 DefInf-Status                  PIC S9(04) COMP VALUE 0.
     05 DefInf-Class                   PIC X(016)      VALUE "DEFAULTS".
     05 DefInf-Attr                    PIC X(016)      VALUE SPACE.
     05 DefInf-Buf                     PIC X(100)      VALUE SPACE.
     05 DefInf-InLth                   PIC S9(04) COMP VALUE 50.
     05 DefInf-OutLth                  PIC S9(04) COMP VALUE 0.
 
**          ---> Parameter fuer TAL-Aufrufe
 01          T-ERROR             PIC S9(4) COMP.
 01          T-FNAME             PIC X(34) VALUE SPACES.
 01          T-FNAME-LEN         PIC S9(4) COMP.
 01          T-FNAME-LEN-MAX     PIC S9(4) COMP VALUE 34.
 01          T-ITEM-LIST.
*            Security String 
     05      T-ITEM-LIST-062     PIC S9(4) COMP VALUE 062.
*            Last Modify     
     05      T-ITEM-LIST-145     PIC S9(4) COMP VALUE 145.
*            Owner (nnn,nnn)    
     05      T-ITEM-LIST-058     PIC S9(4) COMP VALUE 058.
*            Filecode
     05      T-ITEM-LIST-042     PIC S9(4) COMP VALUE 042.        
 01          T-NUM-OF-ITEMS      PIC S9(4) COMP VALUE 4.
 01          T-RESULT.
*            T-RESULT(1:4)
     05      T-RESULT-SECS       PIC X(04).
*            T-RESULT(5:8)     
     05      T-RESULT-MODI       PIC X(08).
*            T-RESULT(13:2)          
     05      T-RESULT-GROUP-USER PIC X(02).
*            T-RESULT(15:2)          
     05      T-RESULT-FILECODE   PIC X(02).
 01          T-RESULT-MAX        PIC S9(4) COMP VALUE 16.
 01          T-RESULT-LEN        PIC S9(4) COMP.
 01          T-ERROR-ITEM        PIC S9(4) COMP.

 EXTENDED-STORAGE SECTION.
 
 
 LINKAGE SECTION.
 
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
      
 PROCEDURE DIVISION USING LINK-REC.
******************************************************************
* Steuerungs-Section
******************************************************************
 A100-STEUERUNG SECTION.
 A100-00.
**  ---> wenn SWICH-15 gesetzt ist
**  ---> nur Umwandlungszeitpunkt zeigen und dann beenden
     IF  SHOW-VERSION
         DISPLAY K-MODUL " vom: " FUNCTION WHEN-COMPILED
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

        WHEN "EI"       SET FKT-MYENV    TO TRUE
        WHEN "FI"       SET FKT-FILEINFO TO TRUE
        
        WHEN OTHER      DISPLAY "Falsches Kommando für ",
                                 K-MODUL,
                                 ": ",
                                 LINK-CMD
                        DISPLAY  "Verarbeitung nicht möglich!"
                        SET PRG-ABBRUCH TO TRUE
                        EXIT SECTION

     END-EVALUATE

**--> Vorarbeiten OK, weiter mit eigentlicher Verarbeitung
     EVALUATE TRUE

        WHEN FKT-MYENV      PERFORM C100-GET-ENVIRONMENT
        WHEN FKT-FILEINFO   PERFORM C200-GET-FILEINFO
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

     MOVE    SPACES     TO LINK-USER-NAME
     MOVE    ZERO       TO LINK-USER-CURLEN   
     MOVE    ZERO       TO LINK-USER-GRP
     MOVE    ZERO       TO LINK-USER-NR
     MOVE    SPACES     TO LINK-VOLUME
     MOVE    SPACES     TO LINK-SUBVOL
     MOVE    SPACES     TO LINK-SECURITY
     MOVE    ZERO       TO LINK-MODI
     MOVE    ZERO       TO LINK-OWNER-GROUP
     MOVE    ZERO       TO LINK-OWNER-NR
     MOVE    SPACES     TO LINK-OWNER-NAME
     MOVE    ZERO       TO LINK-OWNER-CURLEN
     MOVE    ZERO       TO LINK-FCODE

     .
 C000-99.
     EXIT.
******************************************************************
* holen aktuelles Environment
******************************************************************
 C100-GET-ENVIRONMENT SECTION.
 C100-00.
 
*--->   Holen User-Informationen 
     PERFORM C110-USER-PROCINFO
     IF PRG-ABBRUCH 
        EXIT SECTION
     END-IF
     
*--->   Holen Aktuelles Subvolume
     PERFORM C120-INFO-DEFAULTS
      
     .
 C100-99.
     EXIT. 

******************************************************************
* holen aktuelles Environment
******************************************************************
 C200-GET-FILEINFO SECTION.
 C200-00.
 
     
*--->   Holen Datei-Informationen
     PERFORM F100-FILE-INFO
     .
 C200-99.
     EXIT. 
     
******************************************************************
* holen User und Prozess-Informationen
******************************************************************
 C110-USER-PROCINFO SECTION.
 C110-00.
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
         DISPLAY " "
         DISPLAY ZEILE
         DISPLAY " "
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
         DISPLAY " "
         DISPLAY ZEILE
         MOVE P-ERROR-DETAIL TO D-NUM4
         STRING  "-->    detail:  - "
                 D-NUM4
                     DELIMITED BY SIZE
           INTO  ZEILE
         END-STRING
         DISPLAY ZEILE
         DISPLAY " "
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
         STRING  "--> Fehler von: USER_GETINFO_ (EI) - "
                 D-NUM4
                     DELIMITED BY SIZE
           INTO  ZEILE
         END-STRING
         DISPLAY " "
         DISPLAY ZEILE
         DISPLAY " "
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF

     MOVE P-USER-NAME   TO LINK-USER-NAME
     MOVE P-USER-CURLEN TO LINK-USER-CURLEN
     UNSTRING W-USER-GRP-NAME DELIMITED BY "."
         INTO W-GRP-NAME
              W-USER-NAME
     END-UNSTRING

     MOVE P-HOMETERM (1:P-HOMETERM-LEN) TO W-MY-HOMETERM

**  ---> aufbereiten/aufberwahren numerische Gruppen-/User-Werte
     MOVE PR-GUI  TO C4-X2
     MOVE C4-NUM  TO LINK-USER-GRP
     MOVE PR-UUI  TO C4-X2
     MOVE C4-NUM TO LINK-USER-NR
     
     .
 C110-99.
     EXIT.

******************************************************************
* Define-Info =_DEFAULTS
******************************************************************
 C120-INFO-DEFAULTS SECTION.
 C120-00.

     MOVE  SPACES TO DefInf-Buf
     ENTER TAL "DefineInfo"
     USING  DefInf-Name
          , DefInf-Class
          , DefInf-Attr
          , DefInf-Buf
          , DefInf-InLth
          , DefInf-OutLth
        GIVING DefInf-Status

     UNSTRING DefInf-Buf DELIMITED BY "."
     INTO LINK-VOLUME,
          LINK-SUBVOL
     .
 C120-99.
     EXIT.
******************************************************************
* holen Last-Modify Zeitpunkt
******************************************************************
 F100-FILE-INFO SECTION.
 F100-00.

     IF  LINK-REP-FILE-LEN = ZERO
     OR  LINK-REP-FILE     = SPACE
         DISPLAY " "
         DISPLAY "Aufruf >FILEINFO (FI)< OHNE Datei"
         DISPLAY " >>> ABBRUCH <<<"
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF
     
     MOVE   LINK-REP-FILE-LEN       TO T-FNAME-LEN
     MOVE   LINK-REP-FILE           TO T-FNAME     

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
         MOVE T-ERROR TO LINK-RC
         EXIT SECTION
     END-IF

**  ---> Last Modify Zeitpunkt
     MOVE T-RESULT (5:8) TO LAST-MODIFY-X
     ENTER TAL "INTERPRETTIMESTAMP"
                 USING   LAST-MODIFY-N
                         TAL-TIME
                 GIVING  TAL-JUL-DAY

     MOVE CORR TAL-TIME   TO TAL-TIME-D
     MOVE      TAL-TIME-D TO LINK-MODI

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
                                  
     MOVE D-SEC-STRING     TO LINK-SECURITY

**  ---> File Owner bestimmen
     MOVE T-RESULT (13:1) TO CD4-X2
     MOVE CD4-NUM TO D-FILE-GROUP
     MOVE T-RESULT (14:1) TO CD4-X2
     MOVE CD4-NUM TO D-FILE-OWNER
     
     MOVE D-FILE-GROUP      TO LINK-OWNER-GROUP
     MOVE D-FILE-OWNER      TO LINK-OWNER-NR

**  ---> Filecode bestimmen     
     MOVE T-RESULT (15:2) TO CD4-X
     MOVE CD4-NUM         TO LINK-FCODE
          
**  ---> holen File Owner Namen
     MOVE T-RESULT(13:2) TO PR-UI
     ENTER TAL "USER_GETINFO_"
         USING   P-USER-NAME (1:P-USER-MAXLEN)
                 P-USER-CURLEN
                 P-USERID
                 OMITTED OMITTED OMITTED
*                 P-PRIMGROUP
                 OMITTED
         GIVING  P-ERROR
     IF  P-ERROR NOT = ZERO
         MOVE P-ERROR TO D-NUM4
         STRING  "--> Fehler von: USER_GETINFO_ (FI) - "
                 D-NUM4
                     DELIMITED BY SIZE
           INTO  ZEILE
         END-STRING
         DISPLAY " "
         DISPLAY ZEILE
         DISPLAY " "
         SET PRG-ABBRUCH TO TRUE
         EXIT SECTION
     END-IF

     MOVE P-USER-NAME   TO LINK-OWNER-NAME
     MOVE P-USER-CURLEN TO LINK-OWNER-CURLEN
     
     .
 F100-99.
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







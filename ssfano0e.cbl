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
?SQL

 IDENTIFICATION DIVISION.

 PROGRAM-ID. SSFANO0M.

 DATE-COMPILED.


*****************************************************************
* Letzte Aenderung :: 2018-03-16
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
*A.00.00|2018-03-21| kl  |  Neuerstellung
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
     SELECT SOURCEF      ASSIGN TO #DYNAMIC.
     
 DATA DIVISION.
 FILE SECTION.
 FD  SOURCEF
     RECORD  IS VARYING IN SIZE
             FROM 0 TO 128 CHARACTERS
             DEPENDING ON REC-LEN.
 01  SOURCE-RECORD               PIC X(128).

 WORKING-STORAGE SECTION.
*--------------------------------------------------------------------*
* Comp-Felder: Präfix Cn mit n = Anzahl Digits
*--------------------------------------------------------------------*
 01          COMP-FELDER.
     05      C4-ANZ              PIC S9(04) COMP.
     05      C4-COUNT            PIC S9(04) COMP.
     05      C4-I1               PIC S9(04) COMP.
     05      C4-I2               PIC S9(04) COMP.
     05      C4-I3               PIC S9(04) COMP.
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
     05      K-MODUL             PIC X(08)          VALUE "SSFANO0M".
     05      K-LF                PIC X              VALUE x"0A".
     05      K-CR                PIC X              VALUE x"0D".

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

     05      SSFRANNO-FLAG           PIC 9     VALUE ZERO.
          88 SSFRANNO-OK                       VALUE ZERO.
          88 SSFRANNO-NOK                      VALUE 1.
          
     05      SEARCH-FLAG        PIC 9          VALUE ZERO.
          88 ANNO-NOT-FOUND                    VALUE ZERO.
          88 ANNO-FOUND                        VALUE 1.
          
     05      EHDR-STATUS        PIC X(25)  VALUE SPACES.
          88 EHDR                          VALUE
                                           "ENVIRONMENT DIVISION.    "
                                           "Environment Division.    "
                                           "environment division.    ".
*--------------------------------------------------------------------*
* weitere Arbeitsfelder
*--------------------------------------------------------------------*
 01          WORK-FELDER.
     05      W-DUMMY             PIC X(02).
*            Identifikatoren (klein,gross)
     05      W-IDENT-STD         PIC X(30).
     05      W-IDENT-UC          PIC X(30).
     05      W-IDENT-LC          PIC X(30).
*            Zwischenspeicher aktueller Annotationswert     
     05      W-VALUE             PIC X(128)      VALUE SPACES.
     05      W-VALUE-LEN         PIC S9(04) COMP VALUE ZERO.

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
**  ---> Struktur der Tabelle SSFRANNO
 EXEC SQL
    INVOKE =SSFRANNO AS SSFRANNO
 END-EXEC

******************************************************************

 EXEC SQL
     END DECLARE SECTION
 END-EXEC.

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

*Bei Tabellenvergr. anpassen     
 01     MAX-SRC-LINES        PIC S9(04) COMP VALUE 750.
* wegen EXTERNAL auch Hauptprogramm(e) anpassen 
 01     SRC-LINES-COUNT      PIC S9(04) COMP VALUE ZERO. 
 
 01     VINFO-LINES-BUFFER.
    05  VINFO-LINE  OCCURS 15.
     10 VI-VAL               PIC X(128).
     10 VI-LEN               PIC S9(04).
 
 01     MAX-VI-LINES         PIC S9(04) COMP VALUE 15.
 01     VI-LINES-COUNT       PIC S9(04) COMP VALUE ZERO.
 
 01     CURRENT-LINE.
     10 CUR-VAL               PIC X(128).
     10 CUR-LEN               PIC S9(04).
 
 
 LINKAGE SECTION.
*-->    Uebergabe aus Hauptprogramm
 01     LINK-REC.
    05  LINK-HDR.
*       Zu suchende Annotation    
     10 LINK-ANNOTATION         PIC X(15).
     10 LINK-RC                 PIC S9(04) COMP.
*       0    = OK
*       100  = Nicht gefunden (bei Optionalen Annnos)
*       9999 = Programmabbruch - Hauptprogramm muss reagieren
    05  LINK-DATA.
*       Name des Repository-Files (z.b. PFCSIP7R)
     10 LINK-REP-FILE           PIC X(36).
     10 LINK-REP-FILE-LEN       PIC S9(04) COMP.
*       Rueckgabewert     
     10 LINK-AN-VALUE           PIC X(400).
     10 LINK-AN-VALUE-LEN       PIC S9(04) COMP.

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
     PERFORM B100-VERARBEITUNG
     
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
 
** -->  Konfiguration der Annotation holen
     MOVE LINK-ANNOTATION TO AN-NAME of SSFRANNO
     PERFORM S100-SELECT-SSFRANNO     
     IF SSFRANNO-OK
        CONTINUE
     ELSE
        DISPLAY "Gesuchte Annotation >",
                LINK-ANNOTATION
                "< nicht gefunden!"
        DISPLAY ">> Verarbeitung nicht moeglich <<"
        SET PRG-ABBRUCH TO TRUE
        EXIT SECTION
     END-IF

** --> Verarbeiten
*      Sonderfall: Kurzbeschreibung --> B200-VA-DESCR
      IF LINK-ANNOTATION = "SHORTDESC"
         PERFORM B200-VA-DESCR
         EXIT SECTION
      END-IF
      
      PERFORM VARYING C4-I1 FROM 1 BY 1 UNTIL
                      C4-I1 > VI-LINES-COUNT OR
                      ANNO-FOUND             OR
                      PRG-ABBRUCH
                    
        MOVE  VI-VAL(C4-I1) TO CUR-VAL
        MOVE  VI-LEN(C4-I1) TO CUR-LEN
        PERFORM C100-LOOK4ANNOTATION
        IF PRG-ABBRUCH
           EXIT PERFORM
         END-IF
         
        IF ANNO-FOUND
           MOVE W-VALUE            TO LINK-AN-VALUE
           MOVE W-VALUE-LEN        TO LINK-AN-VALUE-LEN
           EXIT PERFORM
        END-IF

     END-PERFORM
     
     IF ANNO-FOUND
        CONTINUE
     ELSE
        IF AN-MOC OF SSFRANNO = "M"
*          Mandatory
           DISPLAY "Annotation >> ",
                   VAL OF AN-IDENT OF SSFRANNO,
                   " << fehlt in "
                   " >> ",
                   SRC-FILE,
                   " <<"
           DISPLAY " >> Verabeitung nicht moeglich <<"
           SET PRG-ABBRUCH TO TRUE
        ELSE
*          Optional oder Conditional - Reaktion im Aufrufer
           MOVE 100   TO LINK-RC
        END-IF
     END-IF
     
    .
 B100-99.
     EXIT.

******************************************************************
* Initialisierung von Feldern und Strukturen
******************************************************************
 B200-VA-DESCR SECTION.
 B200-00.
 
     MOVE 1     TO C4-PTR
     MOVE ZERO  TO C4-LEN
     
     PERFORM UNTIL ANNO-NOT-FOUND
                OR PRG-ABBRUCH
                OR FILE-EOF
                
        PERFORM VARYING C4-I1 FROM 1 BY 1 UNTIL
                         C4-I1 > VI-LINES-COUNT  OR
                         ANNO-FOUND              OR
                         PRG-ABBRUCH
                                    
           SET ANNO-NOT-FOUND TO TRUE
           MOVE  VI-VAL(C4-I1) TO CUR-VAL
           MOVE  VI-LEN(C4-I1) TO CUR-LEN
           PERFORM C100-LOOK4ANNOTATION
           IF PRG-ABBRUCH
              EXIT PERFORM
            END-IF
         
            IF ANNO-FOUND
               MOVE W-VALUE(1:W-VALUE-LEN)   TO LINK-AN-VALUE(C4-PTR:)
               ADD  W-VALUE-LEN              TO C4-PTR, C4-LEN
               MOVE K-LF                     TO LINK-AN-VALUE(C4-PTR:)
               ADD  1                        TO C4-PTR, C4-LEN
            END-IF

        END-PERFORM
        
      END-PERFORM

      IF C4-LEN > ZERO
         MOVE C4-LEN TO LINK-AN-VALUE-LEN
      END-IF        
     .
 B200-99.
     EXIT.
******************************************************************
* Initialisierung von Feldern und Strukturen
******************************************************************
 C000-INIT SECTION.
 C000-00.
     INITIALIZE SCHALTER
                LINK-AN-VALUE
                
     MOVE ZERO TO LINK-AN-VALUE-LEN
     
     IF LINK-REP-FILE     = SPACES
     OR LINK-REP-FILE-LEN = ZERO
        CONTINUE
     ELSE
        PERFORM C010-INIT-SOURCE
     END-IF
     .
 C000-99.
     EXIT.
******************************************************************
* Initialisierung der Recordtabellen
******************************************************************
 C010-INIT-SOURCE SECTION.
 C010-00.
 
** --> Erstmal Tabellen und Zaehler leeren
     PERFORM VARYING  C4-I1 FROM 1 BY 1 
                UNTIL C4-I1 > SRC-LINES-COUNT
                   OR C4-I1 > MAX-SRC-LINES
                   OR SL-LEN(C4-I1) = ZERO
                   
        MOVE ALL SPACES TO SL-VAL(C4-I1)
        MOVE ZERO       TO SL-LEN(C4-I1)
        
     END-PERFORM
     MOVE ZERO TO SRC-LINES-COUNT

     PERFORM VARYING  C4-I1 FROM 1 BY 1 
                UNTIL C4-I1 > VI-LINES-COUNT
                   OR C4-I1 > MAX-VI-LINES
                   OR VI-LEN(C4-I1) = ZERO
                   
        MOVE ALL SPACES TO VI-VAL(C4-I1)
        MOVE ZERO       TO VI-LEN(C4-I1)
        
     END-PERFORM
     MOVE ZERO TO VI-LINES-COUNT

** --> Sourcefile-Name ermitteln
     PERFORM H100-FILENAMES
     IF P-SRC-FILE = SPACE
        DISPLAY "Kein gueltiger Dateiname"
        DISPLAY ">> Verarbeitung nicht moeglich <<"
        SET PRG-ABBRUCH TO TRUE
        EXIT SECTION
     END-IF
     
** --> Datei oeffnen
     PERFORM F100-OPEN-SRCFILE
     IF PRG-ABBRUCH
        EXIT SECTION
     END-IF
     
** --> 1. Lesen der Datei
     READ SOURCEF at end set file-eof to true end-read
     
** --> Hilfszaheler fuer Versionsinfo initialisieren
     MOVE 1 TO C4-I3
     
     PERFORM VARYING C4-I1 FROM 1 BY 1 UNTIL
*                    Mehr ist sinnlos      
                     C4-I1 > MAX-SRC-LINES OR
                     EHDR                  OR
                     PRG-ABBRUCH           OR 
                     FILE-EOF
                     
        MOVE SOURCE-RECORD(2:21)  TO EHDR-STATUS
        IF EHDR
           EXIT PERFORM 
        END-IF
        
        MOVE SOURCE-RECORD   TO SL-VAL(C4-I1)
        MOVE REC-LEN         TO SL-LEN(C4-I1)
        ADD  1               TO SRC-LINES-COUNT
        
        PERFORM VARYING C4-I2  FROM 16 BY 1
                              UNTIL C4-I2 > REC-LEN - 2
                                 OR C4-I3 > MAX-VI-LINES
                                 
            IF SOURCE-RECORD(C4-I2:2) = "::"
               MOVE SOURCE-RECORD        TO VI-VAL(C4-I3)
               MOVE REC-LEN              TO VI-LEN(C4-I3)
               ADD  1                    TO VI-LINES-COUNT
                                            C4-I3
               EXIT PERFORM
            END-IF
            
        END-PERFORM
        
** --> Nachlesen der Datei
       READ SOURCEF at end set file-eof to true end-read
     
     END-PERFORM

     CLOSE SOURCEF
     
     .
 C010-99.
     EXIT.

******************************************************************
* Suchen nach Annotationen
******************************************************************
 C100-LOOK4ANNOTATION SECTION.
 C100-00.
 
**   Initialisieren Rueckgabewerte
     MOVE SPACES TO W-VALUE
     MOVE ZERO   TO W-VALUE-LEN
    
**   Bauen der Vergleichsstrings
     MOVE VAL OF AN-IDENT OF SSFRANNO TO W-IDENT-STD,
                                         W-IDENT-UC,
                                         W-IDENT-LC

*    Upper-Case
     INSPECT W-IDENT-UC 
        CONVERTING "abcdefghijklmnopqrstuvwxyz"
                TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                
*    Lower-Case
     INSPECT W-IDENT-LC 
        CONVERTING "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                TO "abcdefghijklmnopqrstuvwxyz"
                
**--> Kommentarende ignorieren
     IF CUR-VAL(CUR-LEN:1) = "*"
        SUBTRACT 1 FROM CUR-LEN
        ENTER TAL "String^Laenge" USING  CUR-VAL, CUR-LEN
                                  GIVING C4-LEN
     ELSE
        MOVE CUR-LEN TO C4-LEN     
     END-IF
     
**---> Suchen der Annotation
     PERFORM VARYING C4-PTR FROM 1 BY 1
                            UNTIL C4-PTR > (C4-LEN - 
                                            LEN OF AN-IDENT OF SSFRANNO)
                          
         IF  CUR-VAL(C4-PTR:LEN OF AN-IDENT OF SSFRANNO) =
             W-IDENT-STD
         OR  CUR-VAL(C4-PTR:LEN OF AN-IDENT OF SSFRANNO) =
             W-IDENT-UC
         OR  CUR-VAL(C4-PTR:LEN OF AN-IDENT OF SSFRANNO) =
             W-IDENT-LC
           
             SET ANNO-FOUND TO TRUE
** --->      Feststellen des Wert-Anfangs           
             COMPUTE C4-PTR = C4-LEN - 2
             PERFORM UNTIL C4-PTR < C4-LEN - 
                                    LEN OF AN-IDENT OF SSFRANNO
             
                IF CUR-VAL(C4-PTR:2) = "::"
                   ADD 3 TO C4-PTR
                   EXIT PERFORM
                ELSE
                   SUBTRACT 1 FROM C4-PTR
                END-IF
                
             END-PERFORM
             EXIT PERFORM
             
         END-IF
         
     END-PERFORM
     
     IF ANNO-FOUND     
** --> Wert ermitteln
       COMPUTE W-VALUE-LEN = C4-LEN - C4-PTR + 1
       MOVE CUR-VAL(C4-PTR:W-VALUE-LEN) TO W-VALUE     
     END-IF
     .
 C100-99.
    EXIT.
******************************************************************
* Oeffnen Source-Datei (Lesen)
******************************************************************
 F100-OPEN-SRCFILE SECTION.
 F100-00.

     MOVE  P-SRC-FILE       TO ASS-FNAME
     MOVE  ZERO             TO ASS-FSTATUS

**  ---> erst mal Sourcefile assignen
     ENTER "COBOLASSIGN" USING  SOURCEF
                                ASS-FNAME
                         GIVING ASS-FSTATUS

     IF  ASS-FSTATUS NOT = ZERO
         DISPLAY "Fehler bei COBOLASSIGN: "
                 ASS-FNAME " " ASS-FSTATUS
         DISPLAY " ---> Programm-Abbruch <--- "
         SET PRG-ABBRUCH TO TRUE
     ELSE
**       --->  Öffnen Datei im Lesemodus
         OPEN INPUT  SOURCEF
     END-IF

     .
 F100-99.
     EXIT.
******************************************************************
* Uebergabe-File umsetzen auf benoetigte Dateinamen
******************************************************************
 H100-FILENAMES SECTION.
 H100-00.

*P-SRC-FILE = SOURCE_FILE
     UNSTRING LINK-REP-FILE DELIMITED BY "."
     INTO    SRC-VOL
           , SRC-SVOL
           , SRC-FILE

     IF  SRC-SVOL = SPACE
     AND SRC-FILE = SPACE
*        PFCSIP7E
         MOVE     SRC-VOL        TO SRC-FILE
         MOVE     "$WSOFT"       TO SRC-VOL
         MOVE     "SSRCREPO"     TO SRC-SVOL
     ELSE
         IF SRC-FILE = SPACE
*           SSRCREPO.PFCSIP7E
            MOVE   SRC-VOL       TO SRC-SVOL
            MOVE   SRC-SVOL      TO SRC-FILE
            MOVE   "$WSOFT"      TO SRC-VOL
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
     .
 H100-99.
     EXIT.    

******************************************************************
* Select auf Tabelle SSFRANNO
******************************************************************
 S100-SELECT-SSFRANNO SECTION.
 S100-00.
     EXEC SQL
         SELECT    AN_NAME, AN_TYPE, AN_IDENT, AN_MOC, AN_DESCR
                 , ZPINS
           INTO   :AN-NAME of SSFRANNO
                 ,:AN-TYPE of SSFRANNO
                 ,:AN-IDENT of SSFRANNO
                 ,:AN-MOC of SSFRANNO
                 ,:AN-DESCR of SSFRANNO
                 ,:ZPINS of SSFRANNO
                     TYPE AS DATETIME YEAR TO FRACTION(2)
           FROM  =SSFRANNO
          WHERE  AN_NAME, AN_TYPE =
                :AN-NAME       of SSFRANNO
**              Erstmal nur fuer Source-Files; Rest in Tabelle
*               nur informativ                
               ,"SRC"
         BROWSE  ACCESS
     END-EXEC
     EVALUATE SQLCODE OF SQLCA
         WHEN ZERO       SET SSFRANNO-OK  TO TRUE
         WHEN 100        SET SSFRANNO-NOK TO TRUE
         WHEN OTHER      SET PRG-ABBRUCH TO TRUE
     END-EVALUATE
     .
 S100-99.
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







?section KOMMENTAR
******************************************************************
* Datei: MSGLIB                          Version vom: 14.11.2017
******************************************************************
*                       Aenderungshistorie                       *
*                                                                *
* 13.11.96 - A.01.10  Neue Module: PSYS015C                      *
*                                  TTSA900C                      *
*                                  FRESATZN                      *
*                                  TOLP20M1                      *
* 26.05.98 - A.01.11       ""      PSYS911C MEMREC               *
*                                  INT-SCHNITTSTELLE             *
*                                  PSYS901C PSYS905C             *
*                                  PCAPM01C                      *
*                                  PDBC
* 15.09.00 - A.01.12       ""      WSYS021C                      *
*                                                                *
* 02.11.00   A.01.13       ""      THKO4FMC                      *
* 19.02.01   A.01.13       ""      TFHO4FMC                      *
* 07.12.00   A.01.00       ""      WSYS920C                      *
*                                                                *
* 26.02.01                 ""      WSYS022C                      *
* 29.01.02   A.02.00  Alle TOLP.. sections entfernt              *
* 31.01.02   A.02.21  Neues Element WSYS04TC                     *
* 12.04.02   A.02.22  Neues Element WSYS960C                     *
* 04.09.02   A.02.23        ""      WSYS023C                     *
* 06.09.02   A.02.24        ""      WSYS410C                     *
* 31.01.03   A.02.25        ""      WSYS955C                     *
* 14.02.03   A.02.26        ""      WSYS015C                     *
* 16.06.03   A.02.27        ""      WSYS016C                     *
*                           ""      WSYS956C                     *
* 15.08.03   A.02.28        ""      WSYS930C                     *
* 19.08.03   A.02.29        ""      FREGAT-XXL                   *
* 22.08.03   A.02.29        ""      FREGAT-NEU-XXL               *
* 26.11.03   A.02.30        ""      WSYS041C                     *
* 28.11.03   A.02.31   geaendert 88 WSYS930C                     *
* 12.01.04   A.02.33       neu      WUMSC05C                     *
* 21.10.04   A.02.34       neu      PHFMON0C                     *
* 16.03.05   A.02.35       neu      WSTKXUMC                     *
* 19.05.05   A.02.36       neu      MODCOMRC                     *
* 04.01.06   A.02.37       neu      WSYS959C  jb                 *
* 13.01.06   A.02.38   nur Kommentar erweitert bei WSYS016C      *
* 10.07.06   A.02.39       neu      WSYS970C  jb                 *
* 11.07.06   A.02.39       neu      WSYS971C  jb                 *
* 28.07.06   A.02.40       neu      WSYS956X  HJO                *
* 13.03.07   A.02.41       neu      WSYS056C  HJO                *
* 20.07.07   A.02.42       neu      SSHMAP1C  kl                 *
* 20.08.07   A.02.43       neu      WISO400C  jb                 *
* 20.08.07   A.02.44       neu      WISO300C  jb                 *
*                          neu      WISO310C  jb                 *
* 26.11.07   A.02.45       neu      SYSWKZ0C  jb                 *
* 05.02.08   A.02.46       neu      AS-ROUT70 HJO                *
* 08.02.08   A.02.47       ???       ??????                      *
* 15.02.08   A.02.48                   ROUT70 HBANK              *
* 21.02.08   A.02.49                   ROUT70 KZ-GIRO-ALLIANCE   *
* 21.02.08   A.02.50       neu         PS2PRFC                   *
* 02.05.08   A.02.51       neu      WISO410C  jb                 *
* 19.09.08   A.02.52       neu      ASKAI956C HJO                *
* 21.11.08   A.02.53       neu      SDBCDU0C HJO                 *
* 21.11.08   A.02.54       neu      WPCI01C  HJO                 *
* 29.01.09   A.02.55       WSYS956  AC mit ACX überdefiniert     *
* 09.02.09   A.02.56       WISO410C neues Kommando            jb *
* 10.02.09   A.02.57       neu      WISO420C                  jb *
* 07.05.09   A.02.58       neu      SYSABL1C                  jb *
* 22.06.09   A.02.59       geänd.   WISO401C                 HJO *
* 12.07.11   A.02.60       geänd.   TFHO4FMC                 HJO *
* 12.03.12   A.02.61       neu      WSYSAV6C                 HJO *
* 26.05.09   A.02.62       neu      WSYS063C                  kl *
* 16.02.10   A.02.63       neu      WABS000C                  kl *
* 27.04.10   A.02.64       neu      FREGAT-XXX               HJO *
* 20.09.11   A.02.65       WABS000C Neue Schalter TXART       kl *
* 07.08.12   A.02.66       WSYS909C Schnittstelle             kl *
* 02.07.13   A.02.67       WISO107C Schnittstelle             jb *
*                          WISO207C Schnittstelle             jb *
* 20.08.13   A.02.68       Änderung ASKAI956                  jb *
* 26.08.13   F.01.00       neu      WABS00XC                  kl *
* 20.08.14   F.01.00       neu      WABS00YC                  kl *
* 27.08.13   A.02.69       Änderung INT-SCHNITTSTELLE-C       jb *
* 25.09.13   A.02.70       Neu      WNEF056C                 HJO *
* 26.09.13   A.02.71       Neu      WXMSG07C                  kl *
* 27.12.13   A.02.72       Neu      WUMSO07C                  jb *
* 05.06.14   A.01.73       NEU      TFHO7FMC                  as *
* 11.08.14   A.01.02       Änderung WISO200C                  sk *
* 10.11.14   A.01.74       NEU      WUMSC07C                  as *
* 24.11.14   A.01.02       Änderung WISO207C                  sk *
* 13.02.15   A.01.02       NEU      STR2NUMC                  cb *
* 01.04.15   A.01.73       geänd.   TFHO7FMC                  rg *
* 07.04.15   A.01.74       NEU      WSY7066C                  jb *
* 26.06.15   A.01.75       NEU      WISO417C                  HJO*
* 26.06.15   A.01.76       NEU      WISO730C                  HJO*
* 13.07.15   A.01.77       geänd.   WISO300C                  HJO*
* 15.07.15   G.01.00       NEU      PFCBNS7C                  kl *
* 15.07.15   A.01.78       wieder zurückgen.  WISO300C        HJO*
* 15.07.15   A.01.79       neu                WISO370C        HJO*
* 16.04.12   G.01.01       neue 88er WUMS-CMD-IL > WUMSO07C    cb*
* 21.09.16   G.01.02       NEU      WMSG07C                   kl *
* 23.09.16   G.01.00       Neu      WEUR056C                     *
* 28.09.16   G.01.03       WMSG07C.RELEASE auf 2 Byte erweit. kl *
* 10.02.17   G.01.04       W63MP07C.BMP48 verlängert wg. 48.9 kl *
* 27.02.17   G.01.05       Neu: WISOX70C, WISOX30C, WISOX10C     *
* 14.11.17   G.01.06       Neu: PKKBM22-IFC  HJO                 *
*                                                                *
*                                                                *
* In dieser MSGLIB sind die folgenden Module enthalten:          *
*                                                                *
*    ASKAI956C                                                   *
*    AS-ROUT (ALTES FORMAT)                                      *
*    AS-ROUT-NEU (1990)                                          *
*    AS-ROUT-70  (2008)                                          *
*    FREGAT-DTXP
*    FRESATZ
*    MSGROOT
*    MSGROOT1
*    STARTMSG
*    STOPMSG
*    STR2NUMC
*    UMP-MESS1
*    UMP-MESS2
*    TSYS010IFC
*    PHFMON0C
*    PS2PRFC
*    PSYS020IFC
*    SDBCDU0C
*    WPCI01C
*    WSYS015C
*    WSYS016C
*    WSYS021C
*    WSYS022C
*    WSYS023C
*    WSYS410C
*    WSYS04TC
*    WSYS041C
*    WSYS930C
*    WSYS959C
******************************************************************


?section AS-ROUT
*******************************************************************
* USING-Struktur fuer Routing-Modul                               *
* H.J. OHM                                            13.02.1990  *
* Die Copystrecke ist fuer TTSA003 vorgesehen                     *
*                                                                 *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*----------------------> Message
     01      ROUT-SATZ.
       05    ROUT-CC             PIC S9(04) COMP.
          88 ROUT-OK                        VALUE 0.
          88 ROUT-NOT-OK                    VALUE 1 THRU 9999.
       05    ROUT-PAN            PIC X(11).
       05    ROUT-ID             PIC 99.
       05    ROUT-DTX            PIC X(16).
       05    ROUT-FREGATTE       PIC X(16).
       05    ROUT-KZSYNC         PIC X(1).

*******************************************************************

?section AS-ROUT-NEU
*******************************************************************
* USING-Struktur fuer Routing-Modul NEU                           *
* H.J. OHM                                            11.09.1990  *
* Die Copystrecke ist fuer TTSA003 vorgesehen                     *
* Neu mit Lade-Zeitpunkt, Laendercode + Branchenhauptschluessel   *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*----------------------> Message
     01      ROUT-SATZ.
       05    ROUT-CC             PIC S9(04) COMP.
          88 ROUT-OK                        VALUE 0.
          88 ROUT-NOT-OK                    VALUE 1 THRU 9999.
       05    ROUT-PAN            PIC X(11).
       05    ROUT-LCODE          PIC 9(03).
       05    ROUT-ID             PIC 99.
       05    ROUT-DTX            PIC X(16).
       05    ROUT-FREGATTE       PIC X(16).
       05    ROUT-KZSYNC         PIC X(1).

*******************************************************************

?section AS-ROUT-70
*******************************************************************
* USING-Struktur fuer Routing-Modul ZKA 7.0                       *
* H.J. OHM                                            05.02.2008  *
* Die Copystrecke ist fuer PS2ROUT vorgesehen                     *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*----------------------> Message
     01      ROUT70-SATZ.
       05    ROUT-CC             PIC S9(04) COMP.
          88 ROUT-OK                        VALUE 0.
          88 ROUT-NOT-OK                    VALUE 1 THRU 9999.
       05    ROUT-PAN            PIC X(12).
       05    ROUT-KZCARD         PIC 9(02).
          88 ROUT-GIROCARD       VALUE 01.
          88 ROUT-ALLIANCE       VALUE 02.
       05    ROUT-HBANK          PIC 9(08).
       05    ROUT-ASID           PIC S9(09) COMP.
       05    ROUT-LTGIND         PIC S9(04) COMP.
       05    ROUT-TABNR          PIC 99.
       05    ROUT-GG             PIC 99.
       05    ROUT-DTX            PIC X(16).
       05    ROUT-FREGATTE       PIC X(16).
       05    ROUT-KZSYNC         PIC X(1).

*******************************************************************


?section FREGAT
*******************************************************************
* Message fuer Linehandler FREGAT hier Datex-P-Leitungen          *
* J.Bahlmann                                          28.06.1990  *
* Das Feld FRE-LEN muss vom Programm mit 344 besetzt werden       *
* ACHTUNG: Bei Aenderung auch an FRESATZ denken!                  *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*----------------------> Laenge der Message
     05      "*"-LEN             PIC S9(04) COMP.
          88 FREGAT-LEN          VALUE 344.
*----------------------> Message
     05      "*"-SATZ.
      10     "*"-HEADER.
       15    "*"-CC              PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-READ-IL                    VALUE 1.
          88 "*"-WRITE-SL                   VALUE 2.
          88 "*"-AUFBAU-IL                  VALUE 3.
          88 "*"-ABBAU-SL                   VALUE 4.
          88 "*"-AUFBAU-BL                  VALUE 5.
          88 "*"-READ-AL                    VALUE 6.
          88 "*"-WRITE-AL                   VALUE 7.
          88 "*"-WRITEQ-AL                  VALUE 8.
          88 "*"-FREI-BL                    VALUE 9.
          88 "*"-SEND-ASYNC                 VALUE 10.
          88 "*"-SEND-SYNC                  VALUE 11.
          88 "*"-DISCON-TS                  VALUE 101.
          88 "*"-DISCON-TO                  VALUE 102.
          88 "*"-NO-CONNECT                 VALUE 103.
          88 "*"-NO-BL                      VALUE 104.
          88 "*"-MODEM-ERR                  VALUE 105.
          88 "*"-NO-ANSWER                  VALUE 106.
          88 "*"-UNS-MSG                    VALUE 107.
          88 "*"-APPL-DOWN                  VALUE 108.
          88 "*"-DIAGN-ANF                  VALUE 109.

       15    "*"-TERMID          PIC X(16).
       15    "*"-NEXTSERV        PIC X(16).
       15    "*"-LINE            PIC X(16).
       15    "*"-DATLEN          PIC S9(04) COMP.
       15    "*"-DTXNR           PIC X(16).
       15    "*"-CUGID           PIC 99.
       15    "*"-SESSNR          PIC S9(04) COMP.
       15    "*"-MONNAME         PIC X(16).
      10     "*"-NDATEN          PIC X(256).

?section FRESATZ
*******************************************************************
* Message fuer Linehandler FREGAT hier Datex-P-Leitungen          *
* H.J. OHM                                            28.06.1990  *
* Die Copystrecke ist direkt fuer $RECEIVE vorgesehen             *
* ACHTUNG: Bei Aenderung auch FREGAT-DTX aendern                  *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*----------------------> Message
     01      FRE-SATZ.
      10     FRE-HEADER.
       15    FRE-CC              PIC S9(04) COMP.
          88 FRE-OK                         VALUE 0.
          88 FRE-READ-IL                    VALUE 1.
          88 FRE-WRITE-SL                   VALUE 2.
          88 FRE-AUFBAU-IL                  VALUE 3.
          88 FRE-ABBAU-SL                   VALUE 4.
          88 FRE-AUFBAU-BL                  VALUE 5.
          88 FRE-READ-AL                    VALUE 6.
          88 FRE-WRITE-AL                   VALUE 7.
          88 FRE-WRITEQ-AL                  VALUE 8.
          88 FRE-FREI-BL                    VALUE 9.
          88 FRE-SEND-ASYNC                 VALUE 10.
          88 FRE-SEND-SYNC                  VALUE 11.
          88 FRE-DISCON-TS                  VALUE 101.
          88 FRE-DISCON-TO                  VALUE 102.
          88 FRE-NO-CONNECT                 VALUE 103.
          88 FRE-NO-BL                      VALUE 104.
          88 FRE-MODEM-ERR                  VALUE 105.
          88 FRE-NO-ANSWER                  VALUE 106.
          88 FRE-UNS-MSG                    VALUE 107.
          88 FRE-APPL-DOWN                  VALUE 108.
          88 FRE-DIAGN-ANF                  VALUE 109.

       15    FRE-TERMID          PIC X(16).
       15    FRE-NEXTSERV        PIC X(16).
       15    FRE-LINE            PIC X(16).
       15    FRE-DATLEN          PIC S9(04) COMP.
       15    FRE-DTXNR           PIC X(16).
       15    FRE-CUGID           PIC 99.
       15    FRE-SESSNR          PIC S9(04) COMP.
       15    FRE-MONNAME         PIC X(16).
      10     FRE-NDATEN          PIC X(256).

*******************************************************************

?section FREGAT-NEU
*******************************************************************
* Neue FREGAT Message fuer APCOME                                 *
* A.Willomat                                          02.10.1996  *
* Das Feld FRE-LEN muss vom Programm mit 364 besetzt werden       *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*----------------------> Laenge der Message
     05      "*"-LEN             PIC S9(04) COMP.
          88 FREGAT-LEN          VALUE 364.
*----------------------> Message
     05      "*"-SATZ.
      10     "*"-HEADER.
       15    "*"-CC              PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-READ-IL                    VALUE 1.
          88 "*"-WRITE-SL                   VALUE 2.
          88 "*"-AUFBAU-IL                  VALUE 3.
          88 "*"-ABBAU-SL                   VALUE 4.
          88 "*"-AUFBAU-BL                  VALUE 5.
          88 "*"-READ-AL                    VALUE 6.
          88 "*"-WRITE-AL                   VALUE 7.
          88 "*"-WRITEQ-AL                  VALUE 8.
          88 "*"-FREI-BL                    VALUE 9.
          88 "*"-SEND-ASYNC                 VALUE 10.
          88 "*"-SEND-SYNC                  VALUE 11.
          88 "*"-DISCON-TS                  VALUE 101.
          88 "*"-DISCON-TO                  VALUE 102.
          88 "*"-NO-CONNECT                 VALUE 103.
          88 "*"-NO-BL                      VALUE 104.
          88 "*"-MODEM-ERR                  VALUE 105.
          88 "*"-NO-ANSWER                  VALUE 106.
          88 "*"-UNS-MSG                    VALUE 107.
          88 "*"-APPL-DOWN                  VALUE 108.
          88 "*"-DIAGN-ANF                  VALUE 109.

       15    "*"-TERMID          PIC X(16).
       15    "*"-NEXTSERV        PIC X(16).
       15    "*"-LINE            PIC X(36).
       15    "*"-DATLEN          PIC S9(04) COMP.
       15    "*"-DTXNR           PIC X(16).
       15    "*"-CUGID           PIC 99.
       15    "*"-SESSNR          PIC S9(04) COMP.
       15    "*"-MONNAME         PIC X(16).
      10     "*"-NDATEN          PIC X(256).


?section FREGAT-NEU-XXL
*******************************************************************
* Neue FREGAT Message fuer APCOME                                 *
* hjo                                                 22.08.2003  *
* mit extra-langen ndaten                                         *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*----------------------> Laenge der Message
     05      "*"-LEN             PIC S9(04) COMP.
          88 FREGAT-LEN          VALUE 364.
*----------------------> Message
     05      "*"-SATZ.
      10     "*"-HEADER.
       15    "*"-CC              PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-READ-IL                    VALUE 1.
          88 "*"-WRITE-SL                   VALUE 2.
          88 "*"-AUFBAU-IL                  VALUE 3.
          88 "*"-ABBAU-SL                   VALUE 4.
          88 "*"-AUFBAU-BL                  VALUE 5.
          88 "*"-READ-AL                    VALUE 6.
          88 "*"-WRITE-AL                   VALUE 7.
          88 "*"-WRITEQ-AL                  VALUE 8.
          88 "*"-FREI-BL                    VALUE 9.
          88 "*"-SEND-ASYNC                 VALUE 10.
          88 "*"-SEND-SYNC                  VALUE 11.
          88 "*"-DISCON-TS                  VALUE 101.
          88 "*"-DISCON-TO                  VALUE 102.
          88 "*"-NO-CONNECT                 VALUE 103.
          88 "*"-NO-BL                      VALUE 104.
          88 "*"-MODEM-ERR                  VALUE 105.
          88 "*"-NO-ANSWER                  VALUE 106.
          88 "*"-UNS-MSG                    VALUE 107.
          88 "*"-APPL-DOWN                  VALUE 108.
          88 "*"-DIAGN-ANF                  VALUE 109.

       15    "*"-TERMID          PIC X(16).
       15    "*"-NEXTSERV        PIC X(16).
       15    "*"-LINE            PIC X(36).
       15    "*"-DATLEN          PIC S9(04) COMP.
       15    "*"-DTXNR           PIC X(16).
       15    "*"-CUGID           PIC 99.
       15    "*"-SESSNR          PIC S9(04) COMP.
       15    "*"-MONNAME         PIC X(16).
      10     "*"-NDATEN          PIC X(1500).


?section FREGAT-XXX
*******************************************************************
* Neue FREGAT Message fuer WZAST60                                *
* hjo                                                 27.04.2010  *
* mit extra-extra-langen ndaten                                   *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*----------------------> Laenge der Message
     05      "*"-LEN             PIC S9(04) COMP.
*----------------------> Message
     05      "*"-SATZ.
      10     "*"-HEADER.
       15    "*"-CC              PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-READ-IL                    VALUE 1.
          88 "*"-WRITE-SL                   VALUE 2.
          88 "*"-AUFBAU-IL                  VALUE 3.
          88 "*"-ABBAU-SL                   VALUE 4.
          88 "*"-AUFBAU-BL                  VALUE 5.
          88 "*"-READ-AL                    VALUE 6.
          88 "*"-WRITE-AL                   VALUE 7.
          88 "*"-WRITEQ-AL                  VALUE 8.
          88 "*"-FREI-BL                    VALUE 9.
          88 "*"-SEND-ASYNC                 VALUE 10.
          88 "*"-SEND-SYNC                  VALUE 11.
          88 "*"-DISCON-TS                  VALUE 101.
          88 "*"-DISCON-TO                  VALUE 102.
          88 "*"-NO-CONNECT                 VALUE 103.
          88 "*"-NO-BL                      VALUE 104.
          88 "*"-MODEM-ERR                  VALUE 105.
          88 "*"-NO-ANSWER                  VALUE 106.
          88 "*"-UNS-MSG                    VALUE 107.
          88 "*"-APPL-DOWN                  VALUE 108.
          88 "*"-DIAGN-ANF                  VALUE 109.

       15    "*"-TERMID          PIC X(16).
       15    "*"-NEXTSERV        PIC X(16).
       15    "*"-LINE            PIC X(36).
       15    "*"-DATLEN          PIC S9(04) COMP.
       15    "*"-DTXNR           PIC X(16).
       15    "*"-CUGID           PIC 99.
       15    "*"-SESSNR          PIC S9(04) COMP.
       15    "*"-MONNAME         PIC X(16).
      10     "*"-NDATEN          PIC X(3500).



?section MSGROOT
*******************************************************************
* MSGROOT    Message-Beschreibung zwischen Batch-Requestoren      *
*            und Batch-Root-Modulen                               *
* ACHTUNG:   Bei Aenderung auch an MSGROOT1 denken !!!            *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*                                    Funktion
     05      "*"-FKT             PIC S9(04) COMP.
*                                    Syskey fuer DAKT
     05      "*"-KEY             PIC S9(18) COMP.
     05      "*"-LOGPROTD        PIC 99.
*                                    Leitungsart (D=Dtx-P,W=Waehl)
*    05      "*"-LART            PIC X.
     05      "*"-LART            PIC X(02).
     05      "*"-RESTART         PIC X.
     05      "*"-DEVICE.
      10     "*"-SYSTEM          PIC X(08).
      10     "*"-DEV             PIC X(08).
      10     "*"-SUBDEV          PIC X(08).
      10     "*"-DATEI           PIC X(08).
*                                    TCP-Name
     05      "*"-TCP             PIC X(06).
*                                    Requestor-Name
     05      "*"-REQ             PIC X(08).

?section MSGROOT1
*******************************************************************
* MSGROOT    Message-Beschreibung zwischen Batch-Requestoren      *
*            und Batch-Root-Modulen / fuer Requestor !!           *
* ACHTUNG:   Bei Aenderung auch an MSGROOT denken !!              *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
  01         UMP-MESSAGE.
*                                    Funktion
     05      UMP-FKT             PIC S9(04) COMP.
*                                    Syskey fuer DAKT
     05      UMP-KEY             PIC S9(18) COMP.
     05      UMP-LOGPROTD        PIC 99.
*                                    Leitungsart (D=Dtx-P,W=Waehl)
*    05      UMP-LART            PIC X.
     05      UMP-LART            PIC X(02).
     05      UMP-RESTART         PIC X.
     05      UMP-DEVICE.
      10     UMP-SYSTEM          PIC X(08).
      10     UMP-DEV             PIC X(08).
      10     UMP-SUBDEV          PIC X(08).
      10     UMP-DATEI           PIC X(08).
*                                    TCP-Name
     05      UMP-TCP             PIC X(06).
*                                    Requestor-Name
     05      UMP-REQ             PIC X(08).


?section STARTMSG
*******************************************************************
* STARTMSG   MESSAGE vom Dummy-Requestor zum Batch-DFUE-Manager   *
*            der als Server unter Pathway laeuft                  *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*
      05  "*"-CODE                  PIC S9(04) COMP.
      05  "*"-KOMMANDO              PIC X(10).
       88 "*"-RESTART                          VALUE "RESTART".
       88 "*"-SHUTDOWN                         VALUE "SHUTDOWN".
       88 "*"-START                            VALUE "START".
*

?section STOPMSG
*******************************************************************
* STOPMSG    REPLY von DFUE-Rootmodulen an den rufenden           *
*            Requestor,fuer den Endefall                          *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*
      05  "*"-CODE                  PIC S9(04) COMP.
      05  "*"-KOMMANDO              PIC X(10).
       88 "*"-ABORT                            VALUE "ABORT".
       88 "*"-SHUTDOWN                         VALUE "SHUTDOWN".
*
?section STR2NUMC
************************************************************************
* erstellt am      : 13.02.2015
* letzte Aenderung : 13.02.2015
* Beschreibung     : Schnittstelle zum Modul STR2NUM
*                    Konvertierung von einem String zu einem Numerischen Feld
*
* Aenderungen      :
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar
*-------|---------|-----|----------------------------------------*
*-------|---------|-----|----------------------------------------*
*A.01.00|20150213 | cb  | Neuerstellung
*----------------------------------------------------------------*
 01       "*"-STR2NUMC.
    05    "*"-RCODE              PIC S9(04) COMP.
       88 "*"-OK                     VALUE ZERO.
       88 "*"-FERR                   VALUE -1.
       88 "*"-TERR                   VALUE -9998.
       88 "*"-CERR                   VALUE -9999.
    05    "*"-X18                PIC X(18).
    05    "*"-N18                PIC S9(15)V999.
    05    "*"-ANFANG             PIC 9(02).
    05    "*"-LAENGE             PIC 9(02).

?section SYSWKZ0C
************************************************************************
* erstellt am      : 23.11.2007
* letzte Aenderung : 08.02.2008
* Beschreibung     : Schnittstelle zum Modul SYSWKZ0
*                    Pruefen LKZm, WKZ und Waehrungsumrechnung
*
* Aenderungen      :
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar
*-------|---------|-----|----------------------------------------*
*       |20080208 | jb  | Neues CMD ..-WKZ-A: Umsetzung num. WKZ
*       |         |     | in alpha WKZ. Feld BETRAG dafuer redef.
*-------|---------|-----|----------------------------------------*
*A.01.00|20071123 | jb  | Neuerstellung
*----------------------------------------------------------------*
*
*
*
*    Feld RCODE    : 0    -  OK
*                    1    -  LKZ nicht zugelassen
*                    2    -  WKZ nicht zugelassen
*                    3    -  WKZ-N nicht zugelassen
*                    4    -  kein Kurs fuer WKZ vorhanden
*                    5    -  kein Kurs fuer WKZ-N vorhanden
*                    254  -  ungueltiger Wert fuer CMD
*                    255  -  sonstiger Fehler
*
*    Feld CMD      : ..-CMD-INIT     Tabellen initialisieren / laden
*                    ..-CMD-LKZ      pruefen nur Laenderkennzeichen
*                    ..-CMD-WKZ      pruefen nur Waehrungskennzeichen
*                    ..-CMD-KONV     umrechnen Betrag von WKZ nach WKZ-N
*                                    (diese Fkt. schliesst die Pruefung
*                                    der beiden Waehrungen ein)
*                    ..-CMD-LKZ-WKZ  Funktionen ..-CMD-LKZ und ..-CMD-WKZ
*                    ..-CMD-LKZ-KONV Funktionen ..-CMD-LKZ und ..-CMD-KONV
*                    ..-CMD-WKZ-A    liefert alpha WKZ in ..-WKZ-A
*                                    zu num. Wert in ..-WKZ
*
*    Feld MESSAGE  : LKZ     - Laenderkennzeichen
*                    WKZ     - Waehrungskennzeichen (Ausgangswaehrung)
*                    WKZ-N   - Waehrungskennzeichen (Zielwaehrung)
*                              (wenn 0, dann wird 978 / EUR angenommen)
*                    BETRAG  - umzurechnender/umgerechneter Betrag
*                    WKZ-A   - alpha WKZ (redefinierter BETRAG)
*
*
*
************************************************************************
*
 01          "*"-SYSWKZ0C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-LKZ-NOK                    VALUE 1.
          88 "*"-WKZ-NOK                    VALUE 2.
          88 "*"-WKZ-N-NOK                  VALUE 3.
          88 "*"-KURS-NOK                   VALUE 4.
          88 "*"-KURS-N-NOK                 VALUE 5.
          88 "*"-CMDERR                     VALUE 254.
          88 "*"-DIVERR                     VALUE 255.

     05      "*"-CMD             PIC S9(04) COMP.
          88 "*"-CMD-OK                     VALUE 1 thru 6.
          88 "*"-CMD-INIT                   VALUE 1.
          88 "*"-CMD-LKZ                    VALUE 2.
          88 "*"-CMD-WKZ                    VALUE 3.
          88 "*"-CMD-KONV                   VALUE 4.
          88 "*"-CMD-LKZ-WKZ                VALUE 5.
          88 "*"-CMD-LKZ-KONV               VALUE 6.
          88 "*"-CMD-WKZ-A                  VALUE 7.

     05      "*"-MESSAGE.
      10     "*"-LKZ             PIC S9(04) COMP.
      10     "*"-WKZ             PIC S9(04) COMP.
      10     "*"-WKZ-N           PIC S9(04) COMP.
      10     "*"-BETRAG          PIC S9(16)V99 COMP.
      10     "*"-INFO  redefines "*"-BETRAG.
       15    "*"-WKZ-A           PIC X(03).
       15    "*"-LKZ-A           PIC X(03).
       15                        PIC X(02).


?section UMP-MESS1
*******************************************************************
* UMP-MESS1  Message-Beschreibung zwischen Batch-DFUE-Mananger    *
*            und Batch-Requestor ** UNSOLICITED MESSAGE **        *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*
  FD  TCP  LABEL RECORD OMITTED
           RECORD IS VARYING IN SIZE.

  01  UMP-MESSAGE.
      02  UMP-HEADER.
          05 PROTOCOL-ID            PIC  9(04) COMP.
          05 MSG-ID                 PIC  9(04) COMP.
          05 MSG-VERSION            PIC  9(04) COMP.
          05 MSG-HEADER-LEN         PIC  9(04) COMP.
          05 MSG-DEST-NODE          PIC X(08).
          05 MSG-DEST-TCP-NAME      PIC X(06).
          05 MSG-DEST-TERM-NAME     PIC X(15).
          05 FILLER                 PIC X.
          05 MSG-SEQUENCE-NUM       PIC  9(04) COMP.
      02  UMP-NACHRICHT.

?section UMP-MESS2
*******************************************************************
* UMP-MESS2  Message-REPLY zwischen Batch-Requestor  und          *
*            Batch-DFUE-Manager  ** UNSOLICITED MESSAGE **        *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*
  01  UNSO-1.
      02  UNSO-MSG-REPLY-HDR.
          05 MSG-ID                 PIC S9(04) COMP.
          05 REPLY-ID               PIC S9(04) COMP.
          05 REPLY-VERSION          PIC S9(04) COMP.
          05 REPLY-HDR-LEN          PIC S9(04) COMP.
          05 ERROR-CODE             PIC S9(04) COMP.
          05 INFO1                  PIC S9(04) COMP.
          05 INFO2                  PIC S9(04) COMP.
          05 REPLY-SEQU-NUM         PIC S9(04) COMP.
      02  WS-UEBERGABE.

?section TSYS010IFC
***********************************************************************
*                                                                     *
*   Beschreibung der Linkagebereiche fuer TSYS010 (Bitfummler)        *
* ============================================================        *
* Autor       : Hanse Consult - Th. Spitzmann                         *
* Datum       : 05-DEC-1990                                           *
*---------------------------------------------------------------------*
*                         Aenderungshistorie                          *
*                                                                     *
* 31.01.91 A00.01                                                     *
* 27.05.91 A00.02                                                     *
*                                                                     *
***********************************************************************                                                  ******

* Gueltige Werte fuer RETURN-CODE sind:
*         0  - Bearbeitung erfolgreich (kein Fehler)
*         10 - Formatfehler in ISO Nachricht
*         11 - Formatfehler in COBOL Nachricht
*
*         20 bis 84 - Das entsprechende Bit (Fehlernummer - 20)
*                     in der Bitmap wurde gesetzt, aber das
*                     zugehoerige Datenfeld ist bis dato nicht
*                     definiert...
*
*         93 - Falsche Dialogart in Bimaptposition 60 uebergeben,
*              erlaubt sind momentan:
*                                      200/210
*                                      400/410
*                                      810
*         94 - Unzulaessiger Nachrichtentyp uebergeben, erlaubt
*              sind momentan:
*                              0200/0210
*                              0400/0410
*                              0800/0810
*                              9000/9010
*                              9020/9030
*         95 - 2. Bytemap uebergeben, wird aber zur Zeit nicht
*              genutzt.
*         96 - 2. Bitmap uebergeben, wird aber zur Zeit nicht
*              genutzt.
*         97 - ISO Msg Laenge > 300
*         98 - Falscher Opcode uebergeben
*         99 - Fataler Fehler in Routine
    05 "*"-RETURN-CODE                         PIC S9(4) COMP.

* OP-CODE kann folgende Werte annehmen:
*  0 - Konvertierung von ISO -> COBOL
*  5 - Konvertierung von ISO -> COBOL mit UNPACK der BMP 2, 34, 47
*  1 - Konvertierung von COBOL -> ISO
*  6 - Reserviert (momentan jedoch nicht belegt)
    05 "*"-OP-CODE                             PIC S9(04) COMP.

* ISO-LEN gibt die zu erwartende Laenge der ISO Message an.
* Ueber ISO-LEN ist auch eine eingeschraenkte Fehlererkennung
* moeglich.
     05 "*"-ISO-MSG.
        10 "*"-ISO-LEN                          PIC S9(4) COMP.
        10 "*"-ISO-DATA                         PIC X(300).

     05 "*"-COB-MSG.
         10 "*"-MSG-TYPE-TMP.
            15 "*"-MSG-TYPE                     PIC S9(8) COMP.
         10 "*"-BYTEMAP-1                       PIC X(64).
         10 "*"-MSG-DATA.

* BMP-1
            15 "*"-BYTEMAP-2                    PIC X(64).

* Die im folgenden aufgefuehrten Variablen besitzen nachstehende
* Namenskennung:
* X-VarName, wobei X die Werte I ode C annehmen kann, wobei
* I = ISO und
* C = COBOL bedeuten.
*
* ----------------------------------------------------------------
* X-PAN-Y beschreibt das PAN Feld (Br.hauptschluessel != 59):
*          X kann I ODER C sein; I = ISO, C = COBOL
*          Y kann A ODER I sein; A = Ausland, I = Inland
* BMP-2
            15 "*"-I-PAN-A-LEN                  PIC 99.
            15 "*"-I-PAN-A                      PIC X(10).
            15 "*"-I-PAN-A-UNPACK               PIC X(20).
*            15 "*"-C-PAN-A                     PIC entfaellt

* BMP-3
            15 "*"-I-ABWICKLUNG                 PIC X(3).
            15 "*"-C-ABWICKLUNG                 PIC 9(6).

* BMP-4
            15 "*"-I-TRANS-BETRAG               PIC X(6).
            15 "*"-C-TRANS-BETRAG               PIC 9(12).

* BMP-11
            15 "*"-I-TRACE-NR                   PIC X(3).
            15 "*"-C-TRACE-NR                   PIC 9(6).

* BMP-12
            15 "*"-I-LOK-ZEIT                   PIC X(3).
            15 "*"-C-LOK-ZEIT                   PIC 9(6).

* BMP-13
            15 "*"-I-LOK-DATUM                  PIC X(2).
            15 "*"-C-LOK-DATUM                  PIC 9(4).

* BMP-14
            15 "*"-I-VERFALL                    PIC X(2).
            15 "*"-C-VERFALL                    PIC 9(4).

* BMP-20
            15 "*"-I-COUNTRY-CODE               PIC X(2).
            15 "*"-C-COUNTRY-CODE               PIC 9(4).

* BMP-23
            15 "*"-I-KARTEN-FOLGE               PIC X(2).
            15 "*"-C-KARTEN-FOLGE               PIC 9(4).

* BMP-25
            15 "*"-I-COND-CODE                  PIC X.
            15 "*"-C-COND-CODE                  PIC 99.

* BMP-26
            15 "*"-I-PIN-ANZAHL                 PIC X.
            15 "*"-C-PIN-ANZAHL                 PIC 99.

* BMP-33
            15 "*"-I-AS-ID-LEN                  PIC 99.
            15 "*"-I-AS-ID-DATA                 PIC X(3).
            15 "*"-C-AS-ID                      PIC 9(6).

* X-PAN-Y beschreibt das PAN Feld (Br.hauptschluessel = 59):
*          X kann I ODER C sein; I = ISO, C = COBOL
*          Y kann A ODER I sein; A = Ausland, I = Inland
* BMP-34
            15 "*"-I-PAN-I-LEN                  PIC 99.
            15 "*"-I-PAN-I-DATA                 PIC X(11).
            15 "*"-I-PAN-I-UNPACK               PIC X(22).
*            15 "*"-C-PAN-I                      PIC entfaellt.

* BMP-35
            15 "*"-I-TRACK-2-LEN                PIC 99.
            15 "*"-I-TRACK-2-DATA               PIC X(19).
*            15 "*"-C-TRACK-2                    PIC entfaellt.
            15 "*"-I-TRACK-2-UNPACK             PIC X(38).

* BMP-37
            15 "*"-I-POS-NR                     PIC X(6).
            15 "*"-C-POS-NR                     PIC 9(12).

* BMP-39
            15 "*"-I-ANTWORT-CODE               PIC X.
            15 "*"-C-ANTWORT-CODE               PIC 99.

* BMP-41
            15 "*"-I-TERMINAL-ID                PIC X(4).
            15 "*"-C-TERMINAL-ID-NUM            PIC 9(8).

* BMP-47
            15 "*"-I-CARD-ELEM-LEN              PIC 9(3).
            15 "*"-I-CARD-ELEM-DATA             PIC X(11).
            15 "*"-I-CARD-ELEM-UNPACK           PIC X(22).
*            15 "*"-C-CARD-ELEM-DATA             PIC entfaellt.

* BMP-48
            15 "*"-I-SICHERHEIT-LEN             PIC 9(3).
            15 "*"-I-SICHERHEIT-DATA            PIC X(17).
            15 "*"-C-SICHERHEIT.
               20 "*"-CROSS-DOMAIN              PIC X(08).
               20 "*"-PAC-KEY                   PIC X(08).
               20 "*"-GEN-NUMMER                PIC 99.

* BMP-52
           15 "*"-I-PAC                        PIC X(8).
           15 "*"-C-PAC                        PIC X(16).

* BMP-57
           15 "*"-I-VERSCH-PARAM-LEN           PIC 9(3).
           15 "*"-I-VERSCH-PARAM-DATA          PIC X(9).
           15 "*"-C-VERSCH-PARAM.
              20 "*"-SCHL-INDEX                PIC S9(18) COMP.
              20 "*"-GEN-NUMMER                PIC 99.

* BMP-59
           15 "*"-I-AUTOR-MERKMAL-LEN          PIC 9(3).
           15 "*"-I-AUTOR-MERKMAL-DATA         PIC X(8).
           15 "*"-C-AUTOR-MERKMAL              PIC X(16).

* BMP-60
           15 "*"-I-SPEZ-DIALOG-LEN            PIC 9(3).
           15 "*"-I-SPEZ-DIALOG-DATA           PIC X(99).
           15 "*"-C-SPEZ-DIALOG.
              20 "*"-C-200-400                 PIC X(16).
              20 "*"-C-210-410.
                 25 "*"-C-LEN                  PIC 99.
                 25 "*"-C-DATA                 PIC X(99).
              20 "*"-C-810.
                 25 "*"-C-LEN                  PIC 99.
                 25 "*"-C-DATA                 PIC X(80).
                 25 "*"-C-FLOOR                PIC X(16).
                 25 "*"-C-OFFLINE              PIC X.

* Die Felder C-RND1-SIG2 und SIG1-SCHLINDEX beinhalten je nach
* gerade bearbeitetem Teil der Initialisierung die entsprechenden
* Zufallszahlen, Signaturen oder Schluesselindizes...
              20 "*"-C-9000.
                 25 "*"-C-RND1.
                    30 "*"-C-RND1-SIG2         PIC S9(18) COMP.
              20 "*"-C-9010.
                 25 "*"-C-SIG1-RND2.
                    30 "*"-SIG1-SCHLINDEX      PIC S9(18) COMP.
                    30 "*"-RND2                PIC S9(18) COMP.

* Gesamtlaenge des 9020 Datensatzes betraegt 53 Bytes...
              20 "*"-C-9020.
                 25 "*"-C-BELEG-NR-V           PIC S9(4) COMP.
                 25 "*"-C-BELEG-NR-B           PIC S9(4) COMP.
                 25 "*"-C-UMSATZ-EC-I.
                    30 "*"-UMSATZ-EC-I-ANZ     PIC S9(4) COMP.
                    30 "*"-UMSATZ-EC-I-SUM     PIC S9(4) COMP.

                 25 "*"-C-UMSATZ-EC-A.
                    30 "*"-UMSATZ-EC-A-ANZ     PIC S9(4) COMP.
                    30 "*"-UMSATZ-EC-A-SUM     PIC S9(4) COMP.

                 25 "*"-C-UMSATZ-EURO.
                    30 "*"-UMSATZ-EURO-ANZ     PIC S9(4) COMP.
                    30 "*"-UMSATZ-EURO-SUM     PIC S9(4) COMP.

                 25 "*"-C-UMSATZ-AMEX.
                    30 "*"-UMSATZ-AMEX-ANZ     PIC S9(4) COMP.
                    30 "*"-UMSATZ-AMEX-SUM     PIC S9(4) COMP.

                 25 "*"-C-UMSATZ-VISA-I.
                    30 "*"-UMSATZ-VISA-ANZ     PIC S9(4) COMP.
                    30 "*"-UMSATZ-VISA-SUM     PIC S9(4) COMP.

                 25 "*"-C-UMSATZ-DINE.
                    30 "*"-UMSATZ-DINE-ANZ     PIC S9(4) COMP.
                    30 "*"-UMSATZ-DINE-SUM     PIC S9(4) COMP.

                 25 "*"-C-UMSATZ-FREI.
                    30 "*"-UMSATZ-FREI-ANZ     PIC S9(4) COMP.
                    30 "*"-UMSATZ-FREI-SUM     PIC S9(4) COMP.


* BMP-63
           15 "*"-I-FEHLER-ZAEHLER-LEN         PIC 9(3).
           15 "*"-I-FEHLER-ZAEHLER-DATA        PIC X(1).
           15 "*"-C-FEHLER-ZAEHLER             PIC 99.

* BMP-64
           15 "*"-I-MAC                        PIC X(8).
           15 "*"-C-MAC                        PIC X(8).
           15 "*"-C-MAC-UNPACK                 PIC X(16).
*****************************************************************

?section PSYS020IFC
* **********************************************************************
*                   PSYS020 Datenschnittstelle V1.0                    *
* ---------------------------------------------------------------------*
* Author      :  Hanse Consult - Th.Spitzmann                          *
* Date created:  04-Mar-1991                                           *
*----------------------------------------------------------------------*
*                         Aenderungshistorie                           *
*                                                                      *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT      *
*                                                                      *
************************************************************************
*
* -------------------------------------------------------------------- *
*                A l l g e m e i n e   F e h l e r                     *
* -------------------------------------------------------------------- *
*
 01 GEN-ERROR.
     05 ERR-STAT                         PIC S9(4) COMP.
     05 MODUL-NAME                       PIC X(8).
     05 ERROR-KZ                         PIC X(2).
     05 ERROR-NR                         PIC S9(9) COMP.
     05 DATEN-BUFFER-ERROR.
        10 DATEN-BUFFER1                 PIC X(80).
        10 DATEN-BUFFER2                 PIC X(80).
        10 DATEN-BUFFER3                 PIC X(80).
        10 DATEN-BUFFER4                 PIC X(80).
        10 DATEN-BUFFER5                 PIC X(80).
* Es folgen applikationsspezifische Daten.
* Dieser Record muss fuer andere Applikationen angepasst werden.
     05 APPL-SPEC-BUF.
        10 MDNR                          PIC 9(8).
        10 TSNR                          PIC 9(8).
        10 TERMID                        PIC X(4).
*
* End of Interface
**********************************************************************


?SECTION SCS-PARM
*******************************************************************
* SCS-PARM (Serverclass-Send-Parameter)               13.12.1994  *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************

     05  "*"-MON             PIC X(15).
     05  "*"-MON-LEN         PIC S9(04) COMP.
     05  "*"-SRV             PIC X(15).
     05  "*"-SRV-LEN         PIC S9(04) COMP.
     05  "*"-MSG-LEN         PIC S9(04) COMP.
     05  "*"-REP-LEN         PIC S9(04) COMP.
     05  "*"-REP-LEN-MAX     PIC S9(04) COMP.
     05  "*"-TIMEOUT         PIC S9(04) COMP.
     05  "*"-RCODE           PIC S9(04) COMP.
         88  "*"-RCODE-OK                      VALUE ZERO.


?SECTION SCS-INFO
*******************************************************************
* SCS-INFO  (Serverclass-Send-Error-Auswertung)       13.12.1994  *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************

     05  "*"-SEND-ERR             PIC S9(04) COMP.
     05  "*"-FS-ERR               PIC S9(04) COMP.

?section WSYS015C
*****************************************************************
* Autor            : Joachim Bahlmann
* erstellt am      : 14.02.2003
* letzte Aenderung :
* letzte Version   : A.01.00
* Beschreibung     : Schnittstelle zum Modul WSYS015 ISO-8583
*
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    129 -   Fehler im Nachrichtentyp (nicht numerisch)
*                    240 -   ungueltiger Wert fuer CMD
*                    241 -   ungueltiger Wert fuer VERF
*                    242 -   ungueltiger Wert fuer BMP
*                    243 -   Laden der ISO-Tabelle nicht moeglich
*                    244 -   Fehler in der ISO-Tabelle ISO8583
*                    245 -   BMP darf nicht kleiner werden
*                    246 -   Bit fuer angefordertes Feld nicht gesetzt
*                    251 -   fehlerhafte Laengenangabe
*                    252 -   Bitmap nicht korrekt/ungueltig
*                    253 -   sonstiger Fehler ISO-Feld
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*
*    Feld CMD      : 1   -   Laden alle Verfahrenstabellen
*                    11  -   Konvertierung von ISO nach COBOL
*                    12  -   Konvertierung von ISO nach COBOL mit
*                            UNPACK der Felder: BMP 2,34,35,47,64
*                    13  -   Konvertierung von COBOL nach ISO
*
*    Feld VERF     : 1   -   electronic cash / POZ
*                    2   -   Maestro
*                    3   -   GICC / KAAI
*                    4   -   OPT
*                    5   -   NN
*
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld ISOPTR   : O       Aufsetzpointer fuer ISO Untersuchung
*                            (muss vom rufenden Programm bei jeder
*                            NEUEN Nachricht auf 0 gesetzt werden)
*
*    Feld BMP      : I       zurueckzugebendes Feld ISO -> COBOL bzw.
*                            anzuhaengedes Feld COBOL -> ISO
*
*                            Bei ISO -> COBOL:
*                                -1 = Der Nachrichtentyp wird zurueckgegeben
*                                 0 = Die Prim. Bitmap wird als Bytemap
*                                     zurueckgegeben
*                                >0 = Das entsprechende BMP-Feld wird
*                                     zurueckgegeben
*
*                            Bei COBOL -> ISO:
*                                -1 = ISOSTRING wird geloescht,
*                                     Nachrichtentyp in ISOSTRING gestellt
*                                 0 = Bytemap umwandeln in Bitmap und
*                                     an den ISOSTRING anhaengen
*                                >0 = Jeweiliges Feld umwandeln, anhaengen
*
*    Feld BMPLEN   : I/O     Laenge des ISO-Feldes
*
*    Feld BMPVAL   : I/O     ISO-Feld
*
*    Feld COBLEN   : I/O     Laenge des COBOL-Feldes
*
*    Feld COBVAL   : I/O     COBOL-Feld
*
*                     * aus Sicht WSYS015
*
*
*
* Aenderungen      :
*
* A.01.10 - 08.10.1996  Feld ISOSTRING auf 512 Bytes erweitert
*
*
*****************************************************************
*
 01          "*"-WSYS015C.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-VERFERR                    VALUE  241.
          88 "*"-BMPERR                     VALUE  242.
          88 "*"-LADERR                     VALUE  243.
          88 "*"-ISOTABERR                  VALUE  244.
          88 "*"-FOLGERR                    VALUE  245.
          88 "*"-BITERR                     VALUE  246.
          88 "*"-LENERR                     VALUE  251.
          88 "*"-MAPERR                     VALUE  252.
          88 "*"-ISOERR                     VALUE  253.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-INIT                       VALUE    1.
          88 "*"-ISO2COB                    VALUE   11.
          88 "*"-ISO2COBP                   VALUE   12.
          88 "*"-COB2ISO                    VALUE   13.

      10     "*"-VERF            PIC S9(04) COMP.
          88 "*"-VERFNOK                    VALUE -9999 THRU    0
                                                      6 THRU 9999.
          88 "*"-EC                         VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-NN                         VALUE    5.

     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(512).
      10     "*"-ISOPTR          PIC S9(04) COMP.
      10     "*"-BMP             PIC S9(04) COMP.
          88 "*"-BMPNOK                     VALUE -9999 THRU   -2
                                                    129 THRU 9999.
      10     "*"-BMPLEN          PIC S9(04) COMP.
      10     "*"-BMPVAL          PIC  X(256).
      10     "*"-COBLEN          PIC S9(04) COMP.
      10     "*"-COBVAL          PIC  X(256).

?section WSYS016C
*****************************************************************
* Autor            : Joachim Bahlmann
* Letzte Aenderung :: 2006-08-18
* Letzte Version   :: A.01.01
* Kurzbeschreibung :: Schnittstelle zum Modul WSYS016 ISO-8583
*
*                    Uebernahme aus WSYS015C - Verlaengerung der
*                    max. moeglichen Feldgroesse auf 512 Bytes und
*                    der max. Nachrichtenlaenge auf 1024 Bytes
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    129 -   Fehler im Nachrichtentyp (nicht numerisch)
*                    240 -   ungueltiger Wert fuer CMD
*                    241 -   ungueltiger Wert fuer VERF
*                    242 -   ungueltiger Wert fuer BMP
*                    243 -   Laden der ISO-Tabelle nicht moeglich
*                    244 -   Fehler in der ISO-Tabelle ISO8583
*                    245 -   BMP darf nicht kleiner werden
*                    246 -   Bit fuer angefordertes Feld nicht gesetzt
*                    251 -   fehlerhafte Laengenangabe
*                    252 -   Bitmap nicht korrekt/ungueltig
*                    253 -   sonstiger Fehler ISO-Feld
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*                    1nnn -  BMP nnn nicht numerisch
*                    2nnn -  BMP nnn laenger als max. Laenge in ISO-Tab
*                            nur var. Felder
*
*    Feld CMD      : 1   -   Laden alle Verfahrenstabellen
*                    11  -   Konvertierung von ISO nach COBOL
*                    12  -   Konvertierung von ISO nach COBOL mit
*                            UNPACK der Felder: BMP 2,34,35,47,64
*                    13  -   Konvertierung von COBOL nach ISO
*
*    Feld VERF     : 1   -   electronic cash / POZ      Verf1
*                    2   -   Maestro                    Verf2
*                    3   -   GICC / KAAI                Verf3
*                    4   -   OPT                        Verf4
*                    5   -   NN                         Verf5
*
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld ISOPTR   : O       Aufsetzpointer fuer ISO Untersuchung
*                            (muss vom rufenden Programm bei jeder
*                            NEUEN Nachricht auf 0 gesetzt werden)
*
*    Feld BMP      : I       zurueckzugebendes Feld ISO -> COBOL bzw.
*                            anzuhaengedes Feld COBOL -> ISO
*
*                            Bei ISO -> COBOL:
*                                -1 = Der Nachrichtentyp wird zurueckgegeben
*                                 0 = Die Prim. Bitmap wird als Bytemap
*                                     zurueckgegeben
*                                >0 = Das entsprechende BMP-Feld wird
*                                     zurueckgegeben
*
*                            Bei COBOL -> ISO:
*                                -1 = ISOSTRING wird geloescht,
*                                     Nachrichtentyp in ISOSTRING gestellt
*                                 0 = Bytemap umwandeln in Bitmap und
*                                     an den ISOSTRING anhaengen
*                                >0 = Jeweiliges Feld umwandeln, anhaengen
*
*    Feld BMPLEN   : I/O     Laenge des ISO-Feldes
*
*    Feld BMPVAL   : I/O     ISO-Feld
*
*    Feld COBLEN   : I/O     Laenge des COBOL-Feldes
*
*    Feld COBVAL   : I/O     COBOL-Feld
*
*                     * aus Sicht WSYS016
*
*
*
* Aenderungen      :
*
*
*
*****************************************************************
*
 01          "*"-WSYS016C.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-NUMERR                     VALUE  1000 THRU  1128.
          88 "*"-MAXLENERR                  VALUE  2000 THRU  2128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-VERFERR                    VALUE  241.
          88 "*"-BMPERR                     VALUE  242.
          88 "*"-LADERR                     VALUE  243.
          88 "*"-ISOTABERR                  VALUE  244.
          88 "*"-FOLGERR                    VALUE  245.
          88 "*"-BITERR                     VALUE  246.
          88 "*"-LENERR                     VALUE  251.
          88 "*"-MAPERR                     VALUE  252.
          88 "*"-ISOERR                     VALUE  253.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-INIT                       VALUE    1.
          88 "*"-ISO2COB                    VALUE   11.
          88 "*"-ISO2COBP                   VALUE   12.
          88 "*"-COB2ISO                    VALUE   13.

      10     "*"-VERF            PIC S9(04) COMP.
          88 "*"-VERFNOK                    VALUE -9999 THRU    0
                                                      6 THRU 9999.
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-NN                         VALUE    5.
          88 "*"-VERF5                      VALUE    5.

     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(1024).
      10     "*"-ISOPTR          PIC S9(04) COMP.
      10     "*"-BMP             PIC S9(04) COMP.
          88 "*"-BMPNOK                     VALUE -9999 THRU   -2
                                                    129 THRU 9999.
      10     "*"-BMPLEN          PIC S9(04) COMP.
      10     "*"-BMPVAL          PIC  X(512).
      10     "*"-COBLEN          PIC S9(04) COMP.
      10     "*"-COBVAL          PIC  X(512).

?section WSYS01XC
*****************************************************************
* Autor            :  Kay Lorenz aus WSYS016C v. J. Bahlmann
* Letzte Aenderung :: 2007-01-26
* Letzte Version   :: A.01.00
* Kurzbeschreibung :: Schnittstelle zum Modul WSYS01X ISO-8583,
* Kurzbeschreibung :: 1987 + 1993
*
*                    Uebernahme aus WSYS016C - Neuordnung der
*                    Verfahren und damit auch Auswahl der ISO-
*                    Tabelle
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    129 -   Fehler im Nachrichtentyp (nicht numerisch)
*                    240 -   ungueltiger Wert fuer CMD
*                    241 -   ungueltiger Wert fuer VERF
*                    242 -   ungueltiger Wert fuer BMP
*                    243 -   Laden der ISO-Tabelle nicht moeglich
*                    244 -   Fehler in der ISO-Tabelle ISO8583
*                    245 -   BMP darf nicht kleiner werden
*                    246 -   Bit fuer angefordertes Feld nicht gesetzt
*                    251 -   fehlerhafte Laengenangabe
*                    252 -   Bitmap nicht korrekt/ungueltig
*                    253 -   sonstiger Fehler ISO-Feld
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*                    1nnn -  BMP nnn nicht numerisch
*                    2nnn -  BMP nnn laenger als max. Laenge in ISO-Tab
*                            nur var. Felder
*
*    Feld CMD      : 1   -   Laden alle Verfahrenstabellen
*                    11  -   Konvertierung von ISO nach COBOL
*                    12  -   Konvertierung von ISO nach COBOL mit
*                            UNPACK der Felder: BMP 2,34,35,47,64
*                    13  -   Konvertierung von COBOL nach ISO
*
*    Feld VERF     : 1   -   EC                               Verf1
*                    2   -   MAESTRO                          Verf2
*                    3   -   GICC                             Verf3
*                    4   -   OPT                              Verf4
*                    5   -   ISFS1                            Verf5
*                    6   -   NN                               Verf6
*                    7   -   NN                               Verf7
*                    8   -   NN                               Verf8
*                    9   -   NN                               Verf9
*                   10   -   NN                               Verf10
*                   11   -   NN                               Verf11
*                   12   -   NN                               Verf12
*                   13   -   NN                               Verf13
*                   14   -   NN                               Verf14
*                   15   -   NN                               Verf15
*                   16   -   IFP48                            Verf16
*                   17   -   NN                               Verf17
*                   18   -   NN                               Verf18
*                   19   -   NN                               Verf19
*                   20   -   NN                               Verf10

*
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld ISOPTR   : O       Aufsetzpointer fuer ISO Untersuchung
*                            (muss vom rufenden Programm bei jeder
*                            NEUEN Nachricht auf 0 gesetzt werden)
*
*    Feld BMP      : I       zurueckzugebendes Feld ISO -> COBOL bzw.
*                            anzuhaengedes Feld COBOL -> ISO
*
*                            Bei ISO -> COBOL:
*                                -1 = Der Nachrichtentyp wird zurueckgegeben
*                                 0 = Die Prim. Bitmap wird als Bytemap
*                                     zurueckgegeben
*                                >0 = Das entsprechende BMP-Feld wird
*                                     zurueckgegeben
*
*                            Bei COBOL -> ISO:
*                                -1 = ISOSTRING wird geloescht,
*                                     Nachrichtentyp in ISOSTRING gestellt
*                                 0 = Bytemap umwandeln in Bitmap und
*                                     an den ISOSTRING anhaengen
*                                >0 = Jeweiliges Feld umwandeln, anhaengen
*
*    Feld BMPLEN   : I/O     Laenge des ISO-Feldes
*
*    Feld BMPVAL   : I/O     ISO-Feld
*
*    Feld COBLEN   : I/O     Laenge des COBOL-Feldes
*
*    Feld COBVAL   : I/O     COBOL-Feld
*
*                     * aus Sicht WSYS016
*
*
*
* Aenderungen      :
*
*
*
*****************************************************************
*
 01          "*"-WSYS01XC.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-NUMERR                     VALUE  1000 THRU  1128.
          88 "*"-MAXLENERR                  VALUE  2000 THRU  2128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-VERFERR                    VALUE  241.
          88 "*"-BMPERR                     VALUE  242.
          88 "*"-LADERR                     VALUE  243.
          88 "*"-ISOTABERR                  VALUE  244.
          88 "*"-FOLGERR                    VALUE  245.
          88 "*"-BITERR                     VALUE  246.
          88 "*"-LENERR                     VALUE  251.
          88 "*"-MAPERR                     VALUE  252.
          88 "*"-ISOERR                     VALUE  253.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-INIT                       VALUE    1.
          88 "*"-ISO2COB                    VALUE   11.
          88 "*"-ISO2COBP                   VALUE   12.
          88 "*"-COB2ISO                    VALUE   13.

      10     "*"-VERF            PIC S9(04) COMP.
          88 "*"-VERFNOK                    VALUE -9999 THRU    0
                                                     21 THRU 9999.

* ---> Nachrichtenpacker / -entpacker
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-IFSF                       VALUE    5.
          88 "*"-VERF5                      VALUE    5.
*         ffu
          88 "*"-VERF6                      VALUE    6.
          88 "*"-VERF7                      VALUE    7.
          88 "*"-VERF8                      VALUE    8.
          88 "*"-VERF9                      VALUE    9.
          88 "*"-VERF10                     VALUE    10.
          88 "*"-VERF11                     VALUE    11.
          88 "*"-VERF12                     VALUE    12.
          88 "*"-VERF13                     VALUE    13.
          88 "*"-VERF14                     VALUE    14.
          88 "*"-VERF15                     VALUE    15.

* ---> Ab hier ISO-Feldpacker
          88 "*"-IFP48                      VALUE    16.
          88 "*"-VERF16                     VALUE    16.
*         ffu
          88 "*"-VERF17                     VALUE    17.
          88 "*"-VERF18                     VALUE    18.
          88 "*"-VERF19                     VALUE    19.
          88 "*"-VERF20                     VALUE    20.

     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(1024).
      10     "*"-ISOPTR          PIC S9(04) COMP.
      10     "*"-BMP             PIC S9(04) COMP.
          88 "*"-BMPNOK                     VALUE -9999 THRU   -2
                                                    129 THRU 9999.
      10     "*"-BMPLEN          PIC S9(04) COMP.
      10     "*"-BMPVAL          PIC  X(512).
      10     "*"-COBLEN          PIC S9(04) COMP.
      10     "*"-COBVAL          PIC  X(512).

?section WISO100C
*****************************************************************
* Autor            :  Kay Lorenz aus WSYS01XC v. K. Lorenz
* Letzte Aenderung :: 2008-01-12
* Letzte Version   :: A.01.02
* Kurzbeschreibung :: Schnittstelle zum Modul WISO100 ISO-8583,
* Kurzbeschreibung :: 1987 + 1993
*
*
*               ENSTPRICHT WSYS01XC - Name Refactoring
*
*
*                    Uebernahme aus WSYS016C - Neuordnung der
*                    Verfahren und damit auch Auswahl der ISO-
*                    Tabelle
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    129 -   Fehler im Nachrichtentyp (nicht numerisch)
*                    240 -   ungueltiger Wert fuer CMD
*                    241 -   ungueltiger Wert fuer VERF
*                    242 -   ungueltiger Wert fuer BMP
*                    243 -   Laden der ISO-Tabelle nicht moeglich
*                    244 -   Fehler in der ISO-Tabelle ISO8583
*                    245 -   BMP darf nicht kleiner werden
*                    246 -   Bit fuer angefordertes Feld nicht gesetzt
*                    251 -   fehlerhafte Laengenangabe
*                    252 -   Bitmap nicht korrekt/ungueltig
*                    253 -   sonstiger Fehler ISO-Feld
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*                    1nnn -  BMP nnn nicht numerisch
*                    2nnn -  BMP nnn laenger als max. Laenge in ISO-Tab
*                            nur var. Felder
*
*    Feld CMD      : 1   -   Laden alle Verfahrenstabellen
*                    11  -   Konvertierung von ISO nach COBOL
*                    12  -   Konvertierung von ISO nach COBOL mit
*                            UNPACK der Felder: BMP 2,34,35,47,64
*                    13  -   Konvertierung von COBOL nach ISO
*
*    Feld VERF     : 1   -   EC                               Verf1
*                    2   -   MAESTRO                          Verf2
*                    3   -   GICC                             Verf3
*                    4   -   OPT                              Verf4
*                    5   -   ISFS1                            Verf5
*                    6   -   NN                               Verf6
*                    7   -   NN                               Verf7
*                    8   -   NN                               Verf8
*                    9   -   NN                               Verf9
*                   10   -   NN                               Verf10
*                   11   -   NN                               Verf11
*                   12   -   NN                               Verf12
*                   13   -   NN                               Verf13
*                   14   -   NN                               Verf14
*                   15   -   NN                               Verf15
*                   16   -   IFP48                            Verf16
*                   17   -   NN                               Verf17
*                   18   -   NN                               Verf18
*                   19   -   NN                               Verf19
*                   20   -   NN                               Verf10

*
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld ISOPTR   : O       Aufsetzpointer fuer ISO Untersuchung
*                            (muss vom rufenden Programm bei jeder
*                            NEUEN Nachricht auf 0 gesetzt werden)
*
*    Feld BMP      : I       zurueckzugebendes Feld ISO -> COBOL bzw.
*                            anzuhaengedes Feld COBOL -> ISO
*
*                            Bei ISO -> COBOL:
*                                -1 = Der Nachrichtentyp wird zurueckgegeben
*                                 0 = Die Prim. Bitmap wird als Bytemap
*                                     zurueckgegeben
*                                >0 = Das entsprechende BMP-Feld wird
*                                     zurueckgegeben
*
*                            Bei COBOL -> ISO:
*                                -1 = ISOSTRING wird geloescht,
*                                     Nachrichtentyp in ISOSTRING gestellt
*                                 0 = Bytemap umwandeln in Bitmap und
*                                     an den ISOSTRING anhaengen
*                                >0 = Jeweiliges Feld umwandeln, anhaengen
*
*    Feld BMPLEN   : I/O     Laenge des ISO-Feldes
*
*    Feld BMPVAL   : I/O     ISO-Feld
*
*    Feld COBLEN   : I/O     Laenge des COBOL-Feldes
*
*    Feld COBVAL   : I/O     COBOL-Feld
*
*                     * aus Sicht WSYS016
*
*
*
* Aenderungen      :
*
* kl20080111   A.01.01  Neues Kommando GETISOADDR eingefuehrt
* kl20080114   A.01.02  Neues Kommando wieder raus (verlagert
*                       nach WISO200)
*                       entspricht somit A.01.00
*
*****************************************************************
*
 01          "*"-WISO100C.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-NUMERR                     VALUE  1000 THRU  1128.
          88 "*"-MAXLENERR                  VALUE  2000 THRU  2128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-VERFERR                    VALUE  241.
          88 "*"-BMPERR                     VALUE  242.
          88 "*"-LADERR                     VALUE  243.
          88 "*"-ISOTABERR                  VALUE  244.
          88 "*"-FOLGERR                    VALUE  245.
          88 "*"-BITERR                     VALUE  246.
          88 "*"-LENERR                     VALUE  251.
          88 "*"-MAPERR                     VALUE  252.
          88 "*"-ISOERR                     VALUE  253.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-INIT                       VALUE    1.
          88 "*"-ISO2COB                    VALUE   11.
          88 "*"-ISO2COBP                   VALUE   12.
          88 "*"-COB2ISO                    VALUE   13.

      10     "*"-VERF            PIC S9(04) COMP.
          88 "*"-VERFNOK                    VALUE -9999 THRU    0
                                                     22 THRU 9999.

* ---> Nachrichtenpacker / -entpacker
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-IFSF                       VALUE    5.
          88 "*"-VERF5                      VALUE    5.
*         ffu
          88 "*"-VERF6                      VALUE    6.
          88 "*"-VERF7                      VALUE    7.
          88 "*"-VERF8                      VALUE    8.
          88 "*"-VERF9                      VALUE    9.
          88 "*"-VERF10                     VALUE    10.
          88 "*"-VERF11                     VALUE    11.
          88 "*"-VERF12                     VALUE    12.
          88 "*"-VERF13                     VALUE    13.
          88 "*"-VERF14                     VALUE    14.
          88 "*"-VERF15                     VALUE    15.

* ---> Ab hier ISO-Feldpacker
          88 "*"-IFP48                      VALUE    16.
          88 "*"-VERF16                     VALUE    16.
*         ffu
          88 "*"-VERF17                     VALUE    17.
          88 "*"-VERF18                     VALUE    18.
          88 "*"-VERF19                     VALUE    19.
          88 "*"-VERF20                     VALUE    20.

     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(1024).
      10     "*"-ISOPTR          PIC S9(04) COMP.
      10     "*"-BMP             PIC S9(04) COMP.
          88 "*"-BMPNOK                     VALUE -9999 THRU   -2
                                                    129 THRU 9999.
      10     "*"-BMPLEN          PIC S9(04) COMP.
      10     "*"-BMPVAL          PIC  X(512).
      10     "*"-COBLEN          PIC S9(04) COMP.
      10     "*"-COBVAL          PIC  X(512).

?section WISO107C
*****************************************************************
* Autor            :  Erweiterung von WISO100C - Feldgröße auf 1024 - jb
* Letzte Aenderung :: 2017-11-07
* Letzte Version   :: A.01.00
* Kurzbeschreibung :: Schnittstelle zum Modul WISO107 ISO-8583,
* Kurzbeschreibung :: 1987 + 1993
*
*
*               ENSTPRICHT WSYS01XC - Name Refactoring
*
*
*                    Uebernahme aus WSYS016C - Neuordnung der
*                    Verfahren und damit auch Auswahl der ISO-
*                    Tabelle
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    129 -   Fehler im Nachrichtentyp (nicht numerisch)
*                    240 -   ungueltiger Wert fuer CMD
*                    241 -   ungueltiger Wert fuer VERF
*                    242 -   ungueltiger Wert fuer BMP
*                    243 -   Laden der ISO-Tabelle nicht moeglich
*                    244 -   Fehler in der ISO-Tabelle ISO8583
*                    245 -   BMP darf nicht kleiner werden
*                    246 -   Bit fuer angefordertes Feld nicht gesetzt
*                    251 -   fehlerhafte Laengenangabe
*                    252 -   Bitmap nicht korrekt/ungueltig
*                    253 -   sonstiger Fehler ISO-Feld
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*                    1nnn -  BMP nnn nicht numerisch
*                    2nnn -  BMP nnn laenger als max. Laenge in ISO-Tab
*                            nur var. Felder
*
*    Feld CMD      : 1   -   Laden alle Verfahrenstabellen
*                    11  -   Konvertierung von ISO nach COBOL
*                    12  -   Konvertierung von ISO nach COBOL mit
*                            UNPACK der Felder: BMP 2,34,35,47,64
*                    13  -   Konvertierung von COBOL nach ISO
*
*    Feld VERF     : 1   -   EC                               Verf1
*                    2   -   MAESTRO                          Verf2
*                    3   -   GICC                             Verf3
*                    4   -   OPT                              Verf4
*                    5   -   ISFS1                            Verf5
*                    6   -   NN                               Verf6
*                    7   -   NN                               Verf7
*                    8   -   NN                               Verf8
*                    9   -   NN                               Verf9
*                   10   -   NN                               Verf10
*                   11   -   NN                               Verf11
*                   12   -   NN                               Verf12
*                   13   -   NN                               Verf13
*                   14   -   NN                               Verf14
*                   15   -   NN                               Verf15
*                   16   -   IFP48                            Verf16
*                   17   -   NN                               Verf17
*                   18   -   NN                               Verf18
*                   19   -   NN                               Verf19
*                   20   -   NN                               Verf10

*
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld ISOPTR   : O       Aufsetzpointer fuer ISO Untersuchung
*                            (muss vom rufenden Programm bei jeder
*                            NEUEN Nachricht auf 0 gesetzt werden)
*
*    Feld BMP      : I       zurueckzugebendes Feld ISO -> COBOL bzw.
*                            anzuhaengedes Feld COBOL -> ISO
*
*                            Bei ISO -> COBOL:
*                                -1 = Der Nachrichtentyp wird zurueckgegeben
*                                 0 = Die Prim. Bitmap wird als Bytemap
*                                     zurueckgegeben
*                                >0 = Das entsprechende BMP-Feld wird
*                                     zurueckgegeben
*
*                            Bei COBOL -> ISO:
*                                -1 = ISOSTRING wird geloescht,
*                                     Nachrichtentyp in ISOSTRING gestellt
*                                 0 = Bytemap umwandeln in Bitmap und
*                                     an den ISOSTRING anhaengen
*                                >0 = Jeweiliges Feld umwandeln, anhaengen
*
*    Feld BMPLEN   : I/O     Laenge des ISO-Feldes
*
*    Feld BMPVAL   : I/O     ISO-Feld
*
*    Feld COBLEN   : I/O     Laenge des COBOL-Feldes
*
*    Feld COBVAL   : I/O     COBOL-Feld
*
*                     * aus Sicht WSYS016
*
*
*
* Aenderungen      :
*
* jb20130702   A.01.00  Clon von WISO100C
*
*****************************************************************
*
 01          "*"-WISO107C.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-NUMERR                     VALUE  1000 THRU  1128.
          88 "*"-MAXLENERR                  VALUE  2000 THRU  2128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-VERFERR                    VALUE  241.
          88 "*"-BMPERR                     VALUE  242.
          88 "*"-LADERR                     VALUE  243.
          88 "*"-ISOTABERR                  VALUE  244.
          88 "*"-FOLGERR                    VALUE  245.
          88 "*"-BITERR                     VALUE  246.
          88 "*"-LENERR                     VALUE  251.
          88 "*"-MAPERR                     VALUE  252.
          88 "*"-ISOERR                     VALUE  253.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-INIT                       VALUE    1.
          88 "*"-ISO2COB                    VALUE   11.
          88 "*"-ISO2COBP                   VALUE   12.
          88 "*"-COB2ISO                    VALUE   13.

      10     "*"-VERF            PIC S9(04) COMP.
          88 "*"-VERFNOK                    VALUE -9999 THRU    0
                                                     22 THRU 9999.

* ---> Nachrichtenpacker / -entpacker
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-IFSF                       VALUE    5.
          88 "*"-VERF5                      VALUE    5.
*kl20171107 - Nachgepflegt analog WISO207C
          88 "*"-OELV                       VALUE    6.
*kl20171107 - Ende
          88 "*"-VERF6                      VALUE    6.
*         ffu
          88 "*"-VERF7                      VALUE    7.
          88 "*"-VERF8                      VALUE    8.
          88 "*"-VERF9                      VALUE    9.
          88 "*"-VERF10                     VALUE    10.
          88 "*"-VERF11                     VALUE    11.
          88 "*"-VERF12                     VALUE    12.
          88 "*"-VERF13                     VALUE    13.
          88 "*"-VERF14                     VALUE    14.
          88 "*"-VERF15                     VALUE    15.

* ---> Ab hier ISO-Feldpacker
          88 "*"-IFP48                      VALUE    16.
          88 "*"-VERF16                     VALUE    16.
*         ffu
          88 "*"-VERF17                     VALUE    17.
          88 "*"-VERF18                     VALUE    18.
          88 "*"-VERF19                     VALUE    19.
          88 "*"-VERF20                     VALUE    20.

     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(1024).
      10     "*"-ISOPTR          PIC S9(04) COMP.
      10     "*"-BMP             PIC S9(04) COMP.
          88 "*"-BMPNOK                     VALUE -9999 THRU   -2
                                                    129 THRU 9999.
      10     "*"-BMPLEN          PIC S9(04) COMP.
      10     "*"-BMPVAL          PIC  X(1024).
      10     "*"-COBLEN          PIC S9(04) COMP.
      10     "*"-COBVAL          PIC  X(1024).


?section PSYS015C
*****************************************************************
* Autor            : APCON C&S, Joachim Bahlmann
* erstellt am      : 10.04.1995
* letzte Aenderung : 08.10.1996
* letzte Version   : A.01.10
* Beschreibung     : Schnittstelle zum Modul PSYS015 ISO-8583
*
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    129 -   Fehler im Nachrichtentyp (nicht numerisch)
*                    240 -   ungueltiger Wert fuer CMD
*                    241 -   ungueltiger Wert fuer VERF
*                    242 -   ungueltiger Wert fuer BMP
*                    243 -   Laden der ISO-Tabelle nicht moeglich
*                    244 -   Fehler in der ISO-Tabelle ISO8583
*                    245 -   BMP darf nicht kleiner werden
*                    246 -   Bit fuer angefordertes Feld nicht gesetzt
*                    251 -   fehlerhafte Laengenangabe
*                    252 -   Bitmap nicht korrekt/ungueltig
*                    253 -   sonstiger Fehler ISO-Feld
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*
*    Feld CMD      : 1   -   Laden alle Verfahrenstabellen
*                    11  -   Konvertierung von ISO nach COBOL
*                    12  -   Konvertierung von ISO nach COBOL mit
*                            UNPACK der Felder: BMP 2,34,35,47,64
*                    13  -   Konvertierung von COBOL nach ISO
*
*    Feld VERF     : 1   -   electronic cash / POZ
*                    2   -   edc/Maestro
*                    3   -   GICC
*
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld ISOPTR   : O       Aufsetzpointer fuer ISO Untersuchung
*                            (muss vom rufenden Programm bei jeder
*                            NEUEN Nachricht auf 0 gesetzt werden)
*
*    Feld BMP      : I       zurueckzugebendes Feld ISO -> COBOL bzw.
*                            anzuhaengedes Feld COBOL -> ISO
*
*                            Bei ISO -> COBOL:
*                                -1 = Der Nachrichtentyp wird zurueckgegeben
*                                 0 = Die Prim. Bitmap wird als Bytemap
*                                     zurueckgegeben
*                                >0 = Das entsprechende BMP-Feld wird
*                                     zurueckgegeben
*
*                            Bei COBOL -> ISO:
*                                -1 = ISOSTRING wird geloescht,
*                                     Nachrichtentyp in ISOSTRING gestellt
*                                 0 = Bytemap umwandeln in Bitmap und
*                                     an den ISOSTRING anhaengen
*                                >0 = Jeweiliges Feld umwandeln, anhaengen
*
*    Feld BMPLEN   : I/O     Laenge des ISO-Feldes
*
*    Feld BMPVAL   : I/O     ISO-Feld
*
*    Feld COBLEN   : I/O     Laenge des COBOL-Feldes
*
*    Feld COBVAL   : I/O     COBOL-Feld
*
*                     * aus Sicht PSYS015
*
*
*
* Aenderungen      :
*
* A.01.10 - 08.10.1996  Feld ISOSTRING auf 512 Bytes erweitert
*
*
*****************************************************************
*
 01          "*"-PSYS015C.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-VERFERR                    VALUE  241.
          88 "*"-BMPERR                     VALUE  242.
          88 "*"-LADERR                     VALUE  243.
          88 "*"-ISOTABERR                  VALUE  244.
          88 "*"-FOLGERR                    VALUE  245.
          88 "*"-BITERR                     VALUE  246.
          88 "*"-LENERR                     VALUE  251.
          88 "*"-MAPERR                     VALUE  252.
          88 "*"-ISOERR                     VALUE  253.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-INIT                       VALUE    1.
          88 "*"-ISO2COB                    VALUE   11.
          88 "*"-ISO2COBP                   VALUE   12.
          88 "*"-COB2ISO                    VALUE   13.

      10     "*"-VERF            PIC S9(04) COMP.
          88 "*"-VERFNOK                    VALUE -9999 THRU    0
                                                      4 THRU 9999.
          88 "*"-EC                         VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-GICC                       VALUE    3.

     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(512).
      10     "*"-ISOPTR          PIC S9(04) COMP.
      10     "*"-BMP             PIC S9(04) COMP.
          88 "*"-BMPNOK                     VALUE -9999 THRU   -2
                                                    129 THRU 9999.
      10     "*"-BMPLEN          PIC S9(04) COMP.
      10     "*"-BMPVAL          PIC  X(256).
      10     "*"-COBLEN          PIC S9(04) COMP.
      10     "*"-COBVAL          PIC  X(256).

*****************************************************************

?section PSYS040C
*****************************************************************
* Autor            : ADCON C&S, Joachim Bahlmann
* erstellt am      : 12.08.1993
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum Pruefziffernmodul PSYS040
*
*    Feld STATUS   : 0 - OK
*                    1 - nicht definierter Wert in KMDO
*                    2 - Pruefziffer falsch
*                    3 - Kartennummer fehlt
*                    4 - Kartennummer zu gross (bei Pruefziffer-
*                        berechnung max. 18 Stellen)
*
*    Feld KMDO     : 1 - Pruefziffer berechnen
*                    2 - Pruefziffer pruefen
*
*    Feld KANR     : linksbuendig, mit Spaces aufgefuellt
*
*                    bei KMDO = 1 (berechnen)
*
*                        - vom aufrufenden Modul
*                          ohne Pruefziffer (logo!?)
*                        - Rueckgabe KANR mit anhaengender,
*                          berechneter PZ
*
*                    bei KMDO = 2 (pruefen)
*
*                        immer vollstaendige KANR (mit PZ)
*
*
* Aenderungen      :
*
*
*****************************************************************
*
 01          "*"-PSYS040C.
     05      "*"-STATUS          PIC S9(04) COMP.
          88 "*"-OK                              VALUE 0.
          88 "*"-ERR-STATUS                      VALUE -9999 THRU -1
                                                       1 THRU  9999.
          88 "*"-KMDO-NOK                        VALUE 1.
          88 "*"-PZ-NOK                          VALUE 2.
          88 "*"-KANR-MISSING                    VALUE 3.
          88 "*"-KANR-ERR                        VALUE 4.

     05      "*"-KMDO            PIC S9(04) COMP.
          88 "*"-KMDO-ERR                        VALUE -9999 THRU 0
                                                           3 THRU 9999.
          88 "*"-COMPUTE                         VALUE 1.
          88 "*"-CHECK                           VALUE 2.

     05      "*"-KANR            PIC  X(19).

*****************************************************************

?section FRESATZN
*******************************************************************
* Message fuer Linehandler FREGAT hier Datex-P-Leitungen          *
* H.J. OHM                                            28.06.1990  *
* Die Copystrecke ist direkt fuer $RECEIVE vorgesehen             *
* ACHTUNG: Bei Aenderung auch FREGAT-DTX aendern                  *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*----------------------> Message
     01      FRE-SATZ.
      10     FRE-HEADER.
       15    FRE-CC              PIC S9(04) COMP.
          88 FRE-OK                         VALUE 0.
          88 FRE-READ-IL                    VALUE 1.
          88 FRE-WRITE-SL                   VALUE 2.
          88 FRE-AUFBAU-IL                  VALUE 3.
          88 FRE-ABBAU-SL                   VALUE 4.
          88 FRE-AUFBAU-BL                  VALUE 5.
          88 FRE-READ-AL                    VALUE 6.
          88 FRE-WRITE-AL                   VALUE 7.
          88 FRE-WRITEQ-AL                  VALUE 8.
          88 FRE-FREI-BL                    VALUE 9.
          88 FRE-SEND-ASYNC                 VALUE 10.
          88 FRE-SEND-SYNC                  VALUE 11.
          88 FRE-DISCON-TS                  VALUE 101.
          88 FRE-DISCON-TO                  VALUE 102.
          88 FRE-NO-CONNECT                 VALUE 103.
          88 FRE-NO-BL                      VALUE 104.
          88 FRE-MODEM-ERR                  VALUE 105.
          88 FRE-NO-ANSWER                  VALUE 106.
          88 FRE-UNS-MSG                    VALUE 107.
          88 FRE-APPL-DOWN                  VALUE 108.
          88 FRE-DIAGN-ANF                  VALUE 109.

       15    FRE-TERMID          PIC X(16).
       15    FRE-NEXTSERV        PIC X(16).
       15    FRE-LINE            PIC X(16).
       15    FRE-DATLEN          PIC S9(04) COMP.
       15    FRE-DTXNR           PIC X(16).
       15    FRE-CUGID           PIC 99.
       15    FRE-SESSNR          PIC S9(04) COMP.
       15    FRE-MONNAME         PIC X(16).
      10     FRE-NDATEN.
       15                        PIC X(256).

*******************************************************************
?section TTSA900C
*****************************************************************
* Autor            : APCON C&S
* erstellt am      : 10.05.1995  (fuer easycash PSPA900)
* letzte Aenderung : 21.10.1996
* Beschreibung     : Schnittstelle zum Modul TTSA900 ISO-8583
*
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    240 -   ungueltiger Wert fuer CMD
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*
*    Feld CMD      : 12  -   ISO nach COBOL
*                    13  -   COBOL nach ISO
*                    22  -   WEAT nach COBOL
*                    23  -   COBOL nach WEAT
*
*
*    Feld ISOTYP   : 1   -   EC-Nachricht (vom Terminal - zum Terminal)
*                    2   -   EDC-Nachricht(von und zur UES)
*
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld BYTEMAP    I/O     Byte-Map der Iso-Nachricht
*
*    Feld COBREC   : I/O     edc-spezifischer record fuer die
*                            Daten der Felder der ISO-Nachricht
*
*
*
* Aenderungen      :
*
*
*
*
*****************************************************************
*
 01          "*"-TTSA900C.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-ISO2COB                    VALUE    12.
          88 "*"-COB2ISO                    VALUE    13.
          88 "*"-WEAT2COB                   VALUE    22.
          88 "*"-COB2WEAT                   VALUE    23.

      10     "*"-ISOTYP          PIC S9(04) COMP.
          88 "*"-EC                         VALUE    1.
          88 "*"-EDC                        VALUE    2.
     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(256).
      10     "*"-BYTEMAP         PIC  X(128).
      10     "*"-COBREC.
        15   "*"-NTYPE           PIC  9(04).
        15   "*"-PANLEN          PIC  9(02).
        15   "*"-PAN             PIC  X(19).
        15   "*"-ABWKZ           PIC  9(06).
        15   "*"-BETRAG          PIC  9(12).
        15   "*"-ISOBETRAG       PIC  X(06).
        15   "*"-TRACENR         PIC  9(06).
        15   "*"-ISOTRACENR      PIC  X(03).
        15   "*"-ZEIT            PIC  9(06).
        15   "*"-ISOZEIT         PIC  X(03).
        15   "*"-DATUM           PIC  9(04).
        15   "*"-ISODATUM        PIC  X(02).
        15   "*"-VERFALL         PIC  9(04).
        15   "*"-BRANCH          PIC  9(04).
        15   "*"-CCODE           PIC  9(04).
        15   "*"-ERFASSUNG       PIC  9(03).
        15   "*"-KARTENF         PIC  9(04).
        15   "*"-KONDCODE        PIC  9(02).
        15   "*"-ANZPIN          PIC  9(02).
        15   "*"-NETZBETRLEN     PIC  9(02).
        15   "*"-NETZBETR        PIC  X(12).
        15   "*"-UESLEN          PIC  9(02).
        15   "*"-UESSTELLE       PIC  X(12).
        15   "*"-ISOUES          PIC  X(06).
        15   "*"-ECPAN.
         20  "*"-ECBH            PIC  99.
         20  "*"-ECBLZ           PIC  9(8).
         20  "*"-ECTRENN         PIC  X.
         20  "*"-ECKONTO         PIC  9(10).
         20  "*"-ECPRZIF         PIC  9.
        15   "*"-SPUR2LEN        PIC  9(02).
        15   "*"-SPUR2           PIC  X(38).
        15   "*"-REFNR           PIC  X(12).
        15   "*"-POSNR           PIC  X(12).
        15   "*"-ISOPOSNR        PIC  X(06).
        15   "*"-AID             PIC  X(06).
        15   "*"-AC              PIC  9(02).
        15   "*"-TERMNR          PIC  9(08).
        15   "*"-TERMID          PIC  X(04).
        15   "*"-VUNR            PIC  X(15).
        15   "*"-HAENDLER        PIC  X(40).
        15   "*"-EELC            PIC  X(22).
        15   "*"-EELCLEN         PIC  9(03).
        15   "*"-WAEHR-ACQ       PIC  9(03).
        15   "*"-WAEHR-ISS       PIC  9(03).
        15   "*"-PAC             PIC  X(08).
        15   "*"-VERSCH-LEN      PIC  9(03).
        15   "*"-VERSCH-PARAM.
         20  "*"-SI              PIC  X(08).
         20  "*"-SN              PIC  X.
        15   "*"-BMP59DATEN.
         20  "*"-BMP59LEN        PIC  999.
         20  "*"-BMP59           PIC  X(08).
        15   "*"-BMP60DATEN.
         20  "*"-BMP60LEN        PIC  999.
         20  "*"-ISOBMP60        PIC  X(99).
        15   "*"-FBZ             PIC  9.
        15   "*"-FBZLEN          PIC  9(03).
        15   "*"-AUTODATEN.
         20  "*"-TRANSTYP        PIC  9(04).
         20  "*"-AUTOTRACENR     PIC  9(06).
         20  "*"-AUTOZEIT        PIC  9(06).
         20  "*"-AUTODATUM       PIC  9(04).
         20  "*"-AUTONETID       PIC  X(11).
         20  "*"-AUTOUES         PIC  X(11).
        15   "*"-MAC             PIC  X(08).


?section PSYS911C
*****************************************************************
* Autor            : APCON C&S, Joachim Bahlmann
* erstellt am      : 31.05.1995
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum Modul PSYS911 Eintrag BATCHLOG
*
*    Feld STATUS   : 0 - OK
*                    ungleich 0 - SQL-Fehlernummer
*
*    Feld CMD      : steuert die Funktionalitaet des Moduls PSYS911
*                    0 - normaler Aufruf
*                    1 - nur Rueckgabe des Prozessnamens
*
*    Feld PRGSTATUS: Wert wird in Tabelle BATCHLOG eingetragen
*                    0 - Programmstart
*                    1 - normales Programmende
*
*    Feld PROCNAME : Wird vom Modul PSYS910 ermittelt und dem
*                    rufenden Programm zurueckgegeben
*
*    Feld MODUL    : Wert wird in Tabelle BATCHLOG eingetragen
*
*    Feld INFO     : Wert wird in Tabelle BATCHLOG eingetragen
*
*
* Aenderungen      :
*
*
*
*
*****************************************************************
*
 01          "*"-PSYS911C.
     05      "*"-STATUS          PIC S9(04) COMP.
          88 "*"-OK                              VALUE 0.
          88 "*"-ERR                             VALUE -9999 THRU -1
                                                       1 THRU  9999.
     05      "*"-CMD             PIC S9(04) COMP.
          88 "*"-NORM                            VALUE 0.
          88 "*"-NAMEONLY                        VALUE 1.
     05      "*"-PRGSTATUS       PIC S9(04) COMP.
     05      "*"-PROCNAME        PIC  X(06).
     05      "*"-MODUL           PIC  X(08).
     05      "*"-INFO            PIC  X(80).

*****************************************************************

?section MEMREC
******************************************************************
* MEMREC     Message-Beschreibung zwischen Anwendung             *
*            und MEMLOG-PROCESS                                  *
******************************************************************
*
  01         "*"-MEMREC.
*                                    Funktion
   02        "*"-CC              PIC S9(04) COMP.
       88    "*"-INSERT              VALUE 1.
       88    "*"-READ                VALUE 2.
       88    "*"-EXIST               VALUE 3.
       88    "*"-GET-STATS           VALUE 1000.
       88    "*"-GET-STATS-RESET     VALUE 1001.
       88    "*"-LOG-ON              VALUE 1002.
       88    "*"-LOG-OFF             VALUE 1003.

*                                    Verfahrenskennzeichen lt. GUDLOG
   02        "*"-DATA.
     05      "*"-VERFKZ          PIC XX.
*                                    Timout fuer Aufbewahr. in Sekunden
     05      "*"-TIMER           PIC S9(04) COMP.
*                                    Key des Logsatzes
     05      "*"-RECKEY          PIC X(16).
*
     05      "*"-LOGDATA         PIC X(5024).
*                                    daten bei Signal-Timout
   02        "*"-SIGDATA REDEFINES "*"-DATA.
     05      "*"-SIGPARAM1       PIC S9(04) COMP.
     05      "*"-SIGPARAM2       PIC S9(09) COMP.
     05                          PIC X(5038).
******************************************************************

?section MEMREC7
******************************************************************
* MEMREC7    Message-Beschreibung zwischen Anwendung             *
*            und MEMLOG-PROCESS WEAT R7                          *
******************************************************************
*
  01         "*"-MEMREC7.
*                                    Funktion
   02        "*"-CC              PIC S9(04) COMP.
       88    "*"-INSERT              VALUE 1.
       88    "*"-READ                VALUE 2.
       88    "*"-EXIST               VALUE 3.
       88    "*"-INSERT-R7           VALUE 71.
       88    "*"-READ-R7             VALUE 72.
       88    "*"-EXIST-R7            VALUE 73.
       88    "*"-GET-STATS           VALUE 1000.
       88    "*"-GET-STATS-RESET     VALUE 1001.
       88    "*"-LOG-ON              VALUE 1002.
       88    "*"-LOG-OFF             VALUE 1003.

*                                    Verfahrenskennzeichen lt. GUDLOG
   02        "*"-DATA.
     05      "*"-VERFKZ          PIC XX.
*                                    Timout fuer Aufbewahr. in Sekunden
     05      "*"-TIMER           PIC S9(04) comp.
*                                    Key des Logsatzes
     05      "*"-RECKEY          PIC X(64).
*
     05      "*"-LOGDATA         PIC X(15000).

*                                    Fuer R6-Anfragen (Abwärtskompatibilitä)
   02        "*"-DATA-ALT REDEFINES "*"-DATA.
     05      "*"-VERFKZ          PIC XX.
*                                    Timout fuer Aufbewahr. in Sekunden
     05      "*"-TIMER           PIC S9(04) comp.
*                                    Key des Logsatzes
     05      "*"-RECKEY          PIC X(16).
*                                    Logdaten
     05      "*"-LOGDATA         PIC X(5024).
*                                    Zum Auffuellen
     05      "*"-REST-NEU        PIC X(10024).

*                                    Daten bei Signal-Timout
   02        "*"-SIGDATA REDEFINES "*"-DATA.
     05      "*"-SIGPARAM1       PIC S9(04) COMP.
     05      "*"-SIGPARAM2       PIC S9(09) COMP.
     05                          PIC X(15062).
******************************************************************

?section INT-SCHNITTSTELLE
**************************************************************
* Version A.01.00   vom 11.08.1997   JB
*
* Struktur der internen Schnittstelle zwischen den
* Pathway-Servern
*
* Die 01-Stufe ist im Programm zu setzen
**************************************************************
**          ---> FREGAT-Datenstruktur
     05      "*"-SATZ.

**          ---> Header
      10     "*"-HEADER.
       15    "*"-CC              PIC S9(04) COMP.

**          ---> Rueckgabestatus
          88 "*"-OK                         VALUE 0.
          88 "*"-READ-IL                    VALUE 1.
          88 "*"-WRITE-SL                   VALUE 2.
          88 "*"-AUFBAU-IL                  VALUE 3.
          88 "*"-ABBAU-SL                   VALUE 4.
          88 "*"-AUFBAU-BL                  VALUE 5.
          88 "*"-READ-AL                    VALUE 6.
          88 "*"-WRITE-AL                   VALUE 7.
          88 "*"-WRITEQ-AL                  VALUE 8.
          88 "*"-FREI-BL                    VALUE 9.
          88 "*"-SEND-ASYNC                 VALUE 10.
          88 "*"-SEND-SYNC                  VALUE 11.

**          ---> Commands
          88 "*"-DISCON-TS                  VALUE 101.
          88 "*"-DISCON-TO                  VALUE 102.
          88 "*"-NO-CONNECT                 VALUE 103.
          88 "*"-NO-BL                      VALUE 104.
          88 "*"-MODEM-ERR                  VALUE 105.
          88 "*"-NO-ANSWER                  VALUE 106.
          88 "*"-UNS-MSG                    VALUE 107.
          88 "*"-APPL-DOWN                  VALUE 108.
          88 "*"-DIAGN-ANF                  VALUE 109.

       15    "*"-TERMID          PIC X(16).
       15    "*"-NEXTSERV        PIC X(16).
       15    "*"-NEXTSERV-REDEF  REDEFINES "*"-NEXTSERV.
        20   "*"-SERVKLASSE      PIC X(12).
        20   "*"-SNIHEADZT       PIC X(04).
       15    "*"-LINE            PIC X(16).
       15    "*"-SENDLEN         PIC S9(04) COMP.
       15    "*"-DTXNR           PIC X(16).
       15    "*"-CUGID           PIC 99.
       15    "*"-SESSNR          PIC S9(04) COMP.
       15    "*"-MONNAME         PIC X(16).
       15    "*"-MONNAME-REDEF   REDEFINES "*"-MONNAME.
        20   "*"-MONKLASSE       PIC X(12).
        20   "*"-SNIHEADVT       PIC X(04).

**          ---> Nutzdaten (Nachrichten)
      10     "*"-NDATEN          PIC X(512).
**          ---> Reserve
     05      "*"-RESERVE         PIC X(372).
**          ---> Endbestimmungs-serverklasse
     05      "*"-DEST-SERVER     PIC X(16).
**          ---> Trace-Terminalid
     05      "*"-TRACETERMID     PIC X(04).

**          ---> Dialog-NR (Mesa-spl-nr)
     05      "*"-DIALOGNR        PIC S9(04) COMP.
**          ---> echte Datenlaenge
     05      "*"-DATLEN          PIC S9(04) COMP.

**          ---> Mandanten-Nr.
     05      "*"-MDNR            PIC 9(08).

**          ---> Tankstellen-Nr
     05      "*"-TSNR            PIC 9(08).

**          ---> Terminal-Nr.
     05      "*"-TERMNR          PIC 9(08).

**          ---> log. Protokoll
     05      "*"-LOGPROT         PIC 9(02).

**          ---> Verfahrenssteuerung electronic cash
     05      "*"-ECKZ            PIC X(02).


?section INT-SCHNITTSTELLE-C
************************************************************************
* Letzte Aenderung :: 2013-08-27
* Letzte Version   :: B.01.02
* Kurzbeschreibung :: Struktur der internen Schnittstelle zwischen
* Kurzbeschreibung :: den Pathwayservern
*
* Version B.01.01   vom 27.08.2013  - Feld ..-RESERVE unterdefiniert
*
* Version B.01.01   vom 18.08.2006  - Feld ..-MDNR-HOST redefiniert
*                                     mit ..-ISO-VERF
* Version B.01.00   vom 13.03.2006  - Neues Format mit Aufschluesselung
*                                     in WSYS959
*
* Struktur der internen Schnittstelle zwischen den
* Pathway-Servern
*
* Die 01-Stufe ist im Programm zu setzen
* Die Gesamtlaenge der Struktur betraegt 4096 Bytes
************************************************************************
** ------------> Nachrichtenstruktur einer internen Nachricht
     05      "*"-SATZ.

**    ---------> FREGAT-Header
      10     "*"-HEADER.
       15    "*"-CC              PIC S9(04) COMP.

**          ---> Commands
          88 "*"-OK                         VALUE 0.
          88 "*"-READ-IL                    VALUE 1.
          88 "*"-WRITE-SL                   VALUE 2.
          88 "*"-AUFBAU-IL                  VALUE 3.
          88 "*"-ABBAU-SL                   VALUE 4.
          88 "*"-AUFBAU-BL                  VALUE 5.
          88 "*"-READ-AL                    VALUE 6.
          88 "*"-WRITE-AL                   VALUE 7.
          88 "*"-WRITEQ-AL                  VALUE 8.
          88 "*"-FREI-BL                    VALUE 9.
          88 "*"-SEND-ASYNC                 VALUE 10.
          88 "*"-SEND-SYNC                  VALUE 11.
**          ---> fuer OCRYP00S
          88 "*"-DECRYPT                    VALUE 1001.
          88 "*"-ENCRYPT                    VALUE 1002.
          88 "*"-GEN-PAC                    VALUE 1003.
          88 "*"-CHECK-PAC                  VALUE 1004.
          88 "*"-GEN-MAC                    VALUE 1005.
          88 "*"-CHECK-MAC                  VALUE 1006.
          88 "*"-GEN-CERT                   VALUE 1007.
          88 "*"-GIVE-PW                    VALUE 1008.

**          ---> Rueckgabestatus
          88 "*"-DISCON-TS                  VALUE 101.
          88 "*"-DISCON-TO                  VALUE 102.
          88 "*"-NO-CONNECT                 VALUE 103.
          88 "*"-NO-BL                      VALUE 104.
          88 "*"-MODEM-ERR                  VALUE 105.
          88 "*"-NO-ANSWER                  VALUE 106.
          88 "*"-UNS-MSG                    VALUE 107.
          88 "*"-APPL-DOWN                  VALUE 108.
          88 "*"-DIAGN-ANF                  VALUE 109.
**          ---> fuer OCRYP00S
          88 "*"-CMD-ERR                    VALUE 2001.
          88 "*"-KEYLEN-ERR                 VALUE 2002.
          88 "*"-UNK-ERR                    VALUE 2003.
**          -------> Antwortcodes bei falschen Verschluesselungen
          88 "*"-PAC-ERR                    VALUE 2005.
          88 "*"-PAC-ERR-ANZ                VALUE 2006.
          88 "*"-MAC-ERR                    VALUE 2007.

       15    "*"-TERMID          PIC X(16).
       15    "*"-NEXTSERV        PIC X(16).
       15    "*"-LINE            PIC X(16).
**          ---> von FREGAT eingestellte/zu bearbeitende Laenge
       15    "*"-SENDLEN         PIC S9(04) COMP.
       15    "*"-DTXNR           PIC X(16).
       15    "*"-CUGID           PIC 99.
       15    "*"-SESSNR          PIC S9(04) COMP.
*kl20170510 - Nur Kommentar - Dieses Feld muss mit Einführung
*                             eines MEMLOG-Switches IMMER
*     (Für zukünftige         das letzte Feld der Struktur
*        Änderungen)          "*"-HEADER bleiben. Längen-
*                             änderungen davor sind ohne
*                             weiteres möglich.
*
*      Längenermittlung FREHEADER in WFREH07: "*"-MONNAME (global) =
*                                             "*"-MONNAME (lokal)
       15    "*"-MONNAME         PIC X(16).

**    ---------> Nutzdaten (Nachrichten)
      10     "*"-NDATEN          PIC X(1024).

**    ---------> Reserve
      10     "*"-RESERVE.
       15    "*"-NEFTIS.
        20   "*"-EYECATCHER1     PIC X(01).
        20   "*"-CARDID          PIC 9(02).
        20   "*"-ROUTKZ          PIC 9(02).
        20   "*"-EYECATCHER2     PIC X(01).
       15    "*"-RESERVE1        PIC X(232).

      10     "*"-STRUKTUR-OCRYP00S REDEFINES "*"-RESERVE.
       15    "*"-RESERVE-OCRYP00S  PIC X(212).
       15    "*"-KEYLEN          PIC S9(04) COMP.
         88  "*"-NO-KEY                     VALUE ZERO.
         88  "*"-DES                        VALUE 8.
         88  "*"-DES-EDE2                   VALUE 16.
         88  "*"-DES-EDE3                   VALUE 24.
       15    "*"-KEY             PIC X(24).

**    ---------> weitere Routing-/Stamm-Informationen
      10     "*"-ROUT-STAMM.
**          ---> Endbestimmungs-Serverklasse
       15    "*"-DEST-SERVER     PIC X(16).
**          ---> Trace-Terminalid
       15    "*"-TRACETERMID     PIC X(04).
**          ---> Dialog-NR
       15    "*"-DIALOGNR        PIC S9(04) COMP.
**          ---> echte Datenlaenge der Nachricht
       15    "*"-DATLEN          PIC S9(04) COMP.
**          ---> Mandanten-Nr.
       15    "*"-MDNR            PIC 9(08).
**          ---> Tankstellen-Nr
       15    "*"-TSNR            PIC 9(08).
**          ---> Terminal-Nr.
       15    "*"-TERMNR          PIC 9(08).
**          ---> log. Protokoll
       15    "*"-LOGPROT         PIC 9(02).
**          ---> Verfahrenssteuerung electronic cash
       15    "*"-MDNR-HOST       PIC 9(02).
       15    "*"-ISO-VERF  redefines "*"-MDNR-HOST
                                 PIC 9(02).

**    ---------> aufgeschluesselte ISO-Nachricht
      10     "*"-COBDATEN.
**          ---> Nachrichtentyp
       15    "*"-NTYPE           PIC  9(04).
**          ---> Bytemap-, Pointer-, Laengen-Tabellen
       15    "*"-TBMP-O.
        20   "*"-TBMP            PIC 9           OCCURS 128.
       15    "*"-TPTR-O.
        20   "*"-TPTR            PIC S9(04) COMP OCCURS 128.
       15    "*"-TLEN-O.
        20   "*"-TLEN            PIC S9(04) COMP OCCURS 128.
**          ---> Pointer auf naechste freie Stelle im Datenbuffer CF
       15    "*"-NEXT-PTR        PIC S9(04) COMP.

**          ---> aufbereitete (Cobol-) Felder
       15    "*"-CF              PIC X(2048).





?section PSYS901C
*****************************************************************
* Autor            : APCON C&S, H-J Ohm
* erstellt am      : 03.04.1996
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum Modul PSYS901 Komm. MEMLOG
*
*    Feld CC       : Kommando 1 Insert, 2 Read, 3 Exist
*
*    Feld RETCODE  : Returnvalue aus Request vom MEMLOG
*
*    Feld VERFKZ   : Verfahrenskz laut GUDLOG (P,I,A)
*
*    Feld ASNAME   : Name der zustaendigen AS-Serverklasse
*
*    Feld LOGKEY   : Key des Datensatzes
*
*    Die Daten des entspr. Logrecs werden als 2. using uebergeben
*
*
*****************************************************************
*
 01          "*"-PSYS901C.
     05      "*"-CC              PIC S9(04) COMP.
          88 "*"-INSERT                          VALUE 1.
          88 "*"-READ                            VALUE 2.
          88 "*"-EXIST                           VALUE 3.
     05      "*"-RETCODE         PIC S9(04) COMP.
     05      "*"-VERFKZ          PIC  X(02).
     05      "*"-ASNAME          PIC  X(16).
     05      "*"-LOGKEY          PIC  X(16).

*****************************************************************

?section PSYS905C
*****************************************************************
* Autor            : APCON C&S, H-J Ohm
* erstellt am      : 08.05.1996
* letzte Aenderung : 26.03.97
* Beschreibung     : Schnittstelle zum Modul PSYS905 Komm. ASMGR
*
*    Feld CC       : diverse Kommandos
*
*    Feld -daten   : In/Out Columns
*
*
*
*****************************************************************
*
 01          "*"-REC.
     05      "*"-CC              PIC S9(04) COMP.
          88 "*"-FETCH-FIRST                     VALUE 1.
          88 "*"-FETCH-NEXT                      VALUE 2.
          88 "*"-SELECT-DTXNR                    VALUE 3.
          88 "*"-UPDATE-LTG1                     VALUE 4.
          88 "*"-UPDATE-LTG2                     VALUE 5.
          88 "*"-UPDATE-LTGVAR                   VALUE 6.
          88 "*"-SELECT-ROUTID                   VALUE 7.
          88 "*"-UPDATE-SPERRE                   VALUE 8.
          88 "*"-UPDATE-MEMLOG                   VALUE 9.
     05      "*"-DATEN.
      10     "*"-ROUTID          PIC  S9(04) COMP.
      10     "*"-LTGIND          PIC  S9(04) COMP.
      10     "*"-PRUEFLTG        PIC  S9(04) COMP.
      10     "*"-FILLER          PIC  X(144).
*****************************************************************
?section PCAPM01C
*****************************************************************
* Autor            : APCON C&S, J. Bahlmann
* erstellt am      : 14.11.1997
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum
*                    Control-Application-Monitor PCAPM01
*
* Aenderungen      : nn.nn.nn
*
*
*****************************************************************
*
 01          "*"-PCAPM01C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                        VALUE 0.
          88 "*"-NOK                       VALUE 1 THRU 9999.
     05      "*"-BEFEHL          PIC X(02).
          88 "*"-WRITE                     VALUE "W".
          88 "*"-READ                      VALUE "R".
          88 "*"-INIT                      VALUE "I".
          88 "*"-WRITE-TRACE               VALUE "WT".
          88 "*"-READ-TRACE                VALUE "RT".
          88 "*"-CMD-NOK                   VALUE SPACE.
     05      "*"-VERFAHREN       PIC X(04).
          88 "*"-EC                        VALUE "XEMA".
          88 "*"-ECO                       VALUE "TECO".
          88 "*"-ECR                       VALUE "XECR".
          88 "*"-ELV                       VALUE "TELV".
          88 "*"-EBL                       VALUE "TEBL".
          88 "*"-HASP                      VALUE "THAS".
          88 "*"-POZ                       VALUE "XPOS".
          88 "*"-KGB                       VALUE "TKGB".
          88 "*"-EDC                       VALUE "XEDC".
          88 "*"-TUE                       VALUE "XTUE".
          88 "*"-LH                        VALUE "TLHO".
          88 "*"-ECRD                      VALUE "TECD".
          88 "*"-KASS                      VALUE "TKAS".
          88 "*"-TDIA                      VALUE "TDIA".
          88 "*"-ADIA                      VALUE "ADIA".
          88 "*"-INI                       VALUE "TINI".
          88 "*"-MESA                      VALUE "TMES".
          88 "*"-XSYS                      VALUE "XSYS".
          88 "*"-VERF-NOK                  VALUE SPACE.
     05      "*"-ZEIT            PIC S9(09) COMP.
     05      "*"-FROMSERVER      PIC X(16).
     05      "*"-TOSERVER        PIC X(16).
     05      "*"-ACODE           PIC 9(02).

*****************************************************************

?section PDBC
*****************************************************************
* Autor            : APCON C&S, Joachim Bahlmann
* erstellt am      : 30.10.1997
* letzte Aenderung :
* Beschreibung     : Schnittstelle zu div. Zugriffsmodulen
* Aenderungen      :
*
*****************************************************************
 01          "*"-PDBC.
     05      "*"-RCODE           PIC S9(04) COMP.
     05      "*"-CMD             PIC X(02).
          88 "*"-I                          VALUE "I ".
          88 "*"-DT                         VALUE "DT".
          88 "*"-DB                         VALUE "DB".
          88 "*"-ST                         VALUE "ST".
          88 "*"-SB                         VALUE "SB".

*****************************************************************
?section WSYS950C
*****************************************************************
* Autor            : APCON C&S, Kay Lorenz
* erstellt am      : 29.11.1998
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum Modul WXEMA50
*                    ec-spezifische Zwischenschicht neues PAC/MAC
*
*                    S&B Dialog 1062 / ISO8583
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    240 -   ungueltiger Wert fuer CMD
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*
*    Feld CMD      : 12  -   ISO nach COBOL
*                    13  -   COBOL nach ISO
*
*
*    Feld ISOTYP   : 1   -   EC-Nachricht (vom Terminal - zum Terminal)
*
*    Datenfelder:    In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld BYTEMAP  : I/O     Byte-Map der Iso-Nachricht
*
*    Feld COBREC   : I/O     edc-spezifischer record fuer die
*                            Daten der Felder der ISO-Nachricht
*
*
*
* Aenderungen      :
*
*****************************************************************
*
 01          "*"-WSYS950C.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-ISO2COB                    VALUE    12.
          88 "*"-COB2ISO                    VALUE    13.
          88 "*"-SB2COB                     VALUE    22.
          88 "*"-COB2SB                     VALUE    23.

      10     "*"-ISOTYP          PIC S9(04) COMP.
          88 "*"-EC                         VALUE    1.
          88 "*"-EDC                        VALUE    2.

     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(256).
      10     "*"-BYTEMAP         PIC  X(128).
      10     "*"-COBREC.
        15   "*"-NTYPE           PIC  9(04).
        15   "*"-PANLEN          PIC  9(02).
        15   "*"-PAN             PIC  X(19).
        15   "*"-ABWKZ           PIC  9(06).
        15   "*"-BETRAG          PIC  9(12).
        15   "*"-ISOBETRAG       PIC  X(06).
        15   "*"-TRACENR         PIC  9(06).
        15   "*"-ISOTRACENR      PIC  X(03).
        15   "*"-ZEIT            PIC  9(06).
        15   "*"-ISOZEIT         PIC  X(03).
        15   "*"-DATUM           PIC  9(04).
        15   "*"-ISODATUM        PIC  X(02).
        15   "*"-VERFALL         PIC  9(04).
        15   "*"-BRANCH          PIC  9(04).
        15   "*"-ERFASSUNG       PIC  9(03).
        15   "*"-KONDCODE        PIC  9(02).
        15   "*"-ANZPIN          PIC  9(02).
        15   "*"-NETZBETRLEN     PIC  9(02).
        15   "*"-NETZBETR        PIC  X(12).
        15   "*"-UESLEN          PIC  9(02).
        15   "*"-UESSTELLE       PIC  X(12).
        15   "*"-ISOUES          PIC  X(06).
        15   "*"-SPUR2LEN        PIC  9(02).
        15   "*"-SPUR2           PIC  X(38).
        15   "*"-REFNR           PIC  X(12).
        15   "*"-POSNR           PIC  X(12).
        15   "*"-AID             PIC  X(06).
        15   "*"-AC              PIC  9(02).
        15   "*"-TERMNR          PIC  9(08).
        15   "*"-TERMID          PIC  X(04).
        15   "*"-HAENDLER        PIC  X(40).
        15   "*"-WAEHR-ACQ       PIC  9(03).
        15   "*"-WKZ             PIC  9(03)
                 REDEFINES "*"-WAEHR-ACQ.
        15   "*"-WAEHR-ISS       PIC  9(03).
        15   "*"-PAC             PIC  X(08).
        15   "*"-SVERF           PIC  X(16).

        15   "*"-VERSCH-LEN      PIC  9(03).
        15   "*"-VERSCH-PARAM.
         20  "*"-SI              PIC  X(08).
         20  "*"-SN              PIC  X.
         20  "*"-FILLER          PIC  X(25).
        15   "*"-VERSCH-PARAM-N REDEFINES "*"-VERSCH-PARAM.
         20  "*"-SG              PIC  X.
         20  "*"-SV              PIC  X.
         20  "*"-RNDMES          PIC  X(16).
         20  "*"-RNDPAC          PIC  X(16).

        15   "*"-BMP59DATEN.
         20  "*"-BMP59LEN        PIC  999.
         20  "*"-BMP59           PIC  X(08).
        15   "*"-BMP60DATEN.
         20  "*"-BMP60LEN        PIC  999.
         20  "*"-ISOBMP60        PIC  X(256).
        15   "*"-AUTODATEN.
         20  "*"-TRANSTYP        PIC  9(04).
         20  "*"-AUTOTRACENR     PIC  9(06).
         20  "*"-AUTOZEIT        PIC  9(06).
         20  "*"-AUTODATUM       PIC  9(04).
         20  "*"-AUTONETID       PIC  X(11).
         20  "*"-AUTOUES         PIC  X(11).
        15   "*"-MAC             PIC  X(08).
        15   "*"-ECPAN.
         20  "*"-ECBH            PIC  99.
         20  "*"-ECBLZ           PIC  9(8).
         20  "*"-ECTRENN         PIC  X.
         20  "*"-ECKONTO         PIC  9(10).
         20  "*"-ECPRZIF         PIC  9.
        15   "*"-CCODE           PIC  9(04).
        15   "*"-KARTENF         PIC  9(04).
        15   "*"-EELC            PIC  X(22).
        15   "*"-EELCLEN         PIC  9(03).
        15   "*"-FBZ             PIC  9.
        15   "*"-FBZLEN          PIC  9(03).
        15   "*"-ISOPOSNR        PIC  X(06).

*-->    S&B-Spezifische Felder

        15   "*"-FLSN            PIC  X(05).
        15   "*"-FLPNR           PIC  X(02).
        15   "*"-FLHGN           PIC  X(02).
        15   "*"-FLTID           PIC  X(04).

?section WSYS951C
*****************************************************************
* Autor            : APCON C&S
* erstellt am      : 02.02.1999  (fuer easycash WSYS951)
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum Modul WSYS951 ISO-8583,
*                    für WXEMA02 / neues PacMAc-Verfahren
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    240 -   ungueltiger Wert fuer CMD
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*
*    Feld CMD      : 12  -   ISO nach COBOL
*                    13  -   COBOL nach ISO
*                    22  -   WEAT nach COBOL
*                    23  -   COBOL nach WEAT
*
*
*    Feld ISOTYP   : 1   -   EC-Nachricht (vom Terminal - zum Terminal)
*                    2   -   EDC-Nachricht(von und zur UES)
*
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld BYTEMAP    I/O     Byte-Map der Iso-Nachricht
*
*    Feld COBREC   : I/O     edc-spezifischer record fuer die
*                            Daten der Felder der ISO-Nachricht
*
*
*
* Aenderungen      :
*
*
*
*
*****************************************************************
*
 01          "*"-WSYS951C.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-ISO2COB                    VALUE    12.
          88 "*"-COB2ISO                    VALUE    13.
          88 "*"-WEAT2COB                   VALUE    22.
          88 "*"-COB2WEAT                   VALUE    23.

      10     "*"-ISOTYP          PIC S9(04) COMP.
          88 "*"-EC                         VALUE    1.
          88 "*"-EDC                        VALUE    2.
     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(256).
      10     "*"-BYTEMAP         PIC  X(128).
      10     "*"-COBREC.
        15   "*"-NTYPE           PIC  9(04).
        15   "*"-PANLEN          PIC  9(02).
        15   "*"-PAN             PIC  X(19).
        15   "*"-ABWKZ           PIC  9(06).
        15   "*"-BETRAG          PIC  9(12).
        15   "*"-ISOBETRAG       PIC  X(06).
        15   "*"-TRACENR         PIC  9(06).
        15   "*"-ISOTRACENR      PIC  X(03).
        15   "*"-ZEIT            PIC  9(06).
        15   "*"-ISOZEIT         PIC  X(03).
        15   "*"-DATUM           PIC  9(04).
        15   "*"-ISODATUM        PIC  X(02).
        15   "*"-VERFALL         PIC  9(04).
        15   "*"-BRANCH          PIC  9(04).
        15   "*"-CCODE           PIC  9(04).
        15   "*"-ERFASSUNG       PIC  9(03).
        15   "*"-KARTENF         PIC  9(04).
        15   "*"-KONDCODE        PIC  9(02).
        15   "*"-ANZPIN          PIC  9(02).
        15   "*"-NETZBETRLEN     PIC  9(02).
        15   "*"-NETZBETR        PIC  X(12).
        15   "*"-UESLEN          PIC  9(02).
        15   "*"-UESSTELLE       PIC  X(12).
        15   "*"-ISOUES          PIC  X(06).
        15   "*"-ECPAN.
         20  "*"-ECBH            PIC  99.
         20  "*"-ECBLZ           PIC  9(8).
         20  "*"-ECTRENN         PIC  X.
         20  "*"-ECKONTO         PIC  9(10).
         20  "*"-ECPRZIF         PIC  9.
        15   "*"-SPUR2LEN        PIC  9(02).
        15   "*"-SPUR2           PIC  X(38).
        15   "*"-REFNR           PIC  X(12).
        15   "*"-POSNR           PIC  X(12).
        15   "*"-ISOPOSNR        PIC  X(06).
        15   "*"-AID             PIC  X(06).
        15   "*"-AC              PIC  9(02).
        15   "*"-TERMNR          PIC  9(08).
        15   "*"-TERMID          PIC  X(04).
        15   "*"-VUNR            PIC  X(15).
        15   "*"-HAENDLER        PIC  X(40).
        15   "*"-EELC            PIC  X(22).
        15   "*"-EELCLEN         PIC  9(03).
        15   "*"-WAEHR-ACQ       PIC  9(03).
        15   "*"-WAEHR-ISS       PIC  9(03).
        15   "*"-PAC             PIC  X(08).

*KL990118
*       15   "*"-VERSCH-LEN      PIC  9(03).
*       15   "*"-VERSCH-PARAM.
*        20  "*"-SI              PIC  X(08).
*        20  "*"-SN              PIC  X.

        15   "*"-SVERF           PIC  X(16).
        15   "*"-VERSCH-LEN      PIC  9(03).
        15   "*"-VERSCH-PARAM.
         20  "*"-SI              PIC  X(08).
         20  "*"-SN              PIC  X.
         20  "*"-FILLER          PIC  X(25).
        15   "*"-VERSCH-PARAM-N REDEFINES "*"-VERSCH-PARAM.
         20  "*"-SG              PIC  X.
         20  "*"-SV              PIC  X.
         20  "*"-RNDMES          PIC  X(16).
         20  "*"-RNDPAC          PIC  X(16).
*KL990118

        15   "*"-BMP59DATEN.
         20  "*"-BMP59LEN        PIC  999.
         20  "*"-BMP59           PIC  X(08).
        15   "*"-BMP60DATEN.
         20  "*"-BMP60LEN        PIC  999.
         20  "*"-ISOBMP60        PIC  X(99).
        15   "*"-FBZ             PIC  9.
        15   "*"-FBZLEN          PIC  9(03).
        15   "*"-AUTODATEN.
         20  "*"-TRANSTYP        PIC  9(04).
         20  "*"-AUTOTRACENR     PIC  9(06).
         20  "*"-AUTOZEIT        PIC  9(06).
         20  "*"-AUTODATUM       PIC  9(04).
         20  "*"-AUTONETID       PIC  X(11).
         20  "*"-AUTOUES         PIC  X(11).
        15   "*"-MAC             PIC  X(08).

?section WSYS954C
*****************************************************************
* Autor            : APCON C&S
* erstellt am      : 02.02.1999  (fuer easycash WSYS951)
* letzte Aenderung : 20.11.2001
* Beschreibung     : Schnittstelle zum Modul WSYS952 ISO-8583,
*                    für WXEMA04 / neues PacMAc-Verfahren
*                    == 16-Byte Schlüssel / Triple DES Terminal ==
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    240 -   ungueltiger Wert fuer CMD
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*
*    Feld CMD      : 12  -   ISO nach COBOL
*                    13  -   COBOL nach ISO
*
*    Feld ISOTYP   : 1   -   EC-Nachricht (vom Terminal - zum Terminal)
*                    2   -   EDC-Nachricht(von und zur UES)
*
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld BYTEMAP    I/O     Byte-Map der Iso-Nachricht
*
*    Feld COBREC   : I/O     edc-spezifischer record fuer die
*                            Daten der Felder der ISO-Nachricht
*
*
*
* Aenderungen      :
*
*    20.11.2001 - 88-iger Stufe ..-GICC bei ISOTYP dazugenommen
*
*
*****************************************************************
*
 01          "*"-WSYS954C.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-ISO2COB                    VALUE    12.
          88 "*"-COB2ISO                    VALUE    13.

      10     "*"-ISOTYP          PIC S9(04) COMP.
          88 "*"-EC                         VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-GICC                       VALUE    3.

     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(256).
      10     "*"-BYTEMAP         PIC  X(128).
      10     "*"-COBREC.
        15   "*"-NTYPE           PIC  9(04).
        15   "*"-PANLEN          PIC  9(02).
        15   "*"-PAN             PIC  X(19).
        15   "*"-ABWKZ           PIC  9(06).
        15   "*"-BETRAG          PIC  9(12).
        15   "*"-ISOBETRAG       PIC  X(06).
        15   "*"-TRACENR         PIC  9(06).
        15   "*"-ISOTRACENR      PIC  X(03).
        15   "*"-ZEIT            PIC  9(06).
        15   "*"-ISOZEIT         PIC  X(03).
        15   "*"-DATUM           PIC  9(04).
        15   "*"-ISODATUM        PIC  X(02).
        15   "*"-VERFALL         PIC  9(04).
        15   "*"-BRANCH          PIC  9(04).
        15   "*"-CCODE           PIC  9(04).
        15   "*"-ERFASSUNG       PIC  9(03).
        15   "*"-KARTENF         PIC  9(04).
        15   "*"-KONDCODE        PIC  9(02).
        15   "*"-ANZPIN          PIC  9(02).
        15   "*"-NETZBETRLEN     PIC  9(02).
        15   "*"-NETZBETR        PIC  X(12).
        15   "*"-UESLEN          PIC  9(02).
        15   "*"-UESSTELLE       PIC  X(12).
        15   "*"-ISOUES          PIC  X(06).
        15   "*"-ECPAN.
         20  "*"-ECBH            PIC  99.
         20  "*"-ECBLZ           PIC  9(8).
         20  "*"-ECTRENN         PIC  X.
         20  "*"-ECKONTO         PIC  9(10).
         20  "*"-ECPRZIF         PIC  9.
        15   "*"-SPUR2LEN        PIC  9(02).
        15   "*"-SPUR2           PIC  X(38).
        15   "*"-REFNR           PIC  X(12).
        15   "*"-POSNR           PIC  X(12).
        15   "*"-ISOPOSNR        PIC  X(06).
        15   "*"-AID             PIC  X(06).
        15   "*"-AC              PIC  9(02).
        15   "*"-TERMNR          PIC  9(08).
        15   "*"-TERMID          PIC  X(04).
        15   "*"-VUNR            PIC  X(15).
        15   "*"-HAENDLER        PIC  X(40).

        15   "*"-BMP48.
          20 "*"-BMP48LEN        PIC  9(03).
          20 "*"-BMP48DATA.
           25  "*"-K-MAC-T-NEU   PIC  X(16).
           25  "*"-K-PAC-T-NEU   PIC  X(16).
           25  "*"-IKT           PIC  X(02).

        15   "*"-EELC            PIC  X(22).
        15   "*"-EELCLEN         PIC  9(03).
        15   "*"-WAEHR-ACQ       PIC  9(03).
        15   "*"-WKZ             PIC  9(03)
                 REDEFINES "*"-WAEHR-ACQ.
        15   "*"-WAEHR-ISS       PIC  9(03).
        15   "*"-PAC             PIC  X(08).
        15   "*"-SVERF           PIC  X(16).
        15   "*"-VERSCH-LEN      PIC  9(03).

        15   "*"-VERSCH-PARAM.
         20  "*"-IHT             PIC  X.
         20  "*"-VHT             PIC  X.
         20  "*"-RND             PIC  X(08).
         20  "*"-SI              PIC  X(08).
         20  "*"-FILLER          PIC  X(16).
        15   "*"-VERSCH-PARAM-N REDEFINES "*"-VERSCH-PARAM.
         20  "*"-SG              PIC  X.
         20  "*"-SV              PIC  X.
         20  "*"-RNDMES          PIC  X(16).
         20  "*"-RNDPAC          PIC  X(16).

        15   "*"-BMP59DATEN.
         20  "*"-BMP59LEN        PIC  999.
         20  "*"-BMP59           PIC  X(08).

        15   "*"-BMP60DATEN.
         20  "*"-BMP60LEN        PIC  999.
         20  "*"-ISOBMP60        PIC  X(99).
        15   "*"-FBZ             PIC  9.
        15   "*"-FBZLEN          PIC  9(03).
        15   "*"-AUTODATEN.
         20  "*"-TRANSTYP        PIC  9(04).
         20  "*"-AUTOTRACENR     PIC  9(06).
         20  "*"-AUTOZEIT        PIC  9(06).
         20  "*"-AUTODATUM       PIC  9(04).
         20  "*"-AUTONETID       PIC  X(11).
         20  "*"-AUTOUES         PIC  X(11).
        15   "*"-MAC             PIC  X(08).


?section WSYS955C
*****************************************************************
* Autor            : APCON C&S
* erstellt am      : 31.01.2003
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum Modul WSYS955 ISO-8583,
*                    für OPT/CHIP
*                    == 16-Byte Schlüssel / Triple DES Terminal ==
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    240 -   ungueltiger Wert fuer CMD
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*
*    Feld CMD      : 12  -   ISO nach COBOL
*                    13  -   COBOL nach ISO
*
*    Feld ISOTYP   : 1   -   EC-Nachricht (vom Terminal - zum Terminal)
*                    2   -   EDC-Nachricht(von und zur UES)
*                    3   -   GICC
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld BYTEMAP    I/O     Byte-Map der Iso-Nachricht
*
*    Feld COBREC   : I/O     edc-spezifischer record fuer die
*                            Daten der Felder der ISO-Nachricht
*
*
*
* Aenderungen      :
*
*
*****************************************************************
*
 01          "*"-WSYS955C.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-ISO2COB                    VALUE    12.
          88 "*"-COB2ISO                    VALUE    13.

      10     "*"-ISOTYP          PIC S9(04) COMP.
          88 "*"-EC                         VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-OPT                        VALUE    4.

     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(512).
      10     "*"-BYTEMAP         PIC  X(128).
      10     "*"-COBREC.
        15   "*"-NTYPE           PIC  9(04).
        15   "*"-PANLEN          PIC  9(02).
        15   "*"-PAN             PIC  X(19).
        15   "*"-ABWKZ           PIC  9(06).
        15   "*"-BETRAG          PIC  9(12).
        15   "*"-ISOBETRAG       PIC  X(06).
        15   "*"-TRACENR         PIC  9(06).
        15   "*"-ISOTRACENR      PIC  X(03).
        15   "*"-ZEIT            PIC  9(06).
        15   "*"-ISOZEIT         PIC  X(03).
        15   "*"-DATUM           PIC  9(04).
        15   "*"-ISODATUM        PIC  X(02).
        15   "*"-VERFALL         PIC  9(04).
        15   "*"-BRANCH          PIC  9(04).
        15   "*"-CCODE           PIC  9(04).
        15   "*"-ERFASSUNG       PIC  9(03).
        15   "*"-KARTENF         PIC  9(04).
        15   "*"-KONDCODE        PIC  9(02).
        15   "*"-ANZPIN          PIC  9(02).
        15   "*"-NETZBETRLEN     PIC  9(02).
        15   "*"-NETZBETR        PIC  X(12).
        15   "*"-UESLEN          PIC  9(02).
        15   "*"-UESSTELLE       PIC  X(12).
        15   "*"-ISOUES          PIC  X(06).
        15   "*"-ECPAN.
         20  "*"-ECBH            PIC  99.
         20  "*"-ECBLZ           PIC  9(8).
         20  "*"-ECTRENN         PIC  X.
         20  "*"-ECKONTO         PIC  9(10).
         20  "*"-ECPRZIF         PIC  9.
        15   "*"-SPUR2LEN        PIC  9(02).
        15   "*"-SPUR2           PIC  X(38).
        15   "*"-REFNR           PIC  X(12).
        15   "*"-POSNR           PIC  X(12).
        15   "*"-ISOPOSNR        PIC  X(06).
        15   "*"-AID             PIC  X(06).
        15   "*"-AC              PIC  9(02).
        15   "*"-TERMNR          PIC  9(08).
        15   "*"-TERMID          PIC  X(04).
        15   "*"-BETRBLZ         PIC  X(08).
        15   "*"-HAENDLER        PIC  X(40).

        15   "*"-BMP48.
          20 "*"-BMP48LEN        PIC  9(03).
          20 "*"-BMP48DATA.
           25  "*"-K-MAC-T-NEU   PIC  X(16).
           25  "*"-K-PAC-T-NEU   PIC  X(16).
           25  "*"-IKT           PIC  X(02).

        15   "*"-EELC            PIC  X(22).
        15   "*"-EELCLEN         PIC  9(03).
        15   "*"-WAEHR-ACQ       PIC  9(03).
        15   "*"-WKZ             PIC  9(03)
                 REDEFINES "*"-WAEHR-ACQ.
        15   "*"-WAEHR-ISS       PIC  9(03).
        15   "*"-PAC             PIC  X(08).
        15   "*"-SVERF           PIC  X(16).
        15   "*"-VERSCH-LEN      PIC  9(03).

        15   "*"-VERSCH-PARAM.
         20  "*"-IHT             PIC  X.
         20  "*"-VHT             PIC  X.
         20  "*"-RND             PIC  X(08).
         20  "*"-SI              PIC  X(08).
         20  "*"-FILLER          PIC  X(16).
*
        15   "*"-VERSCH-PARAM-N REDEFINES "*"-VERSCH-PARAM.
         20  "*"-SG              PIC  X.
         20  "*"-SV              PIC  X.
         20  "*"-RNDMES          PIC  X(16).
         20  "*"-RNDPAC          PIC  X(16).
*
        15   "*"-BMP59DATEN.
         20  "*"-BMP59LEN        PIC  999.
         20  "*"-BMP59           PIC  X(08).
*
        15   "*"-BMP60DATEN.
         20  "*"-BMP60LEN        PIC  999.
         20  "*"-ISOBMP60        PIC  X(256).
*
        15   "*"-BMP61DATEN.
         20  "*"-BMP61LEN        PIC  999.
         20  "*"-ISOBMP61        PIC  X(256).
*
        15   "*"-BMP62DATEN.
         20  "*"-BMP62LEN        PIC  999.
         20  "*"-ISOBMP62        PIC  X(256).
*
        15   "*"-FBZ             PIC  9.
        15   "*"-FBZLEN          PIC  9(03).
        15   "*"-AUTODATEN.
         20  "*"-TRANSTYP        PIC  9(04).
         20  "*"-AUTOTRACENR     PIC  9(06).
         20  "*"-AUTOZEIT        PIC  9(06).
         20  "*"-AUTODATUM       PIC  9(04).
         20  "*"-AUTONETID       PIC  X(11).
         20  "*"-AUTOUES         PIC  X(11).
*
        15   "*"-MAC             PIC  X(08).


?section ASKAI956C
*****************************************************************
* Autor            : HJO
* erstellt am      : 19.09.2008
* letzte Aenderung : 29.06.2011
* Beschreibung     : Schnittstelle zum Modul WSYS956 ISO-8583,
*                    für OPT/CHIP/KAAI 2.1
*                    == 16-Byte Schlüssel / Triple DES Terminal ==
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    240 -   ungueltiger Wert fuer CMD
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*
*    Feld CMD      : 12  -   ISO nach COBOL
*                    13  -   COBOL nach ISO
*
*    Feld ISOTYP   : 1   -   EC-Nachricht (vom Terminal - zum Terminal)
*                    2   -   EDC-Nachricht(von und zur UES)
*                    3   -   GICC
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld BYTEMAP    I/O     Byte-Map der Iso-Nachricht
*
*    Feld COBREC   : I/O     edc-spezifischer record fuer die
*                            Daten der Felder der ISO-Nachricht
*
*
*
* Aenderungen      :
*
*    28.07.2003  : in WSYS956C BMP42 geaendert
*    29.06.2011  : kl - Neues Feld Faellig fuer neues BMP 15
*    20.08.2013  : jb - Neues Feld BMP54DATEN fuer neues BMP 54
*****************************************************************
*
 01          "*"-ASKAI956C.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-ISO2COB                    VALUE    12.
          88 "*"-COB2ISO                    VALUE    13.

      10     "*"-ISOTYP          PIC S9(04) COMP.
          88 "*"-EC                         VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-OPT                        VALUE    4.

     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(1024).
      10     "*"-BYTEMAP         PIC  X(128).
      10     "*"-COBREC.
        15   "*"-NTYPE           PIC  9(04).
        15   "*"-PANLEN          PIC  9(02).
        15   "*"-PAN             PIC  X(19).
        15   "*"-ABWKZ           PIC  9(06).
        15   "*"-BETRAG          PIC  9(12).
        15   "*"-ISOBETRAG       PIC  X(06).
        15   "*"-TRACENR         PIC  9(06).
        15   "*"-ISOTRACENR      PIC  X(03).
        15   "*"-ZEIT            PIC  9(06).
        15   "*"-ISOZEIT         PIC  X(03).
        15   "*"-DATUM           PIC  9(04).
        15   "*"-ISODATUM        PIC  X(02).
        15   "*"-VERFALL         PIC  9(04).
        15   "*"-FAELLIG         PIC  9(04).
        15   "*"-BRANCH          PIC  9(04).
        15   "*"-CCODE           PIC  9(04).
        15   "*"-ERFASSUNG       PIC  9(03).
        15   "*"-KARTENF         PIC  9(04).
        15   "*"-KONDCODE        PIC  9(02).
        15   "*"-ANZPIN          PIC  9(02).
        15   "*"-NETZBETRLEN     PIC  9(02).
        15   "*"-NETZBETR        PIC  X(12).
        15   "*"-UESLEN          PIC  9(02).
        15   "*"-UESSTELLE       PIC  X(12).
        15   "*"-ISOUES          PIC  X(06).
        15   "*"-ECPAN.
         20  "*"-ECBH            PIC  99.
         20  "*"-ECBLZ           PIC  9(8).
         20  "*"-ECTRENN         PIC  X.
         20  "*"-ECKONTO         PIC  9(10).
         20  "*"-ECPRZIF         PIC  9.
        15   "*"-SPUR2LEN        PIC  9(02).
        15   "*"-SPUR2           PIC  X(38).
        15   "*"-REFNR           PIC  X(12).
        15   "*"-POSNR           PIC  X(12).
        15   "*"-ISOPOSNR        PIC  X(06).
        15   "*"-AID             PIC  X(06).
        15   "*"-AC              PIC  X(02).
        15   "*"-TERMNR          PIC  9(08).
        15   "*"-TERMID          PIC  X(04).
        15   "*"-VUNR            PIC  X(15).
        15   "*"-HAENDLER        PIC  X(40).

        15   "*"-BMP48.
          20 "*"-BMP48LEN        PIC  9(03).
          20 "*"-BMP48DATA.
           25  "*"-K-MAC-T-NEU   PIC  X(16).
           25  "*"-K-PAC-T-NEU   PIC  X(16).
           25  "*"-IKT           PIC  X(02).

        15   "*"-EELC            PIC  X(22).
        15   "*"-EELCLEN         PIC  9(03).
        15   "*"-WAEHR-ACQ       PIC  9(03).
        15   "*"-WKZ             PIC  9(03)
                 REDEFINES "*"-WAEHR-ACQ.
        15   "*"-WAEHR-ISS       PIC  9(03).
        15   "*"-PAC             PIC  X(08).
        15   "*"-SVERF           PIC  X(16).

        15   "*"-BMP55DATEN.
         20  "*"-BMP55LEN        PIC  999.
         20  "*"-ISOBMP55        PIC  X(512).
*
        15   "*"-VERSCH-LEN      PIC  9(03).
        15   "*"-VERSCH-PARAM.
         20  "*"-SEQUNR          PIC  X(08).
         20  "*"-KEYGGVV         PIC  X(02).
         20  "*"-RNDMES          PIC  X(16).
         20  "*"-RNDPAC          PIC  X(16).
         20  "*"-NETWORK         PIC  X(16).
*
        15   "*"-BMP54DATEN.
         20  "*"-BMP54LEN        PIC  999.
         20  "*"-BMP54           PIC  X(128).
*
        15   "*"-BMP59DATEN.
         20  "*"-BMP59LEN        PIC  999.
         20  "*"-BMP59           PIC  X(08).
*
        15   "*"-BMP60DATEN.
         20  "*"-BMP60LEN        PIC  999.
         20  "*"-ISOBMP60        PIC  X(512).
*
        15   "*"-BMP61DATEN.
         20  "*"-BMP61LEN        PIC  999.
         20  "*"-ISOBMP61        PIC  X(512).
*
        15   "*"-BMP62DATEN.
         20  "*"-BMP62LEN        PIC  999.
         20  "*"-ISOBMP62        PIC  X(512).
*
        15   "*"-FBZ             PIC  9.
        15   "*"-FBZLEN          PIC  9(03).
        15   "*"-AUTODATEN.
         20  "*"-TRANSTYP        PIC  9(04).
         20  "*"-AUTOTRACENR     PIC  9(06).
         20  "*"-AUTOZEIT        PIC  9(06).
         20  "*"-AUTODATUM       PIC  9(04).
         20  "*"-AUTONETID       PIC  X(11).
         20  "*"-AUTOUES         PIC  X(11).
*
        15   "*"-MAC             PIC  X(08).




?section WSYS956C
*****************************************************************
* Autor            : APCON C&S
* erstellt am      : 31.01.2003
* letzte Aenderung : 28.07.2003
* Beschreibung     : Schnittstelle zum Modul WSYS956 ISO-8583,
*                    für OPT/CHIP
*                    == 16-Byte Schlüssel / Triple DES Terminal ==
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    240 -   ungueltiger Wert fuer CMD
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*
*    Feld CMD      : 12  -   ISO nach COBOL
*                    13  -   COBOL nach ISO
*
*    Feld ISOTYP   : 1   -   EC-Nachricht (vom Terminal - zum Terminal)
*                    2   -   EDC-Nachricht(von und zur UES)
*                    3   -   GICC
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld BYTEMAP    I/O     Byte-Map der Iso-Nachricht
*
*    Feld COBREC   : I/O     edc-spezifischer record fuer die
*                            Daten der Felder der ISO-Nachricht
*
*
*
* Aenderungen      :
*
*    28.07.2003  : in WSYS956C BMP42 geaendert
*
*****************************************************************
*
 01          "*"-WSYS956C.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-ISO2COB                    VALUE    12.
          88 "*"-COB2ISO                    VALUE    13.

      10     "*"-ISOTYP          PIC S9(04) COMP.
          88 "*"-EC                         VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-OPT                        VALUE    4.

     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(1024).
      10     "*"-BYTEMAP         PIC  X(128).
      10     "*"-COBREC.
        15   "*"-NTYPE           PIC  9(04).
        15   "*"-PANLEN          PIC  9(02).
        15   "*"-PAN             PIC  X(19).
        15   "*"-ABWKZ           PIC  9(06).
        15   "*"-BETRAG          PIC  9(12).
        15   "*"-ISOBETRAG       PIC  X(06).
        15   "*"-TRACENR         PIC  9(06).
        15   "*"-ISOTRACENR      PIC  X(03).
        15   "*"-ZEIT            PIC  9(06).
        15   "*"-ISOZEIT         PIC  X(03).
        15   "*"-DATUM           PIC  9(04).
        15   "*"-ISODATUM        PIC  X(02).
        15   "*"-VERFALL         PIC  9(04).
        15   "*"-BRANCH          PIC  9(04).
        15   "*"-CCODE           PIC  9(04).
        15   "*"-ERFASSUNG       PIC  9(03).
        15   "*"-KARTENF         PIC  9(04).
        15   "*"-KONDCODE        PIC  9(02).
        15   "*"-ANZPIN          PIC  9(02).
        15   "*"-NETZBETRLEN     PIC  9(02).
        15   "*"-NETZBETR        PIC  X(12).
        15   "*"-UESLEN          PIC  9(02).
        15   "*"-UESSTELLE       PIC  X(12).
        15   "*"-ISOUES          PIC  X(06).
        15   "*"-ECPAN.
         20  "*"-ECBH            PIC  99.
         20  "*"-ECBLZ           PIC  9(8).
         20  "*"-ECTRENN         PIC  X.
         20  "*"-ECKONTO         PIC  9(10).
         20  "*"-ECPRZIF         PIC  9.
        15   "*"-SPUR2LEN        PIC  9(02).
        15   "*"-SPUR2           PIC  X(38).
        15   "*"-REFNR           PIC  X(12).
        15   "*"-POSNR           PIC  X(12).
        15   "*"-ISOPOSNR        PIC  X(06).
        15   "*"-AID             PIC  X(06).
        15   "*"-ACX.
         20  "*"-AC              PIC  9(02).
        15   "*"-TERMNR          PIC  9(08).
        15   "*"-TERMID          PIC  X(04).
        15   "*"-VUNR            PIC  X(15).
        15   "*"-HAENDLER        PIC  X(40).

        15   "*"-BMP48.
          20 "*"-BMP48LEN        PIC  9(03).
          20 "*"-BMP48DATA.
           25  "*"-K-MAC-T-NEU   PIC  X(16).
           25  "*"-K-PAC-T-NEU   PIC  X(16).
           25  "*"-IKT           PIC  X(02).

        15   "*"-EELC            PIC  X(22).
        15   "*"-EELCLEN         PIC  9(03).
        15   "*"-WAEHR-ACQ       PIC  9(03).
        15   "*"-WKZ             PIC  9(03)
                 REDEFINES "*"-WAEHR-ACQ.
        15   "*"-WAEHR-ISS       PIC  9(03).
        15   "*"-PAC             PIC  X(08).
        15   "*"-SVERF           PIC  X(16).

        15   "*"-BMP55DATEN.
         20  "*"-BMP55LEN        PIC  999.
         20  "*"-ISOBMP55        PIC  X(512).
*
        15   "*"-VERSCH-LEN      PIC  9(03).
        15   "*"-VERSCH-PARAM.
         20  "*"-IHT             PIC  X.
         20  "*"-VHT             PIC  X.
         20  "*"-RND             PIC  X(08).
         20  "*"-SI              PIC  X(08).
         20  "*"-FILLER          PIC  X(16).
*
        15   "*"-VERSCH-PARAM-N REDEFINES "*"-VERSCH-PARAM.
         20  "*"-SG              PIC  X.
         20  "*"-SV              PIC  X.
         20  "*"-RNDMES          PIC  X(16).
         20  "*"-RNDPAC          PIC  X(16).
*
        15   "*"-BMP59DATEN.
         20  "*"-BMP59LEN        PIC  999.
         20  "*"-BMP59           PIC  X(08).
*
        15   "*"-BMP60DATEN.
         20  "*"-BMP60LEN        PIC  999.
         20  "*"-ISOBMP60        PIC  X(512).
*
        15   "*"-BMP61DATEN.
         20  "*"-BMP61LEN        PIC  999.
         20  "*"-ISOBMP61        PIC  X(512).
*
        15   "*"-BMP62DATEN.
         20  "*"-BMP62LEN        PIC  999.
         20  "*"-ISOBMP62        PIC  X(512).
*
        15   "*"-FBZ             PIC  9.
        15   "*"-FBZLEN          PIC  9(03).
        15   "*"-AUTODATEN.
         20  "*"-TRANSTYP        PIC  9(04).
         20  "*"-AUTOTRACENR     PIC  9(06).
         20  "*"-AUTOZEIT        PIC  9(06).
         20  "*"-AUTODATUM       PIC  9(04).
         20  "*"-AUTONETID       PIC  X(11).
         20  "*"-AUTOUES         PIC  X(11).
*
        15   "*"-MAC             PIC  X(08).


?section WSYS956X
*****************************************************************
* Autor            : APCON C&S
* erstellt am      : 31.01.2003
* letzte Aenderung : 28.02.2007
* Beschreibung     : Schnittstelle zum Modul WSYS956 ISO-8583,
*                    für OPT/CHIP
*                    == 16-Byte Schlüssel / Triple DES Terminal ==
*                    bmp48 auf 68 bytes verlängert
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    240 -   ungueltiger Wert fuer CMD
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*
*    Feld CMD      : 12  -   ISO nach COBOL
*                    13  -   COBOL nach ISO
*
*    Feld ISOTYP   : 1   -   EC-Nachricht (vom Terminal - zum Terminal)
*                    2   -   EDC-Nachricht(von und zur UES)
*                    3   -   GICC
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld BYTEMAP    I/O     Byte-Map der Iso-Nachricht
*
*    Feld COBREC   : I/O     edc-spezifischer record fuer die
*                            Daten der Felder der ISO-Nachricht
*
*
*
* Aenderungen      :
*
*    28.07.2003  : in WSYS956C BMP42 geaendert
*
*****************************************************************
*
 01          "*"-WSYS956X.
     05      "*"-VERWALTUNG.
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-ISO2COB                    VALUE    12.
          88 "*"-COB2ISO                    VALUE    13.

      10     "*"-ISOTYP          PIC S9(04) COMP.
          88 "*"-EC                         VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-OPT                        VALUE    4.

     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(1024).
      10     "*"-BYTEMAP         PIC  X(128).
      10     "*"-COBREC.
        15   "*"-NTYPE           PIC  9(04).
        15   "*"-PANLEN          PIC  9(02).
        15   "*"-PAN             PIC  X(19).
        15   "*"-ABWKZ           PIC  9(06).
        15   "*"-BETRAG          PIC  9(12).
        15   "*"-ISOBETRAG       PIC  X(06).
        15   "*"-TRACENR         PIC  9(06).
        15   "*"-ISOTRACENR      PIC  X(03).
        15   "*"-ZEIT            PIC  9(06).
        15   "*"-ISOZEIT         PIC  X(03).
        15   "*"-DATUM           PIC  9(04).
        15   "*"-ISODATUM        PIC  X(02).
        15   "*"-VERFALL         PIC  9(04).
        15   "*"-BRANCH          PIC  9(04).
        15   "*"-CCODE           PIC  9(04).
        15   "*"-ERFASSUNG       PIC  9(03).
        15   "*"-KARTENF         PIC  9(04).
        15   "*"-KONDCODE        PIC  9(02).
        15   "*"-ANZPIN          PIC  9(02).
        15   "*"-NETZBETRLEN     PIC  9(02).
        15   "*"-NETZBETR        PIC  X(12).
        15   "*"-UESLEN          PIC  9(02).
        15   "*"-UESSTELLE       PIC  X(12).
        15   "*"-ISOUES          PIC  X(06).
        15   "*"-ECPAN.
         20  "*"-ECBH            PIC  99.
         20  "*"-ECBLZ           PIC  9(8).
         20  "*"-ECTRENN         PIC  X.
         20  "*"-ECKONTO         PIC  9(10).
         20  "*"-ECPRZIF         PIC  9.
        15   "*"-SPUR2LEN        PIC  9(02).
        15   "*"-SPUR2           PIC  X(38).
        15   "*"-REFNR           PIC  X(12).
        15   "*"-POSNR           PIC  X(12).
        15   "*"-ISOPOSNR        PIC  X(06).
        15   "*"-AID             PIC  X(06).
        15   "*"-AC              PIC  9(02).
        15   "*"-TERMNR          PIC  9(08).
        15   "*"-TERMID          PIC  X(04).
        15   "*"-VUNR            PIC  X(15).
        15   "*"-HAENDLER        PIC  X(40).

        15   "*"-BMP48.
          20 "*"-BMP48LEN        PIC  9(03).
          20 "*"-BMP48DATA.
           25  "*"-K-MAC-T-NEU   PIC  X(16).
           25  "*"-K-PAC-T-NEU   PIC  X(16).
           25  "*"-IKT           PIC  X(02).
           25  "*"-K-MAC-NONEC   PIC  X(16).
           25  "*"-K-PAC-NONEC   PIC  X(16).
           25  "*"-IKTNONEC      PIC  X(02).

        15   "*"-EELC            PIC  X(22).
        15   "*"-EELCLEN         PIC  9(03).
        15   "*"-WAEHR-ACQ       PIC  9(03).
        15   "*"-WKZ             PIC  9(03)
                 REDEFINES "*"-WAEHR-ACQ.
        15   "*"-WAEHR-ISS       PIC  9(03).
        15   "*"-PAC             PIC  X(08).
        15   "*"-SVERF           PIC  X(16).

        15   "*"-BMP55DATEN.
         20  "*"-BMP55LEN        PIC  999.
         20  "*"-ISOBMP55        PIC  X(512).
*
        15   "*"-VERSCH-LEN      PIC  9(03).
        15   "*"-VERSCH-PARAM.
         20  "*"-IHT             PIC  X.
         20  "*"-VHT             PIC  X.
         20  "*"-RND             PIC  X(08).
         20  "*"-SI              PIC  X(08).
         20  "*"-FILLER          PIC  X(16).
*
        15   "*"-VERSCH-PARAM-N REDEFINES "*"-VERSCH-PARAM.
         20  "*"-SG              PIC  X.
         20  "*"-SV              PIC  X.
         20  "*"-RNDMES          PIC  X(16).
         20  "*"-RNDPAC          PIC  X(16).
*
        15   "*"-BMP59DATEN.
         20  "*"-BMP59LEN        PIC  999.
         20  "*"-BMP59           PIC  X(08).
*
        15   "*"-BMP60DATEN.
         20  "*"-BMP60LEN        PIC  999.
         20  "*"-ISOBMP60        PIC  X(512).
*
        15   "*"-BMP61DATEN.
         20  "*"-BMP61LEN        PIC  999.
         20  "*"-ISOBMP61        PIC  X(512).
*
        15   "*"-BMP62DATEN.
         20  "*"-BMP62LEN        PIC  999.
         20  "*"-ISOBMP62        PIC  X(512).
*
        15   "*"-FBZ             PIC  9.
        15   "*"-FBZLEN          PIC  9(03).
        15   "*"-AUTODATEN.
         20  "*"-TRANSTYP        PIC  9(04).
         20  "*"-AUTOTRACENR     PIC  9(06).
         20  "*"-AUTOZEIT        PIC  9(06).
         20  "*"-AUTODATUM       PIC  9(04).
         20  "*"-AUTONETID       PIC  X(11).
         20  "*"-AUTOUES         PIC  X(11).
*
        15   "*"-MAC             PIC  X(08).
        15   "*"-BMP63LEN        PIC  999.
        15   "*"-ISOBMP63        PIC  X(256).



?section WSYS054C
*******************************************************************
* Message fuer Modul WSYS054 Kommunikation zu den Kryptokom boxen *
*                                                     08.11.1999  *
* (eigentlich die Fregatten-Schnittstelle nur verlaengert)        *
*                                                                 *
* Uebernommen von easyscash                                       *
*******************************************************************
*----------------------> Laenge der Message
     05      "*"-LEN             PIC S9(04) COMP.
          88 WSYS054-LEN          VALUE 588.
*----------------------> Message
    05      "*"-SATZ.
      10     "*"-HEADER.
       15    "*"-CC              PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-READ-IL                    VALUE 1.
          88 "*"-WRITE-SL                   VALUE 2.
          88 "*"-AUFBAU-IL                  VALUE 3.
          88 "*"-ABBAU-SL                   VALUE 4.
          88 "*"-AUFBAU-BL                  VALUE 5.
          88 "*"-READ-AL                    VALUE 6.
          88 "*"-WRITE-AL                   VALUE 7.
          88 "*"-WRITEQ-AL                  VALUE 8.
          88 "*"-FREI-BL                    VALUE 9.
          88 "*"-SEND-ASYNC                 VALUE 10.
          88 "*"-SEND-SYNC                  VALUE 11.
          88 "*"-DISCON-TS                  VALUE 101.
          88 "*"-DISCON-TO                  VALUE 102.
          88 "*"-NO-CONNECT                 VALUE 103.
          88 "*"-NO-BL                      VALUE 104.
          88 "*"-MODEM-ERR                  VALUE 105.
          88 "*"-NO-ANSWER                  VALUE 106.
          88 "*"-UNS-MSG                    VALUE 107.
          88 "*"-APPL-DOWN                  VALUE 108.
          88 "*"-DIAGN-ANF                  VALUE 109.
          88 "*"-APPL-DOWN                  VALUE 108.
          88 "*"-DIAGN-ANF                  VALUE 109.
       15    "*"-TERMID          PIC X(16).
       15    "*"-NEXTSERV        PIC X(16).
       15    "*"-NEXTSERV-REDEF  REDEFINES "*"-NEXTSERV.
          20 "*"-SERVKLASSE      PIC X(12).
          20 "*"-SNIHEADZT       PIC X(04).
       15    "*"-LINE            PIC X(16).
       15    "*"-DATLEN          PIC S9(04) COMP.
       15    "*"-DTXNR           PIC X(16).
       15    "*"-CUGID           PIC 99.
       15    "*"-SESSNR          PIC S9(04) COMP.
       15    "*"-MONNAME         PIC X(16).
       15    "*"-MONNAME-REDEF  REDEFINES "*"-MONNAME.
          20 "*"-MONKLASSE       PIC X(12).
          20 "*"-SNIHEADVT       PIC X(04).
      10     "*"-NDATEN          PIC X(500).

?section PSYS999C
*****************************************************************
* Autor            : APCON C&S, J. Bahlmann
* erstellt am      : 13.05.1993
* letzte Aenderung :
* Beschreibung     : Schnittstelle zu den Programmen, die einen
*                    completioncode setzen wollen
*
* Aenderungen      :
*
* 19991208  kl  Uebernahme von easycash
*
*****************************************************************
*
  01          "*"-PSYS999C.
      05      "*"-CCODE           PIC S9(04) COMP.
      05      "*"-TXTNR           PIC S9(04) COMP.
      05      "*"-TEXT            PIC  X(80).

?Section WUMSC04C
*******************************************************************
* COPY-Struktur fuer WUMSC04A - E                                 *
* K. Lorenz                                           17.09.1999  *
*                                                                 *
* Kommandos und Nutzdaten fuer Cursorverarbeitung UMSATZ/PTRLOG   *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
 01     WUMSC04C.
     05      UMS-HEADER.
**          ---> Return-Code
      10     UMS-RCODE           PIC S9(04) COMP.
**          ---> Cursor
      10     UMS-CURS            PIC XX.
         88  UMS-PCSD010                 VALUE "A1".
         88  UMS-TSYS10X                 VALUE "B1".
         88  UMS-TSYS107                 VALUE "B2".
         88  UMS-TSYS912                 VALUE "C1".
         88  UMS-THKO311                 VALUE "D1".
         88  UMS-THKO311-2               VALUE "D2".
         88  UMS-THKO312                 VALUE "E1".
         88  UMS-THKO312-2               VALUE "E2".
         88  UMS-THKOEDC                 VALUE "F1".
         88  UMS-THKOEDC-2               VALUE "F2".

**          ---> Kommando
      10     UMS-CMD             PIC XX.
         88  UMS-OPEN                    VALUE "OP".
         88  UMS-CLOSE                   VALUE "CL".
         88  UMS-FETCH                   VALUE "FE".
         88  UMS-UPDATE                  VALUE "UP".
         88  UMS-DELETE                  VALUE "DE".
**          ---> Daten
     05      UMS-DATEN.
**          ---> UMSATZ-Satz
      10     UMS-SATZ            PIC X(100).
**          ---> Keys fuer Auswahl bei Cursor
      10     UMS-KEYS            PIC X(038).
      10     UMS-KEYS-R1 REDEFINES UMS-KEYS.

       15    UMS-TERMID          PIC X(004).
       15    UMS-TRACENR         PIC X(003).

       15    UMS-VON             PIC 9(004).
       15    UMS-BIS             PIC 9(004).
       15    FILLER              PIC X.
       15    UMS-TIMESTAMP       PIC X(008).
       15                        PIC X(014).



?Section WUMSC05C
*******************************************************************
* COPY-Struktur fuer WUMSC05                                      *
*                                                     12.01.2004  *
*                                                                 *
* Kommandos und Nutzdaten fuer Cursorverarbeitung UMSATZ/PTRLOG   *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
 01     WUMSC05C.
     05      UMS-HEADER.
**          ---> Return-Code
      10     UMS-RCODE           PIC S9(04) COMP.
**          ---> Cursor
      10     UMS-CURS            PIC XX.
         88  UMS-PCSD010                 VALUE "A1".
         88  UMS-TSYS10X                 VALUE "B1".
         88  UMS-TSYS107                 VALUE "B2".
         88  UMS-TSYS912                 VALUE "C1".
         88  UMS-THKO550-D1              VALUE "D1".
         88  UMS-THKO550-D2              VALUE "D2".
         88  UMS-THKO312                 VALUE "E1".
         88  UMS-THKO312-2               VALUE "E2".
         88  UMS-THKO550-F1              VALUE "F1".
         88  UMS-THKO550-F2              VALUE "F2".

**          ---> Kommando
      10     UMS-CMD             PIC XX.
         88  UMS-OPEN                    VALUE "OP".
         88  UMS-CLOSE                   VALUE "CL".
         88  UMS-FETCH                   VALUE "FE".
         88  UMS-UPDATE                  VALUE "UP".
         88  UMS-DELETE                  VALUE "DE".
**          ---> Daten
     05      UMS-DATEN.
**          ---> UMSATZ-Satz
      10     UMS-SATZ            PIC X(100).
**          ---> Keys fuer Auswahl bei Cursor
      10     UMS-KEYS            PIC X(038).
      10     UMS-KEYS-R1 REDEFINES UMS-KEYS.

       15    UMS-TERMID          PIC X(004).
       15    UMS-TRACENR         PIC X(003).

       15    UMS-VON             PIC 9(004).
       15    UMS-BIS             PIC 9(004).
       15    FILLER              PIC X.
       15    UMS-TIMESTAMP       PIC X(008).
       15                        PIC X(014).


?Section WUMSC07C
*******************************************************************
* COPY-Struktur fuer WUMSC07                                      *
*                                                     10.11.2014  *
*                                                                 *
* Kommandos und Nutzdaten fuer Cursorverarbeitung UMSWEAT/PTRLOG  *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
* 08.12.14        Neue Verabeitung / Neuer Cursor BFHMON7         *
*******************************************************************
 01     WUMSC07C.
     05      UMS-HEADER.
**          ---> Return-Code
      10     UMS-RCODE           PIC S9(04) COMP.
**          ---> Cursor
      10     UMS-CURS            PIC XX.
         88  UMS-WKASSW7                 VALUE "A1".
         88  UMS-BFHMON7                 VALUE "B1".
*         88  UMS-XXXXXXX                 VALUE "B1".

**          ---> Kommando
      10     UMS-CMD             PIC XX.
         88  UMS-OPEN                    VALUE "OP".
         88  UMS-CLOSE                   VALUE "CL".
         88  UMS-FETCH                   VALUE "FE".
         88  UMS-UPDATE                  VALUE "UP".
         88  UMS-DELETE                  VALUE "DE".
**          ---> Daten
     05      UMS-DATEN.
**          ---> UMSATZ-Satz
      10     UMS-SATZ            PIC X(100).
**          ---> Keys fuer Auswahl bei Cursor
      10     UMS-KEYS            PIC X(042).
      10     UMS-KEYS-R1 REDEFINES UMS-KEYS.

       15    UMS-TERMNR          PIC 9(008).
       15    UMS-TRACENR         PIC X(003).

       15    UMS-VON             PIC 9(004).
       15    UMS-BIS             PIC 9(004).
       15    FILLER              PIC X.
       15    UMS-TIMESTAMP       PIC X(008).
       15                        PIC X(012).
       15    UMS-CARDID          PIC 9(02).

?section WSYS021C
* ******************************************************************** *
*                   WSYS021 Datenschnittstelle                         *
* -------------------------------------------------------------------- *
* Author      :  Hanse Consult - Th.Spitzmann                          *
* Date created:  04-Mar-1991                                           *
* Last Change :  dto.                                                  *
* Remarks     :  geaendert fuer WEAT 15.9.2000 JB                                                       *
* ******************************************************************** *
*
* -------------------------------------------------------------------- *
*                A l l g e m e i n e   F e h l e r                     *
* -------------------------------------------------------------------- *
*
 01          GEN-ERROR.
     05      ERR-STAT            PIC S9(4) COMP.
     05      MODUL-NAME          PIC X(8).
     05      ERROR-KZ            PIC X(2).
     05      ERROR-NR            PIC S9(9) COMP.
     05      DATEN-BUFFER        PIC X(80).

* Es folgen applikationsspezifische Daten.
* Dieser Record muss fuer andere Applikationen angepasst werden.
     05      APPL-SPEC-BUF.
        10   MDNR                PIC 9(8).
        10   TSNR                PIC 9(8).
        10   TERMID              PIC X(4).

?section WSYS022C
* ****************************************************************
*                   WSYS022 Datenschnittstelle                   *
* ---------------------------------------------------------------*
* Author      :  JB
* Date created:  26-Mar-2001
* Last Change :
* Remarks     :
* ****************************************************************
*
* ---------------------------------------------------------------*
*                A l l g e m e i n e   F e h l e r               *
* ---------------------------------------------------------------*
*
 01          GEN-ERROR.
     05      ERR-STAT            PIC S9(4) COMP.
     05      MODUL-NAME          PIC X(8).
     05      ERROR-KZ            PIC X(2).
     05      ERROR-NR            PIC S9(9) COMP.
     05      DATEN-BUFFER.
      10     DATEN-BUFFER1       PIC X(80).
      10     DATEN-BUFFER2       PIC X(80).
      10     DATEN-BUFFER3       PIC X(80).
      10     DATEN-BUFFER4       PIC X(80).
      10     DATEN-BUFFER5       PIC X(80).

* Es folgen applikationsspezifische Daten.
* Dieser Record muss fuer andere Applikationen angepasst werden.
     05      APPL-SPEC-BUF.
        10   MDNR                PIC 9(8).
        10   TSNR                PIC 9(8).
        10   TERMID              PIC X(4).

?section WSYS023C
* ****************************************************************
*                   WSYS023 Datenschnittstelle                   *
* ---------------------------------------------------------------*
* Author      :  KL
* Date created:  04-Sep-2002
* Last Change :  06-Sep-2002
* Remarks     :  Anpassung an WSYS410C - Fehlerserver
* ****************************************************************
*
* ---------------------------------------------------------------*
*                A l l g e m e i n e   F e h l e r               *
* ---------------------------------------------------------------*
*
 01      GEN-ERROR.
    05   GEN-HEADER.
      10 ERR-STAT            PIC S9(4) COMP.
         88  ZUL-ERR-STAT        VALUE 0 1.
         88  IS-NOT-POS          VALUE 0.
         88  IS-POS              VALUE 1.
         88  IS-OK               VALUE 0.
         88  IS-STAT-ERR         VALUE 11.
         88  IS-KZ-ERR           VALUE 12.
         88  IS-ERRLOG           VALUE 13.
         88  IS-ERRLOGHO         VALUE 14.
         88  IS-DFUEOK           VALUE 15.
         88  IS-FEHLER           VALUE 91.
         88  IS-MANDANT          VALUE 99.
      10 MODUL-NAME          PIC X(8).
      10 ERROR-KZ            PIC X(2).
      10 ERROR-NR            PIC S9(4) COMP.
* Es folgen applikationsspezifische Daten.
* Dieser Record muss fuer andere Applikationen angepasst werden.
    05   APPL-SPEC-BUF.
      10 MDNR                PIC 9(8).
      10 TSNR                PIC 9(8).
      10 TERMID              PIC X(4).
      10 HOSA                PIC 9(2).
      10 TSSA                PIC 9(3).
      10 TRACENR             PIC X(3).
* Und hier die eigentlichen Fehlermeldungen. Es sind dies
* die Fehlertexte bei Programmfehlern bzw. der gesicherte
* SQLCA bei SQL-Fehlern
    05   DATEN-BUFFER.
      10 DATEN-BUFFER1       PIC X(75).
      10 DATEN-BUFFER2       PIC X(75).
      10 DATEN-BUFFER3       PIC X(75).
      10 DATEN-BUFFER4       PIC X(75).
      10 DATEN-BUFFER5       PIC X(75).
      10 DATEN-RESERVE       PIC X(137).

?section WSYS410C
* ****************************************************************
*                   WSYS410 Datenschnittstelle                   *
* ---------------------------------------------------------------*
* Author      :  KL
* Date created:  06-Sep-2002
* Last Change :
* Remarks     :
* ****************************************************************
*
* ---------------------------------------------------------------*
*                A l l g e m e i n e   F e h l e r               *
* ---------------------------------------------------------------*
*
* 01-er Stufe muss im Programm gesetzt sein.
     05      "*"-MONNAME             PIC X(16).
     05      "*"-GEN-ERROR.
        10   "*"-GEN-HEADER.
* Fehlerstatus
          15 "*"-ERR-STAT            PIC S9(4) COMP.
             88  "*"-ZUL-ERR-STAT    VALUE 0 1.
             88  "*"-IS-NOT-POS      VALUE 0.
             88  "*"-IS-POS          VALUE 1.
             88  "*"-IS-OK           VALUE 0.
             88  "*"-IS-STAT-ERR     VALUE 11.
             88  "*"-IS-KZ-ERR       VALUE 12.
             88  "*"-IS-ERRLOG       VALUE 13.
             88  "*"-IS-ERRLOGHO     VALUE 14.
             88  "*"-IS-DFUEOK       VALUE 15.
             88  "*"-IS-FEHLER       VALUE 91.
             88  "*"-IS-MANDANT      VALUE 99.
* verursachendes Programm
          15 "*"-MODUL-NAME          PIC X(8).
* Fehlerart (PE = Programm, SE = SQL)
          15 "*"-ERROR-KZ            PIC X(2).
* Fehlernummer entsprechend FENR in Tabelle FEHLER
          15 "*"-ERROR-NR            PIC S9(4) COMP.
* Es folgen applikationsspezifische Daten.
* Dieser Record muss fuer andere Applikationen angepasst werden.
        10   "*"-APPL-SPEC-BUF.
          15 "*"-MDNR                PIC 9(8).
          15 "*"-TSNR                PIC 9(8).
          15 "*"-TERMID              PIC X(4).
          15 "*"-HOSA                PIC 9(2).
          15 "*"-TSSA                PIC 9(3).
          15 "*"-TRACENR             PIC X(3).
* Und hier die eigentlichen Fehlermeldungen. Es sind dies
* die Fehlertexte bei Programmfehlern bzw. der gesicherte
* SQLCA bei SQL-Fehlern
        10   "*"-DATEN-BUFFER.
          15 "*"-DATEN-BUFFER1       PIC X(75).
          15 "*"-DATEN-BUFFER2       PIC X(75).
          15 "*"-DATEN-BUFFER3       PIC X(75).
          15 "*"-DATEN-BUFFER4       PIC X(75).
          15 "*"-DATEN-BUFFER5       PIC X(75).
          15 "*"-DATEN-RESERVE       PIC X(137).
        10   "*"-SQLCA               REDEFINES     "*"-DATEN-BUFFER.
          15 FILLER                  PIC X(512).
     05      "*"-IFC-RESERVE         PIC X(454).

?section WSYS04TC
*****************************************************************
* Autor            : ADCON C&S, Joachim Bahlmann
* erstellt am      : 12.08.1993
* letzte Aenderung : 31.01.2002
* Beschreibung     : Schnittstelle zum Pruefziffernmodul WSYS04T
*
*    Feld STATUS   : 0 - OK
*                    1 - nicht definierter Wert in KMDO
*                    2 - Pruefziffer falsch
*                    3 - Kartennummer fehlt
*                    4 - Kartennummer zu gross (bei Pruefziffer-
*                        berechnung max. 18 Stellen)
*
*    Feld KMDO     : 1 - Pruefziffer berechnen
*                    2 - Pruefziffer pruefen
*
*    Feld KANR     : linksbuendig, mit Spaces aufgefuellt
*
*                    bei KMDO = 1 (berechnen)
*
*                        - vom aufrufenden Modul
*                          ohne Pruefziffer (logo!?)
*                        - Rueckgabe KANR mit anhaengender,
*                          berechneter PZ
*
*                    bei KMDO = 2 (pruefen)
*
*                        immer vollstaendige KANR (mit PZ)
*
*
* Aenderungen      :  04.01.2001 - Erweiterung KANR auf 23 Stellen
*                     31.01.2002 - Umbenennung in WSYS04T
*
*****************************************************************
*
 01          "*"-WSYS04TC.
     05      "*"-STATUS          PIC S9(04) COMP.
          88 "*"-OK                              VALUE 0.
          88 "*"-ERR-STATUS                      VALUE -9999 THRU -1
                                                       1 THRU  9999.
          88 "*"-KMDO-NOK                        VALUE 1.
          88 "*"-PZ-NOK                          VALUE 2.
          88 "*"-KANR-MISSING                    VALUE 3.
          88 "*"-KANR-ERR                        VALUE 4.

     05      "*"-KMDO            PIC S9(04) COMP.
          88 "*"-KMDO-ERR                        VALUE -9999 THRU 0
                                                           3 THRU 9999.
          88 "*"-COMPUTE                         VALUE 1.
          88 "*"-CHECK                           VALUE 2.

     05      "*"-KANR            PIC  X(23).

*****************************************************************

?section PS2PRFC
*****************************************************************
* Autor            : AKQUINET, HJO
* erstellt am      : 21.02.2008
* letzte Aenderung : 21.02.2008
* Beschreibung     : Schnittstelle zum Spur-2 Prüfmodul PS2PRF
*                    ZKA-Prüfungen nach TA 7.0
*    Feld RCODE    : 0 - OK
*                   >0 - Antwortcode für ISO-MSG n KMDO
*
* Aenderungen      :
*
*
*****************************************************************
*
 01          "*"-PS2PRFC.
     05      "*"-RCODE               PIC S9(04) COMP.
          88 "*"-OK                             VALUE 0.
          88 "*"-ERR-STATUS                     VALUE -9999 THRU -1
                                                       1 THRU  9999.
     05      "*"-KARTEN-FLAG         PIC  99.
          88 "*"-GIRO-CARD                      VALUE 01.
          88 "*"-ALLIANCE-CARD                  VALUE 02.

*****************************************************************




?section WSYS041C
*****************************************************************
* Autor            : it-eys
* erstellt am      : 26.11.2003
* letzte Aenderung : 26.11.2002
* Beschreibung     : Schnittstelle zum Modul WSYS041,
*                    für WXEMA04 / Pruefung Spur 3 EC-Karten
*
*****************************************************************
*
 01          "*"-WSYS041C.
     05      "*"-DATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(256).
      10     "*"-BYTEMAP         PIC  X(128).
      10     "*"-COBREC.
        15   "*"-NTYPE           PIC  X(04).
        15   "*"-PANLEN          PIC  X(02).
        15   "*"-PAN             PIC  X(19).
        15   "*"-ABWKZ           PIC  X(06).
        15   "*"-BETRAG          PIC  X(12).
        15   "*"-ISOBETRAG       PIC  X(06).
        15   "*"-TRACENR         PIC  X(06).
        15   "*"-ISOTRACENR      PIC  X(03).
        15   "*"-ZEIT            PIC  X(06).
        15   "*"-ISOZEIT         PIC  X(03).
        15   "*"-DATUM           PIC  X(04).
        15   "*"-ISODATUM        PIC  X(02).
        15   "*"-VERFALL         PIC  X(04).
        15   "*"-BRANCH          PIC  X(04).
        15   "*"-CCODE           PIC  X(04).
        15   "*"-ERFASSUNG       PIC  X(03).
        15   "*"-KARTENF         PIC  X(04).
        15   "*"-KONDCODE        PIC  X(02).
        15   "*"-ANZPIN          PIC  X(02).
        15   "*"-NETZBETRLEN     PIC  X(02).
        15   "*"-NETZBETR        PIC  X(12).
        15   "*"-UESLEN          PIC  X(02).
        15   "*"-UESSTELLE       PIC  X(12).
        15   "*"-ISOUES          PIC  X(06).
        15   "*"-ECPAN.
         20  "*"-ECBH            PIC  XX.
         20  "*"-ECBLZ           PIC  X(8).
         20  "*"-ECTRENN         PIC  X.
         20  "*"-ECKONTO         PIC  X(10).
         20  "*"-ECPRZIF         PIC  X.
        15   "*"-SPUR2LEN        PIC  X(02).
        15   "*"-SPUR2           PIC  X(38).
        15   "*"-REFNR           PIC  X(12).
        15   "*"-POSNR           PIC  X(12).
        15   "*"-ISOPOSNR        PIC  X(06).
        15   "*"-AID             PIC  X(06).
        15   "*"-AC              PIC  X(02).
        15   "*"-TERMNR          PIC  X(08).
        15   "*"-TERMID          PIC  X(04).
        15   "*"-VUNR            PIC  X(15).
        15   "*"-HAENDLER        PIC  X(40).

        15   "*"-BMP48.
          20 "*"-BMP48LEN        PIC  X(03).
          20 "*"-BMP48DATA.
           25  "*"-K-MAC-T-NEU   PIC  X(16).
           25  "*"-K-PAC-T-NEU   PIC  X(16).
           25  "*"-IKT           PIC  X(02).

        15   "*"-EELC            PIC  X(22).
        15   "*"-EELCLEN         PIC  X(03).
        15   "*"-WAEHR-ACQ       PIC  X(03).
        15   "*"-WKZ             PIC  X(03)
                 REDEFINES "*"-WAEHR-ACQ.
        15   "*"-WAEHR-ISS       PIC  X(03).
        15   "*"-PAC             PIC  X(08).
        15   "*"-SVERF           PIC  X(16).
        15   "*"-VERSCH-LEN      PIC  X(03).

        15   "*"-VERSCH-PARAM.
         20  "*"-IHT             PIC  X.
         20  "*"-VHT             PIC  X.
         20  "*"-RND             PIC  X(08).
         20  "*"-SI              PIC  X(08).
         20  "*"-FILLER          PIC  X(16).
        15   "*"-VERSCH-PARAM-N REDEFINES "*"-VERSCH-PARAM.
         20  "*"-SG              PIC  X.
         20  "*"-SV              PIC  X.
         20  "*"-RNDMES          PIC  X(16).
         20  "*"-RNDPAC          PIC  X(16).

        15   "*"-BMP59DATEN.
         20  "*"-BMP59LEN        PIC  XXX.
         20  "*"-BMP59           PIC  X(08).

        15   "*"-BMP60DATEN.
         20  "*"-BMP60LEN        PIC  XXX.
         20  "*"-ISOBMP60        PIC  X(99).
        15   "*"-FBZ             PIC  9.
        15   "*"-FBZLEN          PIC  X(03).
        15   "*"-AUTODATEN.
         20  "*"-TRANSTYP        PIC  X(04).
         20  "*"-AUTOTRACENR     PIC  X(06).
         20  "*"-AUTOZEIT        PIC  X(06).
         20  "*"-AUTODATUM       PIC  X(04).
         20  "*"-AUTONETID       PIC  X(11).
         20  "*"-AUTOUES         PIC  X(11).
        15   "*"-MAC             PIC  X(08).


?section WSYS902C
*****************************************************************
* Autor            : APCON C&S, H-J Ohm
* erstellt am      : 03.04.1996
* letzte Aenderung : 13.02.2002
*
*    B.01.00     Uebnahme von PSYS901C
*
* Beschreibung     : Schnittstelle zum Modul WSYS902 Komm. MEMLOG
*
*    Feld CC       : Kommando 1 Insert, 2 Read, 3 Exist
*
*    Feld RETCODE  : Returnvalue aus Request vom MEMLOG
*
*    Feld VERFKZ   : Verfahrenskz laut GUDLOG (P,I,A)
*
*    Feld ASNAME   : Name der zustaendigen AS-Serverklasse
*
*    Feld LOGKEY   : Key des Datensatzes
*
*    Die Daten des entspr. Logrecs werden als 2. using uebergeben
*
*
*****************************************************************
*
 01          "*"-WSYS902C.
     05      "*"-CC              PIC S9(04) COMP.
          88 "*"-INSERT                          VALUE 1.
          88 "*"-READ                            VALUE 2.
          88 "*"-EXIST                           VALUE 3.
     05      "*"-RETCODE         PIC S9(04) COMP.
     05      "*"-VERFKZ          PIC  X(02).
     05      "*"-ASNAME          PIC  X(16).
     05      "*"-LOGKEY          PIC  X(16).

*****************************************************************

?section SYSML7IC
*****************************************************************
* Autor            : Akquinet AG, Kay Lorenz
* erstellt am      : 10.09.2013
* letzte Aenderung : 10.09.2013
*
*    F.01.00     Uebnahme von WSYS902C
*
* Beschreibung     : Schnittstelle zum Modul SYSML7I Komm. MEMLOG
*
*    Feld CC       : Kommando 1 Insert, 2 Read, 3 Exist
*
*    Feld RETCODE  : Returnvalue aus Request vom MEMLOG
*
*    Feld ASNAME   : Name der zustaendigen AS-Serverklasse
*
*    Feld LOGKEY   : Key des Datensatzes
*
*    Feld APP-TO   : Anwendungsspezifischer Timeout
*
*    Die Daten des entspr. Logrecs werden als 2. using uebergeben
*
*
*****************************************************************
*
 01          "*"-SYSML7IC.
     05      "*"-CC              PIC S9(04) COMP.
          88 "*"-INSERT                          VALUE 1.
          88 "*"-READ                            VALUE 2.
          88 "*"-EXIST                           VALUE 3.
     05      "*"-RETCODE         PIC S9(04) COMP.
     05      "*"-VERFKZ          PIC  X(02).
     05      "*"-ASNAME          PIC  X(16).
     05      "*"-LOGKEY          PIC  X(64).
     05      "*"-APP-TIMEOUT     PIC S9(04) COMP.

*****************************************************************


**********************************************************************
?section THKO4FMC
**********************************************************************
 01          THKO4FMC.
     05      THKO4FMC-CMD        PIC XX.
       88    KOMMANDO-OK         VALUE "WD", "F", "E", "EJ", "S",
                                       "R", "AR", "CC".
     05      MDNR                PIC 9(08).
     05      TS-SART             PIC S9(04) COMP.
     05      DATLEN              PIC S9(04) COMP.
     05      NDATEN              PIC X(512).

**********************************************************************
?section TFHO4FMC
**********************************************************************
 01          TFHO4FMC.
     05      TFHO4FMC-CMD        PIC XX.
       88    KOMMANDO-OK         VALUE "WD", "F", "E", "EJ", "S",
                                       "R", "AR", "CC".
     05      MDNR                PIC 9(08).
     05      TS-SART             PIC S9(04) COMP.
     05      DATLEN              PIC S9(04) COMP.
     05      NDATEN              PIC X(512).

**********************************************************************
?section TFHO7FMC
**********************************************************************
 01          TFHO7FMC.
     05      TFHO7FMC-CMD        PIC XX.
       88    KOMMANDO-OK         VALUE "WD", "F", "E", "EJ", "S",
                                       "R", "AR", "CC".
     05      MDNR                PIC 9(08).
     05      TS-SART             PIC S9(04) COMP.
     05      DATLEN              PIC S9(04) COMP.
     05      NDATEN              PIC X(4096).


?section WSYS920C
*****************************************************************
* Autor            : APCON C&S, J. Bahlmann
* erstellt am      : 7.12.00    (27.12.1999)
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum
*                    Monitormodul WSYS920
*
* Aenderungen      : nn.nn.nn
*
*
*****************************************************************
*
 01          "*"-WSYS920C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                        VALUE 0.
          88 "*"-NOK                       VALUE 1 THRU 9999.
          88 "*"-MISSING-PROC              VALUE 1.
          88 "*"-UNKNOWN-CMD               VALUE 2.
          88 "*"-REPEATED-INIT             VALUE 3.
          88 "*"-UPDATE-NOK                VALUE 4.
          88 "*"-ABBRUCH                   VALUE 8888.
          88 "*"-SHUTDOWN                  VALUE 9999.
     05      "*"-CMD             PIC X(02).
          88 "*"-CMD-SHUTDOWN              VALUE "SH".
          88 "*"-CMD-START                 VALUE "ST".
          88 "*"-CMD-UPDATE                VALUE "UP".
          88 "*"-CMD-WORK                  VALUE "WK".
     05      "*"-DATEN           PIC X(124).

?section PSYS053C
*******************************************************************
* Message fuer Modul PSYS053 Kommunikation zu den Kryptokom boxen *
*                                                     14.10.1999  *
* (eigentlich die Fregatten-Schnittstelle nur verlaengert)        *
*                                                                 *
*******************************************************************
*----------------------> Laenge der Message
     05      "*"-LEN             PIC S9(04) COMP.
          88 PSYS053-LEN          VALUE 588.
*----------------------> Message
     05      "*"-SATZ.
      10     "*"-HEADER.
       15    "*"-CC              PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-READ-IL                    VALUE 1.
          88 "*"-WRITE-SL                   VALUE 2.
          88 "*"-AUFBAU-IL                  VALUE 3.
          88 "*"-ABBAU-SL                   VALUE 4.
          88 "*"-AUFBAU-BL                  VALUE 5.
          88 "*"-READ-AL                    VALUE 6.
          88 "*"-WRITE-AL                   VALUE 7.
          88 "*"-WRITEQ-AL                  VALUE 8.
          88 "*"-FREI-BL                    VALUE 9.
          88 "*"-SEND-ASYNC                 VALUE 10.
          88 "*"-SEND-SYNC                  VALUE 11.
          88 "*"-DISCON-TS                  VALUE 101.
          88 "*"-DISCON-TO                  VALUE 102.
          88 "*"-NO-CONNECT                 VALUE 103.
          88 "*"-NO-BL                      VALUE 104.
          88 "*"-MODEM-ERR                  VALUE 105.
          88 "*"-NO-ANSWER                  VALUE 106.
          88 "*"-UNS-MSG                    VALUE 107.
          88 "*"-APPL-DOWN                  VALUE 108.
          88 "*"-DIAGN-ANF                  VALUE 109.

       15    "*"-TERMID          PIC X(16).
       15    "*"-NEXTSERV        PIC X(16).
       15    "*"-NEXTSERV-REDEF  REDEFINES "*"-NEXTSERV.
          20 "*"-SERVKLASSE      PIC X(12).
          20 "*"-SNIHEADZT       PIC X(04).
       15    "*"-LINE            PIC X(16).
       15    "*"-DATLEN          PIC S9(04) COMP.
       15    "*"-DTXNR           PIC X(16).
       15    "*"-CUGID           PIC 99.
       15    "*"-SESSNR          PIC S9(04) COMP.
       15    "*"-MONNAME         PIC X(16).
       15    "*"-MONNAME-REDEF  REDEFINES "*"-MONNAME.
          20 "*"-MONKLASSE       PIC X(12).
          20 "*"-SNIHEADVT       PIC X(04).
      10     "*"-NDATEN          PIC X(500).


?section FREGAT-XXL
*******************************************************************
* Message fuer           Box-Kommunikation zu den Kryptokom boxen *
*                                                     19.08.2003  *
* (eigentlich die Fregatten-Schnittstelle nur verlaengert)        *
*                                                                 *
*******************************************************************
*----------------------> Laenge der Message
     05      "*"-LEN             PIC S9(04) COMP.
          88 FREGXXL-LEN          VALUE 1588.
*----------------------> Message
     05      "*"-SATZ.
      10     "*"-HEADER.
       15    "*"-CC              PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-READ-IL                    VALUE 1.
          88 "*"-WRITE-SL                   VALUE 2.
          88 "*"-AUFBAU-IL                  VALUE 3.
          88 "*"-ABBAU-SL                   VALUE 4.
          88 "*"-AUFBAU-BL                  VALUE 5.
          88 "*"-READ-AL                    VALUE 6.
          88 "*"-WRITE-AL                   VALUE 7.
          88 "*"-WRITEQ-AL                  VALUE 8.
          88 "*"-FREI-BL                    VALUE 9.
          88 "*"-SEND-ASYNC                 VALUE 10.
          88 "*"-SEND-SYNC                  VALUE 11.
          88 "*"-DISCON-TS                  VALUE 101.
          88 "*"-DISCON-TO                  VALUE 102.
          88 "*"-NO-CONNECT                 VALUE 103.
          88 "*"-NO-BL                      VALUE 104.
          88 "*"-MODEM-ERR                  VALUE 105.
          88 "*"-NO-ANSWER                  VALUE 106.
          88 "*"-UNS-MSG                    VALUE 107.
          88 "*"-APPL-DOWN                  VALUE 108.
          88 "*"-DIAGN-ANF                  VALUE 109.

       15    "*"-TERMID          PIC X(16).
       15    "*"-NEXTSERV        PIC X(16).
       15    "*"-NEXTSERV-REDEF  REDEFINES "*"-NEXTSERV.
          20 "*"-SERVKLASSE      PIC X(12).
          20 "*"-SNIHEADZT       PIC X(04).
       15    "*"-LINE            PIC X(16).
       15    "*"-DATLEN          PIC S9(04) COMP.
       15    "*"-DTXNR           PIC X(16).
       15    "*"-CUGID           PIC 99.
       15    "*"-SESSNR          PIC S9(04) COMP.
       15    "*"-MONNAME         PIC X(16).
       15    "*"-MONNAME-REDEF  REDEFINES "*"-MONNAME.
          20 "*"-MONKLASSE       PIC X(12).
          20 "*"-SNIHEADVT       PIC X(04).
      10     "*"-NDATEN          PIC X(1500).



?section WSYS960C
*******************************************************************
* Autor            : Itelligence AG, Kay Lorenz
* erstellt am      : 12.04.2002
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum Timestampkonverter
*                    WSYS960
*
* Aenderungen      : nn.nn.nn
*
*
*******************************************************************

 01       "*"-WSYS960C.
    05    "*"-CMD                  PIC  X.
       88 "*"-SYS2SQL                      VALUE LOW-VALUE.
       88 "*"-SQL2SYS                      VALUE HIGH-VALUE.
    05    "*"-TYPE                 PIC  XX.
       88 "*"-HS                           VALUE "HS".
       88 "*"-SS                           VALUE "SS".
       88 "*"-MI                           VALUE "MI".
       88 "*"-HH                           VALUE "HH".
       88 "*"-TT                           VALUE "TT".
       88 "*"-MM                           VALUE "MM".
    05    "*"-RCODE                PIC S9(04) COMP.
       88 "*"-OK                           VALUE ZERO.
       88 "*"-FERR                         VALUE -1.
       88 "*"-TERR                         VALUE -9998.
       88 "*"-CERR                         VALUE -9999.
    05    "*"-TIMESTAMP-NUM        PIC S9(18) COMP.
    05    "*"-TIMESTAMP-SQL        PIC X(22).

?section RELEASE50
*******************************************************************
* Autor            : Itelligence AG, Kay Lorenz
* erstellt am      : 21.02.2003
* letzte Aenderung :
* Beschreibung     : Ab hier beginnen die Schnittstellen
*                    fur Release 5.0
*
* Aenderungen      : nn.nn.nn
*
*
*******************************************************************
*
* Inhalt
*
* WSYS501C     Schnittstelle zum BER-TLV Modul WSYS501
*

?section WSYS501C
*******************************************************************
* Modulschnittstelle zum BERTLV-Kodierer WSYS501                  *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
*----------------------> Schnittstelle
     05      "*"-IN.
      10     "*"-IN-HEADER.
       15    "*"-BUFLEN          PIC S9(04) COMP.
       15    "*"-CMD             PIC S9(04) COMP.
          88 "*"-MODE-VALID      VALUE 0 1 2 3 4 5.
          88 "*"-MODE-INIT       VALUE ZERO.
          88 "*"-MODE-DECODE     VALUE 1.
          88 "*"-MODE-ENCODE     VALUE 2.
          88 "*"-MODE-K2B        VALUE 3.
          88 "*"-MODE-B2K        VALUE 4.
          88 "*"-MODE-K2A        VALUE 5.
      10     "*"-SA              PIC 9(03).
      10     "*"-SF              PIC 9(03).
      10     "*"-IN-STRING       PIC X(512).
*
* ------> Ausgabepuffer
*
     05      "*"-OUT.
      10     "*"-OUT-HEADER.
       15    "*"-CC              PIC S9(04) COMP.
          88 "*"-OK              VALUE ZERO.
          88 "*"-CMD-INVAL       VALUE 1.
          88 "*"-LEN-INVALID     VALUE 2.
          88 "*"-OVERFLOW        VALUE 3.
          88 "*"-NO-DATA         VALUE 4.
          88 "*"-READ-ERROR      VALUE 5.
          88 "*"-TAGLEN-INVAL    VALUE 6.
          88 "*"-UNKNOWN-TAG     VALUE 7.
          88 "*"-KAAI-INVALID    VALUE 8.
          88 "*"-KAAI-UNKNOWN    VALUE 9.
          88 "*"-UNKNOWN         VALUE 9999.
          88 "*"-NOK             VALUE 1 THRU 9999.

      10     "*"-RESULT.
* Fuer Adressierung per Referencemodification
       15    "*"-TAG-ADRESSING   OCCURS 100.
          20 "*"-TAGNO           PIC X(04).
          20 "*"-KAAI            PIC S9(04)   COMP.
          20 "*"-INPOS           PIC S9(04)   COMP.
          20 "*"-INLEN           PIC S9(04)   COMP.
* Optional fuer Adressierung in der Hostschnittstelle
          20 "*"-OUTPOS          PIC S9(04)   COMP.
          20 "*"-OUTLEN          PIC S9(04)   COMP.
* Wertestack - Zugriff im aufrufenden Modul mittels RM
       15    "*"-TAG-STACK.
          20                     PIC X(1024).
          20                     PIC X(1024).
          20                     PIC X(1024).
          20                     PIC X(1024).
          20                     PIC X(1024).

?section WSYS930C
***********************************************************************
* Schnittstelle zum Modul WSYS930
***********************************************************************
* Das Modul holt ueber die Funktion ..-CMD-ID die CARDID zu der Karten-
* nummer deren ersten 9 Stellen im Feld ..-MERKMAL uebertragen wurden
* ueber Tabelle KANR2ID).
* Mit der Funktion ..-CMD-AS werden Routinginformationen zu dem
* Autorisierungs-KZ in ..-KZ und der Karten-ID in ..-CARDID zurueck-
* gegeben (aus Tabelle TUEAS).
***********************************************************************
* aktuelle Version: A.01.00     vom: 15.08.2003
***********************************************************************
**          ---> Schnittstelle zu WSYS930
 01          "*"-SATZ.
     05      "*"-CC             PIC S9(04) COMP.
          88 "*"-OK                        VALUE 0.
          88 "*"-NOT-OK                    VALUE 1 THRU  9999
                                                 -9999 THRU -1.
          88 "*"-NOCARD                    VALUE 1.
          88 "*"-ASERR                     VALUE 2.
          88 "*"-NOAS                      VALUE 3.
          88 "*"-CMDPRM                    VALUE 254.
          88 "*"-CMDERR                    VALUE 255.
     05      "*"-CMD            PIC X(02).
          88 "*"-CMD-AS                    VALUE "AS" "as" "As" "aS".
          88 "*"-CMD-ID                    VALUE "ID" "id" "Id" "iD".
     05      "*"-ID             PIC S9(04) COMP.
     05      "*"-KZ             PIC S9(04) COMP.
     05      "*"-CARDID         PIC S9(04) COMP.
     05      "*"-DTX            PIC X(16).
     05      "*"-FREGATTE       PIC X(16).
     05      "*"-KZSYNC         PIC X(1).
     05      "*"-MERKMAL        PIC X(09).
     05      "*"-SPL-SERV       PIC X(16).
     05      "*"-AS-SERV        PIC X(16).

*********************************************************************
*
* End of Interface
**********************************************************************


?section WSYS959C
************************************************************************
* Letzte Aenderung :: 2006-08-18
* Letzte Version   :: A.01.03
* Kurzbeschreibung :: Schnittstelle zum Modul WSYS016 ISO-8583
* Kurzbeschreibung :: Schnittstelle zum Modul WSYS959 ISO-8583,
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    240 -   ungueltiger Wert fuer CMD
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*                    ...
*
*    Feld CMD      : 12  -   ISO nach COBOL
*                    13  -   COBOL nach ISO
*
*    Feld ISOTYP   : 1   -   EC-Nachricht (vom Terminal - zum Terminal)
*                    2   -   EDC-Nachricht(von und zur UES)
*                    3   -   GICC
*                    4   -   OPT
*
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld BYTEMAP    I/O     Byte-Map der Iso-Nachricht
*
*    Feld COBREC   : I/O     edc-spezifischer record fuer die
*                            Daten der Felder der ISO-Nachricht
*
*
*
* Aenderungen      :
* Version A.01.03   vom 18.08.2006  Erweiterung der 88er Stufen VERF
* Version A.01.02   vom 30.12.2005  Umbenennung bei Erweiterung
* Version A.01.01   vom 28.12.2005  Erweiterung fuer Funktion ADD-BMP
* Version A.01.00   vom 25.08.2005  Neuerstellung
*
*
************************************************************************
*
 01          "*"-WSYS959C.
     05      "*"-VERWALTUNG.

**          ---> Return-Code
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-ADDERR                     VALUE  253.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

**          ---> BMP eines fehlerhaften Feldes
      10     "*"-ERR-BMP         PIC S9(04) COMP.

**          ---> Command
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-ISO2COB                    VALUE    12.
          88 "*"-COB2ISO                    VALUE    13.
          88 "*"-ADD-BMP                    VALUE   101.

**          ---> Bestimmung der anzuwendenden ISO-Tabelle
      10     "*"-ISOTYP          PIC S9(04) COMP.
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-NN                         VALUE    5.
          88 "*"-VERF5                      VALUE    5.

**          ---> ISO-Rohdaten
     05      "*"-ISODATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(1024).

**          ---> aufgeschluesselte ISO-Nachricht
     05      "*"-COBDATEN.

**          ---> Nachrichtentyp
      10     "*"-NTYPE           PIC  9(04).

**          ---> Bytemap-, Pointer-, Laengen-Tabellen
      10     "*"-TBMP-O.
       15    "*"-TBMP            PIC 9           OCCURS 128.
      10     "*"-TPTR-O.
       15    "*"-TPTR            PIC S9(04) COMP OCCURS 128.
      10     "*"-TLEN-O.
       15    "*"-TLEN            PIC S9(04) COMP OCCURS 128.
**          ---> Pointer auf naechste freie Stelle im Datenbuffer CF
      10     "*"-NEXT-PTR        PIC S9(04) COMP.

**          ---> aufbereitete (Cobol-) Felder
      10     "*"-CF              PIC X(2048).

**          ---> hinzuzufuegendes BMP
     05      "*"-XBMPO.
      10     "*"-XBMP            PIC S9(04) COMP.
      10     "*"-XCOBLEN         PIC S9(04) COMP.
      10     "*"-XCOBVAL         PIC X(512).

?section WSYS95XC
************************************************************************
* Letzte Aenderung :: 2006-08-18
* Letzte Version   :: A.01.03
* Kurzbeschreibung :: Schnittstelle zum Modul WSYS016 ISO-8583
* Kurzbeschreibung :: Schnittstelle zum Modul WSYS95X ISO-8583,
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    240 -   ungueltiger Wert fuer CMD
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*                    ...
*
*    Feld CMD      : 12  -   ISO nach COBOL
*                    13  -   COBOL nach ISO
*
*    Feld ISOTYP   : 1   -   EC-Nachricht (vom Terminal - zum Terminal)
*                    2   -   EDC-Nachricht(von und zur UES)
*                    3   -   GICC
*                    4   -   OPT
*
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld BYTEMAP    I/O     Byte-Map der Iso-Nachricht
*
*    Feld COBREC   : I/O     edc-spezifischer record fuer die
*                            Daten der Felder der ISO-Nachricht
*
*
*
* Aenderungen      :
* Version A.01.03   vom 18.08.2006  Erweiterung der 88er Stufen VERF
* Version A.01.02   vom 30.12.2005  Umbenennung bei Erweiterung
* Version A.01.01   vom 28.12.2005  Erweiterung fuer Funktion ADD-BMP
* Version A.01.00   vom 25.08.2005  Neuerstellung
*
*
************************************************************************
*
 01          "*"-WSYS95XC.
     05      "*"-VERWALTUNG.

**          ---> Return-Code
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-ADDERR                     VALUE  253.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

**          ---> BMP eines fehlerhaften Feldes
      10     "*"-ERR-BMP         PIC S9(04) COMP.

**          ---> Command
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-ISO2COB                    VALUE    12.
          88 "*"-COB2ISO                    VALUE    13.
          88 "*"-ADD-BMP                    VALUE   101.

**          ---> Bestimmung der anzuwendenden ISO-Tabelle
      10     "*"-ISOTYP          PIC S9(04) COMP.

* ---> Nachrichtenpacker / -entpacker
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-IFSF                       VALUE    5.
          88 "*"-VERF5                      VALUE    5.
*         ffu
          88 "*"-VERF6                      VALUE    6.
          88 "*"-VERF7                      VALUE    7.
          88 "*"-VERF8                      VALUE    8.
          88 "*"-VERF9                      VALUE    9.
          88 "*"-VERF10                     VALUE    10.
          88 "*"-VERF11                     VALUE    11.
          88 "*"-VERF12                     VALUE    12.
          88 "*"-VERF13                     VALUE    13.
          88 "*"-VERF14                     VALUE    14.
          88 "*"-VERF15                     VALUE    15.

* ---> Ab hier ISO-Feldpacker
          88 "*"-IFP48                      VALUE    16.
          88 "*"-VERF16                     VALUE    16.
*         ffu
          88 "*"-VERF17                     VALUE    17.
          88 "*"-VERF18                     VALUE    18.
          88 "*"-VERF19                     VALUE    19.
          88 "*"-VERF20                     VALUE    20.


**          ---> ISO-Rohdaten
     05      "*"-ISODATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(1024).

**          ---> aufgeschluesselte ISO-Nachricht
     05      "*"-COBDATEN.

**          ---> Nachrichtentyp
      10     "*"-NTYPE           PIC  9(04).

**          ---> Bytemap-, Pointer-, Laengen-Tabellen
      10     "*"-TBMP-O.
       15    "*"-TBMP            PIC 9           OCCURS 128.
      10     "*"-TPTR-O.
       15    "*"-TPTR            PIC S9(04) COMP OCCURS 128.
      10     "*"-TLEN-O.
       15    "*"-TLEN            PIC S9(04) COMP OCCURS 128.
**          ---> Pointer auf naechste freie Stelle im Datenbuffer CF
      10     "*"-NEXT-PTR        PIC S9(04) COMP.

**          ---> aufbereitete (Cobol-) Felder
      10     "*"-CF              PIC X(2048).

**          ---> hinzuzufuegendes BMP
     05      "*"-XBMPO.
      10     "*"-XBMP            PIC S9(04) COMP.
      10     "*"-XCOBLEN         PIC S9(04) COMP.
      10     "*"-XCOBVAL         PIC X(512).


?section WISO200C
************************************************************************
* Letzte Aenderung :: 2014-08-11
* Letzte Version   :: A.01.02
* Kurzbeschreibung :: Schnittstelle zum Modul WISO200 ISO-8583
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    240 -   ungueltiger Wert fuer CMD
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*                    ...
*
*    Feld CMD      : 12  -   ISO nach COBOL
*                    13  -   COBOL nach ISO
*                   101  -   Feld auf Cobolstack hinzufuegen
*kl20080114 - Neues Kommando
*                   201  -   Holen Isopointer (Wertanfang)
*kl20080114 - Ende
*
*    Feld ISOTYP   : 1   -   EC-Nachricht (vom Terminal - zum Terminal)
*                    2   -   EDC-Nachricht(von und zur UES)
*                    3   -   GICC
*                    4   -   OPT
*                    5   -   IFSF
*                    6   -   EuroELV

*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld BYTEMAP    I/O     Byte-Map der Iso-Nachricht
*
*    Feld COBREC   : I/O     edc-spezifischer record fuer die
*                            Daten der Felder der ISO-Nachricht
*
*
*
* Aenderungen      :
* Version A.01.00   vom 17.08.2007  Neuerstellung aus WSYS95XC
*                                   wg. Namenskonsolidierung
*
*         A.01.02   vom 11.08.14   Verf6 neu für online ELV, AS-intercard
************************************************************************
*
 01          "*"-WISO200C.
     05      "*"-VERWALTUNG.

**          ---> Return-Code
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-ADDERR                     VALUE  253.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

**          ---> BMP eines fehlerhaften Feldes
      10     "*"-ERR-BMP         PIC S9(04) COMP.

**          ---> Command
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-ISO2COB                    VALUE    12.
          88 "*"-COB2ISO                    VALUE    13.
          88 "*"-ADD-BMP                    VALUE   101.
*kl20080114 - Neues Kommando
          88 "*"-GET-ISOPTR                 VALUE   102.
*kl20080114 - Ende

**          ---> Bestimmung der anzuwendenden ISO-Tabelle
      10     "*"-ISOTYP          PIC S9(04) COMP.

* ---> Nachrichtenpacker / -entpacker
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-IFSF                       VALUE    5.
          88 "*"-VERF5                      VALUE    5.
*         sk0140811: Verf6 neu für online ELV, AS-intercard
          88 "*"-OELV                       VALUE    6.
          88 "*"-VERF6                      VALUE    6.
*         ffu
          88 "*"-VERF7                      VALUE    7.
          88 "*"-VERF8                      VALUE    8.
          88 "*"-VERF9                      VALUE    9.
          88 "*"-VERF10                     VALUE    10.
          88 "*"-VERF11                     VALUE    11.
          88 "*"-VERF12                     VALUE    12.
          88 "*"-VERF13                     VALUE    13.
          88 "*"-VERF14                     VALUE    14.
          88 "*"-VERF15                     VALUE    15.

* ---> Ab hier ISO-Feldpacker
          88 "*"-IFP48                      VALUE    16.
          88 "*"-VERF16                     VALUE    16.
*         ffu
          88 "*"-VERF17                     VALUE    17.
          88 "*"-VERF18                     VALUE    18.
          88 "*"-VERF19                     VALUE    19.
          88 "*"-VERF20                     VALUE    20.


**          ---> ISO-Rohdaten
     05      "*"-ISODATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(1024).

**          ---> aufgeschluesselte ISO-Nachricht
     05      "*"-COBDATEN.

**          ---> Nachrichtentyp
      10     "*"-NTYPE           PIC  9(04).

**          ---> Bytemap-, Pointer-, Laengen-Tabellen
      10     "*"-TBMP-O.
       15    "*"-TBMP            PIC 9           OCCURS 128.
      10     "*"-TPTR-O.
       15    "*"-TPTR            PIC S9(04) COMP OCCURS 128.
      10     "*"-TLEN-O.
       15    "*"-TLEN            PIC S9(04) COMP OCCURS 128.
**          ---> Pointer auf naechste freie Stelle im Datenbuffer CF
      10     "*"-NEXT-PTR        PIC S9(04) COMP.

**          ---> aufbereitete (Cobol-) Felder
      10     "*"-CF              PIC X(2048).

**          ---> hinzuzufuegendes BMP
     05      "*"-XBMPO.
      10     "*"-XBMP            PIC S9(04) COMP.
      10     "*"-XCOBLEN         PIC S9(04) COMP.
      10     "*"-XCOBVAL         PIC X(512).

**          ---> Fuer Abruf ISO-Adressse
     05      "*"-PBMPO            REDEFINES "*"-XBMPO.
      10     "*"-PBMP            PIC S9(04) COMP.
      10     "*"-PISOPTR         PIC S9(04) COMP.
      10     "*"-PCOBVAL         PIC X(512).

?section WISO207C
************************************************************************
* Letzte Aenderung :: 2014-11-24
* Letzte Version   :: A.01.02
* Kurzbeschreibung :: Schnittstelle zum Modul WISO207 ISO-8583
*
*    Feld RCODE    : 0   -   OK
*                    1 - 128 Fehler bei BMP
*                    240 -   ungueltiger Wert fuer CMD
*                    254 -   sonstiger Fehler COBOL-Feld
*                    255 -   sonstiger Fehler
*                    ...
*
*    Feld CMD      : 12  -   ISO nach COBOL
*                    13  -   COBOL nach ISO
*                   101  -   Feld auf Cobolstack hinzufuegen
*kl20080114 - Neues Kommando
*                   201  -   Holen Isopointer (Wertanfang)
*kl20080114 - Ende
*
*    Feld ISOTYP   : 1   -   EC-Nachricht (vom Terminal - zum Terminal)
*                    2   -   EDC-Nachricht(von und zur UES)
*                    3   -   GICC
*                    4   -   OPT
*
*   Datenfelder:     In/Out* Beschreibung
*
*    Feld ISOLEN   : I/O     Laenge der ISO-Nachricht
*
*    Feld ISOSTRING: I/O     ISO-Nachricht
*
*    Feld BYTEMAP    I/O     Byte-Map der Iso-Nachricht
*
*    Feld COBREC   : I/O     edc-spezifischer record fuer die
*                            Daten der Felder der ISO-Nachricht
*
*
*
* Aenderungen      :
* Version A.01.00   vom 17.08.2007  Neuerstellung aus WSYS95XC
*                                   wg. Namenskonsolidierung
*
*         A.01.02   vom 24.11.2014 Verf6 neu für online ELV, AS-intercard
************************************************************************
*
 01          "*"-WISO207C.
     05      "*"-VERWALTUNG.

**          ---> Return-Code
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-FELDERR                    VALUE     1 THRU   128.
          88 "*"-CMDERR                     VALUE  240.
          88 "*"-ADDERR                     VALUE  253.
          88 "*"-COBERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

**          ---> BMP eines fehlerhaften Feldes
      10     "*"-ERR-BMP         PIC S9(04) COMP.

**          ---> Command
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-ISO2COB                    VALUE    12.
          88 "*"-COB2ISO                    VALUE    13.
          88 "*"-ADD-BMP                    VALUE   101.
*kl20080114 - Neues Kommando
          88 "*"-GET-ISOPTR                 VALUE   102.
*kl20080114 - Ende

**          ---> Bestimmung der anzuwendenden ISO-Tabelle
      10     "*"-ISOTYP          PIC S9(04) COMP.

* ---> Nachrichtenpacker / -entpacker
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-IFSF                       VALUE    5.
          88 "*"-VERF5                      VALUE    5.
*sk20141124: Verf6 neu für online ELV, AS-intercard
          88 "*"-OELV                       VALUE    6.
          88 "*"-VERF6                      VALUE    6.
*
*         ffu
          88 "*"-VERF6                      VALUE    6.
          88 "*"-VERF7                      VALUE    7.
          88 "*"-VERF8                      VALUE    8.
          88 "*"-VERF9                      VALUE    9.
          88 "*"-VERF10                     VALUE    10.
          88 "*"-VERF11                     VALUE    11.
          88 "*"-VERF12                     VALUE    12.
          88 "*"-VERF13                     VALUE    13.
          88 "*"-VERF14                     VALUE    14.
          88 "*"-VERF15                     VALUE    15.

* ---> Ab hier ISO-Feldpacker
          88 "*"-IFP48                      VALUE    16.
          88 "*"-VERF16                     VALUE    16.
          88 "*"-NEF48                      VALUE    17.
          88 "*"-VERF17                     VALUE    17.
*         ffu
          88 "*"-VERF18                     VALUE    18.
          88 "*"-VERF19                     VALUE    19.
          88 "*"-VERF20                     VALUE    20.


**          ---> ISO-Rohdaten
     05      "*"-ISODATEN.
      10     "*"-ISOLEN          PIC S9(04) COMP.
      10     "*"-ISOSTRING       PIC  X(1024).

**          ---> aufgeschluesselte ISO-Nachricht
     05      "*"-COBDATEN.

**          ---> Nachrichtentyp
      10     "*"-NTYPE           PIC  9(04).

**          ---> Bytemap-, Pointer-, Laengen-Tabellen
      10     "*"-TBMP-O.
       15    "*"-TBMP            PIC 9           OCCURS 128.
      10     "*"-TPTR-O.
       15    "*"-TPTR            PIC S9(04) COMP OCCURS 128.
      10     "*"-TLEN-O.
       15    "*"-TLEN            PIC S9(04) COMP OCCURS 128.
**          ---> Pointer auf naechste freie Stelle im Datenbuffer CF
      10     "*"-NEXT-PTR        PIC S9(04) COMP.

**          ---> aufbereitete (Cobol-) Felder
      10     "*"-CF              PIC X(2048).

**          ---> hinzuzufuegendes BMP
     05      "*"-XBMPO.
      10     "*"-XBMP            PIC S9(04) COMP.
      10     "*"-XCOBLEN         PIC S9(04) COMP.
      10     "*"-XCOBVAL         PIC X(1024).

**          ---> Fuer Abruf ISO-Adressse
     05      "*"-PBMPO            REDEFINES "*"-XBMPO.
      10     "*"-PBMP            PIC S9(04) COMP.
      10     "*"-PISOPTR         PIC S9(04) COMP.
      10     "*"-PCOBVAL         PIC X(1024).

**          ---> optionales Feld fuer COBOL- bzw. ISO-Werte in Schnittst.
**          ---> (0 = ISO, 1 = COBOL), wenn 1.Byte leer (Space) werden die
**          ---> default-Werte des Programms WISO207 verwendet:
**         "0111001000111100010101101100000111101110111000101010101000011110"
**          1234567890123456789012345678901234567890123456789012345678901234
**         "0000000000000000000000000100001000000000000000000000000000000000".
**          5678901234567890123456789012345678901234567890123456789012345678
**          ---> sonst werden die Übergabewerte verwendet.
     05      "*"-COB-ISO         PIC X(128).


?SECTION WSTK5UMC
*******************************************************************
* COPY-Struktur fuer WSTK5UM                                      *
*                                                     24.03.2004  *
*                                                                 *
* Kommandos und Nutzdaten fuer Eintrag Umsaetze in WABRTAB        *
*-----------------------------------------------------------------*
*                         Aenderungshistorie                      *
*                                                                 *
* TT.MM.JJ VVV.VV TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT *
*                                                                 *
*******************************************************************
 01           "*"-UMSATZ.
     05       "*"-HDR.
        10    "*"-COMPRESS-LEVEL     PIC XX.
           88 "*"-DAY              VALUE "CD".
           88 "*"-MON              VALUE "CM".
        10    "*"-RC                 PIC S9(04) COMP.
           88 "*"-OK                 VALUE ZERO.
           88 "*"-COMP-INVALID       VALUE 1.
           88 "*"-NTYPE-INVALID      VALUE 2.
     05       "*"-NDATEN.
        10    "*"-MDNR               PIC 9(02).
        10    "*"-TSNR               PIC 9(08).
        10    "*"-DATUM              PIC 9(08).
        10    "*"-NTYPE              PIC X.
        10    "*"-WKZ                PIC X(03).
        10    "*"-CARDID             PIC 9(06).
        10    "*"-BETRAG             PIC 9(18).


?section PHFMON0C
******************************************************************
* PATHSEND-BUFFER FUER PHFMON0S
*----------------------------------------------------------------*
*                       Aenderungshistorie                       *
*                                                                *
* 2004.10.21 A.05.00 jb Neuerstellung auf Basis LINKCOP-R4       *
******************************************************************

     03  "*"-PSERR              PIC  S9(04) COMP.
     03  "*"-MDNR               PIC  9(02).
     03  "*"-SATZART            PIC  9(02).
     03  "*"-DATEINAME          PIC  X(36).
     03  "*"-PARAM1             PIC  9(04).
     03  "*"-PARAM2             PIC  9(04).
     03  "*"-ZEITPUNKT          PIC  9(16).
     03  "*"-FEHLER             PIC  9(04).
     03  "*"-VKZ                PIC  X(01).
     03  "*"-LFDNR              PIC  9(04).
     03  "*"-FIX-LEN            PIC  9(04).

?section WSTKXUMC
******************************************************************
* Übergabe-Bereich WSTKXUM - allgemeines Modul fuer =WABRTAB     *
******************************************************************

 01      "*"-WSTKXUMC.
    05   "*"-RC                 PIC S9(04) COMP.
     88  "*"-OK                 VALUE ZERO.
     88  "*"-FEHLER             VALUE 1.

    05   "*"-WABRTAB-STRUKT     PIC X(50).

*kl20100216 - Fuer zentrales Abrechnungsmodul WABS000
?section WABS000C
******************************************************************
* Übergabe-Bereich WABS000 - allgemeines Modul fuer Abrechnung   *
******************************************************************
 01     "*"-WABS000C.
    05  "*"-IFC-HDR.
        10    "*"-CMD           PIC XX.
           88 "*"-INIT                          VALUE "IN".
           88 "*"-PROCESS-FILE                  VALUE "VF".
           88 "*"-PROCESS-INT                   VALUE "VI".
*           Fuer den Fall, dass noch OCABRT erzeugt werden muss
*           (was eigentlich nicht sein kann)
           88 "*"-PROCESS-R5                    VALUE "V5".
        10    "*"-RC            PIC S9(04) COMP.
            88 "*"-OK                           VALUE ZERO.
            88 "*"-SQLERR                       VALUE -9999 THRU -1.
            88 "*"-CMDERR                       VALUE 1.
            88 "*"-TXERR                        VALUE 2.
            88 "*"-INITERR                      VALUE 3.
            88 "*"-MISC-ERR                     VALUE 9.
    05  "*"-IFC-DATA.
        10     "*"-MDNR         PIC 9(02).
        10     "*"-TSNR         PIC 9(08).
        10     "*"-CARDID       PIC 9(02).
        10     "*"-TXART        PIC X(04).
*kl20110920 - Neue Schalterauspraegungen (MGFP/CHFP/CCFP)
            88 "*"-MGON                         VALUE "MGON".
            88 "*"-MGOF                         VALUE "MGOF".
            88 "*"-MGFP                         VALUE "MGFP".
            88 "*"-CHON                         VALUE "CHON".
            88 "*"-CHOF                         VALUE "CHOF".
            88 "*"-CHFP                         VALUE "CHFP".
            88 "*"-CCON                         VALUE "CCON".
            88 "*"-CCOF                         VALUE "CCOF".
            88 "*"-CCFP                         VALUE "CCFP".
*kl20110920 - Ende

        10     "*"-KARTENART    PIC X(02).
*---> Diese Daten enstsprechen den Definitionen der HOSA bzw. der Zieltabellen
        10     "*"-DATUM        PIC 9(08).
*              ACHTUNG: Format Betrag 7V3 (vvvvvvvKnnn) wg. Hostschnittstelle !!!
        10     "*"-BETRAG       PIC 9(10).
        10     "*"-ASID         PIC X(06).
        10     "*"-BLZ          PIC S9(09) COMP.
        10     "*"-WKZ          PIC X(03).
            88 "*"-BETRAG-EUR                   VALUE "EUR".
*--->   Fuer Rueckgabe bei integriertem Entgelt (enstpricht HOSA-/DTAUS-Definition)
        10     "*"-ENTG-INFO    PIC XX.
        10     "*"-ENTG-BETRAG  PIC 9(05).
*kl20100216 - Ende


*kl20130826 - Fuer zentrales Abrechnungsmodul WABS00X
*             (Erweiterung WABS000, Einzeltransaktions-
*              nachweis)
?section WABS00XC
******************************************************************
* Übergabe-Bereich WABS000 - allgemeines Modul fuer Abrechnung   *
******************************************************************
 01     "*"-WABS00XC.
    05  "*"-IFC-HDR.
        10    "*"-CMD           PIC XX.
           88 "*"-INIT                          VALUE "IN".
           88 "*"-PROCESS-FILE                  VALUE "VF".
           88 "*"-PROCESS-INT                   VALUE "VI".
*           Fuer den Fall, dass noch OCABRT erzeugt werden muss
*           (was eigentlich nicht sein kann)
           88 "*"-PROCESS-R5                    VALUE "V5".
       10    "*"-RC            PIC S9(04) COMP.
           88 "*"-OK                           VALUE ZERO.
           88 "*"-SQLERR                       VALUE -9999 THRU -1.
           88 "*"-CMDERR                       VALUE 1.
           88 "*"-TXERR                        VALUE 2.
           88 "*"-INITERR                      VALUE 3.
           88 "*"-MISC-ERR                     VALUE 9.
    05  "*"-IFC-DATA.
       10     "*"-MDNR         PIC 9(02).
       10     "*"-TSNR         PIC 9(08).
       10     "*"-CARDID       PIC 9(02).
       10     "*"-TXART        PIC X(04).
           88 "*"-MGON                         VALUE "MGON".
           88 "*"-MGOF                         VALUE "MGOF".
           88 "*"-MGFP                         VALUE "MGFP".
           88 "*"-CHON                         VALUE "CHON".
           88 "*"-CHOF                         VALUE "CHOF".
           88 "*"-CHFP                         VALUE "CHFP".
           88 "*"-CCON                         VALUE "CCON".
           88 "*"-CCOF                         VALUE "CCOF".
           88 "*"-CCFP                         VALUE "CCFP".
        10     "*"-KARTENART    PIC X(02).
*---> Diese Daten enstsprechen den Definitionen der HOSA bzw. der Zieltabellen
        10     "*"-DATUM        PIC 9(08).
*              ACHTUNG: Format Betrag 7V3 (vvvvvvvKnnn) wg. Hostschnittstelle !
        10     "*"-BETRAG       PIC 9(10).
        10     "*"-ASID         PIC X(06).
        10     "*"-BLZ          PIC S9(09) COMP.
        10     "*"-WKZ          PIC X(03).
            88 "*"-BETRAG-EUR                   VALUE "EUR".
*--->   Fuer Rueckgabe bei integriertem Entgelt (enstpricht HOSA-/DTAUS-Definit
        10     "*"-ENTG-INFO    PIC XX.
        10     "*"-ENTG-BETRAG  PIC 9(05).
*--->   Transaktionsdatum / Uhrzeit (=FCLOG.zpins bzw. TXILOG70.zpins)
        10     "*"-ZPINS-LOG    PIC X(22).
*kl20130826 - Ende

*kl20140820 - Fuer zentrales Abrechnungsmodul WABS00Y
*             (Erweiterung WABS00X, Einzeltransaktions-
*              nachweis, TERMNR/TRACENR/NTYPE)
?section WABS00YC
******************************************************************
* Übergabe-Bereich WABS000 - allgemeines Modul fuer Abrechnung   *
******************************************************************
* 01     "*"-WABS00YC.
*    05  "*"-IFC-HDR.
*        10    "*"-CMD           PIC XX.
*           88 "*"-INIT                          VALUE "IN".
*           88 "*"-PROCESS-FILE                  VALUE "VF".
*           88 "*"-PROCESS-INT                   VALUE "VI".
*           Fuer den Fall, dass noch OCABRT erzeugt werden muss
*           (was eigentlich nicht sein kann)
*           88 "*"-PROCESS-R5                    VALUE "V5".
*       10    "*"-RC            PIC S9(04) COMP.
*           88 "*"-OK                           VALUE ZERO.
*           88 "*"-SQLERR                       VALUE -9999 THRU -1.
*           88 "*"-CMDERR                       VALUE 1.
*           88 "*"-TXERR                        VALUE 2.
*           88 "*"-INITERR                      VALUE 3.
*           88 "*"-MISC-ERR                     VALUE 9.
*    05  "*"-IFC-DATA.
*       10     "*"-MDNR         PIC 9(02).
*       10     "*"-TSNR         PIC 9(08).
*       10     "*"-CARDID       PIC 9(02).
*       10     "*"-TXART        PIC X(04).
*           88 "*"-MGON                         VALUE "MGON".
*           88 "*"-MGOF                         VALUE "MGOF".
*           88 "*"-MGFP                         VALUE "MGFP".
*           88 "*"-CHON                         VALUE "CHON".
*           88 "*"-CHOF                         VALUE "CHOF".
*           88 "*"-CHFP                         VALUE "CHFP".
*           88 "*"-CCON                         VALUE "CCON".
*           88 "*"-CCOF                         VALUE "CCOF".
*           88 "*"-CCFP                         VALUE "CCFP".
*        10     "*"-KARTENART    PIC X(02).
*---> Diese Daten enstsprechen den Definitionen der HOSA bzw. der Zieltabellen
*        10     "*"-DATUM        PIC 9(08).
*              ACHTUNG: Format Betrag 7V3 (vvvvvvvKnnn) wg. Hostschnittstelle !
*        10     "*"-BETRAG       PIC 9(10).
*        10     "*"-ASID         PIC X(06).
*        10     "*"-BLZ          PIC S9(09) COMP.
*        10     "*"-WKZ          PIC X(03).
*            88 "*"-BETRAG-EUR                   VALUE "EUR".
*--->   Fuer Rueckgabe bei integriertem Entgelt (enstpricht HOSA-/DTAUS-Definit
*        10     "*"-ENTG-INFO    PIC XX.
*        10     "*"-ENTG-BETRAG  PIC 9(05).
*--->   Transaktionsdatum / Uhrzeit (=FCLOG.zpins bzw. TXILOG70.zpins)
*        10     "*"-ZPINS-LOG    PIC X(22).
*        10     "*"-TERMNR       PIC 9(08).
*        10     "*"-TRACENR      PIC 9(06).
*        10     "*"-NTYPE        PIC X(01).
*kl20140820 - Ende
 01     "*"-WABS00YC.
    05  "*"-IFC-HDR.
        10    "*"-CMD           PIC XX.
           88 "*"-INIT                          VALUE "IN".
           88 "*"-PROCESS-FILE                  VALUE "VF".
           88 "*"-PROCESS-INT                   VALUE "VI".
*           Fuer den Fall, dass noch OCABRT erzeugt werden muss
*           (was eigentlich nicht sein kann)
           88 "*"-PROCESS-R5                    VALUE "V5".
       10    "*"-RC            PIC S9(04) COMP.
           88 "*"-OK                           VALUE ZERO.
           88 "*"-SQLERR                       VALUE -9999 THRU -1.
           88 "*"-CMDERR                       VALUE 1.
           88 "*"-TXERR                        VALUE 2.
           88 "*"-INITERR                      VALUE 3.
           88 "*"-MISC-ERR                     VALUE 9.
    05  "*"-IFC-DATA.
       10     "*"-MDNR         PIC 9(02).
       10     "*"-TSNR         PIC 9(08).
       10     "*"-CARDID       PIC 9(02).
       10     "*"-TXART        PIC X(04).
           88 "*"-MGON                         VALUE "MGON".
           88 "*"-MGOF                         VALUE "MGOF".
           88 "*"-MGFP                         VALUE "MGFP".
           88 "*"-CHON                         VALUE "CHON".
           88 "*"-CHOF                         VALUE "CHOF".
           88 "*"-CHFP                         VALUE "CHFP".
           88 "*"-CCON                         VALUE "CCON".
           88 "*"-CCOF                         VALUE "CCOF".
           88 "*"-CCFP                         VALUE "CCFP".
        10     "*"-KARTENART    PIC X(02).
*---> Diese Daten enstsprechen den Definitionen der HOSA bzw. der Zieltabellen
        10     "*"-DATUM        PIC 9(08).
*              ACHTUNG: Format Betrag 7V3 (vvvvvvvKnnn) wg. Hostschnittstelle !
        10     "*"-BETRAG       PIC 9(10).
        10     "*"-ASID         PIC X(06).
        10     "*"-BLZ          PIC S9(09) COMP.
        10     "*"-WKZ          PIC X(03).
            88 "*"-BETRAG-EUR                   VALUE "EUR".
*--->   Fuer Rueckgabe bei integriertem Entgelt (enstpricht HOSA-/DTAUS-Definit
        10     "*"-ENTG-INFO    PIC XX.
        10     "*"-ENTG-BETRAG  PIC 9(05).
*--->   Transaktionsdatum / Uhrzeit (=FCLOG.zpins bzw. TXILOG70.zpins)
        10     "*"-ZPINS-LOG    PIC X(22).
        10     "*"-TERMNR       PIC 9(08).
        10     "*"-TRACENR      PIC 9(06).
        10     "*"-NTYPE        PIC X(01).
        10     "*"-TRXBIN       PIC X(19).
    05  "*"-WRK-BUFFER.
*--->   Fuer zukuenftige Anforderungen kann hier TXILOG70, FCLOG oder
*       sonst etwas uebergeben werden ...
        10     "*"-TBL-FLAG     PIC X(08).
        10     "*"-LOG-REC      PIC X(4000).


?section WSYS909C
******************************************************************
* Übergabe-Bereich WSYS909 - Übergabe für PCI-SecServ PCICSS6S   *
******************************************************************

 01      "*"-WSYS909C.
    05   "*"-RCODE              PIC S9(04) COMP.
     88  "*"-OK                 VALUE ZERO.
    05   "*"-KEYNAME            PIC X(08).
    05   "*"-TERMNR             PIC 9(08).
    05   "*"-RND                PIC X(16).
    05   "*"-PAN                PIC X(32).


?section MODCOMRC
*******************************************************************
* Autor            : it-eys, Kay Lorenz
* erstellt am      : 18.07.2005
* letzte Aenderung :
* Beschreibung     : Struktur fuer geregelte Rueckgabe von IP-Fehlern
*
*
* Aenderungen      : 18.07.05  kl  Prozesshandling fuer WAITED-Procs.
*
*
*******************************************************************

      05      "*"-MODUL-FLAG        PIC X(01).
          88  "*"-IP                VALUE LOW-VALUE.
          88  "*"-X25               VALUE HIGH-VALUE.
      05      "*"-COMRC             PIC S9(04)    COMP.
*kl20050718 - Fuer Prozesshandling in WAITED-Versionen
      05      "*"-PROCESS           PIC X(06).
      05      "*"-PROC-HANDLE       PIC X(20).
      05      "*"-DAKT              PIC S9(18) COMP.
*kl20050718 - Ende
******************************************************************


?section WSYS056C
************************************************************************
* erstellt am      : 13.04.2007
* letzte Aenderung : 08.03.2012
* Beschreibung     : Schnittstelle zum Modul WSYS056
*                    Boxen-Aufrufe bestücken aus INT-SCHNITTSTELLE
*
*    Feld RCODE    : 0    -  OK
*                   9999  -  ungueltiger  Aufruf
*                   1 -   -  Fehler  aus WSYS055 durchgereicht
*                   9998
*
*    Feld ANWENDUNG: SL   -  SHELL
*                    EM   -  ec magnet
*                    EC   -  ec chip
*                    EV   -  EMV
*
*    Feld CMD      : PU   -  PAC UMSCHLÜSSELN
*                    BT   -  MAC bilden Terminal
*                    BA   -  MAC bilden AS
*                    MB   -  MAC bilden Individuell TKEY (z.B. SHELL)
*                    MP   -  MAC prüfen Individuell TKEY
*                    PT   -  MAC prüfen Terminal
*                    PA   -  MAC prüfen AS
*                    PP   -  PIN prüfen (AS)
*
*    Feld TKEY-NAME: optional:abweichender Terminal-key vom Standard
*    Feld AKEY-NAME: optional:abweichender AS-KEY       vom Standard
*
*
*
* Aenderungen      :
*
*
************************************************************************
*
 01          "*"-WSYS056C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
     05      "*"-ANWENDUNG       PIC XX.
          88 "*"-SHELL                      VALUE    "SL".
          88 "*"-EC-MAGNET                  VALUE    "EM".
          88 "*"-EC-CHIP                    VALUE    "EC".
          88 "*"-EMV                        VALUE    "EV".

     05      "*"-CMD             PIC XX.
          88 "*"-PAC-UMSCHL                 VALUE    "PU".
          88 "*"-MAC-BILDEN                 VALUE    "MB".
          88 "*"-MAC-PRUEFEN                VALUE    "MP".
          88 "*"-MAC-BILDEN-TS              VALUE    "BT".
          88 "*"-MAC-BILDEN-AS              VALUE    "BA".
          88 "*"-MAC-PRUEFEN-TS             VALUE    "PT".
          88 "*"-MAC-PRUEFEN-AS             VALUE    "PA".
          88 "*"-PIN-PRUEFEN-AS             VALUE    "PP".

     05      "*"-TKEY-NAME       PIC X(08).
     05      "*"-AKEY-NAME       PIC X(08).

************************************************************************

?section WSYSAV6C
************************************************************************
* erstellt am      : 12.03.2012
* letzte Aenderung : 12.03.2012
* Beschreibung     : Schnittstelle zum Modul WAV057
*                    Boxen-Aufrufe bestücken aus INT-SCHNITTSTELLE
*
*    Feld RCODE    : 0    -  OK
*                   9999  -  ungueltiger  Aufruf
*                   1 -   -  Fehler  aus WSYS055 durchgereicht
*                   9998
*
*    Feld ANWENDUNG: AV   -  AVIA
*
*    Feld CMD      : PU   -  PAC UMSCHLÜSSELN
*                    BT   -  MAC bilden Terminal
*                    BA   -  MAC bilden AS
*                    MB   -  MAC bilden Individuell TKEY (z.B. SHELL)
*                    MP   -  MAC prüfen Individuell TKEY
*                    PT   -  MAC prüfen Terminal
*                    PA   -  MAC prüfen AS
*                    PP   -  PIN prüfen (AS)
*
*    Feld AKEY-NAME:    AS-KEY-NAME
*    Feld CDKEY-NAME:   cross domain  key zum Errechnen der PIN
*
*
* Aenderungen      :
*
*
************************************************************************
*
 01          "*"-WSYSAV6C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
     05      "*"-ANWENDUNG       PIC XX.
          88 "*"-AVIA                       VALUE    "AV".

     05      "*"-CMD             PIC XX.
          88 "*"-PAC-UMSCHL                 VALUE    "PU".
          88 "*"-MAC-BILDEN                 VALUE    "MB".
          88 "*"-MAC-PRUEFEN                VALUE    "MP".
          88 "*"-MAC-BILDEN-TS              VALUE    "BT".
          88 "*"-MAC-BILDEN-AS              VALUE    "BA".
          88 "*"-MAC-PRUEFEN-TS             VALUE    "PT".
          88 "*"-MAC-PRUEFEN-AS             VALUE    "PA".
          88 "*"-PIN-PRUEFEN-AS             VALUE    "PP".

     05      "*"-AKEY-NAME       PIC X(08).
     05      "*"-CDKEY-NAME       PIC X(08).

************************************************************************




?section WSYS063C
************************************************************************
* erstellt am      : 26.05.2009 aus WSYS056C
* letzte Aenderung : 26.05.2009
* Beschreibung     : Schnittstelle zum Modul WSYS063
*                    Boxen-Aufrufe bestücken aus INT-SCHNITTSTELLE
*                    mit realisierten Funktionec MAC-BILDEN-AS,
*                    MAC-PRUEFEN-AS
*
*    Feld RCODE    : 0    -  OK
*                   9999  -  ungueltiger  Aufruf
*                   1 -   -  Fehler  aus WSYS055 durchgereicht
*                   9998
*
*    Feld ANWENDUNG: SL   -  SHELL
*                    TO   -  Total
*                    DK   -  DKV
*                    UT   -  UTA
*                    EM   -  ec magnet
*                    EC   -  ec chip
*                    EV   -  EMV
*
*    Feld CMD      : PU   -  PAC UMSCHLÜSSELN
*                    BT   -  MAC bilden Terminal
*                    BA   -  MAC bilden AS
*                    MB   -  MAC bilden Individuell TKEY (z.B. SHELL)
*                    MP   -  MAC prüfen Individuell TKEY
*                    PT   -  MAC prüfen Terminal
*                    PA   -  MAC prüfen AS
*
*    Feld TKEY-NAME  :  optional:abweichender Terminal-key vom Standard
*    Feld AKEY-NAME  :  optional:abweichender AS-KEY       vom Standard
*    Feld BOXMON-TEXT:  optional:Uebergabe vom Hauptmodul aus IFSF-Konfig.
*
*
*
* Aenderungen      :
*
* A.01.01. kl 20100521 Feld BOXMON-TEXT fuer IFSF-Konfigurationsverwen.
************************************************************************
*
 01          "*"-WSYS063C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
     05      "*"-ANWENDUNG       PIC XX.
          88 "*"-SHELL                      VALUE    "SL".
          88 "*"-TOTAL                      VALUE    "TO".
          88 "*"-DKV                        VALUE    "DK".
          88 "*"-UTA                        VALUE    "UT".
          88 "*"-EC-MAGNET                  VALUE    "EM".
          88 "*"-EC-CHIP                    VALUE    "EC".
          88 "*"-EMV                        VALUE    "EV".

     05      "*"-CMD             PIC XX.
          88 "*"-PAC-UMSCHL                 VALUE    "PU".
          88 "*"-MAC-BILDEN                 VALUE    "MB".
          88 "*"-MAC-PRUEFEN                VALUE    "MP".
          88 "*"-MAC-BILDEN-TS              VALUE    "BT".
          88 "*"-MAC-BILDEN-AS              VALUE    "BA".
          88 "*"-MAC-PRUEFEN-TS             VALUE    "PT".
          88 "*"-MAC-PRUEFEN-AS             VALUE    "PA".

     05      "*"-VERF            PIC S9(04) COMP.
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-IFSF                       VALUE    5.
          88 "*"-VERF5                      VALUE    5.
*         ffu
          88 "*"-VERF6                      VALUE    6.
          88 "*"-VERF7                      VALUE    7.
          88 "*"-VERF8                      VALUE    8.
          88 "*"-VERF9                      VALUE    9.
          88 "*"-VERF10                     VALUE    10.
          88 "*"-VERF11                     VALUE    11.
          88 "*"-VERF12                     VALUE    12.
          88 "*"-VERF13                     VALUE    13.
          88 "*"-VERF14                     VALUE    14.
          88 "*"-VERF15                     VALUE    15.
* ---> Ab hier ISO-Feldpacker
          88 "*"-IFP48                      VALUE    16.
          88 "*"-VERF16                     VALUE    16.
*         ffu
          88 "*"-VERF17                     VALUE    17.
          88 "*"-VERF18                     VALUE    18.
          88 "*"-VERF19                     VALUE    19.
          88 "*"-VERF20                     VALUE    20.

     05      "*"-TKEY-NAME       PIC X(08).
     05      "*"-AKEY-NAME       PIC X(08).
     05      "*"-BOXMON-TEXT     PIC X(16).

?section WSYS066C
************************************************************************
* erstellt am      : 29.04.2010 aus WSYS063C
* letzte Aenderung : 29.04.2010
* Beschreibung     : Schnittstelle zum Modul WSYS066
*                    Boxen-Aufrufe bestücken aus INT-SCHNITTSTELLE
*                    mit realisierten Funktionec MAC-BILDEN-AS,
*                    MAC-PRUEFEN-AS
*
*    Feld RCODE    : 0    -  OK
*                   9999  -  ungueltiger  Aufruf
*                   1 -   -  Fehler  aus WSYS065 durchgereicht
*                   9998
*
*    Feld ANWENDUNG: SL   -  SHELL
*                    TO   -  Total
*                    DK   -  DKV
*                    UT   -  UTA
*                    RT   -  Routex
*                    AG   -  Routex - genauer AGIP
*                    BP   -  Routex - genauer BP
*                    WS   -  Westfalen Service Card ueber IFSF
*                    EM   -  ec magnet
*                    EC   -  ec chip
*                    EV   -  EMV
*
*    Feld CMD      : PU   -  PAC UMSCHLÜSSELN
*                    BT   -  MAC bilden Terminal
*                    BA   -  MAC bilden AS
*                    MB   -  MAC bilden Individuell TKEY (z.B. SHELL)
*                    MP   -  MAC prüfen Individuell TKEY
*                    PT   -  MAC prüfen Terminal
*                    PA   -  MAC prüfen AS
*
*    Feld TKEY-NAME: optional:abweichender Terminal-key vom Standard
*    Feld AKEY-NAME: optional:abweichender AS-KEY       vom Standard
*
*
*
* Aenderungen      :
*
*
************************************************************************
*
 01          "*"-WSYS066C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
     05      "*"-ANWENDUNG       PIC XX.
          88 "*"-SHELL                      VALUE    "SL".
          88 "*"-TOTAL                      VALUE    "TO".
          88 "*"-ROUTEX                     VALUE    "RT".
          88 "*"-ROUTEX-AGIP                VALUE    "AG".
          88 "*"-ROUTEX-BP                  VALUE    "BP".
          88 "*"-WSC                        VALUE    "WS".
          88 "*"-DKV                        VALUE    "DK".
          88 "*"-UTA                        VALUE    "UT".
          88 "*"-EC-MAGNET                  VALUE    "EM".
          88 "*"-EC-CHIP                    VALUE    "EC".
          88 "*"-EMV                        VALUE    "EV".

     05      "*"-CMD             PIC XX.
          88 "*"-PAC-UMSCHL                 VALUE    "PU".
          88 "*"-MAC-BILDEN                 VALUE    "MB".
          88 "*"-MAC-PRUEFEN                VALUE    "MP".
          88 "*"-MAC-BILDEN-TS              VALUE    "BT".
          88 "*"-MAC-BILDEN-AS              VALUE    "BA".
          88 "*"-MAC-PRUEFEN-TS             VALUE    "PT".
          88 "*"-MAC-PRUEFEN-AS             VALUE    "PA".

     05      "*"-VERF            PIC S9(04) COMP.
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-IFSF                       VALUE    5.
          88 "*"-VERF5                      VALUE    5.
*         ffu
          88 "*"-VERF6                      VALUE    6.
          88 "*"-VERF7                      VALUE    7.
          88 "*"-VERF8                      VALUE    8.
          88 "*"-VERF9                      VALUE    9.
          88 "*"-VERF10                     VALUE    10.
          88 "*"-VERF11                     VALUE    11.
          88 "*"-VERF12                     VALUE    12.
          88 "*"-VERF13                     VALUE    13.
          88 "*"-VERF14                     VALUE    14.
          88 "*"-VERF15                     VALUE    15.
* ---> Ab hier ISO-Feldpacker
          88 "*"-IFP48                      VALUE    16.
          88 "*"-VERF16                     VALUE    16.
*         ffu
          88 "*"-VERF17                     VALUE    17.
          88 "*"-VERF18                     VALUE    18.
          88 "*"-VERF19                     VALUE    19.
          88 "*"-VERF20                     VALUE    20.

     05      "*"-TKEY-NAME       PIC X(08).
     05      "*"-AKEY-NAME       PIC X(08).
     05      "*"-BOXMON-TEXT     PIC X(16).

************************************************************************

?section WSY7066C
************************************************************************
* erstellt am      : 07.04.2015 aus WSYS066C
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum Modul WSY7066
*                    Boxen-Aufrufe bestücken aus INT-SCHNITTSTELLE
*                    mit realisierten Funktionec MAC-BILDEN-AS,
*                    MAC-PRUEFEN-AS
*
*    Feld RCODE    : 0    -  OK
*                   9999  -  ungueltiger  Aufruf
*                   1 -   -  Fehler  aus WSYS065 durchgereicht
*                   9998
*
*    Feld ANWENDUNG: SL   -  default
*                    TO   -  Total
*                    DK   -  DKV
*                    UT   -  UTA
*                    TN   -  TND
*                    GC   -  girocard
*                    KA   -  KAAI
*
*    Feld CMD      : PU   -  PAC UMSCHLÜSSELN
*                    BT   -  MAC bilden Terminal
*                    BA   -  MAC bilden AS
*                    MB   -  MAC bilden Individuell TKEY (z.B. SHELL)
*                    MP   -  MAC prüfen Individuell TKEY
*                    PT   -  MAC prüfen Terminal
*                    PA   -  MAC prüfen AS
*
*    Feld TKEY-NAME: optional:abweichender Terminal-key vom Standard
*    Feld AKEY-NAME: optional:abweichender AS-KEY       vom Standard
*
*
*
* Aenderungen      : 2016-06-22  für WIKO066E (TOKHEIM)
*
*
************************************************************************
*
 01          "*"-WSY7066C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
     05      "*"-ANWENDUNG       PIC XX.
          88 "*"-DEFAULT                    VALUE    "SL".
          88 "*"-TOTAL                      VALUE    "TO".
          88 "*"-DKV                        VALUE    "DK".
          88 "*"-UTA                        VALUE    "UT".
          88 "*"-TND                        VALUE    "TN".
          88 "*"-GIRO                       VALUE    "GC".
          88 "*"-KAAI                       VALUE    "KA".

     05      "*"-CMD             PIC XX.
          88 "*"-PAC-UMSCHL                 VALUE    "PU".
          88 "*"-MAC-BILDEN                 VALUE    "MB".
          88 "*"-MAC-PRUEFEN                VALUE    "MP".
          88 "*"-MAC-BILDEN-TS              VALUE    "BT".
          88 "*"-MAC-BILDEN-AS              VALUE    "BA".
          88 "*"-MAC-PRUEFEN-TS             VALUE    "PT".
          88 "*"-MAC-PRUEFEN-AS             VALUE    "PA".

     05      "*"-VERF            PIC S9(04) COMP.
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-IFSF                       VALUE    5.
          88 "*"-VERF5                      VALUE    5.
*         ffu
          88 "*"-VERF6                      VALUE    6.
          88 "*"-VERF7                      VALUE    7.
          88 "*"-VERF8                      VALUE    8.
          88 "*"-VERF9                      VALUE    9.
          88 "*"-VERF10                     VALUE    10.
          88 "*"-VERF11                     VALUE    11.
          88 "*"-VERF12                     VALUE    12.
          88 "*"-VERF13                     VALUE    13.
          88 "*"-VERF14                     VALUE    14.
          88 "*"-VERF15                     VALUE    15.
* ---> Ab hier ISO-Feldpacker
          88 "*"-IFP48                      VALUE    16.
          88 "*"-VERF16                     VALUE    16.
*         ffu
          88 "*"-VERF17                     VALUE    17.
          88 "*"-VERF18                     VALUE    18.
          88 "*"-VERF19                     VALUE    19.
          88 "*"-VERF20                     VALUE    20.

     05      "*"-TKEY-NAME       PIC X(08).
     05      "*"-AKEY-NAME       PIC X(08).
     05      "*"-BOXMON-TEXT     PIC X(16).

************************************************************************


?section WSYS970C
************************************************************************
* erstellt am      : 08.08.20054
* letzte Aenderung : 13.01.2006
* Beschreibung     : Schnittstelle zum Modul WSYS970
*                    Pruefen Nachrichtenfelder
*
*    Feld RCODE    : 0    -  OK
*                    254  -  ungueltiger Wert fuer CMD
*                    255  -  sonstiger Fehler
*                    1001 -  1128 fehlende BMP
*                    2001 -  2128 BMP nicht numerisch
*                    ...
*
*    Feld CMD      : 01   -  Tabelle initialisieren / laden
*                    10   -  pruefen auf alles
*                    11   -  nur pruefen auf Vorhandensein
*                    12   -  nur numeric Pruefung
*
*    Feld MESSAGE  : NTYPEX - Nachrichtentyp aus Nachricht
*                    ABWKZX - Abwicklungskennzeichen aus Nachricht
*
*
*
* Aenderungen      :
*
* Version A.01.02   vom 13.01.2006  neues Kommando ..-INIT
* Version A.01.01   vom 11.01.2006  Feldnamen geaendert: ..ntypeX
*                                                      + ..abwkzX
*
************************************************************************
*
 01          "*"-WSYS970C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-NUMERR-BMP                 VALUE  1001 THRU  1128.
          88 "*"-MISSING-BMP                VALUE  4001 THRU  4128.
          88 "*"-UNEXPECTED-BMP             VALUE  5001 THRU  5128.
          88 "*"-CMDERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

     05      "*"-CMD             PIC S9(04) COMP.
          88 "*"-CMD-OK                     VALUE    1 10 11 12.
          88 "*"-INIT                       VALUE    1.
          88 "*"-CHECK-ALL                  VALUE    10.
          88 "*"-CHECK-INCL                 VALUE    11.
          88 "*"-CHECK-NUM                  VALUE    12.

     05      "*"-MESSAGE.
      10     "*"-NTYPEX          PIC X(04).
      10     "*"-ABWKZX          PIC X(06).


?section WSYS971C
************************************************************************
* erstellt am      : 11.07.2006
* letzte Aenderung : 11.07.2006
* Beschreibung     : Schnittstelle zum Modul WSYS971
*                    Pruefen Nachrichtenfelder
*
*    Feld RCODE    : 0    -  OK
*                    254  -  ungueltiger Wert fuer CMD
*                    255  -  sonstiger Fehler
*                    1001 -  1128 fehlende BMP
*                    2001 -  2128 BMP nicht numerisch
*                    ...
*
*    Feld CMD      : 01   -  Tabelle initialisieren / laden
*                    10   -  pruefen auf alles
*                    11   -  nur pruefen auf Vorhandensein
*                    12   -  nur numeric Pruefung
*
*    Feld MESSAGE  : NTYPE - Nachrichtentyp aus Nachricht
*                    ABWKZ - Abwicklungskennzeichen aus Nachricht
*
*
*
* Aenderungen      :
*
*
************************************************************************
*
 01          "*"-WSYS971C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-NUMERR-BMP                 VALUE  1001 THRU  1128.
          88 "*"-MISSING-BMP                VALUE  4001 THRU  4128.
          88 "*"-UNEXPECTED-BMP             VALUE  5001 THRU  5128.
          88 "*"-CMDERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

     05      "*"-CMD             PIC S9(04) COMP.
          88 "*"-CMD-OK                     VALUE    1 10 11 12.
          88 "*"-INIT                       VALUE    1.
          88 "*"-CHECK-ALL                  VALUE    10.
          88 "*"-CHECK-INCL                 VALUE    11.
          88 "*"-CHECK-NUM                  VALUE    12.

     05      "*"-MESSAGE.
      10     "*"-NTYPE           PIC X(04).
      10     "*"-ABWKZ           PIC X(06).

?section WSYS980C
******************************************************************
* Letzte Aenderung :: 2007-11-01
* Letzte Version   :: C.06.00
* Kurzbeschreibung :: Schnittstelle zum Modul WSYS980
*
* Aenderungen      :
*
* Version C.06.00   vom 01.11.2007  Neuerstellung
*
*
************************************************************************
*

 01          "*"-WSYS980C.

*----> Modulverwaltung
       05    "*"-VERWALTUNG.
        10   "*"-CC                 PIC S9(04) COMP.
*---->       Kommandocodes
          88 "*"-GET-META                             VALUE 10.
          88 "*"-GET-PROG                             VALUE 11.
          88 "*"-GET-PRC                              VALUE 12.
          88 "*"-GET-ANC                              VALUE 13.
          88 "*"-GET-CLASS                            VALUE 14.
*---->       Returncodes
        10   "*"-RC                 PIC S9(04) COMP.
          88 "*"-OK                                   VALUE ZERO.
          88 "*"-CMD-INVAL                            VALUE 100.
          88 "*"-PROCESS-INVAL                        VALUE 201.
          88 "*"-CLASS-NOT-FOUND                      VALUE 301.
          88 "*"-CLASS-ERROR                          VALUE 399.

*----> Nutzdaten
       05    "*"-NDATEN.
*            Programmnamen (voll qualifiziert)
        10   "*"-PROGRAM.
         15  "*"-SYSTEM             PIC X(08).
         15  "*"-VOL                PIC X(08).
         15  "*"-SUBVOL             PIC X(08).
         15  "*"-MODUL              PIC X(08).
*            Prozessnamen
        10   "*"-PROCESS            PIC X(18).
*            Pathwaysystem
        10   "*"-ANCNAME            PIC X(10).
*            Service Identifikation
        10   "*"-SERVICE.
         15  "*"-SRV-CLASS          PIC X(16).

?section WSYS985C
******************************************************************
* Übergabe-Bereich WSYS985 - IFSF-Konfuguration                  *
******************************************************************
 01     "*"-WSYS985C.
    05  "*"-IFC-HDR.
        10    "*"-CMD           PIC XX.
           88 "*"-GETCFG                        VALUE "GT".
           88 "*"-UPDCFG                        VALUE "UP".
           88 "*"-DELCFG                        VALUE "DE".
           88 "*"-CHKMSG                        VALUE "CM".
           88 "*"-CHKCFG                        VALUE "CC".
        10    "*"-RC            PIC S9(04) COMP.
            88 "*"-OK                           VALUE ZERO.
            88 "*"-SQLERR                       VALUE -9999 THRU -1.
            88 "*"-CMDERR                       VALUE 1.
            88 "*"-INITERR                      VALUE 3.
            88 "*"-MISC-ERR                     VALUE 9.
            88 "*"-NOT-FOUND                    VALUE 100.
    05  "*"-IFC-DATA.
        10 "*"-SERVERKLASSE         PIC   X(16).
        10 "*"-MSGMAP               PIC   X(16).
        10 "*"-ARTMAP               PIC   X(16).
        10 "*"-EXIT01               PIC   X(16).
        10 "*"-EXIT02               PIC   X(16).
        10 "*"-EXIT03               PIC   X(16).
        10 "*"-EXIT04               PIC   X(16).
        10 "*"-EXIT05               PIC   X(16).
        10 "*"-BOXMON               PIC   X(16).
        10 "*"-MACKEY               PIC   X(32).
        10 "*"-MACKEYA              PIC   X(32).
        10 "*"-MACKEYT              PIC   X(32).
        10 "*"-PACKEY               PIC   X(32).
        10 "*"-PACKEYA              PIC   X(32).
        10 "*"-PACKEYT              PIC   X(32).
        10 "*"-HERSTID              PIC   X(02).
        10 "*"-VERSION              PIC   X(02).
        10 "*"-ISOPAD               PIC   X(16).
        10 "*"-MAPSCOPE             PIC   X(16).
        10 "*"-MSGHASH-STATUS       PIC   9.
           88  "*"-MSGHASH-AKTUELL        VALUE ZERO.
           88  "*"-MSGHASH-NEW            VALUE 1.
        10 "*"-IFSFCFG-STATUS       PIC   9.
           88  "*"-IFSFCFG-AKTUELL        VALUE ZERO.
           88  "*"-IFSFCFG-NEW            VALUE 1.
        10 "*"-ZPINS                PIC   X(22).
        10 "*"-ZPUPD                PIC   X(22).
        10 "*"-ZUSER                PIC   X(07).
        10 "*"-ZUSERNAME            PIC   X(30).
        10 "*"-ISOPAD-HEX           PIC   X(08).


?section SSHMAP1C
************************************************************************
* Letzte Aenderung :: 2007-07-19
* Letzte Version   :: A.01.00
* Kurzbeschreibung :: Schnittstelle zum Artikeldatenmapper SSHMAP1
* Kurzbeschreibung :: (Version Shell/IFSF)
*
*
*     ===== VERALTET - siehe WXAMP01C (Server) =====
*
* Version A.01.00   vom 19.07.2007  - Neuerstellung
*
* Die Gesamtlaenge der Struktur betraegt 1050 Bytes
************************************************************************

 01          "*"-SSHMAP1C.

**    ---------> IFC-Header
      05     "*"-HEADER.

** -->    Kommandosteuerung
       10    "*"-CC              PIC S9(04) COMP.
**        Commands
          88 "*"-P2S             VALUE ZERO.
          88 "*"-S2P             VALUE 1.
          88 "*"-VALID-CMD       VALUE 0 THRU 1.
       10    "*"-RC              PIC S9(04) COMP.
**        Returncodes
          88 "*"-OK              VALUE ZERO.
          88 "*"-CMD-INVAL       VALUE -1.
          88 "*"-FORMAT-ERR      VALUE 30.
          88 "*"-NOT-FOUND       VALUE 100.
          88 "*"-SQLERROR        VALUE -9999 THRU -2.

**    ---------> IFC-Header
      05     "*"-DATA.
       10    "*"-MDNR            PIC 9(02).
       10    "*"-TSNR            PIC 9(08).
       10    "*"-CARDID          PIC 9(02).
       10    "*"-POS-LEN         PIC S9(04) COMP.
       10    "*"-POS-VAL         PIC X(512).
       10    "*"-HOST-LEN        PIC S9(04) COMP.
       10    "*"-HOST-VAL        PIC X(512).
*      Fehlerhafter Artikel (X wg. moeglichem Datenschrott)
       10    "*"-BAD-WG          PIC X(06).

?section WXAMP01C
************************************************************************
* Letzte Aenderung :: 2018-03-02
* Letzte Version   :: A.01.03
* Kurzbeschreibung :: Schnittstelle zum Artikeldatenmapper WXAMP01
*
*
* Version A.01.00   vom 09.08.2007  - Neuerstellung
* Version A.01.01   vom 20.05.2010  - Neues Feld "*"-FORMAT
* Version A.01.02   vom 17.01.2012  - Neues Feld "*"-TS63
* Version A.01.03   vom 02.03.2018  - Neue Schalterausprägung fuer "*"-RC
*                                     Alte Versionskommentare nachgezogen
*
* Die Gesamtlaenge der Struktur betraegt 2048 Bytes (FFU = 483)
************************************************************************

      05          "*"-SATZ.
**    ---------> IFC-Header
        10        "*"-HEADER.
**    --> Kommandosteuerung
            15    "*"-CC              PIC S9(04) COMP.
**        Commands
               88 "*"-P2S             VALUE ZERO.
               88 "*"-S2P             VALUE 1.
               88 "*"-VALID-CMD       VALUE 0 THRU 1.
            15    "*"-RC              PIC S9(04) COMP.
**        Returncodes
*kl20180302 - A.01.03 - Fuer erweiterte Fehlerbehandlung (F1ICC-94)
*                       Neu: Alles erlauben
               88 "*"-OK              VALUES 0 THRU 1.
*kl20180302 - A.01.03 - Ende
               88 "*"-CMD-INVAL       VALUE -1.
               88 "*"-FORMAT-ERR      VALUE 30.
*kl20180302 - A.01.03 - Fuer erweiterte Fehlerbehandlung (F1ICC-94)
               88 "*"-ALLOW-ALL       VALUE 1.
               88 "*"-NO-MAP          VALUE 45.
               88 "*"-NO-MATCH        VALUE 87.
*kl20180302 - A.01.03 - Ende
               88 "*"-NOT-FOUND       VALUE 100.
               88 "*"-SQLERROR        VALUE -9999 THRU -2.

**    ---------> IFC-Daten
        10       "*"-DATA.
            15   "*"-MDNR            PIC 9(02).
            15   "*"-TSNR            PIC 9(08).
            15   "*"-CARDID          PIC 9(02).
            15   "*"-POS-LEN         PIC S9(04) COMP.
            15   "*"-POS-VAL         PIC X(512).
            15   "*"-HOST-LEN        PIC S9(04) COMP.
            15   "*"-HOST-VAL        PIC X(512).
*      Fehlerhafter Artikel (X wg. moeglichem Datenschrott)
            15   "*"-BAD-WG          PIC X(06).
*kl20100520 - Fuer Aufloesung N2N-Beziehung Karte/Format
      05         "*"-FORMAT          PIC X(02).
      05         "*"-BMP48-FLAG      PIC 9.
*kl20100520 - Ende

*kl20120117 - Fuer Mapping gegen TS-Artikel
      05         "*"-TS63            PIC X(512).
**    ---------> IFC-Reserve
      05         "*"-RESERVE.
*             Muss kuerzer werden wegen "*"-TS63
*       10        "*"-FFU             PIC X(995).
        10        "*"-FFU             PIC X(483).
*kl20120117 - Ende

?section W63MP07C
************************************************************************
* Letzte Aenderung :: 2017-02-10
* Letzte Version   :: G.01.01
* Kurzbeschreibung :: Schnittstelle zum BMP63-Mapper W63MP07S
*
*
* Version G.01.01   vom 10.02.2017  - POS-48-VAL
* Version G.01.00   vom 02.12.2016  - Neuerstellung
*
* Die Gesamtlaenge der Struktur betraegt 4096 Bytes (FFU = 400)
************************************************************************

      05          "*"-SATZ.
**    ---------> IFC-Header
        10        "*"-HEADER.
**    --> Kommandosteuerung
            15    "*"-CC              PIC S9(04) COMP.
**        Commands
               88 "*"-P2S             VALUE ZERO.
               88 "*"-S2P             VALUE 1.
               88 "*"-VALID-CMD       VALUE 0 THRU 1.
            15    "*"-RC              PIC S9(04) COMP.
**        Returncodes
               88 "*"-OK              VALUE ZERO.
               88 "*"-CMD-INVAL       VALUE -1.
               88 "*"-FORMAT-ERR      VALUE 30.
               88 "*"-NOT-FOUND       VALUE 100.
               88 "*"-SQLERROR        VALUE -9999 THRU -2.

**    ---------> IFC-Daten
        10       "*"-DATA.
            15   "*"-MDNR            PIC 9(02).
            15   "*"-TSNR            PIC 9(08).
            15   "*"-CARDID          PIC 9(02).
            15   "*"-POS-48-LEN      PIC S9(04) COMP.
*kl20170210 - G.01.01 - Verlängert wg. 48.9
*           15   "*"-POS-48-VAL      PIC X(68).
            15   "*"-POS-48-VAL      PIC X(256).
*kl20170210 - G.01.01 - Ende
            15   "*"-POS-63-LEN      PIC S9(04) COMP.
            15   "*"-POS-63-VAL      PIC X(1198).
            15   "*"-HOST-LEN        PIC S9(04) COMP.
            15   "*"-HOST-VAL        PIC X(1198).
*                Fehlerhafter Artikel (X wg. moeglichem Datenschrott)
            15   "*"-BAD-WG          PIC X(06).
*                Fuer Aufloesung N2N-Beziehung Karte/Format
      05         "*"-FORMAT          PIC X(02).
*                BMP48-Werte vorhanden fuer AS-Anfrage
      05         "*"-BMP48-FLAG      PIC 9.
*                wg. Wortgrenze Vor T63...
      05         "*"-FILLER          PIC X.

*                Fuer Mapping gegen TS-Artikel
      05         "*"-TS63-LEN        PIC S9(04) COMP.
      05         "*"-TS63            PIC X(1198).

*kl20170210 - G.01.01 - Hilfsfelder: Absendeserver + Automatenflag
*                       (letzteres fuer Option mit ARTMAP + WEATWGR)
*                       Reserve verkürzt wg. POS-48-VAL + Hilfsfeldern
      05         "*"-SENDING-SRV     PIC X(16).
      05         "*"-KZ-ATM          PIC XX.

**    ---------> IFC-Reserve
      05         "*"-RESERVE         PIC X(194).
*kl20170210 - G.01.01 - Hilfsfelder: Absendeserver + Automatenflag

?section WXMSG01C
************************************************************************
* Letzte Aenderung :: 2007-06-12
* Letzte Version   :: B.01.00
* Kurzbeschreibung :: Struktur der Pathway-Schnittstelle zwischen
* Kurzbeschreibung :: Verarbeitungsserver und Messagemappern
*
*
* Version B.01.00   vom 12.06.2007  - Neuerstellung
*
* Struktur der internen Schnittstelle zwischen den
* Pathway-Servern
*
* Die 01-Stufe ist im Programm zu setzen
* Die Gesamtlaenge der Struktur betraegt 10240 Bytes
************************************************************************

     05      "*"-SATZ.

**    ---------> IFC-Header
      10     "*"-HEADER.

** -->    Kommandosteuerung
       15    "*"-CC              PIC S9(04) COMP.
**        Commands
          88 "*"-CREATE-ISO      VALUE ZERO.
          88 "*"-STACK-ONLY      VALUE 1.
          88 "*"-VALID-CMD       VALUE 0 THRU 1.

** -->    Aufrufer (fuer Bereich in Mappingtabelle, HASHKEY-SRV)
       15    "*"-SRC-MSG         PIC X(16).
       15    "*"-DST-MSG         PIC X(16).

** -->    Fuer CREATE-ISO ist auch das Verfahren erforderlich
       15    "*"-ISO              PIC S9(04) COMP.
* ---> Nachrichtenpacker / -entpacker
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-IFSF                       VALUE    5.
          88 "*"-VERF5                      VALUE    5.
*         ffu
          88 "*"-VERF6                      VALUE    6.
          88 "*"-VERF7                      VALUE    7.
          88 "*"-VERF8                      VALUE    8.
          88 "*"-VERF9                      VALUE    9.
          88 "*"-VERF10                     VALUE    10.
          88 "*"-VERF11                     VALUE    11.
          88 "*"-VERF12                     VALUE    12.
          88 "*"-VERF13                     VALUE    13.
          88 "*"-VERF14                     VALUE    14.
          88 "*"-VERF15                     VALUE    15.

* ---> Ab hier ISO-Feldpacker
          88 "*"-IFP48                      VALUE    16.
          88 "*"-VERF16                     VALUE    16.
*         ffu
          88 "*"-VERF17                     VALUE    17.
          88 "*"-VERF18                     VALUE    18.
          88 "*"-VERF19                     VALUE    19.
          88 "*"-VERF20                     VALUE    20.
          88 "*"-VALID-VERF                 VALUE    1 THRU 20.

** -->    Fuer Fehlerrueckgabe
       15    "*"-RC                PIC S9(04) COMP.
**        Returncodes
          88 "*"-OK              VALUE ZERO.
          88 "*"-CMD-ERROR       VALUE 1.
          88 "*"-ISO-ERROR       VALUE 2.
          88 "*"-NO-HASH         VALUE 100.

**    ---------> Nutzdaten

*  -->    Daten der internen Schnittstelle
      10     "*"-MESSAGE-WRAP       PIC X(4096).
*  -->    ggf. zweite Message
      10     "*"-MESSAGE-WRAP-AUX   PIC X(4096).

*  -->    Stack Anwendungsdaten
      10     "*"-APP-DATA.
*kl20070418 - Neu: Zielbytemap wg. optionaler Felder
       15    "*"-ABMP-O.
        20   "*"-ABMP            PIC 9           OCCURS 128.
*kl20070418 - Ende
       15    "*"-APTR-O.
        20   "*"-APTR            PIC S9(04) COMP OCCURS 30.
       15    "*"-ALEN-O.
        20   "*"-ALEN            PIC S9(04) COMP OCCURS 30.
**          ---> Pointer auf naechste freie Stelle im Datenbuffer AD
       15    "*"-APP-NEXT-PTR    PIC S9(04) COMP.

**          ---> Stackdaten
       15    "*"-AD              PIC X(750).

*  -->    Reserve / For future use
      10     "*"-FFU             PIC X(1010).

*********************************************************************
* ENDE DER SCHNITTSTELLE                                            *
*********************************************************************
*
* Laengenberchnung
*
* Header                 38
* Messagewrap 1        4096
* Messagewrap 2        4096
* ABMP-O                128
* APTR-O                 60
* ALEN-O                 60
* APP-NEXT-PTR            2
* AD                    750
*------------------------------
* Zwischensumme        9230
* FFU                  1010
*------------------------------
*                     10240
*==============================

?section WXMSG07C
************************************************************************
* Letzte Aenderung :: 2013-09-26
* Letzte Version   :: G.01.00
* Kurzbeschreibung :: Struktur der Pathway-Schnittstelle zwischen
* Kurzbeschreibung :: Verarbeitungsserver und Messagemappern
*
*
* Version G.01.00   vom 26-09-2013  - Neuerstellung
*
* Struktur der internen Schnittstelle zwischen den
* Pathway-Servern
*
* Die 01-Stufe ist im Programm zu setzen
* Die Gesamtlaenge der Struktur betraegt 10240 Bytes
*
* Diese Schnittstelle enspricht WXMSG01C. Die Anzahl der Stackpositionen
* wurde gegenueber o.g. IFC auf 128 erhoeht. Der Stack wurde von 750
* auf 1K erweitert.
************************************************************************

     05      "*"-SATZ.

**    ---------> IFC-Header
      10     "*"-HEADER.

** -->    Kommandosteuerung
       15    "*"-CC              PIC S9(04) COMP.
**        Commands
          88 "*"-CREATE-ISO      VALUE ZERO.
          88 "*"-STACK-ONLY      VALUE 1.
          88 "*"-VALID-CMD       VALUE 0 THRU 1.

** -->    Aufrufer (fuer Bereich in Mappingtabelle, HASHKEY-SRV)
       15    "*"-SRC-MSG         PIC X(16).
       15    "*"-DST-MSG         PIC X(16).

** -->    Fuer CREATE-ISO ist auch das Verfahren erforderlich
       15    "*"-ISO              PIC S9(04) COMP.
* ---> Nachrichtenpacker / -entpacker
          88 "*"-EC                         VALUE    1.
          88 "*"-VERF1                      VALUE    1.
          88 "*"-EDC                        VALUE    2.
          88 "*"-VERF2                      VALUE    2.
          88 "*"-GICC                       VALUE    3.
          88 "*"-VERF3                      VALUE    3.
          88 "*"-OPT                        VALUE    4.
          88 "*"-VERF4                      VALUE    4.
          88 "*"-IFSF                       VALUE    5.
          88 "*"-VERF5                      VALUE    5.
*         ffu
          88 "*"-VERF6                      VALUE    6.
          88 "*"-VERF7                      VALUE    7.
          88 "*"-VERF8                      VALUE    8.
          88 "*"-VERF9                      VALUE    9.
          88 "*"-VERF10                     VALUE    10.
          88 "*"-VERF11                     VALUE    11.
          88 "*"-VERF12                     VALUE    12.
          88 "*"-VERF13                     VALUE    13.
          88 "*"-VERF14                     VALUE    14.
          88 "*"-VERF15                     VALUE    15.

* ---> Ab hier ISO-Feldpacker
          88 "*"-IFP48                      VALUE    16.
          88 "*"-VERF16                     VALUE    16.
*         ffu
          88 "*"-VERF17                     VALUE    17.
          88 "*"-VERF18                     VALUE    18.
          88 "*"-VERF19                     VALUE    19.
          88 "*"-VERF20                     VALUE    20.
          88 "*"-VALID-VERF                 VALUE    1 THRU 20.

** -->    Fuer Fehlerrueckgabe
       15    "*"-RC                PIC S9(04) COMP.
**        Returncodes
          88 "*"-OK              VALUE ZERO.
          88 "*"-CMD-ERROR       VALUE 1.
          88 "*"-ISO-ERROR       VALUE 2.
          88 "*"-NO-HASH         VALUE 100.

**    ---------> Nutzdaten

*  -->    Daten der internen Schnittstelle
      10     "*"-MESSAGE-WRAP       PIC X(4096).
*  -->    ggf. zweite Message
      10     "*"-MESSAGE-WRAP-AUX   PIC X(4096).

*  -->    Stack Anwendungsdaten
      10     "*"-APP-DATA.
*kl20070418 - Neu: Zielbytemap wg. optionaler Felder
       15    "*"-ABMP-O.
        20   "*"-ABMP            PIC 9           OCCURS 128.
*kl20070418 - Ende
       15    "*"-APTR-O.
        20   "*"-APTR            PIC S9(04) COMP OCCURS 128.
       15    "*"-ALEN-O.
        20   "*"-ALEN            PIC S9(04) COMP OCCURS 128.
**          ---> Pointer auf naechste freie Stelle im Datenbuffer AD
       15    "*"-APP-NEXT-PTR    PIC S9(04) COMP.

**          ---> Stackdaten
       15    "*"-AD              PIC X(1024).

*  -->    Reserve / For future use
      10     "*"-FFU             PIC X(344).

*********************************************************************
* ENDE DER SCHNITTSTELLE                                            *
*********************************************************************
*
* Laengenberechnung
* -----------------
*
* Header                 38
* Messagewrap 1        4096
* Messagewrap 2        4096
* ABMP-O                128
* APTR-O                256
* ALEN-O                256
* APP-NEXT-PTR            2
* AD                   1024
*------------------------------
* Zwischensumme        9896
* FFU                   340
*------------------------------
*                     10240
*==============================


?section WML0000C
************************************************************************
* erstellt am      : 07.08.2006
* letzte Aenderung : 07.08.2006
* Beschreibung     : Schnittstelle zum Modul WML0000
*                    Mailversender
*
* Aenderungen      :
*
*
************************************************************************
 01          "*"-WML0000C.
*    Retruncode
     05      "*"-RC                     PIC S9(04) COMP.
*    Knotenname fuer generelle Mailparameter
     05      "*"-SYSTEM-NAME            PIC X(08).
*    Sendendes Programm / Mandant / Tankstelle fuer Zugriff auf
*    EKONTAKTE und EMAIL
     05      "*"-MODUL                  PIC X(08).
     05      "*"-MDNR                   PIC 9(02).
     05      "*"-TSNR                   PIC 9(08).
*    ggf. Betreffzeile (falls nicht default aus DB)
     05      "*"-SUBJECT-LEN            PIC S9(04) COMP.
     05      "*"-SUBJECT-VAL            PIC X(80).
*    ggf. Text (falls nicht aus DB)
     05      "*"-BODY-LEN               PIC S9(04) COMP.
     05      "*"-BODY-VAL               PIC X(1024).
*    ggf. anzuhaengende Datei (falls nicht aus DB)
     05      "*"-ATTACHEMENT-LEN        PIC S9(04) COMP.
     05      "*"-ATTACHEMENT-VAL        PIC X(36).
*    ggf. Name des Attachements (der Datei) auf dem Zielsystem
     05      "*"-PCFILE-LEN             PIC S9(04) COMP.
     05      "*"-PCFILE-VAL             PIC X(30).
*    ggf. Namenserweiterung auf dem Zielsystem (PC-Extension)
     05      "*"-PCEXT-LEN              PIC S9(04) COMP.
     05      "*"-PCEXT-VAL              PIC X(20).


?section WISO300C
************************************************************************
* erstellt am      : 01.03.2006
* letzte Aenderung :
* letzte Version   : A.01.00
*
* Beschreibung     : Schnittstelle zum Modul WISO300 - BER-TLV
*                    (encode / decode COBOL/TLV)
*
*                Beschraenkungen:
*
*                    1. max. 2-stellige TAG's
*                    2. max. 2-stellige Laengenfelder
*                    3. Wert-Feld-Laenge max. 512 Bytes
*                    4. TLV-codierte Stringlaenge max 1024 Bytes
*
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*A.01.nn|         |     |
*-------|---------|-----|----------------------------------------*
*A.01.00|20060228 | jb  | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    100 -   EOT (keine weiteren TAG's gefunden)
*                    249 -   kein SubTAG gefunden
*                    250 -   Reihenfolgefehler (1. Aufruf muss
*                            immer ein TAG sein
*                    251 -   TAG-Kodierung falsch
*                            max. 2 Byte lange TAG's werden unterst.
*                    252 -   Laengenfehler
*                            - max. 512 - 4
*                            - verbleibende Laenge zu kurz fuer DA
*                            - Laengenschl. falsch: max. 2 Bytes
*                            - Wertefeld > 255
*                    253 -   irrelevant
*                    254 -   fehlerhafte Kommando
*                    255 -   irrelevant
*
*    Feld CMD      : 10  -   decode TAG   (TLV -> Cobol)
*                    11  -   decode S'TAG (TLV -> Cobol)
*                    20  -   encode TAG   (Cobol -> TLV)
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld TLVLEN   : I/O     Laenge TLV-String
*
*    Feld TLVSTRING: I/O     TLV-codierter String
*
*    Feld TAGPTR   : O       Aufsetzpointer fuer TLV Untersuchung
*                            (muss vom rufenden Programm bei jeder
*                            NEUEN String auf 0 gesetzt werden)
*
*    Feld STAGPTR  : O       Aufsetzpointer fuer TLV Untersuchung
*                            (muss vom rufenden Programm bei jeder
*                            NEUEN String auf 0 gesetzt werden)
*
*    Feld TAGLEN   : I/O     Laenge Inhalt TAG-Feld (nur 2 oder 4 moegl.)
*
*    Feld TAG      : I/O     TAG (CMD=10/20) oder STAG (CMD=11)
*                            (in hexadezimaler Form, also max.4 Bytes,
*                             linksbuendig, mit Spaces aufgefuellt)
*
*    Feld VALLEN   : I/O     Laenge Cobol-Feld (TAG-Wert)
*
*    Feld TAGVAL   : I/O     COBOL-Feld (TAG-Wert) (unveraendert)
*
*                     * aus Sicht WISO300
*
************************************************************************
*
  01          "*"-WISO300C.
      05      "*"-VERWALTUNG.
***          ---> Rueckgabestatus
       10     "*"-RCODE           PIC S9(04) COMP.
           88 "*"-OK                         VALUE 0.
           88 "*"-ERR                        VALUE -9999 THRU    -1
                                                       1 THRU    99
                                                     101 THRU  9999.
           88 "*"-WARN                       VALUE  100.
           88 "*"-EOT                        VALUE  100.
           88 "*"-NOSTAG                     VALUE  249.
           88 "*"-ORDERERR                   VALUE  250.
           88 "*"-TAGERR                     VALUE  251.
           88 "*"-LENERR                     VALUE  252.
           88 "*"-COBERR                     VALUE  253.
           88 "*"-CMDERR                     VALUE  254.
           88 "*"-DIVERR                     VALUE  255.

**          ---> Kommando
       10     "*"-CMD             PIC S9(04) COMP.
           88 "*"-DECTAG                     VALUE   10.
           88 "*"-DECSTAG                    VALUE   11.
           88 "*"-ENCTAG                     VALUE   20.
*
      05      "*"-DATEN.
       10     "*"-TLVLEN          PIC S9(04) COMP.
       10     "*"-TLVSTRING       PIC  X(4000).
       10     "*"-TAGPTR          PIC S9(04) COMP.
       10     "*"-STAGPTR         PIC S9(04) COMP.
       10     "*"-TAGLEN          PIC S9(04) COMP.
       10     "*"-TAG             PIC  X(04).
       10     "*"-VALLEN          PIC S9(04) COMP.
       10     "*"-VAL             PIC  X(2000).
*
************************************************************************


?section WISO370C
************************************************************************
* erstellt am      : 13.07.2015
* letzte Aenderung :
* letzte Version   : G.01.00
*
* Beschreibung     : Schnittstelle zum Modul WISO300 - BER-TLV
*                    (encode / decode COBOL/TLV)
*
*                Beschraenkungen:
*
*                    1. max. 2-stellige TAG's
*                    2. max. 2-stellige Laengenfelder
*                    3. Wert-Feld-Laenge max. 512 Bytes
*                    4. TLV-codierte Stringlaenge max 1024 Bytes
*
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*A.01.nn|         |     |
*-------|---------|-----|----------------------------------------*
*G.01.00|20150713 | HJO | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    100 -   EOT (keine weiteren TAG's gefunden)
*                    249 -   kein SubTAG gefunden
*                    250 -   Reihenfolgefehler (1. Aufruf muss
*                            immer ein TAG sein
*                    251 -   TAG-Kodierung falsch
*                            max. 2 Byte lange TAG's werden unterst.
*                    252 -   Laengenfehler
*                            - max. 512 - 4
*                            - verbleibende Laenge zu kurz fuer DA
*                            - Laengenschl. falsch: max. 2 Bytes
*                            - Wertefeld > 255
*                    253 -   irrelevant
*                    254 -   fehlerhafte Kommando
*                    255 -   irrelevant
*
*    Feld CMD      : 10  -   decode TAG   (TLV -> Cobol)
*                    11  -   decode S'TAG (TLV -> Cobol)
*                    20  -   encode TAG   (Cobol -> TLV)
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld TLVLEN   : I/O     Laenge TLV-String
*
*    Feld TLVSTRING: I/O     TLV-codierter String
*
*    Feld TAGPTR   : O       Aufsetzpointer fuer TLV Untersuchung
*                            (muss vom rufenden Programm bei jeder
*                            NEUEN String auf 0 gesetzt werden)
*
*    Feld STAGPTR  : O       Aufsetzpointer fuer TLV Untersuchung
*                            (muss vom rufenden Programm bei jeder
*                            NEUEN String auf 0 gesetzt werden)
*
*    Feld TAGLEN   : I/O     Laenge Inhalt TAG-Feld (nur 2 oder 4 moegl.)
*
*    Feld TAG      : I/O     TAG (CMD=10/20) oder STAG (CMD=11)
*                            (in hexadezimaler Form, also max.4 Bytes,
*                             linksbuendig, mit Spaces aufgefuellt)
*
*    Feld VALLEN   : I/O     Laenge Cobol-Feld (TAG-Wert)
*
*    Feld TAGVAL   : I/O     COBOL-Feld (TAG-Wert) (unveraendert)
*
*                     * aus Sicht WISO300
*
************************************************************************

 01          "*"-WISO370C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU    99
                                                    101 THRU  9999.
          88 "*"-WARN                       VALUE  100.
          88 "*"-EOT                        VALUE  100.
          88 "*"-NOSTAG                     VALUE  249.
          88 "*"-ORDERERR                   VALUE  250.
          88 "*"-TAGERR                     VALUE  251.
          88 "*"-LENERR                     VALUE  252.
          88 "*"-COBERR                     VALUE  253.
          88 "*"-CMDERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-DECTAG                     VALUE   10.
          88 "*"-DECSTAG                    VALUE   11.
          88 "*"-ENCTAG                     VALUE   20.

     05      "*"-DATEN.
      10     "*"-TLVLEN          PIC S9(09) COMP.
      10     "*"-TLVSTRING       PIC  X(20000).
      10     "*"-TAGPTR          PIC S9(09) COMP.
      10     "*"-STAGPTR         PIC S9(09) COMP.
      10     "*"-TAGLEN          PIC S9(09) COMP.
      10     "*"-TAG             PIC  X(04).
      10     "*"-VALLEN          PIC S9(09) COMP.
      10     "*"-VAL             PIC  X(10000).

************************************************************************

?section WISOX70C
************************************************************************
* erstellt am      : 27.02.2017
* letzte Aenderung :
* letzte Version   : G.01.00
*
* Beschreibung     : Schnittstelle zum Modul WISOX70 - BER-TLV
*                    (encode / decode COBOL/TLV)
*
*                Beschraenkungen:
*
*                    1. max. 3-stellige TAG-Bezeichner
*                    2. max. 3-stellige Laengenfelder
*                    3. Wert-Feld-Laenge max. 10000 Bytes
*                    4. TLV-codierte Stringlaenge max 20000 Bytes
*
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*G.01.00|20170227 | HJO | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    100 -   EOT (keine weiteren TAG's gefunden)
*                    249 -   kein SubTAG gefunden
*                    250 -   Reihenfolgefehler (1. Aufruf muss
*                            immer ein TAG sein
*                    251 -   TAG-Kodierung falsch
*                            max. 2 Byte lange TAG's werden unterst.
*                    252 -   Laengenfehler
*                            - max. 512 - 4
*                            - verbleibende Laenge zu kurz fuer DA
*                            - Laengenschl. falsch: max. 2 Bytes
*                            - Wertefeld > 255
*                    253 -   irrelevant
*                    254 -   fehlerhafte Kommando
*                    255 -   irrelevant
*
*    Feld CMD      : 10  -   decode TAG   (TLV -> Cobol)
*                    11  -   decode S'TAG (TLV -> Cobol)
*                    20  -   encode TAG   (Cobol -> TLV)
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld TLVLEN   : I/O     Laenge TLV-String
*
*    Feld TLVSTRING: I/O     TLV-codierter String
*
*    Feld TAGPTR   : O       Aufsetzpointer fuer TLV Untersuchung
*                            (muss vom rufenden Programm bei jeder
*                            NEUEN String auf 0 gesetzt werden)
*
*    Feld STAGPTR  : O       Aufsetzpointer fuer TLV Untersuchung
*                            (muss vom rufenden Programm bei jeder
*                            NEUEN String auf 0 gesetzt werden)
*
*    Feld TAGLEN   : I/O     Laenge Inhalt TAG-Feld (nur 2, 4, 6 moegl.)
*
*    Feld TAG      : I/O     TAG (CMD=10/20) oder STAG (CMD=11)
*                            (in hexadezimaler Form, also max.6 Bytes,
*                             linksbuendig, mit Spaces aufgefuellt)
*
*    Feld VALLEN   : I/O     Laenge Cobol-Feld (TAG-Wert)
*
*    Feld TAGVAL   : I/O     COBOL-Feld (TAG-Wert) (unveraendert)
*
*                     * aus Sicht WISOX70
*
************************************************************************

 01          "*"-WISOX70C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU    99
                                                    101 THRU  9999.
          88 "*"-WARN                       VALUE  100.
          88 "*"-EOT                        VALUE  100.
          88 "*"-NOSTAG                     VALUE  249.
          88 "*"-ORDERERR                   VALUE  250.
          88 "*"-TAGERR                     VALUE  251.
          88 "*"-LENERR                     VALUE  252.
          88 "*"-COBERR                     VALUE  253.
          88 "*"-CMDERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-DECTAG                     VALUE   10.
          88 "*"-DECSTAG                    VALUE   11.
          88 "*"-ENCTAG                     VALUE   20.

     05      "*"-DATEN.
      10     "*"-DCPOS-VERS      PIC X(05).
      10     "*"-TLVLEN          PIC S9(09) COMP.
      10     "*"-TLVSTRING       PIC  X(30000).
      10     "*"-TAGPTR          PIC S9(09) COMP.
      10     "*"-STAGPTR         PIC S9(09) COMP.
      10     "*"-TAGLEN          PIC S9(09) COMP.
      10     "*"-TAG             PIC  X(06).
      10     "*"-VALLEN          PIC S9(09) COMP.
      10     "*"-VAL             PIC  X(20000).

************************************************************************






?section WISO310C
************************************************************************
* erstellt am      : 03.03.2006
* letzte Aenderung :
* letzte Version   : A.01.00
*
* Beschreibung     : Schnittstelle zum Modul WISO310 - KAAI-LTV
*                    (encode / decode COBOL/KAAI-LTV)
*
*                Beschraenkungen:
*
*                    1. 3-stellige Laengenfelder
*                    2. 2-stellige TAG's (Subfelder)
*                    3. Wert-Feld-Laenge max. 512 Bytes
*                    4. LTV-codierte Stringlaenge max 1024 Bytes
*
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*A.01.nn|         |     |
*-------|---------|-----|----------------------------------------*
*A.01.00|20060303 | jb  | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    100 -   EOT (keine weiteren TAG's gefunden)
*                    249 -   kein SubTAG gefunden
*                    250 -   Reihenfolgefehler (1. Aufruf muss
*                            immer ein TAG sein
*                    251 -   TAG-Kodierung falsch
*                            max. 2 Byte lange TAG's werden unterst.
*                    252 -   Laengenfehler
*                            - max. 512 - 4
*                            - verbleibende Laenge zu kurz fuer DA
*                            - Laengenschl. falsch: max. 2 Bytes
*                            - Wertefeld > 255
*                    253 -   irrelevant
*                    254 -   fehlerhafte Kommando
*                    255 -   irrelevant
*
*    Feld CMD      : 10  -   decode SF    (LTV -> Cobol)
*                    20  -   encode SF    (Cobol -> LTV)
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld LTVLEN   : I/O     Laenge LTV-String
*
*    Feld LTVSTRING: I/O     LTV-codierter String
*
*    Feld SFPTR    : O       Aufsetzpointer fuer LTV Untersuchung
*                            (muss vom rufenden Programm bei jedem
*                            NEUEN String auf 0 gesetzt werden)
*
*    Feld SF       : I/O     TAG (Subfeld-Nr.) (CMD=10/20)
*
*    Feld VALLEN   : I/O     Laenge Cobol-Feld (TAG-Wert)
*
*    Feld TAGVAL   : I/O     COBOL-Feld (TAG-Wert) (unveraendert)
*
*                     * aus Sicht WISO310
*
************************************************************************

 01          "*"-WISO310C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU    99
                                                    101 THRU  9999.
          88 "*"-WARN                       VALUE  100.
          88 "*"-EOT                        VALUE  100.
          88 "*"-NOSTAG                     VALUE  249.
          88 "*"-ORDERERR                   VALUE  250.
          88 "*"-TAGERR                     VALUE  251.
          88 "*"-LENERR                     VALUE  252.
          88 "*"-COBERR                     VALUE  253.
          88 "*"-CMDERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-DECSF                      VALUE   10.
          88 "*"-ENCSF                      VALUE   20.

     05      "*"-DATEN.
      10     "*"-LTVLEN          PIC S9(04) COMP.
      10     "*"-LTVSTRING       PIC  X(1024).
      10     "*"-SFPTR           PIC S9(04) COMP.
      10     "*"-SF              PIC  9(02).
      10     "*"-VALLEN          PIC S9(04) COMP.
      10     "*"-VAL             PIC  X(512).

************************************************************************

?section WISO400C
************************************************************************
* erstellt am      : 06.03.2006
* letzte Aenderung : 18.07.2008
* letzte Version   : A.01.00
*
* kl20080717 - Neues Kommando LOOK4TAGXP - Rueckgabe entpackte TAG-Werte
*
* Beschreibung     : Schnittstellenmodul zwischen Applikation und
*                    BER-TLV- (WISO300) bzw. KAAI-LTV-Fummler (WISO310)
*
*                    Es werden 2 Funktionen unterstuetzt:
*
*                        1. Umkodieren von BER-TLV nach KAAI-LTV
*                        2. Umkodieren von KAAI-LTV nach BER-TLV
*
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*A.01.nn|         |     |
*-------|---------|-----|----------------------------------------*
*A.01.00|20060306 | jb  | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    246 -   gesuchtes Subfeld / TAG nicht im String gef.
*                    247 -   kein Subfeld fuer gefundenes TAG vorhanden
*                    248 -   Fehler beim Laden der Tabellen TLV2LTV
*                            oder STAG2TAG
*                    249 -
*                    250 -   Reihenfolgefehler (1. Aufruf muss
*                            immer ein TAG sein
*                    251 -   TAG-Kodierung falsch
*                            max. 2 Byte lange TAG's werden unterst.
*                    252 -   Laengenfehler
*                            - max. 512 - 4
*                            - verbleibende Laenge zu kurz fuer DA
*                            - Laengenschl. falsch: max. 2 Bytes
*                            - Wertefeld > 255
*                    253 -   irrelevant
*                    254 -   fehlerhaftes Kommando
*                    255 -   irrelevant
*
*    Feld CMD      : 10  -   Umschluesseln BER-TLV -> KAAI-LTV
*                    20  -   Umschluesseln KAAI-LTV -> BER-TLV
*                    30  -   Suchen bestimmtes TAG
*                    31  -   Suchen bestimmtes Subfeld
*                    40  -   Suchen bestimmtes TAG - entpackte Rueckgabe
*                    41  -   Suchen bestimmtes SF  - entpackte Rueckgabe
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld BER-TLV-LEN    : I/O     Laenge TLV-String
*
*    Feld BER-TLV-STRING : I/O     TLV-codierter String
*
*    Feld KAAI-LTV-LEN   : I/O     Laenge TLV-String
*
*    Feld KAAI-LTV-STRING: I/O     TLV-codierter String
*
*    Feld DF4F-SF99      : O       TAG DF4F bzw. Subfeld-Nr. 99 in ASCII
*                                  Der Inhalt des TAG's bzw. Subfelds
*                                  wird aus dem Eingabestring extrahiert
*                                  und hier zurueckgegeben
*
*    Feld SEARCH-TAG     : I       zu suchendes TAG (linksbuendig)
*
*    Feld SEARCH-SF      : I       zu suchendes Subfeld
*
*                     * aus Sicht WISO400
*
************************************************************************

 01          "*"-WISO400C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-NOTFOUND                   VALUE  246.
          88 "*"-MISSINGTAG                 VALUE  247.
          88 "*"-LADERR                     VALUE  248.
          88 "*"-NOSTAG                     VALUE  249.
          88 "*"-ORDERERR                   VALUE  250.
          88 "*"-TAGERR                     VALUE  251.
          88 "*"-LENERR                     VALUE  252.
          88 "*"-COBERR                     VALUE  253.
          88 "*"-CMDERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-TAG2SF                     VALUE   10.
          88 "*"-SF2TAG                     VALUE   20.
          88 "*"-LOOK4TAG                   VALUE   30.
          88 "*"-LOOK4SF                    VALUE   31.
          88 "*"-LOOK4TAGXP                 VALUE   40.
          88 "*"-LOOK4SFXP                  VALUE   41.

     05      "*"-DATEN.
      10     "*"-BER-TLV-LEN     PIC S9(04) COMP.
      10     "*"-BER-TLV-STRING  PIC X(1024).
      10     "*"-KAAI-LTV-LEN    PIC S9(04) COMP.
      10     "*"-KAAI-LTV-STRING PIC X(1024).
      10     "*"-DF4F-SF99       PIC X(02).
      10     "*"-SEARCH-TAG      PIC X(04).
      10     "*"-SEARCH-SF       PIC 9(02).

************************************************************************

?section WISO410C
************************************************************************
* letzte Aenderung : 2009-06-22
* letzte Version   : A.01.04
*
* Beschreibung     : Schnittstellenmodul zwischen Applikation und
*                    BER-TLV- (WISO300)
*
*                    Es werden 2 Funktionen unterstuetzt:
*
*                        1. Suche nach TAG in String
*                        2. Aufbereiten Template fuer spez. Terminal
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*A.01.04|20090622 |HJO  | Verlängerung TEMPLATE von 4000 auf 8K
*       |         |     |
*-------|---------|-----|----------------------------------------*
*A.01.03|20090209 | jb  | Neues Kommando 11 - wie 10, jedoch wird
*       |         |     | nach demselben TAG im Template weiter
*       |         |     | gesucht (Reihenfolge: immer erst 10, dann
*       |         |     | mehrfach 11 moeglich)
*       |         |     | Wenn keine weitere Fundstelle wird EOD
*       |         |     | zurueck gegeben
*-------|---------|-----|----------------------------------------*
*A.01.02|20090127 | jb  | Neues Kommando 21 - wie 20 jedoch wird
*       |         |     | im Bereich 'E2' nachgesehen, ob fuer ein
*       |         |     | gefundenes TAG auch im Bereich 'EA' vor-
*       |         |     | handen ist. Dann wird das TAG aus 'EA'
*       |         |     | in das Template 'E2' eingestellt.
*-------|---------|-----|----------------------------------------*
*A.01.01|20080514 | jb  | neuer OK-Rueckgabestatus (1-..-MDNR-TSNR)
*-------|---------|-----|----------------------------------------*
*A.01.00|20080502 | jb  | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    100 -   gesuchtes TAG nicht im String gef.
*                            keine Werte fuer Templat mit Auswahl gefunden
*                    253 -   angefordertes TAG nicht gefunden
*                    254 -   Laengenfehler
*                            - max. 4000 fuer die Aufbereitung Tamplate
*                    255 -   fehlerhaftes Kommando
*
*    Feld CMD      : 10  -   Suchen bestimmtes TAG
*                    11  -   Suchen bestimmtes TAG (naechstes Vorkommen
*                            im selben Template, erst 10 dann mehrfach 11
*                            moeglich)
*                    20  -   Aufbereiten Template
*                    21  -   Aufbereiten Template (mit ersetzen der
*                            'E2'-TAG's durch 'EA'-TAG's)
*
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld ..-SEARCH-TAG      : I   zu suchendes TAG (linksbuendig)
*    Feld ..-MDNR            : I   MDNR fuer Template
*    Feld ..-TSNR            : I   TSNR fuer Template
*    Feld ..-BEREICHS-KZ     : I   Bereichs-KZ fuer Template
*    Feld ..-APPL-KZ         : I   Applikations-KZ
*    Feld ..-TEMPLATE        : I   zu durchsuchendes Template (binaer)
*                              O   Rueckgabe Wert TAG      (ASCII)
*                                                 Template (binaer)
*    Feld ..-TEMPLATE-LEN    : I   Laenge zu durchsuchendes Template
*                              O   Rueckgabe Laenge TAG/Template
*
************************************************************************

 01          "*"-WISO410C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0 1.
**          ---> Rueckgabe andere MDNR/TSNR
          88 "*"-MDNR-TSNR                  VALUE 1.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      2 THRU  9999.
          88 "*"-EOD                        VALUE  100.
          88 "*"-NOTFOUND                   VALUE  253.
          88 "*"-LENERR                     VALUE  254.
          88 "*"-CMDERR                     VALUE  255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-LOOK4TAG                   VALUE   10.
          88 "*"-LOOK4TAG-NEXT              VALUE   11.
          88 "*"-BUILD-TEMPLATE             VALUE   20.
          88 "*"-BUILD-TEMPLATE-E2-AM       VALUE   21.

     05      "*"-DATEN.
      10     "*"-SEARCH-TAG      PIC X(04).
      10     "*"-MDNR            PIC 9(02).
      10     "*"-TSNR            PIC 9(08).
      10     "*"-BEREICHS-KZ     PIC X(02).
      10     "*"-APPL-KZ         PIC X(02).
      10     "*"-TEMPLATE        PIC X(8000).
      10     "*"-TEMPLATE-LEN    PIC S9(04) COMP.

************************************************************************






?section WISO417C
************************************************************************
* letzte Aenderung : 2015-06-26
* letzte Version   : G.01.00
*
* Beschreibung     : Schnittstellenmodul zwischen Applikation und
*                    BER-TLV- (WISO300)
*
*                    Es werden 2 Funktionen unterstuetzt:
*
*                        1. Suche nach TAG in String
*                        2. Aufbereiten Template fuer spez. Terminal
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*G.01.00|20150626 |HJO  | Template auf 20.000 für R7
*-------|---------|-----|----------------------------------------*
*A.01.04|20090622 |HJO  | Verlängerung TEMPLATE von 4000 auf 8K
*       |         |     |
*-------|---------|-----|----------------------------------------*
*A.01.03|20090209 | jb  | Neues Kommando 11 - wie 10, jedoch wird
*       |         |     | nach demselben TAG im Template weiter
*       |         |     | gesucht (Reihenfolge: immer erst 10, dann
*       |         |     | mehrfach 11 moeglich)
*       |         |     | Wenn keine weitere Fundstelle wird EOD
*       |         |     | zurueck gegeben
*-------|---------|-----|----------------------------------------*
*A.01.02|20090127 | jb  | Neues Kommando 21 - wie 20 jedoch wird
*       |         |     | im Bereich 'E2' nachgesehen, ob fuer ein
*       |         |     | gefundenes TAG auch im Bereich 'EA' vor-
*       |         |     | handen ist. Dann wird das TAG aus 'EA'
*       |         |     | in das Template 'E2' eingestellt.
*-------|---------|-----|----------------------------------------*
*A.01.01|20080514 | jb  | neuer OK-Rueckgabestatus (1-..-MDNR-TSNR)
*-------|---------|-----|----------------------------------------*
*A.01.00|20080502 | jb  | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    100 -   gesuchtes TAG nicht im String gef.
*                            keine Werte fuer Templat mit Auswahl gefunden
*                    253 -   angefordertes TAG nicht gefunden
*                    254 -   Laengenfehler
*                            - max. 4000 fuer die Aufbereitung Tamplate
*                    255 -   fehlerhaftes Kommando
*
*    Feld CMD      : 10  -   Suchen bestimmtes TAG
*                    11  -   Suchen bestimmtes TAG (naechstes Vorkommen
*                            im selben Template, erst 10 dann mehrfach 11
*                            moeglich)
*                    20  -   Aufbereiten Template
*                    21  -   Aufbereiten Template (mit ersetzen der
*                            'E2'-TAG's durch 'EA'-TAG's)
*
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld ..-SEARCH-TAG      : I   zu suchendes TAG (linksbuendig)
*    Feld ..-MDNR            : I   MDNR fuer Template
*    Feld ..-TSNR            : I   TSNR fuer Template
*    Feld ..-BEREICHS-KZ     : I   Bereichs-KZ fuer Template
*    Feld ..-APPL-KZ         : I   Applikations-KZ
*    Feld ..-TEMPLATE        : I   zu durchsuchendes Template (binaer)
*                              O   Rueckgabe Wert TAG      (ASCII)
*                                                 Template (binaer)
*    Feld ..-TEMPLATE-LEN    : I   Laenge zu durchsuchendes Template
*                              O   Rueckgabe Laenge TAG/Template
*
************************************************************************

 01          "*"-WISO417C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0 1.
**          ---> Rueckgabe andere MDNR/TSNR
          88 "*"-MDNR-TSNR                  VALUE 1.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      2 THRU  9999.
          88 "*"-EOD                        VALUE  100.
          88 "*"-NOTFOUND                   VALUE  253.
          88 "*"-LENERR                     VALUE  254.
          88 "*"-CMDERR                     VALUE  255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-LOOK4TAG                   VALUE   10.
          88 "*"-LOOK4TAG-NEXT              VALUE   11.
          88 "*"-BUILD-TEMPLATE             VALUE   20.
          88 "*"-BUILD-TEMPLATE-E2-AM       VALUE   21.

     05      "*"-DATEN.
      10     "*"-SEARCH-TAG      PIC X(04).
      10     "*"-MDNR            PIC 9(02).
      10     "*"-TSNR            PIC 9(08).
      10     "*"-BEREICHS-KZ     PIC X(02).
      10     "*"-APPL-KZ         PIC X(02).
      10     "*"-TEMPLATE        PIC X(30000).
      10     "*"-TEMPLATE-LEN    PIC S9(09) COMP.

************************************************************************


?section WISOX10C
************************************************************************
* letzte Aenderung : 2017-02-27
* letzte Version   : G.01.00
*
* Beschreibung     : Schnittstellenmodul zwischen Applikation und
*                    BER-TLV- (WISOX70)
*
*                    Es wird nur noch 1 Funktion unterstuetzt:
*
*                        1. Suche nach TAG in String
*                        2. Aufbereiten Template fuer spez. Terminal
*                           wird nicht mehr unterstützt
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*G.01.00|20170227 | HJO | Grundversion
*-------|---------|-----|----------------------------------------*
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    100 -   gesuchtes TAG nicht im String gef.
*                            keine Werte fuer Templat mit Auswahl gefunden
*                    253 -   angefordertes TAG nicht gefunden
*                    254 -   Laengenfehler
*                            - max. 4000 fuer die Aufbereitung Tamplate
*                    255 -   fehlerhaftes Kommando
*
*    Feld CMD      : 10  -   Suchen bestimmtes TAG
*                    11  -   Suchen bestimmtes TAG (naechstes Vorkommen
*                            im selben Template, erst 10 dann mehrfach 11
*                            moeglich)
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld ..-SEARCH-TAG      : I   zu suchendes TAG (linksbuendig)
*    Feld ..-MDNR            : I   MDNR fuer Template
*    Feld ..-TSNR            : I   TSNR fuer Template
*    Feld ..-DCPOS-VERS      : I   DCPOS-Version des Terminals
*    Feld ..-BEREICHS-KZ     : I   Bereichs-KZ fuer Template
*    Feld ..-APPL-KZ         : I   Applikations-KZ
*    Feld ..-TEMPLATE        : I   zu durchsuchendes Template (binaer)
*                              O   Rueckgabe Wert TAG      (ASCII)
*                                                 Template (binaer)
*    Feld ..-TEMPLATE-LEN    : I   Laenge zu durchsuchendes Template
*                              O   Rueckgabe Laenge TAG/Template
*
************************************************************************

 01          "*"-WISOX10C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0 1.
**          ---> Rueckgabe andere MDNR/TSNR
          88 "*"-MDNR-TSNR                  VALUE 1.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      2 THRU  9999.
          88 "*"-EOD                        VALUE  100.
          88 "*"-NOTFOUND                   VALUE  253.
          88 "*"-LENERR                     VALUE  254.
          88 "*"-CMDERR                     VALUE  255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-LOOK4TAG                   VALUE   10.
          88 "*"-LOOK4TAG-NEXT              VALUE   11.

     05      "*"-DATEN.
      10     "*"-SEARCH-TAG      PIC X(06).
      10     "*"-MDNR            PIC 9(02).
      10     "*"-TSNR            PIC 9(08).
      10     "*"-DCPOS-VERS      PIC X(05).
      10     "*"-BEREICHS-KZ     PIC X(02).
      10     "*"-APPL-KZ         PIC X(02).
      10     "*"-TEMPLATE        PIC X(30000).
      10     "*"-TEMPLATE-LEN    PIC S9(09) COMP.

************************************************************************



?section WISO420C
************************************************************************
* letzte Aenderung : 2009-02-10
* letzte Version   : A.01.00
*
* Beschreibung     : Schnittstellen zwischen Applikation und WISO410
*
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*A.01.nn|         |     |
*       |         |     |
*-------|---------|-----|----------------------------------------*
*A.01.00|20090210 | jb  | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                      1 -   OK, angegebene MDNR/TSNR geaendert
*                    100 -   Applikation nicht gefunden
*                    101 -   Template nicht gefunden
*                    102 -   TAG nicht gefunden
*                    103 -   Praefix nicht gefunden
*                    254 -   Laengenfehler
*                    255 -   fehlerhaftes Kommando
*
*    Feld CMD      :         Wert irrelevant
*
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld ..-MDNR            : I   MDNR fuer Template
*    Feld ..-TSNR            : I   TSNR fuer Template
*    Feld ..-BEREICHS-KZ     : I   Bereichs-KZ fuer Template
*    Feld ..-APPL-KZ         : I   Applikations-KZ
*    Feld ..-TEMPLATE        : I   zu durchsuchendes Template
*    Feld ..-SEARCH-TAG      : I   zu suchendes TAG (linksbuendig)
*    Feld ..-KANR            : I   zu vergleichender String (Kartennummer)
*
************************************************************************

 01          "*"-WISO420C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0 1.
**          ---> Rueckgabe andere MDNR/TSNR
          88 "*"-MDNR-TSNR                  VALUE 1.
**          ---> alle Fehler
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      2 THRU  9999.
**          ---> nicht gefunden
          88 "*"-APPL-NOTFOUND              VALUE  100.
          88 "*"-TEMPLATE-NOTFOUND          VALUE  101.
          88 "*"-TAG-NOTFOUND               VALUE  102.
          88 "*"-PRAEF-NOTFOUND             VALUE  103.
**          ---> sonstige Fehler
          88 "*"-LENERR                     VALUE  254.
          88 "*"-CMDERR                     VALUE  255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.

     05      "*"-DATEN.
      10     "*"-MDNR            PIC 9(02).
      10     "*"-TSNR            PIC 9(08).
      10     "*"-BEREICHS-KZ     PIC X(02).
      10     "*"-APPL-KZ         PIC X(02).
      10     "*"-TEMPLATE        PIC X(04).
      10     "*"-SEARCH-TAG      PIC X(04).
      10     "*"-KANR            PIC X(20).

************************************************************************

?section WISO430C
************************************************************************
* letzte Aenderung : 2010-07-09
* letzte Version   : A.01.05
*
* Beschreibung     : Schnittstellenmodul zwischen Applikation und
*                    BER-TLV- (WISO300)
*
*                    Es werden 2 Funktionen unterstuetzt:
*
*                        1. Suche nach TAG in String
*                        2. Aufbereiten Template fuer spez. Terminal
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*A.01.|2010 |  |
*       |         |     |
*-------|---------|-----|----------------------------------------*
*A.01.05|20100809 | jb  | Uebernahme von WISO410C (Stand: A.01.04)
*       |         |     | TERMNR in Struktur hinzugenommen
*-------|---------|-----|----------------------------------------*
*A.01.04|20090622 |HJO  | Verlängerung TEMPLATE von 4000 auf 8K
*-------|---------|-----|----------------------------------------*
*A.01.03|20090209 | jb  | Neues Kommando 11 - wie 10, jedoch wird
*       |         |     | nach demselben TAG im Template weiter
*       |         |     | gesucht (Reihenfolge: immer erst 10, dann
*       |         |     | mehrfach 11 moeglich)
*       |         |     | Wenn keine weitere Fundstelle wird EOD
*       |         |     | zurueck gegeben
*-------|---------|-----|----------------------------------------*
*A.01.02|20090127 | jb  | Neues Kommando 21 - wie 20 jedoch wird
*       |         |     | im Bereich 'E2' nachgesehen, ob fuer ein
*       |         |     | gefundenes TAG auch im Bereich 'EA' vor-
*       |         |     | handen ist. Dann wird das TAG aus 'EA'
*       |         |     | in das Template 'E2' eingestellt.
*-------|---------|-----|----------------------------------------*
*A.01.01|20080514 | jb  | neuer OK-Rueckgabestatus (1-..-MDNR-TSNR)
*-------|---------|-----|----------------------------------------*
*A.01.00|20080502 | jb  | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    100 -   gesuchtes TAG nicht im String gef.
*                            keine Werte fuer Templat mit Auswahl gefunden
*                    253 -   angefordertes TAG nicht gefunden
*                    254 -   Laengenfehler
*                            - max. 4000 fuer die Aufbereitung Tamplate
*                    255 -   fehlerhaftes Kommando
*
*    Feld CMD      : 10  -   Suchen bestimmtes TAG
*                    11  -   Suchen bestimmtes TAG (naechstes Vorkommen
*                            im selben Template, erst 10 dann mehrfach 11
*                            moeglich)
*                    20  -   Aufbereiten Template
*                    21  -   Aufbereiten Template (mit ersetzen der
*                            'E2'-TAG's durch 'EA'-TAG's)
*
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld ..-SEARCH-TAG      : I   zu suchendes TAG (linksbuendig)
*    Feld ..-MDNR            : I   MDNR fuer Template
*    Feld ..-TSNR            : I   TSNR fuer Template
*    Feld ..-TERMNR          : I   TERMNR fuer Stammdatensuche
*    Feld ..-BEREICHS-KZ     : I   Bereichs-KZ fuer Template
*    Feld ..-APPL-KZ         : I   Applikations-KZ
*    Feld ..-TEMPLATE        : I   zu durchsuchendes Template (binaer)
*                              O   Rueckgabe Wert TAG      (ASCII)
*                                                 Template (binaer)
*    Feld ..-TEMPLATE-LEN    : I   Laenge zu durchsuchendes Template
*                              O   Rueckgabe Laenge TAG/Template
*
************************************************************************

 01          "*"-WISO430C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0 1.
**          ---> Rueckgabe andere MDNR/TSNR
          88 "*"-MDNR-TSNR                  VALUE 1.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      2 THRU  9999.
          88 "*"-EOD                        VALUE  100.
          88 "*"-NOTFOUND                   VALUE  253.
          88 "*"-LENERR                     VALUE  254.
          88 "*"-CMDERR                     VALUE  255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-LOOK4TAG                   VALUE   10.
          88 "*"-LOOK4TAG-NEXT              VALUE   11.
          88 "*"-BUILD-TEMPLATE             VALUE   20.
          88 "*"-BUILD-TEMPLATE-E2-AM       VALUE   21.

     05      "*"-DATEN.
      10     "*"-SEARCH-TAG      PIC X(04).
      10     "*"-MDNR            PIC 9(02).
      10     "*"-TSNR            PIC 9(08).
      10     "*"-TERMNR          PIC 9(08).
      10     "*"-BEREICHS-KZ     PIC X(02).
      10     "*"-APPL-KZ         PIC X(02).
      10     "*"-TEMPLATE        PIC X(8000).
      10     "*"-TEMPLATE-LEN    PIC S9(04) COMP.

************************************************************************

?section WISO730C
************************************************************************
* letzte Aenderung : 2015-06-26
* letzte Version   : G.01.00
*
* Beschreibung     : Schnittstellenmodul zwischen Applikation und
*                    BER-TLV- (WISO300)
*
*                    Es werden 2 Funktionen unterstuetzt:
*
*                        1. Suche nach TAG in String
*                        2. Aufbereiten Template fuer spez. Terminal
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*G.01.00|20150626 | HJO | Neuerstellung aus WISO430C
*       |         |     |
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    100 -   gesuchtes TAG nicht im String gef.
*                            keine Werte fuer Templat mit Auswahl gefunden
*                    253 -   angefordertes TAG nicht gefunden
*                    254 -   Laengenfehler
*                            - max. 4000 fuer die Aufbereitung Tamplate
*                    255 -   fehlerhaftes Kommando
*
*    Feld CMD      : 10  -   Suchen bestimmtes TAG
*                    11  -   Suchen bestimmtes TAG (naechstes Vorkommen
*                            im selben Template, erst 10 dann mehrfach 11
*                            moeglich)
*                    20  -   Aufbereiten Template
*                    21  -   Aufbereiten Template (mit ersetzen der
*                            'E2'-TAG's durch 'EA'-TAG's)
*
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld ..-SEARCH-TAG      : I   zu suchendes TAG (linksbuendig)
*    Feld ..-MDNR            : I   MDNR fuer Template
*    Feld ..-TSNR            : I   TSNR fuer Template
*    Feld ..-TERMNR          : I   TERMNR fuer Stammdatensuche
*    Feld ..-BEREICHS-KZ     : I   Bereichs-KZ fuer Template
*    Feld ..-APPL-KZ         : I   Applikations-KZ
*    Feld ..-TEMPLATE        : I   zu durchsuchendes Template (binaer)
*                              O   Rueckgabe Wert TAG      (ASCII)
*                                                 Template (binaer)
*    Feld ..-TEMPLATE-LEN    : I   Laenge zu durchsuchendes Template
*                              O   Rueckgabe Laenge TAG/Template
*
************************************************************************

 01          "*"-WISO730C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0 1.
**          ---> Rueckgabe andere MDNR/TSNR
          88 "*"-MDNR-TSNR                  VALUE 1.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      2 THRU  9999.
          88 "*"-EOD                        VALUE  100.
          88 "*"-NOTFOUND                   VALUE  253.
          88 "*"-LENERR                     VALUE  254.
          88 "*"-CMDERR                     VALUE  255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-LOOK4TAG                   VALUE   10.
          88 "*"-LOOK4TAG-NEXT              VALUE   11.
          88 "*"-BUILD-TEMPLATE             VALUE   20.
          88 "*"-BUILD-TEMPLATE-E2-AM       VALUE   21.

     05      "*"-DATEN.
      10     "*"-SEARCH-TAG      PIC X(04).
      10     "*"-MDNR            PIC 9(02).
      10     "*"-TSNR            PIC 9(08).
      10     "*"-TERMNR          PIC 9(08).
      10     "*"-BEREICHS-KZ     PIC X(02).
      10     "*"-APPL-KZ         PIC X(02).
      10     "*"-TEMPLATE        PIC X(30000).
      10     "*"-TEMPLATE-LEN    PIC S9(09) COMP.

************************************************************************

?section WISOX30C
************************************************************************
* letzte Aenderung : 2017-02-28
* letzte Version   : G.01.00
*
* Beschreibung     : Schnittstellenmodul zwischen Applikation und
*                    BER-TLV- (WISOX70)
*
*                    Es werden 2 Funktionen unterstuetzt:
*
*                        1. Suche nach TAG in String
*                        2. Aufbereiten Template fuer spez. Terminal
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*G.01.00|20170228 | HJO | Neuerstellung aus WISO730C
*       |         |     |
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    100 -   gesuchtes TAG nicht im String gef.
*                            keine Werte fuer Templat mit Auswahl gefunden
*                    253 -   angefordertes TAG nicht gefunden
*                    254 -   Laengenfehler
*                            - max. 4000 fuer die Aufbereitung Tamplate
*                    255 -   fehlerhaftes Kommando
*
*    Feld CMD      : 10  -   Suchen bestimmtes TAG
*                    11  -   Suchen bestimmtes TAG (naechstes Vorkommen
*                            im selben Template, erst 10 dann mehrfach 11
*                            moeglich)
*                    20  -   Aufbereiten Template
*                    21  -   Aufbereiten Template (mit ersetzen der
*                            'E2'-TAG's durch 'EA'-TAG's)
*                    31  -   Aufbereiten Template (mit ersetzen der
*                            'E3'-TAG's durch 'EX'-TAG's)
*
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld ..-SEARCH-TAG      : I   zu suchendes TAG (linksbuendig)
*    Feld ..-MDNR            : I   MDNR fuer Template
*    Feld ..-TSNR            : I   TSNR fuer Template
*    Feld ..-TERMNR          : I   TERMNR fuer Stammdatensuche
*    Feld ..-BEREICHS-KZ     : I   Bereichs-KZ fuer Template
*    Feld ..-APPL-KZ         : I   Applikations-KZ
*    Feld ..-TEMPLATE        : I   zu durchsuchendes Template (binaer)
*                              O   Rueckgabe Wert TAG      (ASCII)
*                                                 Template (binaer)
*    Feld ..-TEMPLATE-LEN    : I   Laenge zu durchsuchendes Template
*                              O   Rueckgabe Laenge TAG/Template
*
************************************************************************

 01          "*"-WISOX30C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0 1.
**          ---> Rueckgabe andere MDNR/TSNR
          88 "*"-MDNR-TSNR                  VALUE 1.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      2 THRU  9999.
          88 "*"-EOD                        VALUE  100.
          88 "*"-NOTFOUND                   VALUE  253.
          88 "*"-LENERR                     VALUE  254.
          88 "*"-CMDERR                     VALUE  255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-LOOK4TAG                   VALUE   10.
          88 "*"-LOOK4TAG-NEXT              VALUE   11.
          88 "*"-BUILD-TEMPLATE             VALUE   20.
          88 "*"-BUILD-TEMPLATE-E2-EA       VALUE   21.
          88 "*"-BUILD-TEMPLATE-E3-EX       VALUE   31.

     05      "*"-DATEN.
      10     "*"-SEARCH-TAG      PIC X(06).
      10     "*"-MDNR            PIC 9(02).
      10     "*"-TSNR            PIC 9(08).
      10     "*"-TERMNR          PIC 9(08).
      10     "*"-DCPOS-VERS      PIC X(05).
      10     "*"-BEREICHS-KZ     PIC X(02).
      10     "*"-APPL-KZ         PIC X(02).
      10     "*"-TEMPLATE        PIC X(30000).
      10     "*"-TEMPLATE-LEN    PIC S9(09) COMP.

************************************************************************





?section WISO440C
************************************************************************
* erstellt am      : 11.12.2009
* letzte Aenderung : 11.12.2009
* letzte Version   : A.01.00
*
*
* Beschreibung     : Modul fuer Artikelmapping Road-Runner -> CHW mit
*                    BER-TLV-Fummler (WISO300)
*
*                    Es werden n Funktionen unterstuetzt:
*
*                        1. Mapping WEAT-Artikel -> CHW Artikel mit
*                           Erzeugen GICC-BMP60
*                        2. Suchen von TAGS in AS-Antworten
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*A.01.nn|         |     |
*-------|---------|-----|----------------------------------------*
*A.01.00|20091211 | kl  | Neuerstellung aus WISO400C
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    246 -   gesuchtes Subfeld / TAG nicht im String gef.
*                    247 -   kein Subfeld fuer gefundenes TAG vorhanden
*                    248 -   Fehler beim Laden der Tabellen TLV2LTV
*                            oder STAG2TAG
*                    249 -
*                    250 -   Reihenfolgefehler (1. Aufruf muss
*                            immer ein TAG sein
*                    251 -   TAG-Kodierung falsch
*                            max. 2 Byte lange TAG's werden unterst.
*                    252 -   Laengenfehler
*                            - max. 512 - 4
*                            - verbleibende Laenge zu kurz fuer DA
*                            - Laengenschl. falsch: max. 2 Bytes
*                            - Wertefeld > 255
*                    253 -   irrelevant
*                    254 -   fehlerhaftes Kommando
*                    255 -   irrelevant
*
*    Feld CMD      : 10  -   Umschluesseln BER-TLV -> KAAI-LTV
*                    20  -   Umschluesseln KAAI-LTV -> BER-TLV
*                    30  -   Suchen bestimmtes TAG
*                    31  -   Suchen bestimmtes Subfeld
*                    40  -   Suchen bestimmtes TAG - entpackte Rueckgabe
*                    41  -   Suchen bestimmtes SF  - entpackte Rueckgabe
*
* Datenfelder:     In/Out* Beschreibung
*
*    Feld BER-TLV-LEN    : I/O     Laenge TLV-String
*
*    Feld BER-TLV-STRING : I/O     TLV-codierter String
*
*    Feld KAAI-LTV-LEN   : I/O     Laenge TLV-String
*
*    Feld KAAI-LTV-STRING: I/O     TLV-codierter String
*
*    Feld DF4F-SF99      : O       TAG DF4F bzw. Subfeld-Nr. 99 in ASCII
*                                  Der Inhalt des TAG's bzw. Subfelds
*                                  wird aus dem Eingabestring extrahiert
*                                  und hier zurueckgegeben
*
*    Feld SEARCH-TAG     : I       zu suchendes TAG (linksbuendig)
*
*    Feld SEARCH-SF      : I       zu suchendes Subfeld
*
*                     * aus Sicht WISO400
*
************************************************************************

 01          "*"-WISO440C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus (Der Antwortcode ist im aufrufenden
**                                Programm zu setzen !!!)
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
*         Unbekannter Artikel gefunden -> wird AC 45 !!!
          88 "*"-UNKNOWN-ITEM               VALUE  100.
*         TAG nicht gefunden
          88 "*"-NOTFOUND                   VALUE  246.
          88 "*"-MISSINGTAG                 VALUE  247.
          88 "*"-LADERR                     VALUE  248.
          88 "*"-NOSTAG                     VALUE  249.
          88 "*"-ORDERERR                   VALUE  250.
          88 "*"-TAGERR                     VALUE  251.
          88 "*"-LENERR                     VALUE  252.
          88 "*"-COBERR                     VALUE  253.
          88 "*"-CMDERR                     VALUE  254.
          88 "*"-DIVERR                     VALUE  255.
          88 "*"-ART-SQLERROR               VALUE  -9999 THRU -1.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-MAKE-BMP60                 VALUE   10.
          88 "*"-LOOK4TAG                   VALUE   20.
          88 "*"-LOOK4TAGXP                 VALUE   30.

*    Nutzdaten
     05      "*"-DATEN.
*     Schnittstellendaten zu WISO300
      10     "*"-BER-TLV-DATEN.
        15   "*"-BER-TLV-LEN     PIC S9(04) COMP.
        15   "*"-BER-TLV-STRING  PIC X(1024).
        15   "*"-SEARCH-TAG      PIC X(04).
*     Werte fuer Eingangs- und Ausgangs-BMP
      10     "*"-BMP-VALUES.
        15   "*"-BMP63-LEN       PIC S9(04) COMP.
        15   "*"-BMP63-VAL       PIC X(512).
        15   "*"-BMP60-LEN       PIC S9(04) COMP.
        15   "*"-BMP60-VAL       PIC X(512).
*       Monat und Tag der Anfrage fuer Spezial-Tag 5F01 (Jahr der TX),
*       Ermittlung des korrekten Jahres (MMTT = 1231, aktuell 0101 dann
*       5F01 = TAL-JHJJ - 1 / sonst 5F01 = TAL-JHJJ)
        15   "*"-AMMTT           PIC 9(04).
*     Keyvalues fuer ATMAP
      10     "*"-ARTIKEL-INDEX.
        15   "*"-MDNR            PIC 9(02).
        15   "*"-TSNR            PIC 9(08).
        15   "*"-CARDID          PIC 9(02).

************************************************************************



?section SDBCDU0C
************************************************************************
* letzte Aenderung : 2008-11-21
* letzte Version   : A.06.00
*
* Beschreibung     : Schnittstelle zum DB-Interface zur Tabelle CRDUSED
*
*                    Es werden 2 Funktionen unterstuetzt:
*
*                        1. Insert (mit default ZPINS) in Tabelle CRDUSED
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*A.06.nn|         |     |
*-------|---------|-----|----------------------------------------*
*A.06.00|20081127 | jb  | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :   0 -   OK
*                    100 -   keine Daten gefunden
*                    254 -   Datenfehler  (z.B. Numeric-Fehler)
*                    255 -   fehlerhaftes Kommando
*
*    Feld CMD      : 10  -   Insert (mit Transaktion
*                            , ZPINS wird mit default gesetzt)
*                    11  -   Insert (ohne Transaktion
*                            , ZPINS wird mit default gesetzt)
*                    20  -   Insert (mit Transaktion
*                            , ZPINS wird aus Uebergabe gesetzt)
*                    21  -   Insert (ohne Transaktion
*                            , ZPINS wird aus Uebergabe gesetzt)
*
*
* Datenfelder:     In/Out* Beschreibung
*
*    Struktur:       invoke CRDUSED
*
************************************************************************

 01          "*"-SDBCDU0C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
          88 "*"-EOD                        VALUE  100.
          88 "*"-PW-NOT-FOUND               VALUE  253.
          88 "*"-DATERR                     VALUE  254.
          88 "*"-CMDERR                     VALUE  255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-CMD-INS-MTA                VALUE   10.
          88 "*"-CMD-INS-OTA                VALUE   11.
          88 "*"-CMD-INS-MTA-ZP             VALUE   20.
          88 "*"-CMD-INS-OTA-ZP             VALUE   21.
          88 "*"-CMD-ERR                    VALUE  -9999 thru    9
                                                      12 thru   19
                                                      22 thru 9999.
          88 "*"-MIT-TRANSAKTION            VALUE   10 20.
          88 "*"-OHNE-TRANSAKTION           VALUE   11 21.
          88 "*"-DEFAULT-ZPINS              VALUE   10 11.
          88 "*"-SETZEN-ZPINS               VALUE   20 21.

**          ---> Nutzdaten
     05      "*"-DATEN.
      10     "*"-PNR             PIC 9(02).
      10     "*"-KANR            PIC X(19).
      10     "*"-ZPINS           PIC X(22).
      10     "*"-AKZ             PIC X(01).
      10     "*"-TERMNR          PIC 9(08).
      10     "*"-TRACENR         PIC 9(06).
      10     "*"-AC              PIC 9(02).
      10     "*"-BETRAG          PIC S9(07)V99 COMP.
      10     "*"-MDNR            PIC 9(02).
      10     "*"-TSNR            PIC 9(08).
      10     "*"-KEYNAME         PIC X(08).

************************************************************************


?section WPCI01C
************************************************************************
* erstellt am      : 19.12.2008
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum Modul WCSI055
*                    Boxen-Aufrufe bestücken aus Übergabebereich
*
*    Feld RCODE    : 0    -  OK
*                   9999  -  ungueltiger  Aufruf
*                   1 -   -  Fehler  aus WCSI055 durchgereicht
*                   9998
*
*    Feld CMD      : UL   -  User Login für CSI-Modul
*                    EN   -  Encrypt Kartennr
*                    DE   -  Decrypt Kartennr
*
*    Feld KEY-NAME :  Verwendeter KEY-NAME für encrypt / decrypt
*
* Aenderungen      :
*
************************************************************************
*
 01          "*"-WPCI01C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
     05      "*"-CMD             PIC XX.
          88 "*"-USER-LOGON                 VALUE    "UL".
          88 "*"-ENCRYPT                    VALUE    "EN".
          88 "*"-DECRYPT                    VALUE    "DE".

     05      "*"-KEY-NAME       PIC X(08).
*                gültige Formate:
*                1. Gesamt-PAN gepackt mit rechsbündig aufgefüllten hex(FFFF...)
*                2. Teil-PAN (maskierter Teil) 16 ASCII-Ziffern
     05      "*"-CRYPT-OBJ      PIC X(16).

?section SYSABL1C
************************************************************************
* erstellt am      : 07.05.2009
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum Modul SYSABL1
*                    pruefen, ob Terminalablaeufe in Tabelle TERMABL
*                    fuer anfragendes Terminal vorhanden sind. Wenn ja
*                    wird der vordefinierte AC zurueckgegeben und der
*                    Eintrag geloescht.
*
*    Feld RCODE    :    0 -  OK
*                       1 -  OK neuer AC wird mitgeliefert
*                     255 -  ungueltiger  Aufruf
*
*    Feld CMD      :    0 -  Delete OHNE TMF-Transaktion
*                  :    1 -  Delete MIT  TMF-Transaktion
*
*    Daten-Felder
*
************************************************************************

 01          "*"-SYSABL1C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ABL                        VALUE 1.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      2 THRU  9999.
          88 "*"-ERR-PROC                   VALUE 253.
          88 "*"-ERR-MODI                   VALUE 254.
          88 "*"-ERR-SQL                    VALUE 255.

**          ---> Kommando
      10     "*"-CMD             PIC S9(04) COMP.
          88 "*"-CMD-NOTMF                  VALUE 0.
          88 "*"-CMD-TMF                    VALUE 1.

**          ---> Nutzdaten
     05      "*"-DATEN.
      10     "*"-TERMNR          PIC 9(08).
      10     "*"-SERVER          PIC X(16).
      10     "*"-AC              PIC X(02).
      10     "*"-BEARB           PIC X(08).
          88 "*"-BEARB-OHNE                 VALUE SPACE.

************************************************************************

?section WNEF056C
************************************************************************
* erstellt am      : 07.02.2014
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum Modul WNEF056  NEFTIS DUKPT
*                    Boxen-Aufrufe bestücken aus INT-SCHNITTSTELLE
*
*    Feld RCODE    : 0    -  OK
*                   9999  -  ungueltiger  Aufruf
*                   1 -   -  Fehler  aus WSYS055 durchgereicht
*                   9998
*
*    Feld ANWENDUNG: IF   -  IFSF NEFTIS
*                    ZK   -  ISO-Format ZKA girocard
*                    KA   -  ISO-Format KAAI KK
*
*    Feld CMD      : PU   -  PAC UMSCHLÜSSELN
*                    BT   -  MAC bilden Terminal
*                    BA   -  MAC bilden AS
*                    MB   -  MAC bilden Individuell TKEY (z.B. SHELL)
*                    MP   -  MAC prüfen Individuell TKEY
*                    PT   -  MAC prüfen Terminal
*                    PA   -  MAC prüfen AS
*                    PP   -  PIN prüfen (AS)
*
*    Feld TKEY-NAME: optional:abweichender Terminal-key vom Standard
*    Feld AKEY-NAME: optional:abweichender AS-KEY       vom Standard
*
*
*
* Aenderungen      :
*
*
************************************************************************

 01          "*"-WNEF056C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
     05      "*"-ANWENDUNG       PIC XX.
          88 "*"-IFSF                       VALUE    "IF".
          88 "*"-ZKA                        VALUE    "ZK".
          88 "*"-KAAI                       VALUE    "KA".

     05      "*"-CMD             PIC XX.
          88 "*"-PAC-UMSCHL                 VALUE    "PU".
          88 "*"-MAC-BILDEN                 VALUE    "MB".
          88 "*"-MAC-PRUEFEN                VALUE    "MP".
          88 "*"-MAC-BILDEN-TS              VALUE    "BT".
          88 "*"-MAC-BILDEN-AS              VALUE    "BA".
          88 "*"-MAC-PRUEFEN-TS             VALUE    "PT".
          88 "*"-MAC-PRUEFEN-AS             VALUE    "PA".
          88 "*"-PIN-PRUEFEN-AS             VALUE    "PP".
          88 "*"-E2EE-ENTSCHL               VALUE    "EE".
          88 "*"-E2EE-VERSCHL               VALUE    "EV".

     05      "*"-TKEY-NAME       PIC X(08).
     05      "*"-AKEY-NAME       PIC X(08).

************************************************************************

?section WEUR056C
************************************************************************
* erstellt am      : 23.09.2016
* letzte Aenderung :
* Beschreibung     : Schnittstelle zum Modul WNEF056  NEFTIS DUKPT
*                    Boxen-Aufrufe bestücken aus INT-SCHNITTSTELLE
*
*    Feld RCODE    : 0    -  OK
*                   9999  -  ungueltiger  Aufruf
*                   1 -   -  Fehler  aus WSYS055 durchgereicht
*                   9998
*
*    Feld ANWENDUNG: IF   -  IFSF NEFTIS
*                    ZK   -  ISO-Format ZKA girocard
*                    KA   -  ISO-Format KAAI KK
*
*    Feld CMD      : PU   -  PAC UMSCHLÜSSELN
*                    BT   -  MAC bilden Terminal
*                    BA   -  MAC bilden AS
*                    MB   -  MAC bilden Individuell TKEY (z.B. SHELL)
*                    MP   -  MAC prüfen Individuell TKEY
*                    PT   -  MAC prüfen Terminal
*                    PA   -  MAC prüfen AS
*                    PP   -  PIN prüfen (AS)
*
*    Feld TKEY-NAME:  optional:abweichender Terminal-key vom Standard
*    Feld AKEY-NAME:  optional:abweichender AS-KEY       vom Standard
*    Feld AS-TRACENR: optional:abweichender Stand für EUROWAG mit DUKPT
*                     AS-TRACENR wird in DUKPT verwendet bis
*                     2.000.000
*
* Aenderungen      :
*
*
************************************************************************

 01          "*"-WEUR056C.
     05      "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                         VALUE 0.
          88 "*"-ERR                        VALUE -9999 THRU    -1
                                                      1 THRU  9999.
     05      "*"-ANWENDUNG       PIC XX.
          88 "*"-IFSF                       VALUE    "IF".
          88 "*"-ZKA                        VALUE    "ZK".
          88 "*"-KAAI                       VALUE    "KA".

     05      "*"-CMD             PIC XX.
          88 "*"-PAC-UMSCHL                 VALUE    "PU".
          88 "*"-MAC-BILDEN                 VALUE    "MB".
          88 "*"-MAC-PRUEFEN                VALUE    "MP".
          88 "*"-MAC-BILDEN-TS              VALUE    "BT".
          88 "*"-MAC-BILDEN-AS              VALUE    "BA".
          88 "*"-MAC-PRUEFEN-TS             VALUE    "PT".
          88 "*"-MAC-PRUEFEN-AS             VALUE    "PA".
          88 "*"-PIN-PRUEFEN-AS             VALUE    "PP".
          88 "*"-E2EE-ENTSCHL               VALUE    "EE".
          88 "*"-E2EE-VERSCHL               VALUE    "EV".

     05      "*"-TKEY-NAME       PIC X(08).
     05      "*"-AKEY-NAME       PIC X(08).
     05      "*"-AS-TRACENR      PIC S9(09) COMP.


************************************************************************




?section WUMSO07C
************************************************************************
* erstellt am      : 27.12.2013
* letzte Aenderung :
* letzte Version   : G.01.00
*
*
* Beschreibung     : Übergabeschnittstelle von Anwendungsservern zum
*                    neuen Umsatzverarbeiter zu den Tabellen
*                    =UMSWEAT und =UMSIFSF
*
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*G.01.nn|         |     |
*-------|---------|-----|----------------------------------------*
*G.01.01|20160412 | cb  | neue 88er WUMS-CMD-IL
*----------------------------------------------------------------*
*G.01.00|20131227 | jb  | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RCODE    :    0 -   OK
*                    9999 - falsches Kommando
*                    nnnn - ggf. SQLCODE
*
*    Feld KOMMANDO:
*    - SubFeld TAB : "UI" - Tabelle =UMSIFSF
*                    "UW" - Tabelle =UMSWEAT
*
*    - SubFeld CMD : "DB" - Löschen mit Beleg-Nr.
*                    "DT" - Löschen mit Trace-Nr.
*                    "I " - Insert
*                    "IL "- Insertzweig bei Prepaidladungen
*                    "SB" - Select mit Beleg-Nr.
*                    "ST" - Select mit Trace-Nr.
*                    "UA" - Update - Automat (Betragunf Bearb-KZ)
*                    "UB" - Update - Bestätigung (Bearb-KZ)
*
*    Feld ABSENDER:       - Name des rufenden Programms
*
* Datenfeld:
*
*        -DATEN           - Struktur einer der Tabellen UMSIFSF/UMSWEAT
*
************************************************************************

 01          "*"-WUMSO07C.
     05      "*"-VERWALTUNG.
**          ---> Rueckgabestatus
      10     "*"-RCODE           PIC S9(04) COMP.
          88 "*"-OK                          VALUE 0.
          88 "*"-ERR                         VALUE -9999 THRU    -1
                                                       1 THRU  9999.
          88 "*"-NOTFOUND                    VALUE  100.
          88 "*"-DATERR                      VALUE  9996.
          88 "*"-PWERR                       VALUE  9997.
          88 "*"-TABERR                      VALUE  9998.
          88 "*"-CMDERR                      VALUE  9999.

**          ---> Kommandostruktur
      10     "*"-KOMMANDO.
       15    "*"-TAB             PIC X(02).
          88 "*"-TAB-UI                      VALUE "UI".
          88 "*"-TAB-UW                      VALUE "UW".
       15    "*"-CMD             PIC X(02).
          88 "*"-CMD-DB                      VALUE "DB".
          88 "*"-CMD-DT                      VALUE "DT".
          88 "*"-CMD-I                       VALUE "I ".
          88 "*"-CMD-IL                      VALUE "IL".
          88 "*"-CMD-SB                      VALUE "SB".
          88 "*"-CMD-ST                      VALUE "ST".
          88 "*"-CMD-UA                      VALUE "UA".
          88 "*"-CMD-UB                      VALUE "UB".

**          ---> Absender (hier soll sich das rufende Programm eintragen)
      10     "*"-ABSENDER        PIC X(08).

**          ---> Datenteil
     05      "*"-DATEN.
      10     "*"-UMSATZ          PIC X(100).

************************************************************************
?section PFCBNS7C
************************************************************************
* erstellt am      : 13.07.2015
* letzte Aenderung :
* letzte Version   : G.01.00
*
*
* Beschreibung     : Schnittstelle zum Pruefen von Flottenkarten
*                    gegen die Tabelle =TSKARTLI (BIN-Sperre)
*
*
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*G.01.nn|         |     |
*-------|---------|-----|----------------------------------------*
*G.01.00|20150715 | kl  | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld AC       :    0 -   OK
*                       ? -   BIN gesperrz
*                     999 -   Dummy fuer Aufruf
*
* Datenfelder:
*
*    Feld MDNR     :   Mandant
*         TSNR     :   Tankstelle
*         CARDSYS  :   1 = Indoor, 2 = Outdoor, 3 = Waschanlage
*         CARDID   :   KartenID fuer Suche in TSKARTLI
*         PANLEN   :   Laenge der PAN
*         PAN      :   zu prufende Kartennummer
*
************************************************************************
 01          "*"-PFCBNS7C.
     05      "*"-VERWALTUNG.
         10  "*"-AC           PIC 9(03).
     05      "*"-DATEN.
         10  "*"-MDNR         PIC 9(08).
         10  "*"-TSNR         PIC 9(08).
         10  "*"-CARDSYS      PIC 9(02).
         10  "*"-CARDID       PIC 9(02).
         10  "*"-PANLEN       PIC S9(04) COMP.
         10  "*"-PAN          PIC X(19).
************************************************************************

?section WMSG07C
************************************************************************
* Letzte Aenderung :: 2016-09-28
* Letzte Version   :: G.01.03
* Kurzbeschreibung :: Schnittstelle zu Modul/Server
* Kurzbeschreibung :: WMSG07IM/WMSG07S
*
* Aenderungen      :
* Version G.01.00   vom 17.09.2016  Neuerstellung
* Version G.01.01   vom 20.09.2016  Releaseflag und RC aufgenommen
* Version G.01.02   vom 21.09.2016  - Cardid bei Ursprung = "H"
*                                     aufgenommen
*                                   - 275 Bytes Reserve aufgenommen
* Version G.01.03   vom 28.09.2016  - Wortgrenze COBDATEN.PTR/LEN
*                                     wiederhergestellt (s.u.)
*                                   - Release 2-stellig (60,70 ...)
* Version G.01.04   vom 04.10.2016  - Notfall-Schalter auf BIN-Schalter
*                                     geändert (0/1 statt " "/"E")
*
*  Der RC dient zum einen der (optionalen) Rückgabe von Pathsendfehlern
*  und zum anderen dem An- und Ausschalten der Weitergabe an den Server
*  WMSG07S (DB-Server TANZMSG). Bei der Rückgabe von Fehlern (optional)
*  wird der RC mit einem evtl. Pathsend-Fehler gefüllt. Zur Funktions-
*  steuerung gilt:
*
*  RC = 0              WEITERGABE  an WMSG07S
*  RC <> 0 (z.B. 99)   WEITERGABE  an WMSG07S abgeschaltet
*                      (es erfolgt kein Eintrag in TANZMSG!)
*
*  Der Wert für die Steuerung ist vom rufenden Programm zu setzen.
*
*-----------------------------------------------------------------------
*
*  Länge der Schnittstelle (G.01.03):  >>> 3000 (2726) Bytes <<<
*
************************************************************************
*
  01        "*"-WMSG07C.
**          ---> (Dummy-)Returncode
     05     "*"-RC               PIC S9(04).
         88 "*"-OK               VALUE ZERO.

**          ---> Absenderinformationen
     05     "*"-ABSENDER.
      10    "*"-DTXNR            PIC X(16).
      10    "*"-TERMNR           PIC 9(08).

**          ---> Karteninformatioenen (Nur bei "H", bei "T" = 0)
     05     "*"-CARDID           PIC 9(02).

**          ---> Anwendungsschalter
     05      "*"-LOG-SWITCHES.
*            Terminal / Host
      10     "*"-URSPRUNG        PIC X.
         88  "*"-FROM-TERM       VALUE "T".
         88  "*"-FROM-HOST       VALUE "H".

*kl20160928 - G.01.03 - Anfang
*            WEAT-Release
      10     "*"-RELEASE         PIC 9(02).
         88  "*"-R6              VALUE 50 60.
         88  "*"-R7              VALUE 70.
         88  "*"-R8              VALUE 80.
         88  "*"-R9              VALUE 90.
*kl20160928 - G.01.03 - Ende
*            Normal / Notfall
      10     "*"-EMERGENCY       PIC 9.
         88  "*"-IS-STANDARD     VALUE ZERO.
         88  "*"-IS-EMERGENCY    VALUE 1.

*---> z.Zt. 32 Byte bis hierher

*--------------------------------------------------------------------!
*  ACHTUNG: Bei Aenderung der vorhergehenden 05er Stufen unbedingt   !
*           auf die Einhaltung der Wortgrenzen achten (ggf. 1 Byte   !
*           Filler einfuegen!                                        !
*                                                                    !
*           Andernfalls gehen Pointer/Länge bei einem MOVE der       !
*           Struktur "*"-COBDATEN kaputt!                            !
*--------------------------------------------------------------------!

**          ---> aufgeschluesselte ISO-Nachricht (COBOL-Stack)
     05      "*"-COBDATEN.
**          ---> Nachrichtentyp
      10     "*"-NTYPE           PIC  9(04).
**          ---> Bytemap-, Pointer-, Laengen-Tabellen
      10     "*"-TBMP-O.
       15    "*"-TBMP            PIC 9           OCCURS 128.
      10     "*"-TPTR-O.
       15    "*"-TPTR            PIC S9(04) COMP OCCURS 128.
      10     "*"-TLEN-O.
       15    "*"-TLEN            PIC S9(04) COMP OCCURS 128.
**          ---> Pointer auf naechste freie Stelle im Datenbuffer CF
      10     "*"-NEXT-PTR        PIC S9(04) COMP.
**          ---> aufbereitete (Cobol-) Felder
      10     "*"-CF              PIC X(2048).

**           ---> Vorerst nicht benoetigt (Reserve fuer Erweiterungen)
*kl20160928 - G.01.03 - Oben ist einen länger geworden
*    05      "*"-FFU             PIC X(275).
     05      "*"-FFU             PIC X(274).
*kl20160928 - G.01.03 - Ende
** ---> Länge der Schnittstelle G.01.02: 3000 (2725) Bytes



?section PKKBM22-IFC
************************************************************************
* Beschreibung     : Schnittstelle zum Modifizieren KAAI-BMP22
*                    gegen die Tabelle =BMP22MOD
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*G.01.nn|         |     |
*-------|---------|-----|----------------------------------------*
*G.01.00|20171114 | HJO | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld RC       :    0 -   OK
*                       1 -   Parameter nicht numerisch
*
* Datenfelder:
*
*    Feld MDNR     :   Mandant
*         TSNR     :   Tankstelle
*         CARDSYS  :   1 = Indoor, 2 = Outdoor, 3 = Waschanlage
*         ISO-KONZ :   ISO-Anwendung oder KONZ1 Anwendung ruft auf
*
************************************************************************
 01          PKKBM22-IFC.
     05      PKKBM22-RC           PIC S9(04) COMP.
     05      PKKBM22-MDNR         PIC 9(02).
     05      PKKBM22-TSNR         PIC 9(08).
     05      PKKBM22-CARDSYS      PIC 9(02).
     05      PKKBM22-ISO-KONZ     PIC X(01).
     05      PKKBM22-POS3         PIC 9(01).

************************************************************************

?section ZPVERKAUF-IFC
************************************************************************
* Beschreibung     : Schnittstelle zum Erstellen des Feldes
*                    ZP_VERKAUF der Tabelle =TXILOG70
*
* Aenderungen:
*----------------------------------------------------------------*
* Vers. | Datum   | von | Kommentar                              *
*-------|---------|-----|----------------------------------------*
*G.01.nn|         |     |
*-------|---------|-----|----------------------------------------*
*G.01.00|20180315 | SK  | Neuerstellung
*----------------------------------------------------------------*
*
* Verwaltungsfelder:
*
*    Feld ZPVERKAUF-RC        : 0 -   OK
*                             : 1 -   Fehler bei der Zeitberechnung
*
* Datenfelder:
*
*    Feld ZPVERKAUF-BMP12     : BMP 12 der 200er Terminalanfrage (Zeit)
*         ZPVERKAUF-BMP13     : BMP 13 der 200er Terminalanfrage (Datum)
*         ZPVERKAUF-FEPTALZEIT: TAL-TIME: JHJJMMTT HHMI SS HS
*         ZPVERKAUF-TXILOG70  : einzustellendes DB-Feld ZP_VERKAUF
*                               Format:JHJJMMTThhmmss
************************************************************************
 01          ZPVERKAUF-IFC.
     05      ZPVERKAUF-RC           PIC S9(04) COMP.
     05      ZPVERKAUF-BMP12        PIC X(06).
     05      ZPVERKAUF-BMP13        PIC X(04).
     05      ZPVERKAUF-FEPTALZEIT   PIC 9(16).
     05      ZPVERKAUF-TXILOG70     PIC S9(18) COMP.

************************************************************************

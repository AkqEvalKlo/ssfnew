begin work;

delete from =ssfrarch where source_modul = "PFCSIP7E";
insert into =ssfrarch select * from ssrcrepo.ssfrabck
where source_modul = "PFCSIP7E" browse access;

-- commit work;


select source_modul, version, archiv_modul from =ssfrarch
where archiv_modul like "%A %"
OR    archiv_modul like "%B %"
OR   archiv_modul like "%DEL%"
browse access;

SOURCE_MODUL  VERSION   ARCHIV_MODUL
------------  --------  --------------------------

PFCAUT7E      G.03.11   G0311DEL
PFCFAD7E      G.02.39   G0239DEL
PFCOFF7E      G.06.32   G0632DEL
PFCPRE7E      G.06.49   G0649DEL
PFCSIP7E      G.01.01A  G0101A
PFCSTO7E      G.01.04   G0104DEL

--- 8 row(s) selected.

run  sqldrv0o get PFCSIP7E -B G.01.01A

select source_modul, version, archiv_modul from =ssfrarch
where source_modul = "PFCSIP7E"
browse access;

SOURCE_MODUL  VERSION   ARCHIV_MODUL
------------  --------  --------------------------

PFCSIP7E      G.00.03   G0003
PFCSIP7E      G.00.04   G0004
PFCSIP7E      G.00.05   G0005
PFCSIP7E      G.00.06   G0006
PFCSIP7E      G.01.00   G0100
PFCSIP7E      G.01.01   G0101
PFCSIP7E      G.01.01A  G0101A
PFCSIP7E      G.01.02A  G0102
PFCSIP7E      G.01.03A  G0103
PFCSIP7E      G.01.04   G0104

--- 10 row(s) selected.

\GZ1: $WSOFT.SSRCREPO 96> liz pfcsip7r
Archive:  pfcsip7r
wird."exit
  Length     Date   Time    Name
 --------    ----   ----    ----
   169075  05-07-16 15:06   G0003
   169159  16-11-16 16:05   G0004
   169737  25-08-17 14:43   G0006
   170611  05-01-18 15:15   G0100
   170916  09-01-18 17:39   G0101
   171255  13-03-18 14:37   G0101A
   169410  02-02-17 16:27   G0005
   171743  05-04-18 08:39   G0104
      912  05-04-18 08:39   PFCSIP7H
   168269  01-02-18 15:29   G0102
   170415  27-02-18 15:48   G0103           --> G0103DEL
 --------                   -------
  1701502                   11 files
  
rund flkdrv0o LK wechlckr
run  flkdrv0o LK wechlckr

rund flkdrv0o UL wechlckr
run  flkdrv0o UL wechlckr

b #ssfflk0m.F100-00  
b #ssfflk0m.D130-00
  
dir *.wechlck*
purge  ssrcrepo.wechlckr
rename ssrccout.wechlckr ssrcrepo.wechlckr





FUP Code Program Values Access

– 7     Local super ID only

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

U 6     Owner (local or remote), that is, any user with owner's ID

C 5     Member of owner's group (local or remote), that is, 
        any member of owner's community

N 4     Any user (local or remote)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

O 2     Owner only (local)

G 1     Member of owner's group (local)

A 0     Any user (local)






Neueinrichtung der Entwicklungsumgebung
=======================================

Doppelte Prozessnamen wg. Suchen/Ersetzen in SETSERV

select substring(procname from 3 for 4), count(*) from =namedprc
  group by 1 browse access;
  
--- 1472 row(s) selected.  
  
select substring(procname from 3 for 4), count(*) from =namedprc
  where count(*) > 1 group by 1 browse access;
  
--- 67 row(s) selected.  
  

select * from =namedprc where procname like "__IPL%" browse access;

NODENAME  PROCNAME  SRV_CLASS
--------  --------  ----------------

\GZ1      $AIPL     IPLSENDS-T
\GZ1      $CIPL     IPLSENDS

select * from =namedprc where procname like "__H79%" browse access;

NODENAME  PROCNAME  SRV_CLASS
--------  --------  ----------------

\GZ1      $AH79     PHFMON0S-79
\GZ1      $CH79     PHFMON6S-79

select * from =namedprc where procname like "__PV16%" browse access;

NODENAME  PROCNAME  SRV_CLASS
--------  --------  ----------------

\GZ1      $APV16    AFCPRE7S-16
\GZ1      $CPV16    PFCPRE7S-16

*
*





\GZ1: $WSOFT.SSRCREPO 26> p
PERUSE - T9101H02 - (18APR2017)    SYSTEM  \GZ1
(C)Copyright 2015 Hewlett-Packard Enterprise Development LP
SPOOLER SUPERVISOR IS \GZ1.$WELS

  JOB  BATCH STATE PAGES COPIES PRI HOLD LOCATION         REPORT
  3506       READY 22    1      4        #COBOL85         ANODRV0O
  3507       READY 3     1      4        #SQLCOMP         ANODRV0O
_EOF!


DISPLAY "Anzeige Compileliste       ( /J/N): " WITH NO ADVANCING 
ACCEPT W-PRTCMP-FLG
DISPLAY "Compileliste -> Edit-File  ( /N/J): " WITH NO ADVANCING
ACCEPT W-PRTCMP-FLG

COB SRCCOMPE SSRCREPO.SRCCOMP
TAL SRCCOMPE SSRCREPO.SRCCOMP
C   SRCCOMPE SSRCREPO.SRCCOMP
SQL SRCCOMPE SSRCREPO.SRCCOMP

PRTCMP
PRT2FL

SOURCE_MODUL  SOURCE_LFDNR
------------  ------------
ZIP_STARTUP
--------------------------------------------------------------------------------

------------------------------------------------
ZPINS                   PRG_NAME
----------------------  --------

PRINTFL                  1
$WELS; LIST /out zprt0001/ ALL; exit

2018-03-09:14:28:13.32  PERUSE
PRINTFL                  2
PURGEDATA PRTOUT
2018-03-09:14:28:14.05  FUP

PRINTFL                  3
COPY ZPRT0001, PRTOUT
2018-03-09:14:28:14.77  FUP

PRINTFL                  4          WT^PURGE
!PURGE ZPRT0001
2018-03-09:14:28:15.48  FUP

--- 4 row(s) selected.


>>select * from =ssfrfdef where funktion = "PRTCMP";

ANWENDUNG  MODUL     FUNKTION         LFDNR   PROG
---------  --------  ---------------  ------  --------
ALT_PROG
------------------------------------
PRG_STU
--------------------------------------------------------------------------------
PRG_INF                               PRG_OUTF
------------------------------------  ------------------------------------
PRG_OBF                               ZPINS
------------------------------------  ----------------------

SRCCOMP    SSFCMP0M  PRTCMP                1  PERUSE

@SPOOL@; LIST

                                      2018-04-24:14:34:22.23
SRCSAFE    SSFCMP0M  PRTCMP                1  PERUSE

@SPOOL@; LIST

                                      2018-04-24:14:34:22.23

--- 2 row(s) selected.

insert into =ssfrfdef values (
  "SRCCOMP" 
, "SSFCMP0M"
, "PRT2FL"
, 1
, "PERUSE"
, " "
, "$WELS; LIST /out @TMPFILE@/ ALL; exit"
, " "
, " "
, " " 
, current year to fraction(2));

insert into =ssfrfdef values (
  "SRCCOMP" 
, "SSFCMP0M"
, "PRT2FL"
, 2
, "FUP"
, " "
, "DUP @PRTTEMPL@, @PRTFILE@"
, " "
, " "
, " " 
, current year to fraction(2));

insert into =ssfrfdef values (
  "SRCCOMP" 
, "SSFCMP0M"
, "PRT2FL"
, 3
, "FUP"
, " "
, "COPY @TMPFILE@, @PRTFILE@"
, " "
, " "
, " " 
, current year to fraction(2));

      ENTER TAL "WT^PURGE"    USING P-RESULT,
                                    @TMPFILE@
      
select * from =ssfrfdef where funktion = "PRT2FL";


cobol85 /in $WSOFT.SSRCREPO.SRCCOMPE , out $WE[!!!].#COBOL85/ $WSOFT.SSRCREPO.SRCCOMP ; ENV COMMON; HIGHPIN
cobol85 /in $WSOFT.SSRCREPO.SRCCOMPE , out $WE.#COBOL85/ $WSOFT.SSRCREPO.SRCCOMP ; ENV COMMON; HIGHPIN


PARAMETER-FELDER.P-TEXT = "SRCCOMPE
PARAMETER-FELDER.P-TEXT = "=MYDEFINE
PARAMETER-FELDER.P-TEXT = "SRCCOMP; ENV COMMON; HIGHPIN


Und nochmal STRING delimited by space (SSFRCI0, SI)

MODE 7
*FX 4,1
*FX 200,1
VDU 23;8202;0;0;0;
secpro%=FALSE
O%=0:A%=&00:X%=&01
master%=(USR(&FFF4) AND &FF00)=&300
IF master% THEN PROCnotmaster
A%=&EA:X%=&00:Y%=&FF
IF (USR(&FFF4) AND &FF00) THEN secpro%=TRUE
*RUN SCREEN
U%=INKEY(200)
UH$="  "+CHR$(130)
UL$="  "+CHR$(134)
HH$=CHR$(132)+CHR$(157)+CHR$(135)
HL$=CHR$(132)+CHR$(157)+CHR$(135)
TH$=CHR$(131)+CHR$(157)+CHR$(132)
TL$=CHR$(131)+CHR$(157)+CHR$(132)
START%=2
ROWS%=3
PROCtitle
PROCoptions
PROCselect
PROCgettitle
PROCrun
END

DEF PROCrun
IF O%=0 PROCbbcdisc
IF O%=1 PROCsecpro
IF O%=2 PROCbbccassette
IF O%=3 PROCteletext
IF O%=4 PROCeditor
ENDPROC

DEF PROCtitle
PRINTTAB(13,2);CHR$(151);CHR$(153);"<$h h l$h,";CHR$(145);CHR$(154)
PRINTTAB(13,3);CHR$(151);CHR$(153);"w0j0j j jq";CHR$(145);CHR$(154)
PRINTTAB(13,4);CHR$(135);" COMPENDIUM";CHR$(145);CHR$(154)
VDU28,0,24,39,5
CLS
PRINT'CHR$(130);"   Elite by Ian Bell and David Braben"
PRINTCHR$(130);"       Enhancements by Mark Moxon"
PRINT'CHR$(131);"^ to select, ] for info, RETURN to play";
VDU28,0,24,39,9
ENDPROC

DEF PROCoptions
RESTORE
READ T$,V$
Y%=START%
C%=0
REPEAT
PROChl(Y%,UH$,UL$)
PROCsh(Y%,T$)
PROCsh(Y%+1,V$)
Y%=Y%+ROWS%
C%=C%+1
READ T$, V$
UNTIL T$=""
ENDPROC

DEF PROCgettitle
RESTORE
FOR L%=0 TO O%
READ T$,V$
NEXT
CLS
PROCsh(2,T$)
PROCsh(3,V$)
PROChl(2,TH$,TL$)
PRINT'
ENDPROC

DEF PROCselect
L%=(O%+1)MOD C%
REPEAT
IF O%<>L% THEN PROChl(START%+L%*ROWS%,UH$,UL$):PROChl(START%+O%*ROWS%,HH$,HL$)
L%=O%
K%=GET
IF K%=138 THEN O%=(O%+1)MOD C%
IF K%=139 THEN O%=(O%+C%-1)MOD C%
IF K%=136 OR K%=137 THEN PROCinfo
UNTIL K%=13
ENDPROC

DEF PROCbbcdisc
IF secpro% THEN PROCdisablesecpro
*DRIVE 2
CHAIN "ELITED"
ENDPROC

DEF PROCsecpro
IF NOT secpro% THEN PROCenablesecpro
*DRIVE 2
CHAIN "ELITE65"
ENDPROC

DEF PROCbbccassette
IF secpro% THEN PROCdisablesecpro
*DRIVE 2
CHAIN "ELITEC"
ENDPROC

DEF PROCteletext
IF secpro% THEN PROCdisablesecpro
*DRIVE 2
CHAIN "ELITETT"
ENDPROC

DEF PROCeditor
IF NOT secpro% THEN PROCenablesecpro
*DRIVE 2
*DIR V
*RUN ELITEUE
ENDPROC

DEF PROCsh(Y%,T$)
LOCAL X%
X%=21-LEN(T$)/2
PRINTTAB(X%,Y%);T$;
ENDPROC

DEF PROChl(Y%,T$,U$)
PRINTTAB(0,Y%);T$;
PRINTTAB(0,Y%+1);U$;
ENDPROC

DEF PROCinfo
PROCgettitle
PRINTTAB(0,0);CHR$(131);"       ] for menu, RETURN to play";
FOR I%=5TO13:PRINTTAB(0,I%);CHR$(134);:NEXT
PRINTTAB(0,14);CHR$(130);
PRINTTAB(0,15);CHR$(130);
IF O%=0 PROCsh(5,"The classic 1984 BBC Micro release"):PROCsh(6,"with the following enhancements"):PROCsh(8,"Flicker-free ships and planets")
IF O%=0 PROCsh(9,"Music with volume control"):PROCsh(10,"Volume control for sound effects")
IF O%=1 PROCsh(5,"Fast Elite with the following extras"):PROCsh(7,"Flicker-free ships and planets"):PROCsh(8,"Music with volume control")
IF O%=1 PROCsh(9,"Volume control for sound effects"):PROCsh(10,"Speed adjusted to be playable")
IF O%=2 PROCsh(5,"The classic 1984 BBC Micro release"):PROCsh(6,"with flicker-free ships")
IF O%=3 PROCsh(5,"The classic 1984 BBC Micro release"):PROCsh(6,"with the following enhancements"):PROCsh(8,"Converted to run entirely in teletext")
IF O%=3 PROCsh(9,"Flicker-free ships and planets"):PROCsh(10,"Music with volume control"):PROCsh(11,"Volume control for sound effects"):PROCsh(12,"Ceefax option for the market page")
IF O%=4 PROCsh(5,"Create your own 3D scenarios in Elite"):PROCsh(7,CHR$(34)+"Press play"+CHR$(34)+" to bring them to life"):PROCsh(9,"Comes with lots of example universes")
IF O%=4 PROCsh(11,"See bbcelite.com/hacks for instructions")
IF O%=0 OR O%=3 PROCsh(14,"For the BBC Micro with 16K Sideways RAM")
IF O%=1 PROCsh(14,"For the BBC Micro + co-pro + 16K SRAM")
IF O%=2 PROCsh(14,"For the standard BBC Micro")
IF O%=4 PROCsh(14,"For the BBC Micro + 6502 co-processor")
PROCsh(15,"See www.bbcelite.com for more details")
REPEAT
K%=GET
UNTIL K%=136 OR K%=137 OR K%=13
IF K%=13 PROCgettitle:PROCrun
CLS
PROCtitle
PROCoptions
PROChl(START%+O%*ROWS%,HH$,HL$)
L%=O%
ENDPROC

DEF PROCnotmaster
PRINT"Sorry, this version of the Elite"
PRINT"Compendium only works on a BBC Micro."
PRINT'"There is a separate version for the"
PRINT"BBC Master. See bbcelite.com/hacks for"
PRINT"more details."
END
ENDPROC

DEF PROCdisablesecpro
VDU26
CLS
PRINT"Sorry, this version of Elite will not"
PRINT"run on a 6502 Second Processor."
PRINT
PRINT"Please disable the Tube with this"
PRINT"command:"
PRINT
PRINT"  *CONFIGURE NOTUBE"
PRINT
PRINT"and try booting the disc again."
END
ENDPROC

DEF PROCenablesecpro
VDU26
CLS
PRINT"Sorry, this version of Elite needs a"
PRINT"6502 Second Processor."
PRINT
PRINT"Please enable the Tube with this"
PRINT"command:"
PRINT
PRINT"  *CONFIGURE TUBE"
PRINT
PRINT"and try booting the disc again."
END
ENDPROC

REM  "----------------------------------"
DATA "BBC Micro disc Elite"
DATA "The best version of original Elite"
DATA "6502 Second Processor Elite"
DATA "The best version of co-pro Elite"
DATA "BBC Micro cassette Elite"
DATA "The best version of tape Elite"
DATA "Teletext Elite"
DATA "Classic Elite with added Ceefax"
DATA "Elite Universe Editor"
DATA "Create fully playable 3D scenarios"
DATA "",""
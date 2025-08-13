\ ******************************************************************************
\
\ BBC MICRO ELITE COMPENDIUM DISC IMAGE SCRIPT
\
\ BBC Micro disc Elite was written by Ian Bell and David Braben and is copyright
\ Acornsoft 1984
\
\ The code in this file has been reconstructed from a disassembly of the version
\ released on Ian Bell's personal website at http://www.elitehomepage.org/
\
\ The commentary is copyright Mark Moxon, and any misunderstandings or mistakes
\ in the documentation are entirely my fault
\
\ The terminology and notations used in this commentary are explained at
\ https://elite.bbcelite.com/terminology
\
\ The deep dive articles referred to in this commentary can be found at
\ https://elite.bbcelite.com/deep_dives
\
\ ------------------------------------------------------------------------------
\
\ This source file produces side 2 of the following DSD disc image:
\
\   * elite-compendium.dsd
\
\ This can be loaded into an emulator or a real BBC Master.
\
\ ******************************************************************************

\ Menu

 PUTBASIC "1-source-files/menu-files/$.MENU.bas", "MENU"
 PUTFILE "1-source-files/menu-files/$.SCREEN.bin", "SCREEN", &FF7800, &FF7BE8

\ Elite music ROM (incorporating extra code from disc version)

 PUTFILE "elite-source-code-bbc-micro-disc/3-assembled-output/elite-music.rom", "MUSIC", &008000, &008000

\ Elite music ROM (incorporating extra code from cassette version)

 PUTFILE "elite-source-code-bbc-micro-cassette/3-assembled-output/elite-music.rom", "MUSICC", &008000, &008000

\ BBC Micro cassette Elite (Flicker-free version) = CHAIN "ELITEC"

 PUTFILE "elite-source-code-bbc-micro-cassette/3-assembled-output/ELITE.bin", "ELTdata", &FF1100, &FF2000
 PUTFILE "elite-source-code-bbc-micro-cassette/3-assembled-output/ELTcode.bin", "ELTcode", &FF1128, &FF1128
 PUTBASIC "elite-source-code-bbc-micro-cassette/1-source-files/music/load-music.bas", "ELITEC"

\ Elite Universe Editor (BBC Master version) = *DIR V : *RUN ELITEUE

 PUTFILE "elite-universe-editor-6502-second-processor/3-assembled-output/ELITE.bin", "V.ELITEUE", &FF1FDC, &FF2085
 PUTFILE "elite-universe-editor-6502-second-processor/3-assembled-output/ELITEa.bin", "V.IELITEa", &FF2000, &FF2000
 PUTFILE "elite-universe-editor-6502-second-processor/3-assembled-output/I.CODE.bin", "V.ICODE", &FF2400, &FF2C89
 PUTFILE "elite-universe-editor-6502-second-processor/3-assembled-output/P.CODE.bin", "V.PCODE", &000E3C, &00106A
 PUTFILE "elite-universe-editor-library/universe-files/U.BOXART1.bin", "U.BOXART1", &000000, &000000
 PUTFILE "elite-universe-editor-library/universe-files/U.BOXART2.bin", "U.BOXART2", &000000, &000000
 PUTFILE "elite-universe-editor-library/universe-files/U.BOXARTC.bin", "U.BOXARTC", &000000, &000000
 PUTFILE "elite-universe-editor-library/universe-files/U.MANUAL.bin", "U.MANUAL", &000000, &000000
 PUTFILE "elite-universe-editor-library/universe-files/U.SHIPID.bin", "U.SHIPID", &000000, &000000
 PUTFILE "elite-universe-editor-library/universe-files/U.SHIPID6.bin", "U.SHIPID6", &000000, &000000
 PUTFILE "elite-universe-editor-library/universe-files/U.SHIPIDC.bin", "U.SHIPIDC", &000000, &000000

\ 6502SP Elite (Compendium version) = CHAIN "ELITE65"

 PUTFILE "elite-source-code-6502-second-processor/3-assembled-output/ELITE.bin", "ELITE", &FF1FDC, &FF2085
 PUTFILE "elite-source-code-6502-second-processor/3-assembled-output/ELITEa.bin", "I.ELITEa", &FF2000, &FF2000
 PUTFILE "elite-source-code-6502-second-processor/3-assembled-output/I.CODE.bin", "I.CODE", &FF2400, &FF2C89
 PUTFILE "elite-source-code-6502-second-processor/3-assembled-output/P.CODE.bin", "P.CODE", &000E3C, &0010D1
 PUTBASIC "elite-source-code-6502-second-processor/1-source-files/music/load-music.bas", "ELITE65"

\ Disc Elite (Compendium version) = CHAIN "ELITED", which does *DRIVE 0 : *RUN ELITED

 PUTBASIC "elite-source-code-bbc-micro-disc/1-source-files/music/load-music-drive-2.bas", "ELITED"
 PUTFILE "elite-source-code-bbc-micro-disc/1-source-files/music/SRLoad.bin", "SRLOAD", &FF0900, &FF093D

\ Teletext Elite (Compendium version) = CHAIN "ELITETT", which does *DRIVE 0 : *RUN ELITET

 PUTBASIC "teletext-elite/1-source-files/music/load-music-drive-2.bas", "ELITETT"


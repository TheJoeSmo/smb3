; Super Mario Bros. 3 Full Disassembly by Southbird 2012
; For more info, see http://www.sonicepoch.com/sm3mix/
;
; PLEASE INCLUDE A CREDIT TO THE SOUTHBIRD DISASSEMBLY
; AND THE ABOVE LINK SOMEWHERE IN YOUR WORKS :)
;
; Original disassembler source generated by DCC6502 version v1.4
; (With labels, comments, and some syntax corrections for nesasm by Southbird)
; For more info about DCC6502, e-mail veilleux@ameth.org
;
; This source file last updated: 2011-11-18 21:50:36.000000000 -0600
; Distribution package date: Fri Apr  6 23:46:16 UTC 2012

.if KEEP_USED_LEVELS != 0
  _C000:      .include "PRG/objects/C000.asm"
.endif
W2UNO:      .include "PRG/objects/EmptyW2.asm"  ; Unused/empty object set linked to World 2 Start Panel
.if KEEP_USED_LEVELS != 0
  _C004:      .include "PRG/objects/C004.asm"
.endif
W503O:
Empty_ObjLayout:    .include "PRG/objects/Empty.asm"    ; Shared Empty object set
.if KEEP_USED_LEVELS != 0
  _C008:      .include "PRG/objects/C008.asm"
  _C00A:      .include "PRG/objects/C00A.asm"
  _C00C:      .include "PRG/objects/C00C.asm"
  _C00E:      .include "PRG/objects/C00E.asm"
  _C010:      .include "PRG/objects/C010.asm"
  _C012:      .include "PRG/objects/C012.asm"
  _C014:      .include "PRG/objects/C014.asm"
  _C016:      .include "PRG/objects/C016.asm"
  _C018:      .include "PRG/objects/C018.asm"
  _C01A:      .include "PRG/objects/C01A.asm"
  _C01C:      .include "PRG/objects/C01C.asm"
  _C01E:      .include "PRG/objects/C01E.asm"
  _C020:      .include "PRG/objects/C020.asm"
  _C025:      .include "PRG/objects/C025.asm"
.endif
TOADO:      .include "PRG/objects/ToadTyp.asm"
TOAD_SpecO: .include "PRG/objects/ToadSpec.asm"
W8HBO:      .include "PRG/objects/W8HBO.asm"    ; World 8 Hammer Bro object mapping (sort of)
.if KEEP_USED_LEVELS != 0
  _C06F:      .include "PRG/objects/C06F.asm"
  _C07A:      .include "PRG/objects/C07A.asm"
  _C07C:      .include "PRG/objects/C07C.asm"
  _C07E:      .include "PRG/objects/C07E.asm"
  _C080:      .include "PRG/objects/C080.asm"
  _C082:      .include "PRG/objects/C082.asm"
  _C084:      .include "PRG/objects/C084.asm"
  _C098:      .include "PRG/objects/C098.asm"
  _C0A0:      .include "PRG/objects/C0A0.asm"
.endif
W8P1O:      .include "PRG/objects/W8Pipe1.asm"  ; World 8 Pipe Junction 1
W8P2O:      .include "PRG/objects/W8Pipe2.asm"  ; World 8 Pipe Junction 2
W8P3O:      .include "PRG/objects/W8Pipe3.asm"  ; World 8 Pipe Junction 3
W8P4O:      .include "PRG/objects/W8Pipe4.asm"  ; World 8 Pipe Junction 4
W8P5O:      .include "PRG/objects/W8Pipe5.asm"  ; World 8 Pipe Junction 5
W8P6O:      .include "PRG/objects/W8Pipe6.asm"  ; World 8 Pipe Junction 6
W7P1O:      .include "PRG/objects/W7Pipe1.asm"  ; World 7 Pipe Junction 1
W7P2O:      .include "PRG/objects/W7Pipe2.asm"  ; World 7 Pipe Junction 2
W7P3O:      .include "PRG/objects/W7Pipe3.asm"  ; World 7 Pipe Junction 3
W7P4O:      .include "PRG/objects/W7Pipe4.asm"  ; World 7 Pipe Junction 4
W7P5O:      .include "PRG/objects/W7Pipe5.asm"  ; World 7 Pipe Junction 5
W7P6O:      .include "PRG/objects/W7Pipe6.asm"  ; World 7 Pipe Junction 6
W7P7O:      .include "PRG/objects/W7Pipe7.asm"  ; World 7 Pipe Junction 7
W7P8O:      .include "PRG/objects/W7Pipe8.asm"  ; World 7 Pipe Junction 8
W6P1O:      .include "PRG/objects/W6Pipe1.asm"  ; World 6 Pipe Junction 1
W6P2O:      .include "PRG/objects/W6Pipe2.asm"  ; World 6 Pipe Junction 2
W2P1O:      .include "PRG/objects/W2Pipe1.asm"  ; World 2 Pipe Junction 1
W3P1O:      .include "PRG/objects/W3Pipe1.asm"  ; World 3 Pipe Junction 1
W3P2O:      .include "PRG/objects/W3Pipe2.asm"  ; World 3 Pipe Junction 2
W3P3O:      .include "PRG/objects/W3Pipe3.asm"  ; World 3 Pipe Junction 3
W4P1O:      .include "PRG/objects/W4Pipe1.asm"  ; World 4 Pipe Junction 1
W4P2O:      .include "PRG/objects/W4Pipe2.asm"  ; World 4 Pipe Junction 2
W5P1O:      .include "PRG/objects/W5Pipe1.asm"  ; World 5 Pipe Junction 1
W507_LowerO:    .include "PRG/objects/5-7Lower.asm"
W705_UnderO:    .include "PRG/objects/7-5Under.asm"
.if KEEP_USED_LEVELS != 0
  _C1A6:      .include "PRG/objects/C1A6.asm"
  Unused1O:   .include "PRG/objects/Unused1.asm"  ; "Unused level 1"
.endif
W46BO:      .include "PRG/objects/4-6B.asm" ; 4-6B
.if KEEP_USED_LEVELS != 0
  Unused2O:   .include "PRG/objects/Unused2.asm"  ; "Unused level 2"
.endif
W701O:      .include "PRG/objects/7-1.asm"  ; 7-1
W707O:      .include "PRG/objects/7-7.asm"  ; 7-7
W46AO:      .include "PRG/objects/4-6A.asm" ; 4-6A
W503_InsideO:   .include "PRG/objects/5-3Inner.asm" ; 5-3 Inside
W103O:      .include "PRG/objects/1-3.asm"  ; 1-3
W305_EndO:  .include "PRG/objects/3-5End.asm"   ; 3-5 Exit
W405_BonusO:    .include "PRG/objects/4-5Bonus.asm" ; 4-5 Bonus
W708O:      .include "PRG/objects/7-8.asm"  ; 7-8
W309O:      .include "PRG/objects/3-9.asm"  ; 3-9
W309_EndO:  .include "PRG/objects/3-9End.asm"   ; 3-9 Exit
W706O:      .include "PRG/objects/7-6.asm"  ; 7-6
W704O:      .include "PRG/objects/7-4.asm"  ; 7-4
W501O:      .include "PRG/objects/5-1.asm"  ; 5-1
W501_BonusO:    .include "PRG/objects/5-1Bonus.asm" ; 5-1 Bonus
.if KEEP_USED_LEVELS != 0
  _C41F:      .include "PRG/objects/C41F.asm"
.endif
W801O:      .include "PRG/objects/8-1.asm"  ; 8-1
W307O:      .include "PRG/objects/3-7.asm"  ; 3-7
W301_ExitO: .include "PRG/objects/3-1Exit.asm"  ; 3-1 Exit pipe
.if KEEP_USED_LEVELS != 0
  _C4B4:      .include "PRG/objects/C4B4.asm"
  _C4EC:      .include "PRG/objects/C4EC.asm"
.endif
W101O:      .include "PRG/objects/1-1.asm"  ; 1-1
W705O:      .include "PRG/objects/7-5.asm"
W308_EndO:  .include "PRG/objects/3-8End.asm"   ; 3-8 Exit
W503_EndO:  .include "PRG/objects/5-3End.asm"
.if KEEP_USED_LEVELS != 0
  _C565:      .include "PRG/objects/C565.asm"
  Unused2_ExitO:  .include "PRG/objects/Unused2E.asm" ; "Unused level 2" Exit
.endif
W104_EndO:  .include "PRG/objects/1-4End.asm"   ; 1-4 End
.if KEEP_USED_LEVELS != 0
  _C58C:      .include "PRG/objects/C58C.asm"
.endif
W303O:      .include "PRG/objects/3-3.asm"  ; 3-3
W303_EndO:  .include "PRG/objects/3-3End.asm"   ; 3-3 End
W2PY_InsideO:   .include "PRG/objects/PyramidI.asm" ; Pyramid (Inside)
W605_UnderO:    .include "PRG/objects/6-5Under.asm" ; 6-5 Underground
W609_UnderO:    .include "PRG/objects/6-9Under.asm" ; 6-9 Underground
W3HBO:      .include "PRG/objects/W3HBO.asm"    ; World 3 Hammer Bro Battle
W606_UnderO:    .include "PRG/objects/6-6Under.asm" ; 6-6 Underground
W102O:      .include "PRG/objects/1-2.asm"  ; 1-2
Unused3O:   .include "PRG/objects/Unused3.asm"  ; "Unused level 3"
W703O:      .include "PRG/objects/7-3.asm"  ; 7-3
W1HBO:      .include "PRG/objects/W1HBO.asm"    ; World 1 Hammer Bro Battle
.if KEEP_USED_LEVELS != 0
  _C733:      .include "PRG/objects/C733.asm"
  _C759:      .include "PRG/objects/C759.asm"
  _C764:      .include "PRG/objects/C764.asm"
  _C77E:      .include "PRG/objects/C77E.asm"
  Unused4_InnerO: .include "PRG/objects/Unused4I.asm"
  _C7EB:      .include "PRG/objects/C7EB.asm"
  _C80B:      .include "PRG/objects/C80B.asm"
.endif
W2STO:      .include "PRG/objects/SandTrap.asm" ; World 2 Sand Trap
W403_UnderO:    .include "PRG/objects/4-3Under.asm" ; 4-3 Underground
W202O:      .include "PRG/objects/2-2.asm"  ; 2-2
W502O:      .include "PRG/objects/5-2.asm"  ; 5-2 (above ground)
W802O:      .include "PRG/objects/8-2.asm"  ; 8-2
W105O:      .include "PRG/objects/1-5.asm"  ; 1-5
W308O:      .include "PRG/objects/3-8.asm"  ; 3-8
W40F_BonusO:    .include "PRG/objects/4-FBonus.asm" ; World 4 Fortress Bonus area
BigQBlock1O:    .include "PRG/objects/BigQ1.asm"    ; World 1's Big [?] block area (empty)
BigQBlock2O:    .include "PRG/objects/BigQ2.asm"    ; World 2's Big [?] block area
BigQBlock3O:    .include "PRG/objects/BigQ3.asm"    ; World 3's Big [?] block area
BigQBlock4O:    .include "PRG/objects/BigQ4.asm"    ; World 4's Big [?] block area
BigQBlock5O:    .include "PRG/objects/BigQ5.asm"    ; World 5's Big [?] block area
BigQBlock6O:    .include "PRG/objects/BigQ6.asm"    ; World 6's Big [?] block area
BigQBlock7O:    .include "PRG/objects/BigQ7.asm"    ; World 7's Big [?] block area
BigQBlock8O:    .include "PRG/objects/BigQ8.asm"    ; World 8's Big [?] block area
W304O:      .include "PRG/objects/3-4.asm"  ; 3-4
W608O:      .include "PRG/objects/6-8.asm"  ; 6-8
W302O:      .include "PRG/objects/3-2.asm"  ; 3-2
W302_EndO:  .include "PRG/objects/3-2End.asm"   ; 3-2 End
W306O:      .include "PRG/objects/3-6.asm"  ; 3-6
W306_EndO:  .include "PRG/objects/3-6End.asm"   ; 3-6 End
W603O:      .include "PRG/objects/6-3.asm"  ; 6-3
W6F2O:      .include "PRG/objects/6-F2.asm" ; World 6 2nd Fortress
W6F2_AltO:  .include "PRG/objects/6-F2A.asm"    ; World 6 2nd Fortress Alternate
W605O:      .include "PRG/objects/6-5.asm"  ; 6-5
.if KEEP_USED_LEVELS != 0
  Unused11O:  .include "PRG/objects/Unused11.asm" ; "Unused level 11"
.endif
W505O:      .include "PRG/objects/5-5.asm"  ; 5-5
.if KEEP_USED_LEVELS != 0
  Unused12:   .include "PRG/objects/Unused12.asm" ; "Unused level 12"
  Unused13:   .include "PRG/objects/Unused13.asm" ; "Unused level 13"
.endif
W602O:      .include "PRG/objects/6-2.asm"  ; 6-2
.if KEEP_USED_LEVELS != 0
  _CB8D:      .include "PRG/objects/CB8D.asm"
.endif
W601O:      .include "PRG/objects/6-1.asm"
W1UNO:      .include "PRG/objects/Unused6.asm"  ; "Unused Level 6"
W602_EndO:  .include "PRG/objects/6-2End.asm"   ; 6-2 End (also end of "Unused Level 6")
W106O:      .include "PRG/objects/1-6.asm"  ; 1-6
W104O:      .include "PRG/objects/1-4.asm"  ; 1-4
W604O:      .include "PRG/objects/6-4.asm"  ; 6-4
.if KEEP_USED_LEVELS != 0
  Unused7O:   .include "PRG/objects/Unused7.asm"  ; "Unused level 7"
  Unused7_EndO:   .include "PRG/objects/Unused7E.asm" ; "Unused level 7" exit area
.endif
W606O:      .include "PRG/objects/6-6.asm"  ; 6-6
W610O:      .include "PRG/objects/6-10.asm" ; 6-10
W607O:      .include "PRG/objects/6-7.asm"  ; 6-7
W607_EndO:  .include "PRG/objects/6-7End.asm"   ; 6-7 End
W609O:      .include "PRG/objects/6-9.asm"  ; 6-9
W707_MainO: .include "PRG/objects/7-7Main.asm"  ; 7-7 main section
.if KEEP_USED_LEVELS != 0
  _CD55:      .include "PRG/objects/CD55.asm"
.endif
W701_MazeO: .include "PRG/objects/7-1Maze.asm"  ; 7-1 Maze area
W704_WaterO:    .include "PRG/objects/7-4Water.asm" ; 7-4 Underwater section
W305O:      .include "PRG/objects/3-5.asm"  ; 3-5
W4F2_BonusO:    .include "PRG/objects/4-F2Bonu.asm" ; World 4 2nd Fortress bonus
W301O:      .include "PRG/objects/3-1.asm"  ; 3-1
W502_UnderO:    .include "PRG/objects/5-2Under.asm" ; 5-2 Underground
W706_MazeO: .include "PRG/objects/7-6Maze.asm"  ; 7-6 Maze
W508O:      .include "PRG/objects/5-8.asm"  ; 5-8
W504_EndO:  .include "PRG/objects/5-4End.asm"   ; 5-4 Exit
W307_CoinHeavO: .include "PRG/objects/W307Coin.asm" ; 3-7 Coin Heaven
W401O:      .include "PRG/objects/4-1.asm"  ; 4-1
.if KEEP_USED_LEVELS != 0
  Unused9O:   .include "PRG/objects/Unused9.asm"  ; "Unused level 9"
.endif
W507O:      .include "PRG/objects/5-7.asm"  ; 5-7
W403O:      .include "PRG/objects/4-3.asm"  ; 4-3
W402O:      .include "PRG/objects/4-2.asm"  ; 4-2
W506O:      .include "PRG/objects/5-6.asm"  ; 5-6
W509O:      .include "PRG/objects/5-9.asm"  ; 5-9
W404O:      .include "PRG/objects/4-4.asm"  ; 4-4
.if KEEP_USED_LEVELS != 0
  Unused3_CHO:    .include "PRG/objects/Un3Coin.asm"  ; "Unused Level 3" coin heaven
.endif
W103_CoinHeavO: .include "PRG/objects/W103Coin.asm" ; 1-3 Coin Heaven
W5TDO:      .include "PRG/objects/W5TowerD.asm" ; World 5 Tower coming downward
W5T4O:      .include "PRG/objects/W5Tower4.asm" ; World 5 Tower 4/4
W5T2O:      .include "PRG/objects/W5Tower2.asm" ; World 5 Tower 2/4
W405O:      .include "PRG/objects/4-5.asm"  ; 4-5
W604_CoinHeavO: .include "PRG/objects/W604Coin.asm" ; 6-4 Coin Heaven
W105_CoinHeavO: .include "PRG/objects/W105Coin.asm" ; 1-5 Coin Heaven
W401_BonusO:    .include "PRG/objects/4-1Bonus.asm" ; 4-1 Bonus
W504O:      .include "PRG/objects/5-4.asm"  ; 5-4
W7I2O:      .include "PRG/objects/W7Plant2.asm" ; World 7 Giant Piranha 2
W7I1O:      .include "PRG/objects/W7Plant1.asm" ; World 7 Giant Piranha 1
W8H2O:      .include "PRG/objects/W8HTrap2.asm" ; World Hand Trap 2
W8H1O:      .include "PRG/objects/W8HTrap1.asm" ; World Hand Trap 1
W8H3O:      .include "PRG/objects/W8HTrap3.asm" ; World Hand Trap 3
W8H_PrizeO: .include "PRG/objects/W8HTrapE.asm" ; World Hand Trap Prize room
W7I2_PrizeO:    .include "PRG/objects/W7Prize2.asm" ; World 7 Giant Piranha 2 Prize room
W7I1_PrizeO:    .include "PRG/objects/W7Prize1.asm" ; World 7 Giant Piranha 1 Prize room
W4HBO:      .include "PRG/objects/W4HBO.asm"    ; World 4 Heavy Bro battle
W708_CoinHeavO: .include "PRG/objects/W708Coin.asm" ; 7-8 Coin Heaven
W2PYO:      .include "PRG/objects/PyramidO.asm" ; Pyramid (outside)
W709_EndO:  .include "PRG/objects/7-9End.asm"   ; 7-9 Exit
W702O:      .include "PRG/objects/7-2.asm"  ; 7-2
W2FBO:      .include "PRG/objects/W2FBO.asm"    ; World 2 Fire Bro
W2HBO:      .include "PRG/objects/W2HBO.asm"    ; World 2 Boomerang Bro
Unused8_EndO:   .include "PRG/objects/Unused8E.asm" ; "Unused level 8" exit area
W709O:      .include "PRG/objects/7-9.asm"  ; 7-9
W201O:      .include "PRG/objects/2-1.asm"  ; 2-1
W205O:      .include "PRG/objects/2-5.asm"  ; 2-5
W203O:      .include "PRG/objects/2-3.asm"  ; 2-3
W20FO:      .include "PRG/objects/2-F.asm"  ; World 2 Fortress
W20F_AltO:  .include "PRG/objects/2-FA.asm" ; World 2 Fortress Alternate
W204O:      .include "PRG/objects/2-4.asm"  ; 2-4
.if KEEP_USED_LEVELS != 0
  _D28E:      .include "PRG/objects/D28E.asm"
.endif
W202_ExitO: .include "PRG/objects/2-2Exit.asm"  ; 2-2 Exit
W203_ExitO: .include "PRG/objects/2-3Exit.asm"  ; 2-3 Exit
KINGO:      .include "PRG/objects/King.asm"
W5F2O:      .include "PRG/objects/5-F2.asm"
W5F2_AltO:  .include "PRG/objects/5-F2A.asm"
.if KEEP_USED_LEVELS != 0
  _D309:      .include "PRG/objects/D309.asm"
  _D320:      .include "PRG/objects/D320.asm"
.endif
W10FO:      .include "PRG/objects/1-F.asm"  ; World 1 Fortress
W10F_AltO:  .include "PRG/objects/1-FA.asm" ; World 1 Fortress Alternate
W3F2O:      .include "PRG/objects/3-F2.asm" ; World 3 2nd Fortress
W3F2_AltO:  .include "PRG/objects/3-F2A.asm"    ; World 3 2nd Fortress Alternate
W3F1O:      .include "PRG/objects/3-F1.asm" ; World 3 1st Fortress
W3F1_AltO:  .include "PRG/objects/3-F1A.asm"    ; World 3 1st Fortress Alternate
W5F1O:      .include "PRG/objects/5-F1.asm" ; World 5 Ground Fortress
W5F1_AltO:  .include "PRG/objects/5-F1A.asm"    ; World 5 Ground Fortress Alternate
.if KEEP_USED_LEVELS != 0
  Unused5O:   .include "PRG/objects/Unused5.asm"  ; "Unused Level 5" (TCRF)
.endif
W7F2O:      .include "PRG/objects/7-F2.asm" ; World 7 2nd Fortress
W7F2_AltO:  .include "PRG/objects/7-F2A.asm"    ; World 7 2nd Fortress Alternate
W6F3O:      .include "PRG/objects/6-F3.asm" ; World 6 3rd Fortress
W6F3_AltO:  .include "PRG/objects/6-F3A.asm"    ; World 6 3rd Fortress Alternate
W6F1O:      .include "PRG/objects/6-F1.asm" ; World 6 1st Fortress
W6F1_AltO:  .include "PRG/objects/6-F1A.asm"    ; World 6 1st Fortress Alternate
W7F1O:      .include "PRG/objects/7-F1.asm" ; World 7 1st Fortress
W5T1O:      .include "PRG/objects/W5Tower1.asm"
W5T3O:      .include "PRG/objects/W5Tower3.asm"
W4F2O:      .include "PRG/objects/4-F2.asm"
W4F1O:      .include "PRG/objects/4-F1.asm"
W80FO:      .include "PRG/objects/8-F.asm"
W80F_AltO:  .include "PRG/objects/8-FA.asm"
W8BCO:      .include "PRG/objects/Bowser.asm"
W8BC_AltO:  .include "PRG/objects/BowserA.asm"
.if KEEP_USED_LEVELS != 0
  _D637:      .include "PRG/objects/D637.asm"
.endif
WAirship_IntroO:    .include "PRG/objects/WAIntro.asm"  ; Any Airship run, jump, catch anchor intro
W4Airship_BossO:    .include "PRG/objects/W4ABoss.asm"  ; World 4 Airship boss room
W5AirshipO: .include "PRG/objects/W5A.asm"          ; World 5 Airship
W1AirshipO: .include "PRG/objects/W1A.asm"          ; World 1 Airship
W2AirshipO: .include "PRG/objects/W2A.asm"          ; World 2 Airship
W3AirshipO: .include "PRG/objects/W3A.asm"          ; World 3 Airship
W4AirshipO: .include "PRG/objects/W4A.asm"          ; World 4 Airship
W6AirshipO: .include "PRG/objects/W6A.asm"          ; World 6 Airship
W7AirshipO: .include "PRG/objects/W7A.asm"          ; World 7 Airship
W8AirshipO: .include "PRG/objects/W8A.asm"          ; World 8 Airship
W8BSO:      .include "PRG/objects/W8Ship.asm"       ; World 8 Battleship
W8T2O:      .include "PRG/objects/W8Tank2.asm"      ; World 8 Tank 2
W8T1O:      .include "PRG/objects/W8Tank1.asm"      ; World 8 Tank 1
W1Airship_BossO:    .include "PRG/objects/W1ABoss.asm"  ; World 1 Airship boss room
W2Airship_BossO:    .include "PRG/objects/W2ABoss.asm"  ; World 2 Airship boss room
W3Airship_BossO:    .include "PRG/objects/W3ABoss.asm"  ; World 3 Airship boss room
W5Airship_BossO:    .include "PRG/objects/W5ABoss.asm"  ; World 5 Airship boss room
W6Airship_BossO:    .include "PRG/objects/W6ABoss.asm"  ; World 6 Airship boss room
W7Airship_BossO:    .include "PRG/objects/W7ABoss.asm"  ; World 7 Airship boss room
CoinShipO:      .include "PRG/objects/CoinShip.asm" ; Coin Ship
CoinShip_BossO:     .include "PRG/objects/CoinBoss.asm" ; Coin Ship boss
W8Tank2_BossO:      .include "PRG/objects/W8Tank2B.asm"
W8BS_BossO:     .include "PRG/objects/W8ShipBs.asm"
W8Airship_BossO:    .include "PRG/objects/W8ABoss.asm"  ; World 8 Airship boss room
W8Tank1_BossO:  .include "PRG/objects/W8Tank1B.asm"
.if KEEP_USED_LEVELS != 0
  _DA34:      .include "PRG/objects/DA34.asm"
  _DA60:      .include "PRG/objects/DA60.asm"
.endif
.if INCLUDE_DEMO_LEVELS != 0
REX_LEVEL_Objects:  .include "PRG/objects/rex.asm"            ; Demo rex level
.endif
.if INCLUDE_TEST_LEVELS != 0
REX_TEST_LEVEL_Objects:  .include "PRG/objects/test_rex.asm"  ; Test rex level
.endif

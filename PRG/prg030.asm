
    .base ObjectGroup_InitJumpTable  ; <-- help enforce this table *here*
ObjectGroup30_InitJumpTable:
    .word ObjInit_DoNothing ; Object $00
    .word ObjInit_Obj01 ; Object $01
    .word ObjInit_Obj02 ; Object $02
    .word ObjInit_DoNothing ; Object $03
    .word ObjInit_Obj04 ; Object $04
    .word ObjInit_Obj05 ; Object $05
    .word ObjInit_BounceDU  ; Object $06 - OBJ_BOUNCEDOWNUP
    .word ObjInit_WarpHide  ; Object $07 - OBJ_WARPHIDE
    .word ObjInit_PDoor ; Object $08 - OBJ_PSWITCHDOOR
    .word ObjInit_Anchor    ; Object $09 - OBJ_AIRSHIPANCHOR
    .word ObjInit_Obj0A ; Object $0A
    .word ObjInit_PUpMush   ; Object $0B - OBJ_POWERUP_1UP
    .word ObjInit_StarOrSuit; Object $0C - OBJ_POWERUP_STARMAN
    .word ObjInit_PUpMush   ; Object $0D - OBJ_POWERUP_MUSHROOM
    .word ObjInit_Koopaling ; Object $0E - OBJ_BOSS_KOOPALING
    .word ObjInit_DoNothing ; Object $0F
    .word ObjInit_DoNothing ; Object $10
    .word ObjInit_DoNothing ; Object $11
    .word ObjInit_DoNothing ; Object $12
    .word ObjInit_DoNothing ; Object $13
    .word ObjInit_DoNothing ; Object $14
    .word ObjInit_Rex1      ; Object $15 - OBJ_REX
    .word ObjInit_RexSquished1 ; Object $16 - OBJ_REX_SQUISHED
    .word ObjInit_SpinyCheep; Object $17 - OBJ_SPINYCHEEP
    .word ObjInit_Bowser    ; Object $18 - OBJ_BOSS_BOWSER
    .word ObjInit_FireFlower; Object $19 - OBJ_POWERUP_FIREFLOWER
    .word ObjInit_DoNothing ; Object $1A
    .word ObjInit_BounceLR  ; Object $1B - OBJ_BOUNCELEFTRIGHT
    .word ObjInit_Obj1C ; Object $1C
    .word ObjInit_DoNothing ; Object $1D
    .word ObjInit_SuperLeaf ; Object $1E - OBJ_POWERUP_SUPERLEAF
    .word ObjInit_Vine  ; Object $1F - OBJ_GROWINGVINE
    .word ObjInit_DoNothing ; Object $20
    .word ObjInit_DoNothing ; Object $21 - OBJ_POWERUP_MUSHCARD
    .word ObjInit_DoNothing ; Object $22 - OBJ_POWERUP_FIRECARD
    .word ObjInit_DoNothing ; Object $23 - OBJ_POWERUP_STARCARD


    ; Object group $00 (i.e. objects starting at ID $00) State 2 jump table

    .base ObjectGroup_NormalJumpTable    ; <-- help enforce this table *here*
ObjectGroup30_NormalJumpTable:
    .word ObjNorm_DoNothing ; Object $00
    .word ObjNorm_Obj01 ; Object $01
    .word ObjNorm_Obj02 ; Object $02
    .word ObjNorm_DoNothing ; Object $03
    .word ObjNorm_Obj04 ; Object $04
    .word ObjNorm_Obj05 ; Object $05
    .word ObjNorm_BounceDU  ; Object $06 - OBJ_BOUNCEDOWNUP
    .word ObjNorm_WarpHide  ; Object $07 - OBJ_WARPHIDE
    .word ObjNorm_PDoor ; Object $08 - OBJ_PSWITCHDOOR
    .word ObjNorm_Anchor    ; Object $09 - OBJ_AIRSHIPANCHOR
    .word ObjNorm_Obj0A ; Object $0A
    .word ObjNorm_PUp1UpMush; Object $0B - OBJ_POWERUP_1UP
    .word ObjNorm_StarOrSuit; Object $0C - OBJ_POWERUP_STARMAN
    .word ObjNorm_PUpMush   ; Object $0D - OBJ_POWERUP_MUSHROOM
    .word ObjNorm_Koopaling ; Object $0E - OBJ_BOSS_KOOPALING
    .word ObjNorm_DoNothing ; Object $0F
    .word ObjNorm_DoNothing ; Object $10
    .word ObjNorm_DoNothing ; Object $11
    .word ObjNorm_DoNothing ; Object $12
    .word ObjNorm_DoNothing ; Object $13
    .word ObjNorm_DoNothing ; Object $14
    .word ObjNorm_Rex1      ; Object $15 - OBJ_REX
    .word ObjNorm_RexSquashed1 ; Object $16 - OBJ_REX_SQUISHED
    .word ObjNorm_SpinyCheep; Object $17 - OBJ_SPINYCHEEP
    .word ObjNorm_Bowser    ; Object $18 - OBJ_BOSS_BOWSER
    .word ObjNorm_FireFlower; Object $19 - OBJ_POWERUP_FIREFLOWER
    .word ObjNorm_Obj1A ; Object $1A
    .word ObjNorm_BounceLR  ; Object $1B - OBJ_BOUNCELEFTRIGHT
    .word ObjNorm_Obj1C ; Object $1C
    .word ObjNorm_DoNothing ; Object $1D
    .word ObjNorm_SuperLeaf ; Object $1E - OBJ_POWERUP_SUPERLEAF
    .word ObjNorm_Vine  ; Object $1F - OBJ_GROWINGVINE
    .word ObjNorm_DoNothing ; Object $20
    .word ObjNorm_Card  ; Object $21 - OBJ_POWERUP_MUSHCARD
    .word ObjNorm_Card  ; Object $22 - OBJ_POWERUP_FIRECARD
    .word ObjNorm_Card  ; Object $23 - OBJ_POWERUP_STARCARD


    ; Object group $00 (i.e. objects starting at ID $00) Collision routine jump table (if calling Object_HitTestRespond;
    ; Special values of OCSPECIAL_KILLCHANGETO or OCSPECIAL_HIGHSCORE can be used here instead otherwise.)

    .base ObjectGroup_CollideJumpTable   ; <-- help enforce this table *here*
ObjectGroup30_CollideJumpTable:
    .word ObjHit_DoNothing  ; Object $00
    .word ObjHit_Obj01  ; Object $01
    .word ObjHit_DoNothing  ; Object $02
    .word ObjHit_DoNothing  ; Object $03
    .word ObjHit_Obj04  ; Object $04
    .word ObjHit_Obj05  ; Object $05
    .word ObjHit_DoNothing  ; Object $06 - OBJ_BOUNCEDOWNUP
    .word ObjHit_DoNothing  ; Object $07 - OBJ_WARPHIDE
    .word ObjHit_DoNothing  ; Object $08 - OBJ_PSWITCHDOOR
    .word ObjHit_DoNothing  ; Object $09 - OBJ_AIRSHIPANCHOR
    .word ObjHit_Obj0A  ; Object $0A
    .word ObjHit_PUp1UpMush ; Object $0B - OBJ_POWERUP_1UP
    .word ObjHit_StarOrSuit ; Object $0C - OBJ_POWERUP_STARMAN
    .word ObjHit_PUpMush    ; Object $0D - OBJ_POWERUP_MUSHROOM
    .word ObjHit_Koopaling  ; Object $0E - OBJ_BOSS_KOOPALING
    .word ObjHit_DoNothing  ; Object $0F
    .word ObjHit_DoNothing  ; Object $10
    .word ObjHit_DoNothing  ; Object $11
    .word ObjHit_DoNothing  ; Object $12
    .word ObjHit_DoNothing  ; Object $13
    .word ObjHit_DoNothing  ; Object $14
    .word ObjHit_DoNothing  ; Object $15 - OBJ_REX
    .word ObjHit_DoNothing  ; Object $16 - OBJ_REX_SQUISHED
    .word ObjHit_DoNothing  ; Object $17 - OBJ_SPINYCHEEP
    .word OCSPECIAL_HIGHSCORE; Object $18 - OBJ_BOSS_BOWSER
    .word ObjHit_FireFlower ; Object $19 - OBJ_POWERUP_FIREFLOWER
    .word ObjHit_Obj1A  ; Object $1A
    .word ObjHit_BoundLR    ; Object $1B - OBJ_BOUNCELEFTRIGHT
    .word ObjHit_DoNothing  ; Object $1C
    .word ObjHit_DoNothing  ; Object $1D
    .word ObjHit_SuperLeaf  ; Object $1E - OBJ_POWERUP_SUPERLEAF
    .word ObjHit_DoNothing  ; Object $1F - OBJ_GROWINGVINE
    .word ObjHit_DoNothing  ; Object $20
    .word ObjHit_Card   ; Object $21 - OBJ_POWERUP_MUSHCARD
    .word ObjHit_Card   ; Object $22 - OBJ_POWERUP_FIRECARD
    .word ObjHit_Card   ; Object $23 - OBJ_POWERUP_STARCARD


    ; Object group $00 (i.e. objects starting at ID $00) attribute bits set 1 (OA1_* flags valid here)

    .base ObjectGroup_Attributes ; <-- help enforce this table *here*
ObjectGroup30_Attributes:
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH8  ; Object $00
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $01
    .byte OA1_PAL1 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $02
    .byte OA1_PAL1 | OA1_HEIGHT16 | OA1_WIDTH24 ; Object $03
    .byte OA1_PAL1 | OA1_HEIGHT32 | OA1_WIDTH16 ; Object $04
    .byte OA1_PAL2 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $05
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $06 - OBJ_BOUNCEDOWNUP
    .byte OA1_PAL0 | OA1_HEIGHT32 | OA1_WIDTH16 ; Object $07 - OBJ_WARPHIDE
    .byte OA1_PAL3 | OA1_HEIGHT32 | OA1_WIDTH16 ; Object $08 - OBJ_PSWITCHDOOR
    .byte OA1_PAL1 | OA1_HEIGHT16 | OA1_WIDTH24 ; Object $09 - OBJ_AIRSHIPANCHOR
    .byte OA1_PAL2 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $0A
    .byte OA1_PAL2 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $0B - OBJ_POWERUP_1UP
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $0C - OBJ_POWERUP_STARMAN
    .byte OA1_PAL1 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $0D - OBJ_POWERUP_MUSHROOM
    .byte OA1_PAL2 | OA1_HEIGHT32 | OA1_WIDTH24 ; Object $0E - OBJ_BOSS_KOOPALING
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH8  ; Object $0F
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH8  ; Object $10
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH8  ; Object $11
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH8  ; Object $12
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH8  ; Object $13
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH8  ; Object $14
    .byte OA1_PAL2 | OA1_HEIGHT32 | OA1_WIDTH16 ; Object $15 - OBJ_REX
    .byte OA1_PAL2 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $16 - OBJ_REX_SQUISHED
    .byte OA1_PAL3 | OA1_HEIGHT32 | OA1_WIDTH24 ; Object $17 - OBJ_SPINYCHEEP
    .byte OA1_PAL1 | OA1_HEIGHT48 | OA1_WIDTH32 ; Object $18 - OBJ_BOSS_BOWSER
    .byte OA1_PAL2 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $19 - OBJ_POWERUP_FIREFLOWER
    .byte OA1_PAL3 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $1A
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $1B - OBJ_BOUNCELEFTRIGHT
    .byte OA1_PAL1 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $1C
    .byte OA1_PAL1 | OA1_HEIGHT32 | OA1_WIDTH24 ; Object $1D
    .byte OA1_PAL1 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $1E - OBJ_POWERUP_SUPERLEAF
    .byte OA1_PAL2 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $1F - OBJ_GROWINGVINE
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH8  ; Object $20
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $21 - OBJ_POWERUP_MUSHCARD
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $22 - OBJ_POWERUP_FIRECARD
    .byte OA1_PAL0 | OA1_HEIGHT16 | OA1_WIDTH16 ; Object $23 - OBJ_POWERUP_STARCARD


    ; Object group $00 (i.e. objects starting at ID $00) second set attribute bits

    ; Attribute bits for objects:
    ;   Bits 0: If set, object is NOT a "shelled" enemy
    ;   Bits 1: Subtly modifies Player detection response; see comments in PRG000_D205
    ;   Bits 2: If set, object doesn't respond if stomped (indifferent, not same as attr 3, bit 5 which leads to hurting player)
    ;   Bits 3: Object uses 16-bit X value (otherwise, Object_XHi will be zeroed)
    ;   Bits 4-7: Pick root tile detection group offset (from Object_TileDetectOffsets)

    .base ObjectGroup_Attributes2    ; <-- help enforce this table *here*
ObjectGroup30_Attributes2:
    .byte OA2_TDOGRP0   ; Object $00
    .byte OA2_TDOGRP1   ; Object $01
    .byte OA2_TDOGRP1   ; Object $02
    .byte OA2_TDOGRP5   ; Object $03
    .byte OA2_TDOGRP2   ; Object $04
    .byte OA2_TDOGRP1   ; Object $05
    .byte OA2_TDOGRP1   ; Object $06 - OBJ_BOUNCEDOWNUP
    .byte OA2_TDOGRP0   ; Object $07 - OBJ_WARPHIDE
    .byte OA2_TDOGRP0   ; Object $08 - OBJ_PSWITCHDOOR
    .byte OA2_TDOGRP1   ; Object $09 - OBJ_AIRSHIPANCHOR
    .byte OA2_TDOGRP1   ; Object $0A
    .byte OA2_TDOGRP1   ; Object $0B - OBJ_POWERUP_1UP
    .byte OA2_TDOGRP1   ; Object $0C - OBJ_POWERUP_STARMAN
    .byte OA2_TDOGRP1   ; Object $0D - OBJ_POWERUP_MUSHROOM
    .byte OA2_TDOGRP6   ; Object $0E - OBJ_BOSS_KOOPALING
    .byte OA2_TDOGRP0   ; Object $0F
    .byte OA2_TDOGRP0   ; Object $10
    .byte OA2_TDOGRP0   ; Object $11
    .byte OA2_TDOGRP0   ; Object $12
    .byte OA2_TDOGRP0   ; Object $13
    .byte OA2_TDOGRP0   ; Object $14
    .byte OA2_TDOGRP2   ; Object $15 - OBJ_REX
    .byte OA2_TDOGRP1   ; Object $16 - OBJ_REX_SQUISHED
    .byte OA2_TDOGRP1   ; Object $17 - OBJ_SPINYCHEEP
    .byte OA2_STOMPDONTCARE | OA2_TDOGRP12  ; Object $18 - OBJ_BOSS_BOWSER
    .byte OA2_TDOGRP1   ; Object $19 - OBJ_POWERUP_FIREFLOWER
    .byte OA2_TDOGRP1   ; Object $1A
    .byte OA2_TDOGRP1   ; Object $1B - OBJ_BOUNCELEFTRIGHT
    .byte OA2_TDOGRP1   ; Object $1C
    .byte OA2_TDOGRP2   ; Object $1D
    .byte OA2_TDOGRP1   ; Object $1E - OBJ_POWERUP_SUPERLEAF
    .byte OA2_TDOGRP1   ; Object $1F - OBJ_GROWINGVINE
    .byte OA2_TDOGRP0   ; Object $20
    .byte OA2_TDOGRP1   ; Object $21 - OBJ_POWERUP_MUSHCARD
    .byte OA2_TDOGRP1   ; Object $22 - OBJ_POWERUP_FIRECARD
    .byte OA2_TDOGRP1   ; Object $23 - OBJ_POWERUP_STARCARD


    ; Object group $00 (i.e. objects starting at ID $00) third set attribute bits

    ; Attribute bits for objects:
    ;   Bits 0-3: Determines what to do when gameplay halted (see Object_DoHaltedAction, most common is 5 / 0101)
    ;   Bit 4: If set, enemy goes to "squashed" (state 7) after being stomped, otherwise it goes to "shelled" (state 3); in the case of being stomped by Kuribo's shoe or the Tanooki statue, squashed enemies still get sqashed, and otherwise they get "killed" (6)
    ;   Bit 5: Object is NOT stompable (e.g. a spikey enemy, HURTS PLAYER, not same as attr 2 bit 2 which is just indifferent)
    ;   Bit 6: The CollideJumpTable entry MAY contain the "special" entry; see CollideJumpTable; also "dies" into "shell" (state 3) (i.e. object "bumps" into shell when hit from beneath)
    ;   Bit 7: If set, object cannot be tail attacked

    .base ObjectGroup_Attributes3    ; <-- help enforce this table *here*
ObjectGroup30_Attributes3:
    .byte OA3_HALT_HOTFOOTSPECIAL   ; Object $00
    .byte OA3_HALT_JUSTDRAW | OA3_TAILATKIMMUNE ; Object $01
    .byte OA3_HALT_JUSTDRAW | OA3_TAILATKIMMUNE ; Object $02
    .byte OA3_HALT_JUSTDRAWWIDE     ; Object $03
    .byte OA3_HALT_JUSTDRAWTALL     ; Object $04
    .byte OA3_HALT_JUSTDRAW     ; Object $05
    .byte OA3_HALT_NORMALONLY | OA3_TAILATKIMMUNE   ; Object $06 - OBJ_BOUNCEDOWNUP
    .byte OA3_HALT_NORMALONLY | OA3_NOTSTOMPABLE | OA3_TAILATKIMMUNE    ; Object $07 - OBJ_WARPHIDE
    .byte OA3_HALT_NORMALONLY | OA3_NOTSTOMPABLE | OA3_TAILATKIMMUNE    ; Object $08 - OBJ_PSWITCHDOOR
    .byte OA3_HALT_JUSTDRAW     ; Object $09 - OBJ_AIRSHIPANCHOR
    .byte OA3_HALT_JUSTDRAW | OA3_TAILATKIMMUNE ; Object $0A
    .byte OA3_HALT_NORMALONLY | OA3_TAILATKIMMUNE   ; Object $0B - OBJ_POWERUP_1UP
    .byte OA3_HALT_NORMALONLY | OA3_TAILATKIMMUNE   ; Object $0C - OBJ_POWERUP_STARMAN
    .byte OA3_HALT_NORMALONLY | OA3_TAILATKIMMUNE   ; Object $0D - OBJ_POWERUP_MUSHROOM
    .byte OA3_HALT_NORMALONLY | OA3_TAILATKIMMUNE   ; Object $0E - OBJ_BOSS_KOOPALING
    .byte OA3_HALT_HOTFOOTSPECIAL   ; Object $0F
    .byte OA3_HALT_HOTFOOTSPECIAL   ; Object $10
    .byte OA3_HALT_HOTFOOTSPECIAL   ; Object $11
    .byte OA3_HALT_HOTFOOTSPECIAL   ; Object $12
    .byte OA3_HALT_HOTFOOTSPECIAL   ; Object $13
    .byte OA3_HALT_HOTFOOTSPECIAL   ; Object $14
    .byte OA3_HALT_JUSTDRAWTALL | OA3_SQUASH    ; Object $15 - OBJ_REX
    .byte OA3_HALT_JUSTDRAW | OA3_SQUASH        ; Object $16 - OBJ_REX_SQUISHED
    .byte OA3_HALT_NORMALONLY | OA3_NOTSTOMPABLE    ; Object $17 - OBJ_SPINYCHEEP
    .byte OA3_HALT_NORMALONLY | OA3_TAILATKIMMUNE   ; Object $18 - OBJ_BOSS_BOWSER
    .byte OA3_HALT_NORMALONLY | OA3_TAILATKIMMUNE   ; Object $19 - OBJ_POWERUP_FIREFLOWER
    .byte OA3_HALT_JUSTDRAW     ; Object $1A
    .byte OA3_HALT_NORMALONLY | OA3_TAILATKIMMUNE   ; Object $1B - OBJ_BOUNCELEFTRIGHT
    .byte OA3_HALT_JUSTDRAW | OA3_TAILATKIMMUNE ; Object $1C
    .byte OA3_HALT_DONOTHING    ; Object $1D
    .byte OA3_HALT_JUSTDRAW | OA3_TAILATKIMMUNE ; Object $1E - OBJ_POWERUP_SUPERLEAF
    .byte OA3_HALT_JUSTDRAWMIRROR | OA3_TAILATKIMMUNE   ; Object $1F - OBJ_GROWINGVINE
    .byte OA3_HALT_HOTFOOTSPECIAL   ; Object $20
    .byte OA3_HALT_JUSTDRAWMIRROR | OA3_TAILATKIMMUNE   ; Object $21 - OBJ_POWERUP_MUSHCARD
    .byte OA3_HALT_JUSTDRAWMIRROR | OA3_TAILATKIMMUNE   ; Object $22 - OBJ_POWERUP_FIRECARD
    .byte OA3_HALT_JUSTDRAWMIRROR | OA3_TAILATKIMMUNE   ; Object $23 - OBJ_POWERUP_STARCARD


    ; Object group $00 (i.e. objects starting at ID $00) Pattern Table Select

    .base ObjectGroup_PatTableSel    ; <-- help enforce this table *here*
ObjectGroup30_PatTableSel:
    .byte OPTS_NOCHANGE ; Object $00
    .byte OPTS_SETPT5 | $48 ; Object $01
    .byte OPTS_SETPT5 | $4C ; Object $02
    .byte OPTS_SETPT5 | $48 ; Object $03
    .byte OPTS_SETPT5 | $48 ; Object $04
    .byte OPTS_SETPT5 | $48 ; Object $05
    .byte OPTS_NOCHANGE ; Object $06 - OBJ_BOUNCEDOWNUP
    .byte OPTS_NOCHANGE ; Object $07 - OBJ_WARPHIDE
    .byte OPTS_SETPT6 | $13 ; Object $08 - OBJ_PSWITCHDOOR
    .byte OPTS_SETPT6 | $37 ; Object $09 - OBJ_AIRSHIPANCHOR
    .byte OPTS_SETPT5 | $48 ; Object $0A
    .byte OPTS_NOCHANGE ; Object $0B - OBJ_POWERUP_1UP
    .byte OPTS_NOCHANGE ; Object $0C - OBJ_POWERUP_STARMAN
    .byte OPTS_NOCHANGE ; Object $0D - OBJ_POWERUP_MUSHROOM
    .byte OPTS_NOCHANGE ; Object $0E - OBJ_BOSS_KOOPALING
    .byte OPTS_NOCHANGE ; Object $0F
    .byte OPTS_NOCHANGE ; Object $10
    .byte OPTS_NOCHANGE ; Object $11
    .byte OPTS_NOCHANGE ; Object $12
    .byte OPTS_NOCHANGE ; Object $13
    .byte OPTS_NOCHANGE ; Object $14
    .byte OPTS_NOCHANGE ; Object $15 - OBJ_REX
    .byte OPTS_NOCHANGE ; Object $16 - OBJ_REX_SQUISHED
    .byte OPTS_SETPT5 | $1A ; Object $17 - OBJ_SPINYCHEEP
    .byte OPTS_SETPT5 | $3A ; Object $18 - OBJ_BOSS_BOWSER
    .byte OPTS_NOCHANGE ; Object $19 - OBJ_POWERUP_FIREFLOWER
    .byte OPTS_NOCHANGE ; Object $1A
    .byte OPTS_NOCHANGE ; Object $1B - OBJ_BOUNCELEFTRIGHT
    .byte OPTS_NOCHANGE ; Object $1C
    .byte OPTS_SETPT5 | $48 ; Object $1D
    .byte OPTS_NOCHANGE ; Object $1E - OBJ_POWERUP_SUPERLEAF
    .byte OPTS_NOCHANGE ; Object $1F - OBJ_GROWINGVINE
    .byte OPTS_SETPT5 | $0A ; Object $20
    .byte OPTS_NOCHANGE ; Object $21 - OBJ_POWERUP_MUSHCARD
    .byte OPTS_NOCHANGE ; Object $22 - OBJ_POWERUP_FIRECARD
    .byte OPTS_NOCHANGE ; Object $23 - OBJ_POWERUP_STARCARD


    ; Object group $00 (i.e. objects starting at ID $00) "Kill Action"

    .base ObjectGroup_KillAction ; <-- help enforce this table *here*
ObjectGroup30_KillAction:
    .byte KILLACT_STANDARD  ; Object $00
    .byte KILLACT_STANDARD  ; Object $01
    .byte KILLACT_STANDARD  ; Object $02
    .byte KILLACT_STANDARD  ; Object $03
    .byte KILLACT_STANDARD  ; Object $04
    .byte KILLACT_STANDARD  ; Object $05
    .byte KILLACT_STANDARD  ; Object $06 - OBJ_BOUNCEDOWNUP
    .byte KILLACT_STANDARD  ; Object $07 - OBJ_WARPHIDE
    .byte KILLACT_STANDARD  ; Object $08 - OBJ_PSWITCHDOOR
    .byte KILLACT_STANDARD  ; Object $09 - OBJ_AIRSHIPANCHOR
    .byte KILLACT_STANDARD  ; Object $0A
    .byte KILLACT_JUSTDRAWMIRROR    ; Object $0B - OBJ_POWERUP_1UP
    .byte KILLACT_JUSTDRAWMIRROR    ; Object $0C - OBJ_POWERUP_STARMAN
    .byte KILLACT_JUSTDRAWMIRROR    ; Object $0D - OBJ_POWERUP_MUSHROOM
    .byte KILLACT_NORMALANDKILLED   ; Object $0E - OBJ_BOSS_KOOPALING
    .byte KILLACT_STANDARD  ; Object $0F
    .byte KILLACT_STANDARD  ; Object $10
    .byte KILLACT_STANDARD  ; Object $11
    .byte KILLACT_STANDARD  ; Object $12
    .byte KILLACT_STANDARD  ; Object $13
    .byte KILLACT_STANDARD  ; Object $14
    .byte KILLACT_JUSTDRAW16X32  ; Object $15 - OBJ_REX
    .byte KILLACT_JUSTDRAW16X16  ; Object $16 - OBJ_REX_SQUISHED
    .byte KILLACT_JUSTDRAW16X16 ; Object $17 - OBJ_SPINYCHEEP
    .byte KILLACT_NORMALSTATE   ; Object $18 - OBJ_BOSS_BOWSER
    .byte KILLACT_JUSTDRAWMIRROR    ; Object $19 - OBJ_POWERUP_FIREFLOWER
    .byte KILLACT_STANDARD  ; Object $1A
    .byte KILLACT_STANDARD  ; Object $1B - OBJ_BOUNCELEFTRIGHT
    .byte KILLACT_STANDARD  ; Object $1C
    .byte KILLACT_STANDARD  ; Object $1D
    .byte KILLACT_STANDARD  ; Object $1E - OBJ_POWERUP_SUPERLEAF
    .byte KILLACT_STANDARD  ; Object $1F - OBJ_GROWINGVINE
    .byte KILLACT_STANDARD  ; Object $20
    .byte KILLACT_STANDARD  ; Object $21 - OBJ_POWERUP_MUSHCARD
    .byte KILLACT_STANDARD  ; Object $22 - OBJ_POWERUP_FIRECARD
    .byte KILLACT_STANDARD  ; Object $23 - OBJ_POWERUP_STARCARD

.if INCLUDE_DINO == 1
    .include "PRG/enemies/rex.asm"
.endif

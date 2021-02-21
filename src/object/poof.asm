    ; Patterns selected by "poof" death frame
PoofDeath_Pats:
    .byte $47, $45, $41, $43

ObjState_PoofDying:
    LDA Objects_Timer,X
    BNE PRG000_CAAE  ; If object timer is not expired, jump to PRG000_CAAE

    JMP PRG000_D068  ; Jump to PRG000_D068 (Object_SetDeadEmpty)

PRG000_CAAE:
    JSR Object_AnySprOffscreen
    BNE PRG000_CAF0  ; If any sprite is off-screen, jump to PRG000_CAF0 (RTS)

    ; Set the "poof" pixel positions
    JSR Object_CalcSpriteXY_NoHi
    LDY Object_SprRAM,X
    LDA object_sprite_y,X
    STA Sprite_RAM+$00,Y
    STA Sprite_RAM+$04,Y
    LDA object_sprite_x,X
    STA Sprite_RAM+$03,Y
    CLC
    ADC #$08
    STA Sprite_RAM+$07,Y

    LDA Objects_Timer,X
    LSR A
    LSR A
    LSR A
    TAX      ; X = "poof" frame

    ; Set "poof" death patterns
    LDA PoofDeath_Pats,X
    STA Sprite_RAM+$01,Y
    STA Sprite_RAM+$05,Y

    ; Set the attributes
    LDA Level_NoStopCnt
    LSR A
    LSR A
    ROR A
    AND #$80
    ORA #$01
    STA Sprite_RAM+$02,Y

    EOR #$c0
    STA Sprite_RAM+$06,Y

    LDX object_index     ; X = object slot index

PRG000_CAF0:
    RTS      ; Return
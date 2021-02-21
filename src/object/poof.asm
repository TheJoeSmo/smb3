    ; Patterns selected by "poof" death frame
object_poof_pattern:
    .byte $47, $45, $41, $43

object_poof:
    LDA objects_timer, x
    BNE +
    JMP Object_SetDeadEmpty     ; Object is completely dead

+
    JSR Object_AnySprOffscreen
    BNE +return  ; Only draw the poof if it is on the screen

; Set the "poof" pixel positions
    JSR Object_CalcSpriteXY_NoHi
    LDY objects_sprite_offset,x
    LDA object_sprite_y,x
    STA sprite_data_y,y
    STA sprite_data_y+4,y
    LDA object_sprite_x,x
    STA sprite_data_x,y
    CLC
    ADC #$08
    STA sprite_data_x+4,y

; Set pattern for the poof by the timer
    LDA objects_timer,x
    LSR A
    LSR A
    LSR A
    TAX
    LDA object_poof_pattern,x
    STA sprite_data_graphic,y
    STA sprite_data_graphic+4,y

; Set the attributes
    LDA Level_NoStopCnt
    LSR A
    LSR A
    ROR A
    AND #$80
    ORA #$01
    STA sprite_data_attributes,y
    EOR #$C0
    STA sprite_data_attributes+4,y

    LDX object_index     ; Reload the object index

+return:
    RTS      ; Return
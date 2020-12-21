    ; Patterns for TIME-UP
timeup_sprite_pattern:
    .byte $21   ; T
    .byte $23   ; I
    .byte $25   ; M
    .byte $27   ; E
    .byte $29   ; -
    .byte $1D   ; U
    .byte $1F   ; P

    ; X positions for each letter in TIME-UP
timeup_horizontal_positions:
    .byte $60, $68, $70, $78, $80, $88, $90

Player_Die_TimeUp:
    LDA is_above_level
    BNE +
        ; Don't jump to next part of the program until we are under the status bar
        LDA player_sprite_y
        AND #$F0
        CMP #$B0
        BEQ ++

+
; Apply the upward momentum untill counter hits 0
    LDA event_counter
    BNE +
    JMP player_apply_death_gravity
+
    JMP player_draw_death  ; Jump to player_apply_death_gravity if event_counter <> 0

++
    DEC player_pipe_y

    LDA player_pipe_x
    CMP #$60
    BLT +  ; If player_pipe_x < $60, jump to +
        CLC
        ADC player_pipe_y
        STA player_pipe_x

        LDA #112
        STA event_counter  ; event_counter = 112

+
    LDA event_counter
    BEQ player_die_offscreen

; Load timeup sprites
    LDA #$32
    STA PatTable_BankSel+2

    LDY #$06
    LDX player_sprite_offset

-
    ; Loop through and set sprite attributes
        LDA player_pipe_x
        STA sprite_data_y, x
        LDA timeup_sprite_pattern, y
        STA sprite_data_graphic, x
        LDA #$01
        STA sprite_data_attributes, x
        LDA timeup_horizontal_positions, y
        STA sprite_data_x, x

        INX
        INX
        INX
        INX
        DEY
    BPL -

    RTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Player_GetTileAndSlope
;
; Gets tile and attribute of tile for either non-vertical or
; vertical levels based on Player's position
;
; _player_y_offset is a Y offset (e.g. 0 for Player's feet, 31 for Player's head)
; _player_x_offset is an X offset
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_player_y_offset = Temp_Var10
_player_x_offset = Temp_Var11
__player_y_hi = Temp_Var13
__player_y_lo = Temp_Var14
__player_x_hi = Temp_Var15
__player_x_lo = Temp_Var16

Player_GetTileAndSlope:

    LDA #$00
    STA temp_17

    LDA is_vertical
    BNE player_get_vertical_tile

    LDA player_partition_detection
    BEQ +

; Bottom two tile rows forced detection enabled when Player Y >= 160...

    LDA is_above_level
    BNE +  ; If Player is above top of screen, jump to +

; Get the value of the player y + offset (the distance to the top of mario) - the vertical scroll
    LDA player_y
    CLC
    ADC _player_y_offset
    SEC
    SBC vertical_scroll_lo

    CMP #160
    BLT +

; The player is inside the partition (bottom 2 rows of tiles)

    SBC #16
    AND #$F0            ; Align to tile grid
    STA __player_y_lo

    LDA #$01
    STA __player_y_hi   ; The hi y value will always be 1 (bottom of the screen)
    STA temp_17         ; temp_17 = 1

    BNE ++      ; JMP ++

+

; Normal setup

; Get the player y value
    LDA player_y_hi
    STA __player_y_hi

    LDA _player_y_offset
    CLC
    ADC player_y
    STA __player_y_lo
    BCC ++
    INC __player_y_hi   ; Apply carry

++
    LDA __player_y_hi
    BEQ ++  ; If __player_y_hi (high byte / carry) = 0, jump to ++

; Check if the player is above the level
    CMP #$01
    BNE +   ; Horizontal levels are from 0-1, so a different value is invalid

    LDA __player_y_lo
    CMP #$B0
    BLT ++  ; The player is below the level at y 1B0 (this number repeats a lot) 

+
; The player is below the level
    LDA #$00
    STA player_slope
    RTS

++
; The player is inside the level
    LDA player_x_hi
    STA __player_x_hi

    LDA _player_x_offset
    BPL +  ; Check if the offset is negative or not
    DEC __player_x_hi

+
; Add the offset to the player x (the distance from the center of the player)
    LDA player_x
    CLC
    ADC _player_x_offset
    STA __player_x_lo
    BCC +  
    INC __player_x_hi  ; Apply carry

+

    ; So in total we've calculated:
    ; __player_y_hi / __player_y_lo -- Y Hi and Lo
    ; __player_x_hi / __player_x_lo -- X Hi and Lo
    ; X/Y were not modified, so as inputs:
    ; X = 0 (going down) or 1 (going up)
    ; Y = player_yVel

    STY _player_y_offset  ; _player_y_offset = player_yVel
    STX _player_x_offset  ; _player_x_offset = 0 or 1

    JSR Player_GetTileAndSlope_Normal    ; Set Level_Tile and player_slope

    LDX _player_x_offset     ; _player_x_offset = 0 (going down) or 1 (going up)
    LDY pipe_movement
    BNE + 

; Don't substitute p switch attributes if we're inside a pipe
    JSR PSwitch_SubstTileAndAttr        ; Otherwise, substitute the tile if effected by P-Switch

+
    LDY _player_y_offset  ; Restore y velocity
    RTS

player_get_vertical_tile:
    LDA player_y_hi
    STA __player_y_hi

    LDA _player_y_offset
    CLC
    ADC player_y
    STA __player_y_lo
    BCC +
    INC __player_y_hi   ; Add carry

+
    LDA __player_y_hi
    BPL +

; If under the level return
    LDA #$00
    RTS

+
    LDA player_x
    CLC
    ADC _player_x_offset
    STA __player_x_lo

    STY _player_y_offset

    JSR Player_GetTileV  ; Get tile, set Level_Tile

    LDY pipe_movement   ; Y = pipe_movement
    BNE +

; Don't set p switch attributes if we're in a pipe
    JSR PSwitch_SubstTileAndAttr

+
    LDY #$00
    STY __player_x_hi

    LDY _player_y_offset
    RTS
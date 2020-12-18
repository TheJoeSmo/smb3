;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Level_CheckIfTileUnderwater
;
; Checks the head or left block based on the X register
; Uses underwater_tileset_offset as an index into level_underwater_tsa_attributes
;
; The result can be overridden if the proper bit in
; is_above_below_water is set, which will force the
; report to say underwater...
;
; CARRY: The "carry flag" will be set and the input tile not
; otherwise tested if the tile is in the "solid floor" region!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
___head_block = Temp_Var1
___left_block = Temp_Var2
underwater_tileset_offset = Temp_Var3

Level_CheckIfTileUnderwater:

    ; X = 0 or 1

    LDY #$01
    STY ___head_block5  ; ___head_block5 = 1 (Indicates underwater)

; Add water partition if needed (Automagically add water partition at the bottom)
    LDA is_above_below_water
    AND FloatLevel_StatCheck, x
    BNE +

    LDA ___head_block, x
    ASL A
    ROL A
    ROL A
    AND #$03
    TAY      ; Y = Quadrant of tile (i.e. 0-3 for $00, $40, $80, $C0)

; Check if we're inside a solid tile.  Cannot be in water if inside a solid tile
    LDA ___head_block, x
    CMP Tile_AttrTable, y
    BGE ++

; Additional check to include the pressed p switch if 
    CMP #TILEA_PSWITCH_PRESSED
    BNE +++
; P switch is pressed
    LDY #$00    ; Not underwater
    BEQ ++++    ; JMP ++++

+++

; Get the tileset offset + tileset attribute offset
    TYA
    ORA underwater_tileset_offset
    TAY

; Get the minimum tile value for this quadrant which is considered
; underwater (NOTE: If there are no underwater tiles in this quadrant,
; the mostly unreachable value of $FF is what we get here)
    LDA level_underwater_tsa_attributes, y

; Not underwater of A > head_block, x
    LDY #$00
    CMP ___head_block, x
    BGE ++++

; We are underwater
    INY      ; Y = 1 (Underwater)

    LDA ___head_block, x

; Check if we are in a waterfall
    CMP #TILE1_WFALLTOP
    BEQ +++
    CMP #TILE1_WFALLMID
    BNE ++++

+++
    INY      ; Y = 2 (In waterfall)

++++
    STY Temp_Var15  ; Store Y -> ___head_block5 (0, 1, or 2)

+
    CLC      ; Clear carry (tile was not in the solid floor region)

++
    RTS      ; Return

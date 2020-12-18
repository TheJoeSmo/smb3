; Custom macro for figuring out if a tile is solid
; this is to provide consistency
;
; BLT = air (tile < attr)
; BGE = solid/semi-solid (tile >= attr)
;
;Tile_Attributes_TSX:
;                            ; ranges for air           ; 00 - 24, 40 - 4F, 80 - 9F, C0 - D9
;   .byte $25, $50, $A0, $E2 ; ranges for semi-solid    ; 25 - 2D, 50 - 53, A0 - AD, E2 - F0
;   .byte $2D, $53, $AD, $F0 ; ranges for solid         ; 2D - 3F, 53 - 7F, AD - BF, F0 - FF
;
; This combines with Level_MinTileUWByQuad for water.
; For plains it is these values...
;   .byte $FF, $FF, $FF, $DA ; ranges for water         ; FF - FF, FF - FF, FF - FF, DA - E1
;

    macro if_solid
    PHA
    AND #$c0
    CLC
    ROL A
    ROL A
    ROL A
    TAY                 ; y = tile quadrant (0 to 3)

    PLA
    CMP Tile_AttrTable+4, y
    endm

    macro if_semi_solid
    PHA
    AND #$c0
    CLC
    ROL A
    ROL A
    ROL A
    TAY                 ; y = tile quadrant (0 to 3)

    PLA
    CMP Tile_AttrTable, y 
    endm

    macro ADD_WORD lo, hi
    CLC
    ADC lo
    STA lo
    BCC +++++           ; if no carry jump
    INC hi
+++++
    endm

    macro ADD_WORD_BIG lo, hi, value
    LDA lo
    CLC
    ADC #(value & $00FF)
    STA lo
    LDA hi
    ADC #((value & $FF00) >> 8)
    STA hi
    endm

    macro ADD_WORD_BIG_TO_VAR in_lo, in_hi, out_lo, out_hi, value
    LDA lo
    CLC
    ADC #(value & $00FF)
    STA out_lo
    LDA hi
    ADC #((value & $FF00) >> 8)
    STA out_hi
    endm
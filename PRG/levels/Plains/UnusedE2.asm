; Original address was $B773
; Lonely pipe exit area
    .word $0000 ; Alternate level layout
    .word $0000 ; Alternate object layout
    .byte LEVEL1_SIZE_02 | LEVEL1_YSTART_170
    .byte LEVEL2_BGPAL_00 | LEVEL2_OBJPAL_08 | LEVEL2_XSTART_18
    .byte LEVEL3_TILESET_01 | LEVEL3_VSCROLL_LOCKLOW | LEVEL3_PIPENOTEXIT
    .byte LEVEL4_BGBANK_INDEX(1) | LEVEL4_INITACT_NOTHING
    .byte LEVEL5_BGM_OVERWORLD | LEVEL5_TIME_300

    .byte $1A, $00, $C0, $1F, $38, $07, $A1, $40, $0B, $09, $FF

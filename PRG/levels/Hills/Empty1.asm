; Original address was $A7CD
; Empty/unused 1
    .word $0000 ; Alternate level layout
    .word $0000 ; Alternate object layout
    .byte LEVEL1_SIZE_04 | LEVEL1_YSTART_0B0
    .byte LEVEL2_BGPAL_00 | LEVEL2_OBJPAL_08 | LEVEL2_XSTART_18
    .byte LEVEL3_TILESET_03 | LEVEL3_VSCROLL_FREE | LEVEL3_PIPENOTEXIT
    .byte LEVEL4_BGBANK_INDEX(3) | LEVEL4_INITACT_NOTHING
    .byte LEVEL5_BGM_UNDERGROUND | LEVEL5_TIME_300

    .byte $FF

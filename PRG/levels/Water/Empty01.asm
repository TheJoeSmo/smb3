; Original address was $AB8D
; Empty/unused
    .word W701L ; Alternate level layout
    .word W701O ; Alternate object layout
    .byte LEVEL1_SIZE_08 | LEVEL1_YSTART_040
    .byte LEVEL2_BGPAL_00 | LEVEL2_OBJPAL_08 | LEVEL2_XSTART_18
    .byte LEVEL3_TILESET_01 | LEVEL3_VSCROLL_LOCKLOW | LEVEL3_PIPENOTEXIT
    .byte LEVEL4_BGBANK_INDEX(6) | LEVEL4_INITACT_NOTHING
    .byte LEVEL5_BGM_UNDERWATER | LEVEL5_TIME_300

    .byte $FF

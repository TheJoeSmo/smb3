; Original address was $BE47
; Bowser's castle "wrong way" and alternate routes
    .word W8BCL ; Alternate level layout
    .word W8BCO ; Alternate object layout
    .byte LEVEL1_SIZE_15 | LEVEL1_YSTART_170
    .byte LEVEL2_BGPAL_04 | LEVEL2_OBJPAL_08 | LEVEL2_XSTART_18
    .byte LEVEL3_TILESET_02 | LEVEL3_VSCROLL_LOCKED | LEVEL3_PIPENOTEXIT
    .byte LEVEL4_BGBANK_INDEX(2) | LEVEL4_INITACT_NOTHING
    .byte LEVEL5_BGM_FORTRESS | LEVEL5_TIME_300

    .byte $4E, $00, $AA, $24, $6E, $2D, $3A, $C2, $79, $60, $31, $1F, $79, $C0, $31, $2F
    .byte $6E, $00, $D6, $10, $75, $00, $D3, $01, $79, $00, $D1, $2C, $17, $03, $00, $E0
    .byte $68, $20, $6E, $11, $D0, $02, $6E, $14, $D1, $CF, $70, $1E, $D0, $20, $71, $1F
    .byte $D0, $1D, $72, $14, $D6, $05, $73, $1A, $D5, $00, $74, $1B, $D4, $00, $75, $1C
    .byte $D3, $00, $76, $1D, $D2, $00, $77, $1E, $D1, $00, $78, $1F, $D0, $00, $72, $20
    .byte $D0, $1B, $73, $21, $D0, $19, $74, $22, $D0, $18, $75, $25, $D3, $0F, $17, $40
    .byte $E1, $00, $18, $45, $E0, $00, $16, $4C, $E2, $00, $15, $40, $05, $16, $45, $05
    .byte $14, $4C, $05, $11, $42, $63, $70, $51, $D0, $0E, $71, $53, $D0, $0A, $72, $54
    .byte $D0, $08, $73, $55, $D1, $06, $78, $5E, $D0, $00, $77, $5F, $D3, $01, $17, $52
    .byte $E1, $00, $15, $52, $05, $16, $56, $61, $7A, $61, $40, $1A, $11, $64, $65, $11
    .byte $6C, $71, $77, $65, $E1, $78, $6C, $E1, $70, $7D, $D3, $07, $73, $7C, $D0, $00
    .byte $79, $7B, $D1, $04, $11, $7C, $05, $74, $72, $E1, $77, $77, $E0, $6F, $85, $DB
    .byte $07, $6F, $8D, $D9, $07, $77, $81, $D3, $03, $78, $80, $D2, $00, $15, $83, $00
    .byte $E8, $58, $1C, $6F, $95, $D6, $09, $70, $9F, $D0, $05, $71, $9F, $D0, $02, $72
    .byte $9F, $D0, $01, $73, $9F, $D0, $00, $70, $AD, $D0, $08, $71, $AF, $D0, $05, $75
    .byte $A9, $D0, $00, $76, $A8, $D0, $02, $77, $A7, $D0, $04, $78, $A3, $D0, $09, $11
    .byte $A7, $61, $13, $A9, $05, $16, $A3, $05, $34, $AC, $01, $72, $B1, $D0, $01, $73
    .byte $B1, $D1, $00, $75, $B0, $D0, $01, $77, $B4, $D1, $00, $74, $BD, $D0, $06, $75
    .byte $BC, $D0, $07, $76, $BB, $D0, $08, $77, $BA, $D0, $09, $78, $B9, $D0, $0A, $79
    .byte $B9, $D1, $0E, $11, $BA, $62, $13, $B0, $05, $13, $BC, $05, $15, $B4, $05, $70
    .byte $C5, $D0, $02, $71, $C6, $D5, $00, $11, $CA, $71, $78, $CC, $D0, $00, $7A, $C8
    .byte $40, $1C, $75, $DC, $D0, $00, $77, $D2, $D0, $01, $78, $D9, $D0, $00, $12, $D2
    .byte $61, $11, $DA, $71, $6F, $E4, $D1, $0B, $71, $E6, $D1, $09, $73, $E6, $D0, $01
    .byte $74, $E5, $D0, $01, $73, $EF, $D2, $00, $76, $EC, $D0, $03, $77, $EB, $D0, $04
    .byte $78, $EA, $D0, $05, $79, $E4, $D1, $0B, $78, $E0, $D0, $00, $12, $E5, $05, $14
    .byte $ED, $00, $EE, $58, $1E, $FF

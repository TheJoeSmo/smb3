; Original address was $ADCD
; "Unused Level 11"
    .word $0000 ; Alternate level layout
    .word $0000 ; Alternate object layout
    .byte LEVEL1_SIZE_11 | LEVEL1_YSTART_170
    .byte LEVEL2_BGPAL_00 | LEVEL2_OBJPAL_08 | LEVEL2_XSTART_18 | LEVEL2_UNUSEDFLAG
    .byte LEVEL3_TILESET_04 | LEVEL3_VSCROLL_LOCKLOW
    .byte LEVEL4_BGBANK_INDEX(4) | LEVEL4_INITACT_NOTHING
    .byte LEVEL5_BGM_ATHLETIC | LEVEL5_TIME_300

    .byte $19, $00, $68, $18, $02, $42, $18, $0A, $22, $1A, $0B, $04, $15, $0D, $22, $17
    .byte $0E, $04, $11, $0F, $24, $30, $10, $82, $19, $11, $63, $13, $11, $04, $36, $12
    .byte $00, $38, $12, $81, $36, $15, $62, $16, $19, $24, $15, $1A, $42, $18, $1A, $04
    .byte $18, $1C, $04, $31, $1F, $82, $36, $20, $61, $13, $23, $10, $03, $19, $23, $63
    .byte $12, $24, $41, $14, $24, $04, $36, $25, $10, $31, $2A, $60, $30, $2C, $82, $11
    .byte $2C, $10, $02, $35, $2C, $80, $18, $2C, $40, $19, $2C, $62, $12, $2D, $04, $35
    .byte $2E, $80, $18, $2E, $40, $11, $31, $10, $02, $12, $32, $04, $34, $35, $23, $19
    .byte $34, $65, $18, $35, $42, $24, $3A, $30, $07, $3A, $F2, $24, $3B, $0A, $0C, $3B
    .byte $F3, $2A, $3C, $82, $16, $3C, $61, $12, $40, $02, $12, $46, $03, $12, $4B, $02
    .byte $12, $4E, $03, $13, $40, $10, $06, $36, $40, $22, $19, $40, $63, $24, $41, $82
    .byte $07, $41, $F2, $29, $42, $83, $0B, $42, $F3, $39, $46, $60, $17, $48, $22, $19
    .byte $49, $04, $13, $4B, $10, $03, $27, $4C, $84, $15, $50, $23, $14, $51, $42, $19
    .byte $51, $64, $17, $51, $04, $0B, $52, $F9, $38, $52, $82, $36, $68, $60, $11, $6A
    .byte $2A, $36, $6A, $10, $13, $6B, $04, $36, $6C, $10, $36, $6E, $10, $36, $70, $10
    .byte $19, $71, $63, $36, $72, $00, $18, $72, $40, $13, $73, $04, $36, $74, $30, $18
    .byte $74, $40, $36, $76, $31, $39, $76, $10, $11, $76, $25, $13, $79, $04, $19, $78
    .byte $62, $38, $7C, $60, $11, $7D, $22, $13, $7E, $04, $19, $82, $61, $35, $86, $17
    .byte $19, $86, $63, $18, $87, $41, $19, $8B, $62, $17, $90, $61, $17, $93, $61, $19
    .byte $96, $6F, $18, $98, $45, $19, $A6, $6F, $40, $A0, $09, $FF

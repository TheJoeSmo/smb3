    .word $BD33 ; Alternate level layout
    .word $C55B ; Alternate object layout
    .byte LEVEL1_SIZE_08 | LEVEL1_YSTART_140
    .byte LEVEL2_BGPAL_00 | LEVEL2_OBJPAL_08 | LEVEL2_XSTART_18 | LEVEL2_UNUSEDFLAG
    .byte LEVEL3_TILESET_01 | LEVEL3_VSCROLL_LOCKLOW | LEVEL3_PIPENOTEXIT
    .byte LEVEL4_BGBANK_INDEX(19) | LEVEL4_INITACT_NOTHING
    .byte LEVEL5_BGM_ATHLETIC | LEVEL5_TIME_300

    .byte $40, $00, $0E, $56, $00, $B2, $07, $52, $06, $B3, $01, $95, $02, $D2, $53, $0A
    .byte $0B, $56, $0A, $B3, $03, $56, $0F, $B2, $06, $2B, $0F, $40, $35, $0F, $0C, $4E
    .byte $10, $01, $95, $10, $D2, $55, $18, $B3, $01, $AD, $1B, $32, $51, $1E, $B8, $02
    .byte $35, $15, $10, $2E, $1F, $0A, $4F, $1F, $E0, $50, $1F, $E0, $52, $25, $B7, $01
    .byte $54, $29, $B5, $00, $AF, $27, $32, $56, $2E, $B3, $03, $33, $2F, $82, $54, $22
    .byte $B0, $00, $35, $30, $0B, $36, $34, $10, $57, $34, $B2, $05, $54, $35, $0B, $32
    .byte $36, $82, $2C, $39, $40, $36, $39, $0C, $B0, $3A, $32, $57, $3C, $B2, $03, $33
    .byte $3D, $82, $36, $3D, $31, $2F, $37, $81, $57, $42, $B3, $03, $2C, $43, $40, $34
    .byte $43, $0C, $96, $43, $D2, $AB, $46, $32, $53, $48, $0A, $57, $48, $B2, $04, $55
    .byte $4D, $B4, $02, $2F, $41, $81, $2F, $44, $81, $AD, $50, $32, $51, $52, $B8, $01
    .byte $4E, $57, $B2, $03, $4E, $5B, $B0, $01, $51, $57, $B1, $00, $56, $57, $B2, $02
    .byte $55, $5A, $B3, $09, $8D, $58, $D1, $32, $59, $82, $4E, $5D, $B2, $02, $94, $5D
    .byte $D4, $32, $5F, $82, $4F, $60, $B1, $0A, $32, $63, $82, $8E, $64, $D3, $56, $64
    .byte $B3, $05, $54, $66, $08, $32, $67, $82, $4F, $6A, $B2, $01, $33, $6A, $80, $55
    .byte $6A, $B4, $01, $31, $6B, $13, $53, $6C, $B6, $03, $2C, $69, $0B, $2D, $69, $10
    .byte $2E, $69, $10, $55, $64, $B0, $05, $51, $70, $B8, $0F, $4E, $71, $0B, $4D, $75
    .byte $0A, $AA, $78, $32, $2F, $7B, $E2, $40, $7E, $BF, $01, $50, $7E, $B6, $01, $E7
    .byte $53, $30, $59, $00, $81, $80, $FF

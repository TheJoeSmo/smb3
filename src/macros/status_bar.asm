;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/19/2020
; A macro to help make the status bar in various locations in the PPU
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.macro StatusBar _base_addr

    ; Sync next three with PRG026 Flip_TopBarCards
    DBYT _base_addr + $00
    .byte $02, $FC, $A0     ; Upper left corner

    DBYT _base_addr + $02
    .byte VU_REPEAT | $12, $A1  ; Bar across the top

    DBYT _base_addr + $14
    .byte $0C, $A2, $A0, $A1, $A1, $A3, $A1, $A1, $A3, $A1, $A1, $A2, $FC   ; top of card slots

    ; Sync this with PRG026 Flip_MidTStatCards
    DBYT _base_addr + $20
    .byte $20, $FC, $A6, $70, $71, $72, $73, $FE, $FE, $EF, $EF, $EF, $EF, $EF, $EF, $3C    ; |WORLD  >>>>>>[P] $  | |  | |  | |  | |
    .byte $3D, $FE, $EC, $F0, $F0, $A7, $A6, $FE, $FE, $AA, $FE, $FE, $AA, $FE, $FE, $A7, $FC
    ; Discrepency --------^  (Pattern is ... $FE, $F0 ... in PRG026 status bar graphics)

    ; Sync this with PRG026 Flip_MidBStatCards
    DBYT _base_addr + $40
    ; Discrepency --------v  (Pattern is ... $FE, $FE ... in PRG030 status bar)  Unimportant; inserts <M> which is replaced anyway
    .byte $20, $FC, $A6, $FE, $FE, $FB, $FE, $F3, $FE, $F0, $F0, $F0, $F0, $F0, $F0, $F0    ; [M/L]x  000000 c000| etc.
    .byte $FE, $ED, $F4, $F0, $F0, $A7, $A6, $FE, $FE, $AA, $FE, $FE, $AA, $FE, $FE, $A7, $FC
    ; Discrepency --------^  (Pattern is ... $F4, $F0 ... in PRG030 status bar graphics)

    ; Sync next three with PRG026 Flip_BottomBarCards
    DBYT _base_addr + $60
    .byte $02, $FC, $A8 ; Lower corner

    DBYT _base_addr + $62
    .byte VU_REPEAT | $12, $A4  ; Bottom bar

    DBYT _base_addr + $74
    .byte $0C, $A5, $A8, $A4, $A4, $A9, $A4, $A4, $A9, $A4, $A4, $A5, $FC   ; lower corner and card bottoms

    ; End PRG026 sync

    DBYT _base_addr + $80
    .byte VU_REPEAT | $20, $FC  ; black space

    DBYT _base_addr + $A0
    .byte VU_REPEAT | $20, $FC  ; black space

    ; Terminator
    .byte $00
    .endm
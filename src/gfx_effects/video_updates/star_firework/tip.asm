;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/19/2020
; The tip and eyes of the star firework at the end of the level
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Video_3CMStarTip:
    DBYT $2128
    .byte $01, $A9
    DBYT $2137
    .byte $01, $A9
    DBYT $2149
    .byte $01, $A9
    DBYT $214E
    .byte VU_VERT | VU_REPEAT | $03, $A9
    DBYT $2151
    .byte VU_VERT | VU_REPEAT | $03, $A9
    DBYT $2156
    .byte $01, $A9
    .byte $00   ; Terminator
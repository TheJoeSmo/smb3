;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/19/2020
; The secondary partition of the bottom of the star firework
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Video_3CMStarBot2:
    DBYT $2248
    .byte $05, $A9, $FC, $FC, $A9, $A9
    DBYT $2253
    .byte $05, $A9, $A9, $FC, $FC, $A9
    DBYT $2268
    .byte VU_REPEAT | $03, $A9
    DBYT $2275
    .byte VU_REPEAT | $03, $A9
    .byte $00   ; Terminator
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/19/2020
; The main partition of the bottom of the star firework
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Video_3CMStarBot1:
    DBYT $2209
    .byte VU_VERT | VU_REPEAT | $02, $A9
    DBYT $220F
    .byte VU_REPEAT | $42, $A9
    DBYT $2216
    .byte VU_VERT | VU_REPEAT | $02, $A9
    DBYT $222D
    .byte VU_REPEAT | $02, $A9
    DBYT $2231
    .byte VU_REPEAT | $02, $A9
    .byte $00   ; Terminator
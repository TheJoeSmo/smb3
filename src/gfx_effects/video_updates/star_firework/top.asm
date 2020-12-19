;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/19/2020
; The top of the star firework at the end of the level
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Video_3CMStarTop:
    DBYT $208F
    .byte VU_REPEAT | $02, $A9
    DBYT $20AE
    .byte VU_VERT | VU_REPEAT | $02, $A9
    DBYT $20B1
    .byte VU_VERT | VU_REPEAT | $02, $A9
    DBYT $20ED
    .byte $01, $A9
    DBYT $20F2
    .byte $01, $A9
    DBYT $2108
    .byte VU_REPEAT | $06, $A9
    DBYT $2112
    .byte VU_REPEAT | $06, $A9
    .byte $00   ; Terminator
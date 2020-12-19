;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/19/2020
; The side of the star firework
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Video_3CMStarSide:
    DBYT $216A
    .byte $01, $A9
    DBYT $2175
    .byte $01, $A9
    DBYT $218B
    .byte VU_VERT | VU_REPEAT | $02, $A9
    DBYT $2194
    .byte VU_VERT | VU_REPEAT | $02, $A9
    DBYT $21CA
    .byte VU_VERT | VU_REPEAT | $02, $A9
    DBYT $21D5
    .byte VU_VERT | VU_REPEAT | $02, $A9
    .byte $00   ; Terminator
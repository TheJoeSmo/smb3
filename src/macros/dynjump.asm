;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/19/2020
; A quicker implementation of the dynjump routine
; Uses a double lookup table compared to a single lookup
; Allows for relatively few reads and little loss in efficiency
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    .macro quick_dynjump _hi_tbl, _lo_tbl
        TAY
        LDA _lo_tbl, y
        STA Temp_Var1
        LDA _hi_tbl, y
        STA Temp_Var2
        JMP (Temp_Var1)
    .endm
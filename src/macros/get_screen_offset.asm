;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/18/2020
; Get the screen offset in block memory
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    .macro get_screen_offset
        AND #$F0
        LSR A
        LSR A
        LSR A
        TAY
        LDA block_screen_offsets,Y
        STA _block_data_pointer
        LDA block_screen_offsets+1,Y
        STA _block_data_pointer+1
    .endm
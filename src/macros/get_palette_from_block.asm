;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/18/2020
; Gets the palette of a given block
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    .macro get_palette_from_block
        LDA (_block_data_pointer), y
        AND #$C0
    .endm
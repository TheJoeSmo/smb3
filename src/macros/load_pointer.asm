;;;;;;;;;;;;;;;;;;;;;;;
; Load a given pointer into an address
; Joe Smo 12/21/2020
;;;;;;;;;;;;;;;;;;;;;;;

    .macro load_pointer pointer_address, ram_address
        LDA <pointer_address
        STA ram_address
        LDA >pointer_address
        STA ram_address+1
    .endm
    
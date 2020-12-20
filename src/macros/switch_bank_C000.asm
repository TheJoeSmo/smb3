;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/19/2020
; Switch bank C000 - Switch the bank and remember the bank switch
; Switch bank C000 dirty - Switch the bank, but can be reset for nmi's and irq's
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    .macro switch_bank_C000 bank
        LDA #bank
        STA PAGE_C000
        JSR PRGROM_Change_C000
    .endm

    .macro switch_bank_C000_dirty bank
        LDA #MMC3_8K_TO_PRG_C000
        STA MMC3_COMMAND
        LDA #bank
        STA MMC3_PAGE
    .endm
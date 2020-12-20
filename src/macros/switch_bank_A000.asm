;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/19/2020
; Switch bank A000 - Switch the bank and remember the bank switch
; Switch bank A000 dirty - Switch the bank, but can be reset for nmi's and irq's
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    .macro switch_bank_A000 bank
        LDA #bank
        STA PAGE_A000
        JSR PRGROM_Change_A000
    .endm

    .macro switch_bank_A000_dirty bank
        LDA #MMC3_8K_TO_PRG_A000
        STA MMC3_COMMAND
        LDA #bank
        STA MMC3_PAGE
    .endm
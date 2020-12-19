
    .macro switch_bank_A000 bank
        LDA #bank
        STA PAGE_A000
        JSR PRGROM_Change_A000
    .endm
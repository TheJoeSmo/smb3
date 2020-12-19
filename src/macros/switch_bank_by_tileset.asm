
    .macro switch_bank_by_tileset
        LDY tileset_num
        LDA TileLayoutPage_ByTileset, y
        STA PAGE_A000
        JSR PRGROM_Change_A000
    .endm
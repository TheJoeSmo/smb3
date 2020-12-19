;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Scroll_Dirty_Update
;
; This function performs a full-screen redraw of all tiles,
; used when first showing map/level, but not for scrolling!
; (Though it does call the same routine USED for scrolling)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
scroll_last_direction_offset:
    .byte $08, $F8

scroll_left_right_offset:
    .byte $01, $FF

scroll_left_right_endian:
    .byte $00, $08

Scroll_Dirty_Update:
redraw_entire_screen:
    LDA is_vertical
    BNE redraw_entire_vertical_screen

@redraw_entire_vertical_screen:
; Redraw the entire screen column by column
    LDX scroll_last_direction
    LDA horizontal_scroll_lo
    STA scroll_update_direction, x

-
    ; Push the next scroll to buffer
        switch_bank_by_tileset
        JSR scroll_do_column
        switch_bank_A000 26
        JSR scroll_commit_column

    ; Go to the next column
        LDX scroll_last_direction
        LDA scroll_update_direction, x
        CLC
        ADC scroll_last_direction_offset, x
        STA scroll_update_direction, x

    ; Commit column data to vram
        JSR scroll_do_attribute_column
        JSR scroll_commit_column

        LDX scroll_last_direction
        LDA scroll_update_direction, x
        AND #$08
        CMP scroll_left_right_endian, x
        BNE +
            LDA scroll_column, x
            CLC
            ADC scroll_left_right_offset, x
            STA scroll_column, x
    +
        DEC columns_to_update
        BNE -

; Set the left scroll as not updated
    LDA #$FF
    STA scroll_update_direction
    RTS


redraw_entire_vertical_screen:
    LDA #$00
    STA scroll_last_direction

    LDA #$E0
    STA vertical_scroll_lo

; Add the scroll_column + (screens - 1) * 0xF0
    CLC
    ADC #$08
    STA scroll_update_direction
    LDY level_origional_screens
    DEY
    TYA
    ORA #$E0
    STA scroll_column

    -
        switch_bank_by_tileset
        JSR VScroll_PageAndDoPatAttrRow  ; Do the row of patterns and attributes for vertical scroll
        switch_bank_A000 26

        JSR Scroll_ToVRAM_Apply
        JSR Scroll_ToVRAM_Apply

        LDA vertical_scroll_lo
        CLC
        ADC #$08
        STA vertical_scroll_lo

        CMP #$F0
        BNE +
        ; Change to a new screen
            INC Scroll_VOffsetT
            LDA Scroll_VOffsetT     ; Loop vertical offset to new screen
            AND #$0F
            STA Scroll_VOffsetT

            JMP ++  ; Jump to ++

    +
        LDA vertical_scroll_lo
        AND #$08
        BNE ++ 
            ; Get the next row of data
            LDA Scroll_VOffsetT
            CLC
            ADC #$10
            STA Scroll_VOffsetT

    ++
        LDA vertical_scroll_lo
        CMP #$D0
        BNE -

    LDA #$00
    STA vertical_scroll_lo 
    STA Scroll_VertUpd

    RTS

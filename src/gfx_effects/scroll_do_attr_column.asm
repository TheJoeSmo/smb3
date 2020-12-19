;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/18/2020
; Commits a column attributes to the buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_cur_row                = Temp_Var1
_block_offset           = Temp_Var2

attr_even_offset:
    .byte $F1, $01

attr_odd_offset:
    .byte $ff, $0f

Scroll_Do_AttrColumn:
scroll_do_attribute_column:
    LDX scroll_last_direction
    LDY scroll_column, x
    TYA
    AND #$01
    BEQ +
    ; Add +/-1 depending on going left/right respectively
        TYA
        CLC
        ADC attr_odd_offset, x
        TAY
+
    STY _block_offset
    LDA #$00
    STA _cur_row

    --
        LDA _block_offset
        get_screen_offset

    ; Store the low nibble of the horzontal scroll (indexed by this screen)
        LDX _cur_row
        LDA _block_offset
        AND #$0F
        TAY
        -
            get_palette_from_block
            STA scroll_palette_buffer, x    ; Store into the buffer

        ; Add an additional row to the offset
            TYA
            CLC
            ADC #16
            TAY
            BCC +
                INC _block_data_pointer+1
        +
            INX
            STX _cur_row

            CPX #27
            BNE +

            ; X is 27, we need to go to the next page
            LDX scroll_last_direction
            LDY scroll_column, x
            TYA
            AND #$01
            BNE ++
                TYA
                CLC
                ADC attr_even_offset, x
                TAY
        ++
            STY _block_offset
            JMP --

    +
        CPX #54
        BNE -


    LDY #$00     ; Y = 0
    LDX #$00     ; X = 0

-
    ; Attributes store colors for 4 tiles in one byte, this
    ; forms the coloring information for all four blocks; this
    ; also explains the odd-but-necessary offsets
    LDA scroll_palette_buffer, x
    LSR A
    LSR A
    ORA scroll_palette_buffer+27, x
    LSR A
    LSR A
    ORA scroll_palette_buffer+1, x
    LSR A
    LSR A
    ORA scroll_palette_buffer+28, x

    STA scroll_attr_buffer, y
    INX
    INX
    CPY #$07
    BNE +
    ; Only store half the attribute data on row 7
        LDA scroll_attr_buffer, y
        AND #$0F
        STA scroll_attr_buffer, y
        DEX
+
    INY
    CPY #14
    BNE -

    LDA #$23
    STA vram_attr_pointer_hi
    LDX scroll_last_direction
    LDA scroll_column, x
    AND #$0F
    LSR A
    ORA #$C0
    STA scroll_attr_idx

    LDA #$00
    STA scroll_update_flag

    RTS

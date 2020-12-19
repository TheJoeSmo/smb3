;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/18/2020
; Commits a column to the buffer
; Determines if the attributes need to be updated
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

_cur_row                = Temp_Var1
_block_offset           = Temp_Var2
_upper_tsa_tile_pointer = Temp_Var11
_lower_tsa_tile_pointer = Temp_Var13
;_block_data_pointer     = Temp_Var15

Scroll_DoColumn:
scroll_do_column:
    LDY tileset_num
    LDA TileLayoutPage_ByTileset,Y
    STA PAGE_A000
    JSR PRGROM_Change_A000

; Determine if we're on the first or second partition of the block
    LDX scroll_last_direction
    LDA scroll_update_direction, x
    AND #$08
    LSR A
    LSR A
    LSR A
    STA scroll_block_partition

; Determine if we need to update the attributes
    LDA horizontal_scroll_lo
    AND #$0F
    CPX #$00
    BNE +right_check
+left_check
    CMP #$04
    BGE +flag_attr_update
    JMP +get_column_data
+right_check
    CMP #12
    BGE +get_column_data
+flag_attr_update
    LDA #$01
    STA scroll_update_flag

+get_column_data
    LDA tileset_num
    ASL A
    TAY

; Get the lower byte of the pointer
    LDA TileLayout_ByTileset, y
    STA _upper_tsa_tile_pointer
    STA _lower_tsa_tile_pointer

; Get either the left or right side of the block (0 or 512)
    LDX TileLayout_ByTileset+1, y
    LDA scroll_block_partition
    BEQ +
        INX
        INX

+
    STX _upper_tsa_tile_pointer+1
    INX
    STX _lower_tsa_tile_pointer+1

    LDX scroll_last_direction
    LDA scroll_column, x
    get_screen_offset

; Set up the row and column offset
    LDA #26
    STA _cur_row
    LDA scroll_column, x
    AND #$0F
    STA _block_offset

    LDX #$00        ; X = 0
    -
    ; Get the block in the block memory
        LDY _block_offset
        LDA (_block_data_pointer), y
        TAY

    ; Store the partitions of the block
        LDA (_upper_tsa_tile_pointer), y
        STA scroll_buffer, x
        LDA (_lower_tsa_tile_pointer), y
        STA scroll_buffer+1, x

    ; Add an additional row to the offset
        LDA _block_offset
        CLC
        ADC #16
        STA _block_offset
        BCC +
            INC _block_data_pointer+1
    +
    ; Move the buffer over by two and dec the row counter
        INX
        INX
        DEC _cur_row
        BPL -

; Update the last_horz_column to the relative last column updated (to the tile level)
    LDX scroll_last_direction
    LDA scroll_column, x
    AND #$0F
    ASL A
    ORA scroll_block_partition
    STA last_horz_column

    LDA #$20        ; Prep vram pointer for commit
    STA vram_pointer_hi
    RTS

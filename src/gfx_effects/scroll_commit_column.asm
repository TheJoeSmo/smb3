;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/18/2020
; Commits a column or a column's attributes to the ppu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

scroll_commit_column:
Scroll_Commit_Column:
    LDA ppu_status

    LDA vram_pointer_hi
    BEQ +scroll_commit_attr

; Set the ppu_address to the nametable + column
    LDA vram_pointer_hi
    STA ppu_address
    LDA last_horz_column
    STA ppu_address

; Use vertical mirroring
    LDA ppu_contorl_copy
    ORA #$04
    STA ppu_control


    LDY #$00
-
    ; Commit scroll to the nametable
        LDA scroll_buffer, y
        STA ppu_data
        INY
        CPY #30
        BNE -

; Set the ppu_address to the nametable + column + 0x0800
    LDA vram_pointer_hi
    ORA #$08
    STA ppu_address
    LDA last_horz_column
    STA ppu_address

-   
    ; Commit scroll to the nametable
        LDA scroll_buffer, y
        STA ppu_data
        INY
        CPY #30+24
    BNE -

    LDA #$00
    STA vram_pointer_hi
    RTS


+scroll_commit_attr
; If vram_pointer_hi = 0 ... do we need to commit any attribute updates??
    LDA vram_attr_pointer_hi
    BEQ +return  ; If vram_attr_pointer_hi = 0, jump to PRG026_B38E (RTS)

; Commiting attribute updates...
    LDA ppu_contorl_copy
    STA ppu_control        ; Update ppu_control

    LDX scroll_attr_idx
    LDY #$00

-
    ; Set the ppu_address to the attributes
        LDA vram_attr_pointer_hi
        STA ppu_address
        STX ppu_address

    ; Commit to the buffer
        LDA scroll_attr_buffer, y
        STA ppu_data

    ; Add eight to the scroll_attr_idx
        TXA
        CLC
        ADC #$08
        TAX
        BCC +
        ; Flip the pointer to the second partition
            LDA vram_attr_pointer_hi
            EOR #$08
            STA vram_attr_pointer_hi
            LDX scroll_attr_idx
        +
        INY
        CPY #14
        BNE -

; Update the vram_attr_pointer_hi to indicate a complete update
    LDA #$00
    STA vram_attr_pointer_hi

+return
    RTS      ; Return

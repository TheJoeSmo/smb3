
nmi_normal_update:
PRG031_F4E3:
    LDA #$00
    STA ppu_mask            ; Hide sprites and bg
    STA ppu_oam_address     ; Resets to sprite 0 in memory
    LDA #$02
    STA ppu_oam_dma

    JSR PT2_Full_CHRROM_Switch   ; Set up PT2 (Sprites) CHRROM

; If we are in a vblank, commit various graphical effects
    LDA in_vblank
    BNE +

    ; Commit various graphical effects and revert the bank back to their origional state
        switch_bank_A000_dirty 26     
        JSR Scroll_Commit_Column ; Update nametable as screen scrolls (differs from call made in UpdSel_Vertical, UpdSel_32PixPart)
        JSR Video_Misc_Updates   ; Various updates other than scrolling (palettes, status bar, etc.)
        JSR TileChng_VRAMCommit  ; Commit 16x16 tile change to VRAM
        JSR PRGROM_Change_A000

        LDA graphics_update_queue
        BNE ++
        ; Reset the buffer
            LDA #$00
            STA graphics_buffer_idx
            STA graphics_buffer

    ++
        LDA #$00
        STA graphics_update_queue   ; Finished updating the buffer

+

    LDA ppu_status      ; Reset the hi/lo latch

; Show the sprites and background
    LDA ppu_mask_copy
    ORA #ppu_show_all
    STA ppu_mask

; Set ppu_control approprately
    LDA PPU_CTL1_Mod
    ORA #%10101000
    STA ppu_control
    LDA ppu_status

; Set the ppu_scroll approprately
    LDA horizontal_scroll_lo
    STA ppu_scroll
    LDA vertical_scroll_lo
    CLC
    ADC viberation_offset
    STA ppu_scroll

; Time an interrupt for the status bar
    LDA #192
    STA irq_scanline
    STA irq_reload
    STA irq_enable
    CLI 

nmi_common_update:
PRG031_F55B:
    ; This is a common routine used by variants

; Only read the inputs and randomize once per 'frame'
    LDA is_next_frame
    BEQ +

        JSR Randomize
        JSR Read_Joypads
        DEC in_vblank       ; Don't read this until we complete the next frame

PRG031_F567:
+

; Do the sound engine
    switch_bank_A000_dirty 28
    switch_bank_C000_dirty 29

    JSR Sound_Engine_Begin

; Revert back to the previous banks
    JSR PRGROM_Change_Both

; Increment the tick counter
    INC tick_counter

; Retrieve the variables on the stack
    PLA
    STA Temp_Var3
    PLA
    STA Temp_Var2
    PLA
    STA Temp_Var1
    PLA
    TAY
    PLA
    TAX
    PLA
    PLP

; Return back to normal
    RTI
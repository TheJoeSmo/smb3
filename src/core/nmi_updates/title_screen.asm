

UpdSel_Title:
    LDA #$00
    STA ppu_mask            ; Hide sprites and bg
    STA ppu_oam_address     ; Resets to sprite 0 in memory
    LDA #$02
    STA ppu_oam_dma

    JSR PT2_Full_CHRROM_Switch   ; Set up PT2 (Sprites) CHRROM

; If we are in a vblank, commit various graphical effects
    LDA in_vblank
    BNE +

        LDA credits_state
        BEQ ++

        ; We are doing the credits
        switch_bank_A000_dirty 24
        switch_bank_C000_dirty 25
        JSR Do_Ending2_IntCmd
        JMP +

        ++
        ; Normal update
            switch_bank_A000_dirty 26
            JSR Video_Misc_Updates

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
    STA ppu_scroll

; Time an interrupt for the status bar
    LDA #193
    STA irq_scanline
    STA irq_reload
    STA irq_enable
    CLI 

    JMP nmi_common_update

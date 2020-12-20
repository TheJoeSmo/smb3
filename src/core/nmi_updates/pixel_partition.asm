

UpdSel_32PixPart:
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
        JSR PRGROM_Change_Both

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

; Begin the partition 32 pixels in advanced
    LDA #160
    STA irq_scanline
    STA irq_reload
    STA irq_enable
    
    CLI

    JMP nmi_common_update

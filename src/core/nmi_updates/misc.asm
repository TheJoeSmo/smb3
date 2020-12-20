

UpdSel_Misc:
    switch_bank_A000_dirty 26

    LDA #$00
    STA ppu_mask            ; Hide sprites and bg
    STA ppu_oam_address     ; Resets to sprite 0 in memory
    LDA #$02
    STA ppu_oam_dma

    JSR PT2_Full_CHRROM_Switch   ; Set up PT2 (Sprites) CHRROM

    LDA world_level_enter_effect
    BEQ +  
    ; Entering a level
        CMP #$01     ;
        BNE ++
        ; Japanese level entering effect
            JSR Map_EnterLevel_Effect   ; World map "entering" effect on page 26
            JMP +

    ++
        JSR Level_Opening_Effect    ; Level "opening" effect on page 26 (unused on US release)

+

    LDA ppu_status      ; Reset the hi/lo latch

; Show the sprites and background
    LDA ppu_mask_copy
    ORA #ppu_show_all
    STA ppu_mask

; Set ppu_control
    LDA #%10101000
    STA ppu_control

; Set scroll
    LDA horizontal_scroll_lo
    STA ppu_scroll
    LDA vertical_scroll_lo
    STA ppu_scroll

    LDA ppu_status      ; Reset the hi/lo latch

    DEC in_vblank

    ; Time an interrupt for the status bar
    LDA #192
    STA irq_scanline
    STA irq_reload
    STA irq_enable

    CLI 

    JMP nmi_music_update
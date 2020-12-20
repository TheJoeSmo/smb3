


nmi_update_routines:
    .byte nmi_partition_update_routine   ; UPDATERASTER_32PIXPART (opt. flag UPDATERASTER_32PIXSHOWSPR)
    .byte nmi_spade_game_update_routine   ; UPDATERASTER_SPADEGAME
    .byte nmi_partition_update_routine   ; UPDATERASTER_WATERLINE

nmi_raster_routines:
    .byte $40   ; UPDATERASTER_32PIXPART (opt. flag UPDATERASTER_32PIXSHOWSPR)
    .byte $60   ; UPDATERASTER_SPADEGAME
    .byte $A0   ; UPDATERASTER_WATERLINE

IntNMI:
nmi_interrupt:
; Disable any other interrupts from occuring and store the first 3 temp vars onto the stack
    SEI      
    PHP
    PHA
    TXA
    PHA
    TYA
    PHA
    LDA Temp_Var1
    PHA
    LDA Temp_Var2
    PHA
    LDA Temp_Var3
    PHA

    LDA #$00
    STA raster_state

    LDA raster_request
    BEQ +
    ; Handle request
        AND #$7F
        TAY
        LDA nmi_update_routines-1, y
        STA update_routine
        LDA nmi_raster_routines-1, y
        STA raster_routine

+

    LDA ppu_update_disable
    BEQ +
        JMP PRG031_F567

+
    
    LDA update_routine    ; Get the update_routine value
    quick_dynjump update_routines_hi, update_routines_lo

update_routines_hi:
    .byte >UpdSel_Misc          ; nmi_misc_update_routine
    .byte >UpdSel_Title         ; nmi_title_screen_update_routine
    .byte >UpdSel_Roulette      ; nmi_spade_game_update_routine
    .byte >UpdSel_Vertical      ; nmi_vertical_update_routine
    .byte >UpdSel_32PixPart     ; nmi_partition_update_routine
    .byte >PRG031_F4E3          ; nmi_normal_update_routine
update_routines_lo:
    .byte <UpdSel_Misc          ; nmi_misc_update_routine
    .byte <UpdSel_Title         ; nmi_title_screen_update_routine
    .byte <UpdSel_Roulette      ; nmi_spade_game_update_routine
    .byte <UpdSel_Vertical      ; nmi_vertical_update_routine
    .byte <UpdSel_32PixPart     ; nmi_partition_update_routine
    .byte <PRG031_F4E3          ; nmi_normal_update_routine

UpdSel_Misc:
    ; MMC3 event
    LDA #MMC3_8K_TO_PRG_A000    ; Changing PRG ROM at A000
    STA MMC3_COMMAND        ; Set MMC3 command
    LDA #26             ; Page 26
    STA MMC3_PAGE           ; Set MMC3 page
    JMP PRG031_F610 
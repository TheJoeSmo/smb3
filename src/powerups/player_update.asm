
; Update the player
Player_Update:
    LDA active_powerup_queue
    BEQ +  ; If we don't have a suit change queued, jump to +
    JSR handle_active_powerup_queue

+

    LDA is_dying
    ORA player_action_pause
    BNE +

    LDA wand_state
    CMP #$03
    BGS +

; Normal level actions
    LDA is_above_level
    BNE ++

; Check if the player is under the status bar and determine if they should die
    LDA Player_SpriteY
    AND #$F0
    CMP #$C0
    BNE ++

; The player has fell into a pit and fate will soon be served
; Remove any powerups from the player
    LDA #PLAYERSUIT_SMALL
    STA active_powerup

; Initialize the death sequence
    JSR Player_Die

; Jumps the initial part of the death sequence
    LDA #$c0
    STA Event_Countdown
    LDA #$02
    STA is_dying
    BNE +       ; JMP +

++
; The player has not fell into a pit
    LDA debug_enable
    CMP #$80
    BEQ ++

; Check if time remains
    LDA timer_enabled
    AND #$7f
    BNE +
    LDA level_time_hi
    ORA level_time_mi
    ORA level_time_lo
    BNE ++

; The player's time has ran out; begin the death sequence
    JSR Player_Die

; Do 'TIME UP!' death
    LDA #$03
    STA is_dying

-
    LDA #$50
    STA Event_Countdown
    JMP +

++
; Check if the player is getting crushed
    LDA Player_SpriteX
    CMP #$f8
    BLT +

    LDA is_vertical
    ORA end_level_counter
    BNE +

; Player was crushed!
    JSR Player_Die   ; Begin death sequence
    JMP -

+
    ; The following are always called, dead or alive...

    JSR Player_DrawAndDoActions29   ; Draw Player and perform reactions to various things (coin heaven, pipes, etc lots more)
    JSR Player_ControlJmp       ; Controllable actions
    JSR Player_PowerUpdate      ; Update "Power Meter"
    JSR Player_DoScrolling      ; Scroll relative to Player against active rules
    JSR AScrlURDiag_HandleWrap  ; Handle the diagonal autoscroller wrapping
    JSR Player_DetectSolids     ; Handle solid tiles, including slopes if applicable
    JSR Player_TailAttack_HitBlocks ; Do Tail attack against blocks
    JSR Player_DoSpecialTiles   ; Handle unique-to-style tiles!
    JSR Player_DoVibration      ; Shake the screen when required to do so!
    JSR Player_SetSpecialFrames ; Set special Player frames
    JSR Player_Draw29       ; ... and if you get through all that, draw the Player!!

    LDA #$00
    STA Player_XVelAdj   ; Player_XVelAdj = 0

    RTS      ; Return


handle_active_powerup_queue:
    CMP #$0F
    BLS set_player_powerup
    CMP #$40
    BEQ set_make_splash
    CMP #$80
    BEQ set_kuribo_suit
    LDA #$C0
    STA is_statue
    JMP clear_powerup_queue

clear_powerup_queue:
    LDA #$00
    STA active_powerup_queue      ; Clear active_powerup_queue
    JSR Level_SetPlayerPUpPal ; Set power up's correct palette

set_kuribo_suit:
    INC is_kuribo
    JMP clear_powerup_queue

set_make_splash:
    INC Player_InWater  ; Set "in water" flag
    JMP clear_powerup_queue

set_player_powerup:
    AND #$0F
    TAY
    DEY
    STY active_powerup ; Store into active_powerup

clear_powerup_queue:
; Clear queue and set proper palette
    LDA #$00
    STA active_powerup_queue
    JMP Level_SetPlayerPUpPal


Player_Die_Dying:
    LDA is_above_level
    BNE +

        LDA Player_SpriteY
        AND #$F0
        CMP #$B0
        BEQ ++  ; If Player_SpriteY >= $B0 && Player_SpriteY <= $BF (Player is halfway below status bar), jump to ++

+
    
    LDA event_counter
    BNE +
    ; Don't apply gravity until counter hits 0
        JMP player_apply_death_gravity
+

    JMP player_draw_death

++
    LDA event_counter
    BNE +

    ; Reload event_counter
    LDA #64
    STA event_counter ; event_counter = 64

+
    CMP #$01
    BNE +
        BEQ player_die_offscreen

+
    RTS

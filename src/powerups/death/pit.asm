

Player_Die_FellOff:

; Don't do anything until we finish the death jingle
    LDA event_counter
    BNE +

    PRG029_D6FB:
    player_die_offscreen:
    ; Return from the level and do not mark it as complete
        LDA #$01
        STA level_exit_state
        STA return_status_from_level

    +
    RTS
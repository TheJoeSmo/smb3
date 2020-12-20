

player_do_deaths_hi:
    .byte >Player_Die_NotDying   ; 0 - Player isn't dying!  Do nothing
    .byte >Player_Die_Dying      ; 1 - Dying normal
    .byte >Player_Die_FellOff    ; 2 - Dying by having fallen off screen
    .byte >Player_Die_TimeUp     ; 3 - Dying due to time up

player_do_deaths_lo:
    .byte <Player_Die_NotDying   ; 0 - Player isn't dying!  Do nothing
    .byte <Player_Die_Dying      ; 1 - Dying normal
    .byte <Player_Die_FellOff    ; 2 - Dying by having fallen off screen
    .byte <Player_Die_TimeUp     ; 3 - Dying due to time up

player_do_death:
PRG029_D6BC:
    LDA is_dying
    quick_dynjump player_do_deaths_hi, player_do_deaths_lo

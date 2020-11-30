

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Player_DrawAndDoActions
;
; Have to give this one its props; this function does an entire
; mess of routines, from adjusting the Player during autoscroll,
; going to coin heaven, the airship intro, going through pipes,
; changing power ups... all the things that happen to the Player
; object, though none of the instigation code is here!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Player_DrawAndDoActions:
    LDA player_action_pause
    BEQ player_action_normal

; This code is only executed if the Player is halted

    DEC player_action_pause

    JSR Player_Draw     ; Draw Player's sprite!

    LDA horizontal_scroll_settings
    BEQ +               ; If horizontal_scroll_settings = 0 (no auto scroll going on), jump to +

    JSR AutoScroll_CalcPlayerY  ; Adjust Player_Y and Player_YHi for auto scroll

+:
    RTS      ; Return


player_action_normal:
    LDA is_dying
    BEQ PRG029_D1D5  ; If Player is not dying, jump to PRG029_D1D5

    JMP PRG029_D6BC  ; Jump to PRG029_D6BC (the Player's death routine)

PRG029_D1D5:
    LDA Level_CoinHeav
    BPL PRG029_D205  ; If Level_CoinHeav >= 0, jump to PRG029_D205

    ; Note that by above logic, Level_CoinHeav must be <= -1...
    ; Technically, it is set to $80 (-128) at start!

    ; Release holding anything and stop horizontal movement
    LDA #$00
    STA Player_IsHolding
    STA Player_XVel

    ; Produces an initial burst of upward Y velocity which slows down
    INC Level_CoinHeav  ; Level_CoinHeav++
    LDA Level_CoinHeav
    STA Player_YVel
    BNE PRG029_D1EE     ; If Level_CoinHeav <> 0, jump to PRG029_D1EE

    INC Level_CoinHeav  ; Level_CoinHeav++

PRG029_D1EE:
    LDA Player_YHi
    BPL PRG029_D205  ; If Player hasn't gone above top of screen yet, jump to PRG029_D205

    ; Once Player crosses top of screen, he is then placed at halfway
    ; above the status bar (16 pixels above the death point!)
    LDA #$01
    STA Player_YHi ; Player_YHi = 1 (really low)
    LDA #$b0
    STA Player_Y   ; Player_Y = $B0 (near the bottom)

    LDA #$d0
    STA Level_CoinHeav

    ; Change to coin heaven (technically, this is the "general" level junction)
    LDA #$03
    STA Level_JctCtl ; Level_JctCtl = 3

    RTS      ; Return


PRG029_D205:
    LDA Player_SuitLost
    BEQ PRG029_D20E  ; If Player_SuitLost = 0, jump to PRG029_D20E

    JSR Player_SuitLost_DoPoof  ; Do the suit lost poof

    RTS      ; Return


PRG029_D20E:
    LDA Player_StarOff
    BEQ PRG029_D224  ; If Player_StarOff = 0 (invincibility is not wearing off), jump to PRG029_D224

    CMP #31
    BNE PRG029_D21D  ; If Player_StarOff <> 31, jump to PRG029_D21D

    DEC Player_StarOff ; Player_StarOff--
    JMP PRG029_D224    ; Jump to PRG029_D224

PRG029_D21D:
    JSR Player_Draw    ; Draw Player
    DEC Player_StarOff ; Player_StarOff--

    RTS      ; Return

PRG029_D224:
    LDA Player_Grow
    BEQ PRG029_D257  ; If Player is not transforming into "Super", jump to PRG029_D257

    LSR A
    LSR A
    TAX      ; X = Player_Grow >> 2

    LDY Player_Suit ; Y = Player_Suit
    BNE PRG029_D238  ; If Y <> 0 (small), jump to PRG029_D238

    STX Temp_Var1
    LDA #$0b
    SEC
    SBC Temp_Var1
    TAX      ; Otherwise, X = $0B - (Player_Grow >> 2)

PRG029_D238:
    AND #$01
    PHP      ; Save result

    LDA Player_GrowFrames,X  ; Get this grow frame
    STA Player_Frame    ; Set as current frame

    JSR Player_Draw      ; Draw Player

    ; Changes the Sprite 1/4 VROM bank as appropriate
    LDA PatTable_BankSel+2
    AND #$03
    ORA #$54
    PLP      ; Restore result
    BEQ PRG029_D250
    SEC
    SBC #$10
PRG029_D250:
    STA PatTable_BankSel+2

    DEC Player_Grow  ; Player_Grow--

    RTS      ; Return

PRG029_D257:
    LDA Player_EndLevel
    BEQ PRG029_D279  ; If we're not doing the end of level run, jump to PRG029_D279

    LDA Player_Kuribo
    BEQ PRG029_D26B ; If Player was not in a Kuribo's shoe, jump to PRG029_D26B

    ; If Player was in Kuribo's shoe at the end goal, "poof" it away!

    LDA #$00
    STA Player_Kuribo

    LDA #$18
    STA Player_SuitLost  ; Player_SuitLost = $18

PRG029_D26B:
    LDA Player_InAir
    BNE PRG029_D279     ; If Player is mid-air, jump to PRG029_D279

    DEC Player_EndLevel ; Player_EndLevel--

    LDA #$14
    STA Player_XVel    ; Player_XVel = $14
    JMP PRG029_D457     ; Jump to PRG029_D457

PRG029_D279:
    LDA Level_AirshipCtl
    BNE PRG029_D281  ; If Level_AirshipCtl <> 0, jump to PRG029_D281

    JMP PRG029_D33E  ; Otherwise, jump to PRG029_D33E

PRG029_D281:

    ; Level_AirshipCtl <> 0...

    PHA      ; Save Level_AirshipCtl

    LDA #$00
    STA Scroll_LastDir ; Force screen to have "last moved right"

    INC Horz_Scroll    ; Screen scrolls to the right
    BNE PRG029_D28C     ; If it hasn't rolled over, jump to PRG029_D28C
    INC Horz_Scroll_Hi ; Otherwise, apply carry

PRG029_D28C:
    LDA Horz_Scroll_Hi
    BNE PRG029_D296     ; If Horz_Scroll_Hi <> 0, jump to PRG029_D296

    LDA Horz_Scroll
    CMP #$60
    BLT PRG029_D2AF  ; If Horz_Scroll < $60, jump to PRG029_D2AF

PRG029_D296:
    INC Level_AirshipH   ; Level_AirshipH++

    LDA Level_AirshipH
    CLC
    ADC Counter_Wiggly   ; Increase height of the airship in a bit of a wobbly way
    BCC PRG029_D2AF     ; If it hasn't overflowed, jump to PRG029_D2AF

    INC Vert_Scroll

    LDA Objects_Y+4
    SEC
    SBC #$01
    STA Objects_Y+4    ; Anchor's Y minus 1
    BCS PRG029_D2AF
    DEC Objects_YHi+4  ; If overflow occurred, propogate the carry
PRG029_D2AF:

    PLA      ; Restore Level_AirshipCtl
    JSR DynJump  ; Dynamic jump based on Level_AirshipCtl...

    ; THESE MUST FOLLOW DynJump FOR THE DYNAMIC JUMP TO WORK!!
    .word AirshipCtl_DoNothing  ; 0 - Do nothing (not used)
    .word AirshipCtl_RunAndJump ; 1 - Run and jump (when horizontal scroll hits $80)
    .word AirshipCtl_Catch      ; 2 - Catch anchor
    .word AirshipCtl_HoldAnchor ; 3 - Hold onto anchor
    .word AirshipCtl_LandOnDeck ; 4 - Land Player on deck

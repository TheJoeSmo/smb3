;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; JoeSmo 12/18/2020
; Read controllers input
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_ctrl_input = Temp_Var1

; TODO: Fix two player vs mode not reading controller inputs

Read_Joypads:
read_controllers:
    LDA tileset_num     ; Read both player controller if in the overworld
    BEQ @read_both_player_controllers

    LDY player_cur      ; Only read the current player's inputs
@read_joycon_safe
    JSR @read_controller

@reread_controller:
; Check the controller inputs, due to a glitch with the APU DMC
    LDA _ctrl_input
    PHA
    JSR @read_controller
    PLA
    CMP _ctrl_input
    BNE @reread_controller  ; Keep reading untill we get a match

@reject_opposing_presses:
; Rejects any up+down or left+right inputs
    LDA _ctrl_input
    AND #%00001010
    LSR A
    AND _ctrl_input
    BEQ @calculate_just_pressed
        RTS     ; Use the previous frame's direction

@calculate_just_pressed:
; Only set just pressed if the button is pressed and the result of and the previous frame didn't
    LDA _ctrl_input
    STA active_inputs
    LDA controller_pressed_inputs, y
    EOR _ctrl_input
    AND _ctrl_input
    STA controller_new_input, y
    STA new_inputs
    LDA _ctrl_input
    STA controller_pressed_inputs, y
    RTS

@read_both_player_controllers:
    LDA player_cur      ; Read the secondary player first and then main player
    EOR #$01
    TAY
    JSR @read_joycon_safe
    LDY player_cur
    JSR @read_joycon_safe
    RTS

@read_controller:
; Read the controller inputs, for more information, read http://wiki.nesdev.com/w/index.php/Controller_reading

    LDA #$01    ; Set strobe to high
    STA JOYPAD
    STA _ctrl_input
    LSR A
    STA JOYPAD  ; Set strobe to low (no more reading the buttons)

@read_next_button_loop:
        ; Read inputs
        LDA JOYPAD, y
        LSR A
        ROL _ctrl_input
        BCC @read_next_button_loop
    RTS

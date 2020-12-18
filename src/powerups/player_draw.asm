
; TODO: Fix Vertical Level Rendering Error
; TODO: Fix Sprite Rendering Error From Kick 

mario_frame_offset_hi:
    .byte >PF00, >PF01, >PF02, >PF03, >PF04, >PF05, >PF06, >PF07
    .byte >PF08, >PF09, >PF0A, >PF0B, >PF0C, >PF0D, >PF0E, >PF0F
    .byte >PF10, >PF11, >PF12, >PF13, >PF14, >PF15, >PF16, >PF17
    .byte >PF18, >PF19, >PF1A, >PF1B, >PF1C, >PF1D, >PF1E, >PF1F
    .byte >PF20, >PF21, >PF22, >PF23, >PF24, >PF25, >PF26, >PF27
    .byte >PF28, >PF29, >PF2A, >PF2B, >PF2C, >PF2D, >PF2E, >PF2F
    .byte >PF30, >PF31, >PF32, >PF33, >PF34, >PF35, >PF36, >PF37
    .byte >PF38, >PF39, >PF3A, >PF3B, >PF3C, >PF3D, >PF3E, >PF3F
    .byte >PF40, >PF41, >PF42, >PF43, >PF44, >PF45, >PF46, >PF47
    .byte >PF48, >PF49, >PF4A, >PF4B, >PF4C, >PF4D, >PF4E, >PF4F
    .byte >PF50

mario_frame_offset_lo:
    .byte <PF00, <PF01, <PF02, <PF03, <PF04, <PF05, <PF06, <PF07
    .byte <PF08, <PF09, <PF0A, <PF0B, <PF0C, <PF0D, <PF0E, <PF0F
    .byte <PF10, <PF11, <PF12, <PF13, <PF14, <PF15, <PF16, <PF17
    .byte <PF18, <PF19, <PF1A, <PF1B, <PF1C, <PF1D, <PF1E, <PF1F
    .byte <PF20, <PF21, <PF22, <PF23, <PF24, <PF25, <PF26, <PF27
    .byte <PF28, <PF29, <PF2A, <PF2B, <PF2C, <PF2D, <PF2E, <PF2F
    .byte <PF30, <PF31, <PF32, <PF33, <PF34, <PF35, <PF36, <PF37
    .byte <PF38, <PF39, <PF3A, <PF3B, <PF3C, <PF3D, <PF3E, <PF3F
    .byte <PF40, <PF41, <PF42, <PF43, <PF44, <PF45, <PF46, <PF47
    .byte <PF48, <PF49, <PF4A, <PF4B, <PF4C, <PF4D, <PF4E, <PF4F
    .byte <PF50

    ; The six Patterns per player_frame to start each of the six Player sprites with!
    ; Note the order is the three patterns for the three sprites that make the upper
    ; half followed by the next three for the lower half.
    ; $F1 is a magic value reserved as a "don't display this sprite" flag

SPPF_Table:
PF00:   .byte $01, $03, $F1, $05, $07, $09  ; Walk Raccoon / Frog
PF01:   .byte $0B, $0D, $F1, $0F, $29, $2B  ; |
PF02:   .byte $2D, $2F, $F1, $19, $1B, $1D  ; / Spin Hammer
PF03:   .byte $2D, $2F, $F1, $19, $1B, $09  ; Tail Attack
PF04:   .byte $21, $21, $F1, $23, $23, $F1  ; | Spin Big
PF05:   .byte $25, $25, $F1, $27, $27, $F1  ; Big in Pipe / Tail Attack / Spin Big
PF06:   .byte $01, $03, $F1, $05, $07, $F1  ; Fall Big
PF07:   .byte $31, $33, $F1, $35, $37, $39  ; Ducking Raccoon
PF08:   .byte $01, $03, $F1, $05, $07, $39  ; Fluttering Tail Wag
PF09:   .byte $01, $03, $F1, $05, $07, $09  ; Tail Attack in Air / Fluttering Tail Wag
PF0A:   .byte $01, $03, $F1, $05, $07, $3B  ; Fluttering Tail Wag
PF0B:   .byte $F1, $F1, $F1, $3D, $3F, $F1  ; Mid Grow Small
PF0C:   .byte $01, $03, $F1, $05, $07, $F1  ; Walk Big / Fire / Hammer
PF0D:   .byte $0B, $0D, $F1, $0F, $29, $F1  ; |
PF0E:   .byte $2D, $2F, $F1, $19, $1B, $F1  ; / Throwing Projectile / Spin not Hammer
PF0F:   .byte $31, $33, $F1, $35, $37, $F1  ; Ducking not Raccoon
PF10:   .byte $09, $2F, $F1, $1D, $1F, $F1  ; Throwing Projectile
PF11:   .byte $2D, $2F, $F1, $39, $3B, $F1  ; /
PF12:   .byte $31, $31, $F1, $33, $33, $F1  ; Frog Swim Up
PF13:   .byte $35, $35, $F1, $37, $37, $F1  ; |
PF14:   .byte $39, $39, $F1, $3B, $3B, $F1  ; /
PF15:   .byte $01, $03, $F1, $05, $07, $09  ; Frog Hop
PF16:   .byte $0B, $0D, $F1, $0F, $29, $2B  ; |
PF17:   .byte $2D, $2F, $F1, $19, $1B, $1D  ; /
PF18:   .byte $2D, $2F, $F1, $A9, $AB, $F1  ; Not Small in Kuribo's Shoe
PF19:   .byte $2D, $2F, $F1, $A9, $AD, $F1  ;
PF1A:   .byte $01, $03, $05, $07, $09, $0B  ; Somersault Base
PF1B:   .byte $0D, $0F, $39, $3B, $3D, $3F  ; |
PF1C:   .byte $19, $1B, $1D, $1F, $21, $23  ; |
PF1D:   .byte $25, $27, $29, $2B, $2D, $2F  ; /
PF1E:   .byte $31, $33, $F1, $35, $37, $F1  ; Statue
PF1F:   .byte $25, $29, $2D, $33, $37, $0D  ; Frog Swim Idle
PF20:   .byte $25, $29, $2D, $33, $37, $0F  ; /
PF21:   .byte $19, $1D, $21, $1B, $1F, $23  ; Frog Swim Sideways
PF22:   .byte $25, $29, $2D, $27, $2B, $2F  ; |
PF23:   .byte $25, $29, $2D, $33, $37, $3B  ; /
PF24:   .byte $01, $01, $F1, $03, $03, $F1  ; Frog Swim Down
PF25:   .byte $05, $05, $F1, $07, $07, $F1  ; |
PF26:   .byte $09, $09, $F1, $0B, $0B, $F1  ; /
PF27:   .byte $31, $33, $F1, $35, $37, $F1  ; Mid Grow Medium
PF28:   .byte $31, $35, $F1, $39, $3D, $F1  ; Holding Item not Small / Climbing Frog
PF29:   .byte $01, $03, $F1, $05, $07, $09  ; |

    ; Second page begins here
PF2A:   .byte $01, $03, $F1, $0B, $0D, $0F  ; |
PF2B:   .byte $01, $03, $F1, $21, $23, $25  ; /
PF2C:   .byte $31, $33, $F1, $35, $37, $F1  ; Climbing not Frog
PF2D:   .byte $27, $19, $F1, $1D, $1F, $F1  ; Kick Big
PF2E:   .byte $F1, $F1, $F1, $35, $37, $F1  ; Holding Item Small
PF2F:   .byte $F1, $F1, $F1, $31, $33, $F1  ; /
PF30:   .byte $29, $2B, $F1, $2D, $2F, $F1  ; Skid Big
PF31:   .byte $39, $3B, $F1, $3D, $3F, $F1  ; Slide Big
PF32:   .byte $F1, $F1, $F1, $2F, $2F, $F1  ; Spinning Small / Frog
PF33:   .byte $F1, $F1, $F1, $2B, $2D, $F1  ; Slide Small
PF34:   .byte $29, $2B, $F1, $0D, $0F, $27  ; Swim Big Active / Idle / Throwing Projectile in Air
PF35:   .byte $29, $2B, $F1, $09, $0B, $25  ; Throwing in Air
PF36:   .byte $29, $2B, $F1, $01, $03, $3F  ; Swim Big Active / Tail Wag / Throwing in Air
PF37:   .byte $29, $2B, $F1, $01, $03, $05  ; |
PF38:   .byte $29, $2B, $F1, $01, $03, $07  ; Fast Jump Big / Tail Wag
PF39:   .byte $29, $2B, $F1, $31, $33, $3D  ; Running not Small
PF3A:   .byte $29, $2B, $F1, $35, $37, $3D  ; Jump Small
PF3B:   .byte $29, $2B, $F1, $39, $3B, $3D  ; Running not Small
PF3C:   .byte $29, $2B, $F1, $0D, $1F, $25  ; Swim Big Idle
PF3D:   .byte $29, $2B, $F1, $0D, $2D, $2F  ; /
PF3E:   .byte $F1, $F1, $F1, $05, $07, $F1  ; Walk Small / Spinning Small / Frog
PF3F:   .byte $F1, $F1, $F1, $01, $03, $F1  ; /
PF40:   .byte $F1, $F1, $F1, $19, $1B, $F1  ;
PF41:   .byte $F1, $F1, $F1, $21, $23, $F1  ; Skid Small
PF42:   .byte $F1, $F1, $F1, $1D, $1F, $F1  ; Kick Small
PF43:   .byte $05, $07, $F1, $A9, $AB, $F1  ; Small in Kuribo's Shoe
PF44:   .byte $05, $07, $F1, $A9, $AD, $F1  ;
PF45:   .byte $29, $2B, $F1, $01, $03, $05  ;
PF46:   .byte $F1, $F1, $F1, $25, $27, $F1  ; Swim Small Active / Idle
PF47:   .byte $F1, $F1, $F1, $29, $2B, $F1  ; |
PF48:   .byte $F1, $F1, $F1, $29, $2F, $F1  ; /
PF49:   .byte $F1, $F1, $F1, $25, $2D, $F1  ; Swim Small Idle
PF4A:   .byte $F1, $F1, $F1, $09, $0B, $F1  ; Climbing Small
PF4B:   .byte $F1, $F1, $F1, $0D, $0D, $F1  ; Dying
PF4C:   .byte $F1, $F1, $F1, $31, $33, $F1  ; Running Small
PF4D:   .byte $F1, $F1, $F1, $35, $37, $F1  ; / 
PF4E:   .byte $F1, $F1, $F1, $0F, $3F, $F1  ;
PF4F:   .byte $19, $1B, $F1, $1D, $21, $F1  ; Jump Big / Fire / Hammer / Frog
PF50:   .byte $19, $1B, $F1, $1D, $21, $23  ; Jump Raccoon



    ; Selects a VROM page offset per player_frame
player_frame_chr_page:
    .byte 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 ; 00 - 0F
    .byte 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1 ; 10 - 1F
    .byte 1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  2,  2,  2,  2,  2,  2 ; 20 - 2F
    .byte 2,  2,  2,  2,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3 ; 30 - 3F
    .byte 3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3 ; 40 - 4F
    .byte 3

    ; Specified root VROM page for a given power up
player_powerup_frame_chr_page_base:
    ;     Small, Big, Fire, Leaf, Frog, Tanooki, Hammer
    .byte $50,   $54, $54,  $00,  $50,  $40,     $44

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Player_Draw
;
; Not literally "draw", but configure the sprites for the Player
; to be drawn!  With the given data set of where the screen is
; scrolled, the Player's animation frame, invincibility status,
; etc. all handled by this major subroutine...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
player_chr_page = PatTable_BankSel+2
_player_palette = Temp_Var1

Player_Draw:
; select a page from the given frame and base offset from the power
    LDX player_frame
    LDY active_powerup
    LDA player_frame_chr_page, x
    CLC
    ADC player_powerup_frame_chr_page_base, y
    STA player_chr_page

; Set the new sprite position to be the player x - scroll
    LDA player_x
    SEC
    SBC horizontal_scroll_lo
    STA player_sprite_x

    LDA player_y
    SEC
    SBC vertical_scroll_lo
    STA player_sprite_y

; Determines if the player is above the screen
    LDA player_y_hi
    SBC vertical_scroll_hi
    STA is_above_level
 
; Custom code for starman color cycling
    JSR player_draw_starman_checks
    STA _player_palette

; Custom code for sprite priority
    JSR player_draw_priority_bg

; Get the offset to the sprites
    LDY #$00
    LDA mario_frame_offset_hi, x   ; x is player_frame
    STA player_sprite_pointer+1
    LDA mario_frame_offset_lo, x
    STA player_sprite_pointer

; Load the graphics into OAM
    LDX player_sprite_offset        ; Offset in OAM

    LDA (player_sprite_pointer), y
    STA sprite_data_graphic+12, x
    INY
    LDA (player_sprite_pointer), y
    STA sprite_data_graphic+16, x
    INY
    LDA (player_sprite_pointer), y
    STA sprite_data_graphic+20, x
    INY
    LDA (player_sprite_pointer), y
    STA sprite_data_graphic, x
    INY
    LDA (player_sprite_pointer), y
    STA sprite_data_graphic+4, x
    INY
    LDA (player_sprite_pointer), y
    STA sprite_data_graphic+8, x

; Merge flip direction with palette and sprite priority attributes 
    LDA player_direction
    AND #$C0
    ORA _player_palette

; Push attributes
    STA sprite_data_attributes, x
    STA sprite_data_attributes+4, x
    STA sprite_data_attributes+8, x
    STA sprite_data_attributes+12, x
    STA sprite_data_attributes+16, x
    STA sprite_data_attributes+20, x

    LDA sprite_data_graphic, x
    CMP sprite_data_graphic+4, x
    BNE +

; Mirror both sides to save chr space

    LDA sprite_data_attributes+12, x
    AND #<~SPR_HFLIP     ; Keep all attributes EXCEPT horizontal flip
    STA sprite_data_attributes, x
    STA sprite_data_attributes+12, x
    ORA #SPR_HFLIP      ; Force horizontal flip
    STA sprite_data_attributes+4, x
    STA sprite_data_attributes+16, x

+

; Set the y positions of the sprites
    LDA player_sprite_y
    STA sprite_data_y+12, x
    STA sprite_data_y+16, x
    STA sprite_data_y+20, x
    CLC
    ADC #16
    STA sprite_data_y, x
    STA sprite_data_y+4, x
    STA sprite_data_y+8, x

; Set the x positions of the sprites
    LDA player_sprite_x
    STA sprite_data_x, x
    STA sprite_data_x+12, x
    CLC
    ADC #8
    STA sprite_data_x+4, x
    STA sprite_data_x+16, x
    CLC
    ADC #8
    STA sprite_data_x+8, x
    STA sprite_data_x+20, x

    LDA player_direction
    AND #SPR_HFLIP
    BEQ +

; Horizontally flip the sprites
    LDA sprite_data_graphic, x
    PHA
    LDA sprite_data_graphic+4, x
    STA sprite_data_graphic, x
    PLA
    STA sprite_data_graphic+4, x

    LDA sprite_data_graphic+12, x
    PHA
    LDA sprite_data_graphic+16, x
    STA sprite_data_graphic+12, x
    PLA
    STA sprite_data_graphic+16, x

; Move the 3rd partition of the sprite to the other side
    LDA sprite_data_x+8, x
    CLC
    ADC #-24
    STA sprite_data_x+8, x
    STA sprite_data_x+20, x

    LDA invis_summer_sault
    BEQ +

; Move all sprites by 8 to the right for better summer sault hitbox
    LDA sprite_data_x, x
    CLC
    ADC #8
    STA sprite_data_x, x
    STA sprite_data_x+12, x

    LDA sprite_data_x+4, x
    CLC
    ADC #8
    STA sprite_data_x+4, x
    STA sprite_data_x+16, x

    LDA sprite_data_x+8, x
    CLC
    ADC #8
    STA sprite_data_x+8, x
    STA sprite_data_x+20, x


+
    LDA is_kuribo
    BEQ +

; Custom kuribo code
    
; In short, if Player is small, use Temp_Var1 = 6, otherwise Temp_Var1 = 0 (sprite vertical offset in shoe)
    LDY #$00
    LDA active_powerup
    BNE ++
    LDY #$06

++
    STY Temp_Var1

    LDA in_air
    BEQ ++  ; If Player is not mid-air, jump to ++

    LDA player_y_vel
    BPL +++  ; If Player is falling, jump to +++

    EOR #$FF     ; Otherwise negate it (sort of)

+++
    LSR A
    LSR A
    LSR A
    LSR A
    SEC
    SBC #$03    ; The "whole" part of the Y Velocity, minus 3

    EOR #$FF     ; Negate that (sort of)
    BPL ++  ; If the result is positive, jump to ++

    LDA #$00     ; Otherwise if it slipped below zero, just use zero

++
    CLC
    ADC Temp_Var1   ; Add that to the initial offset
    CLC
    ADC player_sprite_y  ; And add in the Player's sprite Y position

; Set the adjusted y position
    STA sprite_data_y+12, x
    STA sprite_data_y+16, x
    STA sprite_data_y+20, x

; Set the boot palette
    LDA sprite_data_attributes, x
    ORA #$02
    STA sprite_data_attributes, x
    STA sprite_data_attributes+4, x


+
    LDA player_frame
    CMP #PF_KICK_BIG
    BNE +  ; If player_frame <> PF_KICK_BIG (kicking shell, etc. when not small), jump to +

; Move the first sprite around to make a foot for the kick
    LDA sprite_data_y, x
    STA sprite_data_y+20, x

; Get the horizontal offset
    LDA #-8
    LDY player_direction
    BEQ ++
    LDA #16
++
    CLC
    ADC sprite_data_x+12, x
    STA sprite_data_x+16, x

; Force the foot to pattern 1B
    LDA #$1B
    STA sprite_data_graphic+20, x

    LDA sprite_data_attributes+12, x
    STA sprite_data_attributes+20, x    ; Attributes are copied (is this necessary?)

+
    LDA player_direction
    AND #$80
    BEQ player_finished_draw

; Flip the player upside 
    LDA sprite_data_y, x
    STA sprite_data_y+12, x
    STA sprite_data_y+16, x
    STA sprite_data_y+20, x
    CLC
    ADC #-16
    STA sprite_data_y, x
    STA sprite_data_y+4, x
    STA sprite_data_y+8, x


player_finished_draw:
    LDA #$00
    STA player_offscreen     ; player_offscreen = 0 (not off screen until we decide so!)

    LDA is_above_level
    BPL +     ; Jump if Player is not above top of screen

    LDA player_sprite_y
    CLC
    ADC #16
    LDA #$00
    ADC is_above_level

    BNE player_draw_offscreen
    BEQ player_draw_onscreen

+
    BNE player_draw_offscreen  ; Player is offscreen, so draw offscreen!

    LDA player_sprite_y
    CMP #$C0
    BGE player_draw_offscreen   ; Player is completely below the status bar

    CMP #$B0
    BGE ++                      ; Only draw half of the player
    BLT player_draw_onscreen    ; The player is completely visible

player_draw_offscreen:
    INC player_offscreen

; Prevent sprites from showing
    LDA #$FF
    STA sprite_data_y+12, x
    STA sprite_data_y+16, x
    STA sprite_data_y+20, x

++

; Prevent top sprites from being displayed
    LDA #$FF
    STA sprite_data_y, x
    STA sprite_data_y+4, x
    STA sprite_data_y+8, x


player_draw_onscreen:

; Remove any sprites that are the value 0xF1
    LDY #$05

-
    LDA sprite_data_graphic, x
    CMP #$F1
    BNE +

; Make the sprite invisible
    LDA #$F8
    STA sprite_data_y, x

+
    INX
    INX
    INX
    INX
    DEY
    BPL -


    LDA pipe_movement
    BEQ +

; When Player is going through pipe, a special "cover sprite" is used
; at the pipe entrance which masks the Player...

; Mask sprite X
    LDA player_pipe_x
    SEC
    SBC horizontal_scroll_lo
    STA sprite_data_x
    STA sprite_data_x+4
    CLC
    ADC #$08
    STA sprite_data_x+8
    STA sprite_data_x+12

; Mask sprite Y
    LDA player_pipe_y
    SEC
    SBC vertical_scroll_lo
    PHA
    CMP #$F0
    BLT ++
    LDA #$00
++
    STA player_sprite_y
    STA player_sprite_y+8
    PLA
    CLC
    ADC #16
    STA player_sprite_y+4
    STA player_sprite_y+12


; The pattern doesn't really matter so long as it is opaque
; since the masking sprite is not intended to be visible
; (not that certain glitches or ill behavior don't reveal
; it once in a while)

; Uses pattern $77 ("metal block" from used up [?], should be completely opaque)
    LDA #$77
    STA sprite_data_graphic
    STA sprite_data_graphic+4
    STA sprite_data_graphic+8
    STA sprite_data_graphic+12

; Make the sprites hide behind the pipe
    LDA #SPR_BEHINDBG
    STA sprite_data_attributes
    STA sprite_data_attributes+4
    STA sprite_data_attributes+8
    STA sprite_data_attributes+12

+
    RTS


player_draw_priority_bg:
    LDA pipe_movement
    ORA is_behind
    ORA is_sinking
    BEQ +  ; If Player is behind the scenes, jump to +

    LDA #$20
    ORA _player_palette
    STA _player_palette
+
    RTS


player_draw_starman_checks:
    
    LDA player_invisability_flash
    BEQ +     ; If player_invisability_flash = 0, jump to +

    DEC player_invisability_flash ; player_invisability_flash--
    AND #$02
    BEQ +     ; Every 2 ticks, draw Player
    PLA
    PLA                 ; Jump and do not return
    JMP player_finished_draw     ; Every other 2 ticks, don't!

+

    LDA player_star_wear_off
    BNE +

    LDA invinsability_counter
    BEQ ++     ; If invinsability_counter = 0 (not star invincible), jump to ++

; Do custom star code
    LDA tick_counter
    AND #%00000001
    BEQ +

    DEC invinsability_counter

+

    LDA tick_counter
    AND #$0f    ; A = 0-15 ticks

    LDY player_star_wear_off
    BNE +

    LDY invinsability_counter
    CPY #32
    BNE +++  ; If invinsability_counter <> 32, jump to +++
    JSR restore_music_queue_two

    BCS +++  ; If we're NOT doing the "wearing off" star invincibility, jump to +++

+
    ; These shifts are used to produce the "slower" color cycle
    ; when the star invincibility is wearing off...
    LSR A
    LSR A

+++
    AND #$03     ; Cap it 0-3 in any case (select one of the four sprite palettes, basically)

++
    RTS


restore_music_queue_two:
    LDY pswitch_cnt
    BNE +++     ; Do not restore p switch music

; Otherwise, restore level BGM music now that invincibility is wearing off
    LDY background_music_restore
    STY music_queue_2

+++
    RTS
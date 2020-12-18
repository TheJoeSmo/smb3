
powerup_can_duck:
    .byte 0, 1, 1, 1, 0, 1, 1, 1, 1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Player_Control
;
; Pretty much all controllable Player actions like ducking,
; sliding, tile detection response, doors, vine climbing, and
; including basic power-up / suit functionality (except the actual
; throwing of fireballs / hammers for some reason!)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

player_y_offset = Temp_Var10
player_x_offset = Temp_Var11

__head_block = Temp_Var1
__left_block = Temp_Var2
__abs_player_vel = Temp_Var3

Player_Control:
    LDA player_direction
    STA last_player_direction

    LDA in_air
    STA last_in_air

; Remove horizontal velocity and controller inputs if stunned or ending a level
    LDA end_level_counter
    BNE +
    LDA is_shaking_counter
    BEQ ++
    DEC is_shaking_counter
+
    LDA #$00
    STA player_x_vel
    STA active_inputs
    STA new_inputs

++

; Disable the B button if sliding down a slope
    LDA is_sliding
    BEQ +
    LDA new_inputs
    AND #<~PAD_B
    STA new_inputs      ; Otherwise, disable 'B' button

+

; Disable movement if in cut-scene
    LDA level_objects+1
    CMP #OBJ_TOADANDKING
    BNE +
    LDA active_inputs
    AND #<~(PAD_LEFT | PAD_RIGHT | PAD_UP | PAD_DOWN)
    STA active_inputs    ; Otherwise, disable all directional inputs

+

    JSR player_update_ducking   ; Set if the player is ducking or not

    LDY #20         ; Y = 20 (ducking or small)

    LDA active_powerup
    BEQ +     ; If Player is small, jump to +

    LDA is_ducking
    BNE +     ; If Player is ducking, jump to +

    LDY #10         ; Otherwise, Y = 10 (not ducking, not small)

+
    STY player_y_offset     ; player_y_offset (Y offset) = 20 or 10

    LDA #$08
    STA player_x_offset     ; player_x_offset (X offset) = 8

    JSR Player_GetTileAndSlope ; Get tile above Player

    STA head_block
    STA __head_block
    LDA left_block
    STA __left_block

    LDA is_behind
    STA is_behind_enabled       ; Set if behind
    BEQ +

; Player is behind the scene
    LDA tick_counter
    LSR A
    BCC ++     
    DEC is_behind       ; Every other tick, decrement

++
    LDY #$00     ; Y = 0 (disable "behind the scenes")

; If tile behind Player's head is $41 or TILE1_SKY, disable is_behind
    LDA __head_block
    CMP #$41
    BEQ ++
    CMP #TILE1_SKY
    BEQ ++

    INY             ; We are behind the scenery

    LDA is_behind
    BNE ++          ; If Player is behind the scenes, jump to ++

    STY is_behind   ; Set Player as behind the scenes

++
    STY is_behind_enabled    ; Store whether Player is actually behind scenery

; End of behind enable code

+

; Handle water inputs
    JSR player_input_water_check

; Clear vertical flip on sprite
    LDA player_direction
    AND #%01111111
    STA player_direction

    JSR player_input_door_check


; Cannot be in water, hold an item, or be in a kuribo and climb
    LDA in_water
    ORA is_holding
    ORA is_kuribo
    BNE +player_no_climb

; Need to be on a vine to climb
    LDA __head_block
    CMP #TILE1_VINE
    BNE +player_no_climb

; Continue to climb if climbing
    LDA is_climbing
    BNE +

; Cannot begin climbing if not holding up or down
    LDA active_inputs
    AND #PAD_UP | PAD_DOWN
    BEQ +player_no_climb

; If holding either up or down, always begin climbing
    LDY in_air
    BNE +

; Allow ducking on the ground
    AND #PAD_UP
    BNE +

+player_no_climb:
    LDA #$00
    STA is_climbing
    JMP +player_not_climbing

+
; Likely climbing
    LDA #$01
    STA is_climbing    ; is_climbing = 1 (Player is climbing)

; No velocities
    LDA #$00
    STA player_x_vel
    STA player_y_vel

    LDA active_inputs
    AND #PAD_UP | PAD_DOWN
    BEQ +

; Pressing up or down
    LDY #$10    ; Y = $10 (will be Y velocity down if Player is pressing down)

; Can always go down, do additional checks for upward movement
    AND #PAD_UP
    BEQ ++

; Get player offset for climbing, need to check if next block is a vine
    LDY #16
    LDA active_powerup
    BEQ +++
    LDY #0
+++
    STY player_y_offset
    LDA #$08
    STA player_x_offset
    JSR Player_GetTileAndSlope
    CMP #TILE1_VINE
    BNE +

; Another vine to go upwards on, flag in air and set velocity
    LDY #-$10
    STY in_air
++
    STY player_y_vel  ; Set Player's Y Velocity

+
; Begin work on horizontal velocity
; If not holding left or right, no horizontal velocity
    LDA active_inputs
    AND #PAD_LEFT | PAD_RIGHT
    BEQ +

; Set right or left velocities respectively
    LDY #$10
    AND #PAD_LEFT
    BEQ ++
    LDY #-$10
++
    STY player_x_vel

+

; Set is_climbing if needed
    LDA is_climbing
    BEQ +
    LDA in_air
    BNE +
    LDA active_inputs
    AND #PAD_UP | PAD_DOWN
    BNE +
    STA is_climbing

+

; Apply Player's X and Y velocity for the vine climbing
    JSR Player_ApplyXVelocity
    JSR Player_ApplyYVelocity
    JSR Player_DoClimbAnim
    JSR _player_draw
    RTS


+player_not_climbing:

; Add slope velocity if needed
    LDA sliding_x_vel
    BEQ +
    LDA player_x_vel
    CLC
    ADC sliding_x_vel
    STA player_x_vel
+
    JSR Player_ApplyXVelocity

    LDA sliding_x_vel
    BEQ +

; Remove the previously gained sliding velocity
    LDA player_x_vel
    SEC
    SBC sliding_x_vel
    STA player_x_vel

+

; Sliding velocity does not persist
    LDA #$00
    STA sliding_x_vel

; Determine player's direction and the absolute value of the player's velocity
    LDY #2  ; Going right
    LDA player_x_vel
    BPL +
    NEG
    DEY     ; Going left
+
    BNE +
    TAY     ; Going nowhere
+
    STA __abs_player_vel
    STY player_movement_direction

    LDA in_air
    BEQ +  ; Don't fall through the ground

; Don't keep falling below the level?
    LDA player_y_hi
    BPL ++
    LDA player_y
    BMI ++

    LDA player_y_vel
    BMI +

++
    JSR Player_ApplyYVelocity

+
    JSR Player_CommonGroundAnims     ; Perform common ground animation routines

    LDA is_kuribo
    BEQ PRG008_A94C  ; If Player is not wearing Kuribo's shoe, jump to PRG008_A94C

    ; If in Kuribo's shoe...

    LDA #14      ; A = 14 (Kuribo's shoe code pointer)
    BNE PRG008_A956  ; Jump (technically always) to PRG008_A956

PRG008_A94C:
    LDA active_powerup

    LDY in_water
    BEQ PRG008_A956  ; If Player is not under water, jump to PRG008_A956

    CLC
    ADC #$07     ; Otherwise, add 7 (underwater code pointers)

PRG008_A956:
    ASL A        ; 2-byte pointer
    TAY      ; -> Y

    ; MOVEMENT LOGIC PER POWER-UP / SUIT

    ; NOTE: If you were ever one to play around with the "Judgem's Suit"
    ; glitch power-up, and wondered why he swam in the air and Kuribo'ed
    ; in the water, here's the answer!


    ; Get proper movement code address for power-up
    ; (ground movement, swimming, Kuribo's shoe)
    LDA PowerUpMovement_JumpTable,Y
    STA Temp_Var1
    LDA PowerUpMovement_JumpTable+1,Y
    STA Temp_Var2


    JMP (Temp_Var1)  ; Jump into the movement code!

PowerUpMovement_JumpTable:
    ; Ground movement code
    .word GndMov_Small  ; 0 - Small
    .word GndMov_Big    ; 1 - Big
    .word GndMov_FireHammer ; 2 - Fire
    .word GndMov_Leaf   ; 3 - Leaf
    .word GndMov_Frog   ; 4 - Frog
    .word GndMov_Tanooki    ; 5 - Tanooki
    .word GndMov_FireHammer ; 6 - Hammer

    ; Underwater movement code
    .word Swim_SmallBigLeaf ; 0 - Small
    .word Swim_SmallBigLeaf ; 1 - Big
    .word Swim_FireHammer   ; 2 - Fire
    .word Swim_SmallBigLeaf ; 3 - Leaf
    .word Swim_Frog     ; 4 - Frog
    .word Swim_Tanooki  ; 5 - Tanooki
    .word Swim_FireHammer   ; 6 - Hammer

    ; Kuribo's shoe
    .word Move_Kuribo

GndMov_Small:
    JSR Player_GroundHControl ; Do Player left/right input control
    JSR Player_JumpFlyFlutter ; Do Player jump, fly, flutter wag

    LDA Player_SandSink
    LSR A
    BCS PRG008_A9A3  ; If bit 0 of Player_SandSink was set, jump to PRG008_A9A3 (RTS)

    LDA Player_AllowAirJump
    BNE PRG008_A9A3  ; If Player_AllowAirJump, jump to PRG008_A9A3 (RTS)

    LDA in_air
    BEQ PRG008_A9A3  ; If Player is not mid air, jump to PRG008_A9A3 (RTS)

    ; Player is mid-air...

    LDA #PF_JUMPFALLSMALL   ; Standard jump/fall frame

    LDY Player_FlyTime
    BEQ PRG008_A9A1  ; If Player_FlyTime = 0, jump to PRG008_A9A1

    LDA #PF_FASTJUMPFALLSMALL    ; High speed jump frame

PRG008_A9A1:
    STA Player_Frame ; Set appropriate frame

PRG008_A9A3:
    RTS      ; Return

Swim_SmallBigLeaf:
    JSR Player_UnderwaterHControl ; Do Player left/right input for underwater
    JSR Player_SwimV ; Do Player up/down swimming action
    JSR Player_SwimAnim ; Do Player swim animations
    RTS      ; Return

GndMov_Big:
    JSR Player_GroundHControl ; Do Player left/right input control
    JSR Player_JumpFlyFlutter ; Do Player jump, fly, flutter wag
    JSR Player_SoarJumpFallFrame ; Do Player soar/jump/fall frame
    RTS      ; Return

    RTS      ; Return?

GndMov_FireHammer:
    JSR Player_GroundHControl ; Do Player left/right input control
    JSR Player_JumpFlyFlutter ; Do Player jump, fly, flutter wag
    JSR Player_SoarJumpFallFrame ; Do Player soar/jump/fall frame
    JSR Player_ShootAnim ; Do Player shooting animation
    RTS      ; Return

Swim_FireHammer:
    JSR Player_UnderwaterHControl ; Do Player left/right input for underwater
    JSR Player_SwimV ; Do Player up/down swimming action
    JSR Player_SwimAnim ; Do Player swim animations
    JSR Player_ShootAnim ; Do Player shooting animation
    RTS      ; Return

GndMov_Leaf:
    JSR Player_GroundHControl ; Do Player left/right input control
    JSR Player_JumpFlyFlutter ; Do Player jump, fly, flutter wag
    JSR Player_AnimTailWag ; Do Player's tail animations
    JSR Player_TailAttackAnim ; Do Player's tail attack animations
    RTS      ; Return

    RTS      ; Return?

GndMov_Frog:
    JSR Player_GroundHControl ; Do Player left/right input control
    JSR Player_JumpFlyFlutter ; Do Player jump, fly, flutter wag

    LDA is_holding
    BNE PRG008_AA23  ; If Player is holding something, jump to PRG008_AA23

    LDA in_air
    BEQ PRG008_AA00  ; If Player is NOT in mid air, jump to PRG008_AA00

    LDA Player_SandSink
    LSR A
    BCS PRG008_AA00  ; If bit 0 of Player_SandSink is set, jump to PRG008_AA00

    LDA #$00
    STA Player_FrogHopCnt    ; Player_FrogHopCnt = 0

    LDY #$01     ; Y = 1
    JMP PRG008_AA1E  ; Jump to PRG008_AA1E

PRG008_AA00:
    LDA Player_FrogHopCnt
    BNE PRG008_AA1A  ; If Player_FrogHopCnt <> 0, jump to PRG008_AA1A

    STA player_x_vel    ; player_x_vel = 0
    LDA active_inputs
    AND #PAD_LEFT | PAD_RIGHT
    BEQ PRG008_AA1A  ; If Player is not pressing left/right, jump to PRG008_AA1A

    ; Play frog hop sound
    LDA Sound_QPlayer
    ORA #SND_PLAYERFROG
    STA Sound_QPlayer

    LDA #$1f
    STA Player_FrogHopCnt ; Player_FrogHopCnt = $1f

PRG008_AA1A:
    LSR A
    LSR A
    LSR A
    TAY  ; Y = Player_FrogHopCnt >> 3

PRG008_AA1E:
    LDA Player_FrogHopFrames,Y  ; Get frog frame
    STA Player_Frame       ; Store as frame

PRG008_AA23:
    RTS      ; Return

Frog_SwimSoundMask:
    .byte $03, $07

    ; Base frame for the different swimming directions of the frog
Frog_BaseFrame:
    ; Down, Up, Left/Right
    .byte PF_FROGSWIM_DOWNBASE, PF_FROGSWIM_UPBASE, PF_FROGSWIM_LRBASE

    ; Frame offset to frames above
Frog_FrameOffset:
    .byte $02, $02, $02, $01, $00, $01, $02, $02

    ; Base velocity for frog swim right/down, left/up
Frog_Velocity:
    .byte 16, -16

Swim_Frog:
    LDX #$ff     ; X = $FF

    LDA active_inputs
    AND #PAD_UP | PAD_DOWN
    BEQ PRG008_AA61  ; If Player is NOT pressing up/down, jump to PRG008_AA61

    ;
    STA in_air

    LSR A
    LSR A
    LSR A
    TAX      ; X = 1 if pressing up, else 0

    LDA Frog_Velocity,X ; Get base frog velocity
    BPL PRG008_AA4D  ; If value >= 0 (if pressing down), jump to PRG008_AA4D

    LDY Player_AboveTop
    BPL PRG008_AA4D  ; If Player is not off top of screen, jump to PRG008_AA4D

    LDA #$00     ; A = 0

PRG008_AA4D:
    LDY active_inputs
    BPL PRG008_AA52  ; If Player is not pressing 'A', jump to PRG008_AA52

    ASL A        ; Double vertical speed

PRG008_AA52:
    CMP #PLAYER_FROG_MAXYVEL+1
    BLT PRG008_AA5C

    LDY in_air
    BNE PRG008_AA5C  ; If Player is swimming above ground, jump to PRG008_AA5C

    LDA #PLAYER_FROG_MAXYVEL     ; Cap swim speed

PRG008_AA5C:
    STA player_y_vel ; Set Y Velocity
    JMP PRG008_AA6E  ; Jump to PRG008_AA6E

PRG008_AA61:
    LDY player_y_vel
    BEQ PRG008_AA6E  ; If Y Velocity = 0, jump to PRG008_AA6E

    INY      ; Y++

    LDA player_y_vel
    BMI PRG008_AA6C  ; If player_y_vel < 0, jump to PRG008_AA6C

    DEY
    DEY      ; Y -= 2

PRG008_AA6C:
    STY player_y_vel ; Update Y Velocity

PRG008_AA6E:
    LDA active_inputs
    AND #PAD_LEFT | PAD_RIGHT
    BEQ PRG008_AA84  ; If Player is not pressing left or right, jump to PRG008_AA84

    ; Player is pressing left/right...

    LSR A
    TAY
    LDA Frog_Velocity,Y ; Get base frog velocity

    LDY active_inputs
    BPL PRG008_AA7E  ; If Player is not pressing 'A', jump to PRG008_AA7E

    ASL A        ; Double horizontal velocity

PRG008_AA7E:
    STA player_x_vel ; Update X Velocity

    LDX #$02     ; X = 2
    BNE PRG008_AA9C  ; Jump (technically always) to PRG008_AA9C

PRG008_AA84:
    LDY player_x_vel
    BEQ PRG008_AA94  ; If Player is not moving horizontally, jump to PRG008_AA94

    INY      ; Y++

    LDA player_x_vel
    BMI PRG008_AA8F  ; If player_x_vel < 0, jump to PRG008_AA8F

    DEY
    DEY      ; Y -= 2

PRG008_AA8F:
    STY player_x_vel ; Update X Velocity
    JMP PRG008_AA9C  ; Jump to PRG008_AA9C

PRG008_AA94:
    LDA in_air
    BNE PRG008_AA9C  ; If Player is swimming above ground, jump to PRG008_AA9C

    LDA #$15     ; A = $15
    BNE PRG008_AAD2  ; Jump (technically always) to PRG008_AAD2

PRG008_AA9C:
    TXA
    BMI PRG008_AAC8  ; If X < 0, jump to PRG008_AAC8

    LDA tick_counter
    LSR A
    LSR A

    LDY #$00     ; Y = 0

    BIT active_inputs
    BMI PRG008_AAAB  ; If Player is holding 'A', jump to PRG008_AAAB

    LSR A        ; Otherwise, reduce velocity adjustment
    INY      ; Y++

PRG008_AAAB:
    AND #$07
    TAY
    BNE PRG008_AABF

    LDA tick_counter
    AND Frog_SwimSoundMask,Y
    BNE PRG008_AABF  ; If timing is not right for frog swim sound, jump to PRG008_AABF

    ; Play swim sound
    LDA Sound_QPlayer
    ORA #SND_PLAYERSWIM
    STA Sound_QPlayer

PRG008_AABF:
    LDA Frog_BaseFrame,X
    CLC
    ADC Frog_FrameOffset,Y
    BNE PRG008_AAD2

PRG008_AAC8:
    LDY #PF_FROGSWIM_IDLEBASE

    LDA tick_counter
    AND #$08
    BEQ PRG008_AAD1

    INY

PRG008_AAD1:
    TYA

PRG008_AAD2:
    STA Player_Frame ; Update Player_Frame
    RTS      ; Return

GndMov_Tanooki:
    JSR Player_TanookiStatue  ; Change into/maintain Tanooki statue (NOTE: Will not return here if statue!)
    JSR Player_GroundHControl ; Do Player left/right input control
    JSR Player_JumpFlyFlutter ; Do Player jump, fly, flutter wag
    JSR Player_AnimTailWag ; Do Player's tail animations
    JSR Player_TailAttackAnim ; Do Player's tail attack animations
    RTS      ; Return

Swim_Tanooki:
    JSR Player_TanookiStatue ; Change into/maintain Tanooki statue (NOTE: Will not return here if statue!)
    JSR Player_UnderwaterHControl ; Do Player left/right input for underwater
    JSR Player_SwimV ; Do Player up/down swimming action
    JSR Player_SwimAnim ; Do Player swim animations
    RTS      ; Return

Move_Kuribo:
    JSR Player_GroundHControl ; Do Player left/right input control
    JSR Player_JumpFlyFlutter ; Do Player jump, fly, flutter wag

    LDA in_air
    BNE PRG008_AAFF  ; If Player is mid air, jump to PRG008_AAFF

    STA is_kuriboDir     ; Clear is_kuriboDir

PRG008_AAFF:
    LDA is_kuriboDir
    BNE PRG008_AB17  ; If Kuribo's shoe is moving, jump to PRG008_AB17

    LDA in_air
    BNE PRG008_AB25  ; If Player is mid air, jump to PRG008_AB25

    LDA active_inputs
    AND #PAD_LEFT | PAD_RIGHT
    STA is_kuriboDir     ; Store left/right pad input -> is_kuriboDir
    BEQ PRG008_AB25     ; If Player is not pressing left or right, jump to PRG008_AB25
    INC in_air    ; Flag as in air (Kuribo's shoe bounces along)

    LDY #-$20
    STY player_y_vel     ; player_y_vel = -$20

PRG008_AB17:
    LDA new_inputs
    BPL PRG008_AB25  ; If Player is NOT pressing 'A', jump to PRG008_AB25

    LDA #$00
    STA is_kuriboDir     ; is_kuriboDir = 0

    LDY Player_RootJumpVel   ; Get initial jump velocity
    STY player_y_vel     ; Store into Y velocity

PRG008_AB25:
    LDY active_powerup
    BEQ PRG008_AB2B  ; If Player is small, jump to PRG008_AB2B

    LDY #$01     ; Otherwise, Y = 1

PRG008_AB2B:

    ; Y = 0 if small, 1 otherwise

    LDA is_kuriboFrame,Y    ; Get appropriate Kuribo's shoe frame
    STA Player_Frame       ; Store as active Player frame

    LDA tick_counter
    AND #$08
    BEQ PRG008_AB38     ; Every 8 ticks, jump to PRG008_AB38

    INC Player_Frame   ; Player_Frame++

PRG008_AB38:
    RTS      ; Return


player_update_ducking:
; Do checks to disable ducking if needed
    LDY active_powerup
    LDA powerup_can_duck, y
    BNE +

    LDA is_holding
    ORA is_sliding
    ORA is_kuribo
    BNE +

    LDA in_air
    BEQ player_ground_duck_check    

    LDA in_water
    BEQ player_air_duck_check

; If the player is in water

+

; Forcefully disable any ducking
    LDA #$00
    STA is_ducking
    BEQ +           ; JMP +

player_air_duck_check:
; Keep the player ducked if already ducking
    LDA is_ducking
    BNE set_player_ducking
    BEQ player_ducking_check_finished

player_ground_duck_check:
; Have an additional check for slopes
    LDA #$00
    STA is_ducking

    LDA is_sloped
    BEQ player_input_duck_check

; Disable ducking if we are sliding
    LDA sliding_x_vel
    BNE player_ducking_check_finished

player_input_duck_check:

; Ensure the player is holding down
    LDA active_inputs
    AND #PAD_LEFT | PAD_RIGHT | PAD_UP | PAD_DOWN
    CMP #PAD_DOWN
    BNE player_ducking_check_finished     ; If Player is not just holding down, jump to +

set_player_ducking:
    STY is_ducking    ; Set ducking flag (uses non-zero suit value)

player_ducking_check_finished:
    RTS


player_input_water_check:
; Solid check
    LDA __head_block
    if_solid            ; Macro for checking if solid from custom_macros.asm
    BLT +

; Is solid
    LDA in_air
    ORA in_water
    ORA pipe_movement
    BNE +               ; If Player is mid air, in water, or moving in a pipe, jump to +

; Player is stuck inside a wall (we need to help them not cheese the game)
    ; LDA #$00 (implied)
    STA player_x_vel
    STA new_inputs

    LDA #$01
    STA is_stuck_in_wall        ; Aye game we're stuck in a wall over here!

; Make the player slide left (no more cheese for you >:p)
    SEC
    SBC player_x
    STA player_x
    BCC +
    DEC player_x_hi             ; Apply carry

+

; End of special inside wall checks
    ; This will be used in Level_CheckIfTileUnderwater
    ; as bits 2-3 of an index into Level_MinTileUWByQuad
    LDA tileset
    ASL A
    ASL A
    STA Temp_Var3   ; Temp_Var3 = tileset << 2

; Check if Mario's head is underwater
    LDX #$00        
    JSR Level_CheckIfTileUnderwater

; Check if the head hit a solid
    BCS +

; 0 = Not under water, 1 = Underwater, 2 = Waterfall
    TYA
    BNE +likely_in_water

+
; Either inside a solid block or not underwater

; Jump if the player isn't in water and wasn't in it prior
    LDA in_water
    BEQ +input_check_end  

; Jump if the player is not on the ground, but were in the water last frame
    LDA in_air
    BNE +

; The player was in the water last frame, but are on the ground

; If the player was underwater and in a solid block, ignore water checks
; If the player was underwater and in an air region, consider ourselves out of water
    BCS +input_check_end
    BCC +not_underwater

+
; The player is not on the ground, head not in water, and was in water last frame

    BCS +

    LDA player_y_vel
    BMI ++

+
; The player's head is a solid, but was in water last frame

; Stash the carry (if solid) value in bit 7
    ROR A
    STA Temp_Var16  

; Check if the feets are getting dipped in water
    LDX #$01
    JSR Level_CheckIfTileUnderwater

    BCS +  ; If tile was in the floor solid region, jump to +

    TYA
    BEQ +not_underwater

+
; In a solid tile or underwater
    LDA Temp_Var16
    BMI +likely_in_water

++
; The player is moving upward or moving downward w/o hitting a solid or water block

; Cap swim upwards velocity to -12
    LDY player_y_vel
    CPY #-12
    BGS +
    LDY #-12

+
; Every 8 ticks apply gravity (in water)
    LDA tick_counter
    AND #$07
    BNE +
    INY

+
; Push the new player's velocity
    STY player_y_vel

; Remove any A presses
    LDA new_inputs
    AND #<~PAD_A
    STA new_inputs

; Remove any up inputs and stash the 'old' inputs in Y
    LDA active_inputs
    TAY
    AND #<~PAD_UP
    STA active_inputs

    TYA
    AND #PAD_UP | PAD_A
    CMP #PAD_UP | PAD_A
    BNE +input_check_end  ; If Player is not pressing UP + A, jump to +input_check_end

; Set the exit velocity for water
    LDA #-54
    STA player_y_vel

+not_underwater:

; Set swim counter to 0
    LDY #$00
    STY swim_counter
    BEQ +    ; JMP +

+likely_in_water
    LDY Temp_Var15
    CPY in_water
    BEQ +input_check_end

+
; Merge water status flags
    TYA
    ORA in_water
    STY in_water                ; Merge water flag status
    CMP #$02
    BEQ +input_check_end

    JSR Player_WaterSplash      ; Hit water; splash!

+input_check_end
    RTS


player_input_door_check:
; Cannot enter a door if not holding up
    LDA new_inputs
    AND #PAD_UP
    BEQ + 

; Check that we are not in the air
    LDA in_air
    BNE +

    LDA __head_block

; Check fortress only door
    LDY tileset
    CPY #$01
    BNE +
    CMP #TILEA_DOOR1
    BEQ player_is_in_door_block

+

; Check universal door block
    CMP #TILEA_DOOR2
    BNE +

player_is_in_door_block:
; Exit to the map or to another level depending on level header
    LDY #$01
    LDA no_exit_to_map
    BEQ ++
    LDY #$03
++
    STY level_junction_type ; Set appropriate value to level_junction_type

; Reset the return status and x velocity
    LDY #$00
    STY return_status_from_level
    STY player_x_vel

; Center the player on the door
    LDA player_x
    AND #$08
    BEQ ++
    LDY #16
++
    TYA
    CLC
    ADC player_x
    AND #$F0
    STA player_x

+
    RTS
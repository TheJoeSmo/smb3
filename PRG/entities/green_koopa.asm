; The green koopa extracted from the game such that it can be used without
; being forced to be in the third bank and optimized.
;
; Disassembly by Southbird  - http://www.sonicepoch.com/sm3mix/
; Adapted by JoeSmo         - https://www.patreon.com/JoeSmo
; Supporters:
;     SMB3 Prime            - https://discord.gg/x2M2Z8hErp
;
; For modification: Provide credit and links to aforementioned peoples
;---------------------------------------------------------------------------

GreenKoopa                  = $10
GreenKoopaPalette           = OA1_PAL2 | OA1_HEIGHT32 | OA1_WIDTH16
GreenKoopaCollision         = OA2_GNDPLAYERMOD | OA2_TDOGRP1
GreenKoopaSpecial           = OA3_HALT_NORMALONLY | OA3_DIESHELLED
GreenKoopaPatterns          = OPTS_SETPT6 | $4F
GreenKoopaKillAction        = KILLACT_JUSTDRAWMIRROR
GreenKoopaBoundBox          = OAT_BOUNDBOX01

GreenKoopa_State            = Objects_Var2
GreenKoopa_NORMAL           = 0
GreenKoopa_SHELLED          = 1
GreenKoopa_HELD             = 2
GreenKoopa_KICKED           = 3

GreenKoopa_STOMP_RANGE      = 19

GreenKoopa_Invincibility    = Objects_Timer2
GreenKoopa_WakeUpTimer      = Objects_Timer3

GreenKoopa_ShelledWakeUpDirection:
GreenKoopa_FlipTowardsPlayer:
    .byte SPR_HFLIP, $00

GreenKoopa_AnimationDelay:
    .byte $FF, $C0, $80, $60, $40

; Collision of the entity hit by a held shell upon death
GreenKoopa_HeldCollisionXVel:

; X velocities of a bumped koopa
GreenKoopa_BumpVelocity:

GreenKoopa_XVel:
    .byte -$08, $08
    .byte -$06, $06
    .byte -$05, $05

; In units of $10 ticks by timer 3
GreenKoopa_ShakeBitMask:
    .byte %00000010, %00000010, %00000100, %00001000, %00010000, %00010000

; The feet of the waking koopa offsets Y for being vertically flipped
GreenKoopa_ShakeYOffset:
    .byte 10, -10

; Set appropriate flip bits based on object's relative position to player
GreenKoopa_KickPlayerDirection: 
    .byte $00, $40

GreenKoopa_FrameYOffset:
    .byte $06, $05

GreenKoopa_Frames:
    .byte $CB, $C5, $C3, $C5, $FD, $FD, $FD, $FD, $FD, $FD, $D1, $D1, $D3, $D5

; Select (1st, 2nd) if the frame is even, otherwise (2nd, 3rd) for the foot sprite patterns.
GreenKoopa_FootByEvenOddFrame:
    .byte $C7, $C9, $C7 ; Even
    .byte $F9, $FB, $F9 ; Odd

; X velocities of kicking a shell added to by half of player's X velocity
GreenKoopa_KickVelocity:
    .byte -$30, $30

; Different X and X Hi offsets applied to the held shell depending on the direction and if entering a pipe
GreenKoopa_HeldXOffset:
    .byte $0B, -$0B, $04, -$04, $04, $0B, -$13, $04, -$08, $04, $00
GreenKoopa_HeldXHiOffset:
    .byte $00,  $FF, $00,  $FF, $00, $00,  $FF, $00,  $FF, $00, $00

; Kicked shell object animation frames AND flips
GreenKoopa_ShellAnimFlipBits:
    .byte $00, $00, $00, $40
GreenKoopa_AnimFrame:
    .byte $04, $06, $05, $06
GreenKoopa_BaseKickVelocity:
    .byte $18, -$18

ObjInit_GreenKoopa:
    JSR Level_ObjCalcXDiffs

    ; Use GreenKoopa_State to manage the state of the koopa, as we don't use the object's state to our advantage
    LDA #GreenKoopa_NORMAL
    STA GreenKoopa_State, x

    ; Face Player when appearing
    LDA GreenKoopa_FlipTowardsPlayer, y
    STA Objects_FlipBits, x
    RTS


ObjNorm_GreenKoopa:
    ; Delete object if it falls off-screen
    JSR Object_DeleteOffScreen

    ; We handle the special commands of the koopa internally.
    LDA GreenKoopa_State, x
    JSR DynJump

    .word GreenKoopa_Update
    .word GreenKoopa_Shelled
    .word GreenKoopa_Held
    .word GreenKoopa_Kicked

GreenKoopa_Update:
    ; Check if we should do halted or normal action
    LDA Player_HaltGame
    BEQ GreenKoopa_NormalAction

    GreenKoopa_HaltedAction:
        ; Draw the enemy and don't come back!
        JMP GreenKoopa_Draw

GreenKoopa_NormalAction:
    ; Set Y = 0 or 1, depending if horizontally flipped or not
    LDA Objects_FlipBits, x
    ASL A
    ASL A
    ROL A
    AND #$01
    TAY      

    ; Objects_TargetingXVal is set if koopa is hit by a left/right bouncing block
    LDA Objects_TargetingXVal, x
    BPL GreenKoopa_ApplyXVel
        INY             ; Use 2nd index
        INY

        CMP #-$02
        BNE GreenKoopa_ApplyXVel
            INY         ; Use 3rd index
            INY

GreenKoopa_ApplyXVel:
    ; Set X velocity
    LDA GreenKoopa_XVel, y
    STA Objects_XVel, x

    ; Toggle frame 0/1
    LDA Objects_Var5, x
    LSR A
    LSR A
    AND #$01
    STA Objects_Frame, x

    LDA Objects_Var1, x
    BEQ GreenKoopa_StandardMovement
        ; Abridged movement (var 1 is set)
        DEC Objects_Var1, x

        ; Apply x velocity
        JSR Object_ApplyXVel

        ; Update frame counter
        INC Objects_Var5, x

        ; Draw and detect the player hitting the koopa.
        JSR GreenKoopa_Draw
        JMP GreenKoopa_CheckPlayerCollision

GreenKoopa_StandardMovement:
    ; Draw and do standard movements
    JSR GreenKoopa_Draw
    CrossJumpToA 1, Object_Move

    ; If this enemy is in contact with a left/right bouncing block, set Objects_TargetingXVal
    LDA LRBounce_Vel
    STA Objects_TargetingXVal, x

    ; Handle bouncing off other enemies
    JSR GreenKoopa_BumpOffOthers

    LDY LRBounce_Vel
    INY
    INY

    ; Apply animation delay and increase frame is required.
    LDA Objects_Var7, x
    CLC
    ADC GreenKoopa_AnimationDelay, y
    STA Objects_Var7, x
    BCC GreenKoopa_ChangeFrameSkip
        INC Objects_Var5, x

GreenKoopa_ChangeFrameSkip:
    ; Check if we hit the ground, walls, or ceiling
    LDA Objects_DetStat, x
    AND #$04
    BNE GreenKoopa_HitGround

    GreenKoopa_DidNotHitGround:
        LDA Objects_DetStat, x
        AND #$08
        BEQ GreenKoopa_DidNotHitCeiling

        GreenKoopa_HitCeiling:
            ; Bounce off the ceiling
            LDA #$01
            STA Objects_YVel, x

    GreenKoopa_DidNotHitCeiling:
        STA Objects_Var5, x
        JMP GreenKoopa_CheckWallCollision

GreenKoopa_HitGround:
    ; Align to the floor
    JSR Object_HitGround

GreenKoopa_CheckWallCollision:
    LDA Objects_DetStat, x
    AND #$03
    BEQ GreenKoopa_DidNotHitWall
        ; Turn around and go the other direction.
        JSR Object_FlipFace

GreenKoopa_DidNotHitWall:
    JMP GreenKoopa_CheckCommonCollision


GreenKoopa_Draw:
    ; Ignore the first two sprite slots, to make it more compatible with flying variants
    LDA Object_SprRAM, x
    CLC
    ADC #$08
    STA Object_SprRAM, x

    ; Get the y offset based off the frame used
    LDY Objects_Frame, x
    LDA GreenKoopa_FrameYOffset, y
    TAY

    ; Handles much of the directional nature of the koopa using the the frame y offset
    JSR GreenKoopa_DrawOffsetInY

    ; Determine which direction the koopa is facing
    LDA Objects_FlipBits, x
    STA Temp_Var2
    BEQ GreenKoopa_DrawNotFlipped
        ; Use the next sprite to draw the head
        INY
        INY
        INY
        INY

GreenKoopa_DrawNotFlipped:
    ; If this sprite is vertically off-screen, jump to GreenKoopa_DrawOcciput
    LDA Sprite_RAM+$00, y
    CMP #$f8
    BEQ GreenKoopa_DrawOcciput

    ; Set the y position of the head
    SEC
    SBC #16
    STA Sprite_RAM-$08, y

    ; Set the head pattern of the koopa
    LDA #$c1
    STA Sprite_RAM-$07, y

    ; Set the x position of the head
    LDA Sprite_RAM+$03, y
    STA Sprite_RAM-$05, y

    ; Set the attributes (correct palette) of the head
    LDA Sprite_RAM+$02, y
    AND #<~$03
    ORA #SPR_PAL3
    STA Sprite_RAM-$06, y
    STA Sprite_RAM+$02, y

GreenKoopa_DrawOcciput:
    ; Sprite on opposite side of whatever we just put the head on (not actually used)

GreenKoopa_DrawLeftFoot:
    ; Set the Y offset of the left foot if it is on screen
    LDY Object_SprRAM, x

    LDA Sprite_RAM+$00, y
    CMP #$f8
    BEQ GreenKoopa_DrawRightFoot

        ; Left foot appears at Sprite Y + 16
        CLC
        ADC #16
        STA Sprite_RAM+$08, y

GreenKoopa_DrawRightFoot:
    ; Set the Y offset of the right foot if it is on screen
    LDA Sprite_RAM+$04, y
    CMP #$f8
    BEQ GreenKoopa_DrawSetAttributes

        ; Right foot appears at Sprite Y + 16
        CLC
        ADC #16
        STA Sprite_RAM+$0C, y

GreenKoopa_DrawSetAttributes:
    ; Copy Sprite X for left foot
    LDA Sprite_RAM+$03, y
    STA Sprite_RAM+$0B, y

    ; Copy Sprite X for right foot
    LDA Sprite_RAM+$07, y
    STA Sprite_RAM+$0F, y

    ; Set correct palette for the feet of the koopa
    LDA Sprite_RAM+$02, y
    AND #<~$03
    ORA #SPR_PAL3
    STA Sprite_RAM+$0A, y
    STA Sprite_RAM+$0E, y

    ; Alternate the sprite being drawn every other frame
    LDA Objects_Frame, x
    LDX #$00
    LSR A
    BCC GreenKoopa_DrawFootByEvenOddFrame
        INX
        INX
        INX

GreenKoopa_DrawFootByEvenOddFrame:
    ; Use an alternative frame for flipped foot
    LDA Temp_Var2
    BEQ GreenKoopa_DrawApplyFootFrame
        INX

GreenKoopa_DrawApplyFootFrame:
    ; Apply left and right foot frames
    LDA GreenKoopa_FootByEvenOddFrame, x
    STA Sprite_RAM+$09, y
    LDA GreenKoopa_FootByEvenOddFrame+1, x
    STA Sprite_RAM+$0D, y

    ; Restore entity index
    LDX SlotIndexBackup
    RTS

GreenKoopa_DrawOffsetInY:
    ; Store the Y offset of the koopa, typically 5 or 6 pixels
    STY Temp_Var1

    ; Quickly calculate the location of the sprite
    JSR Object_CalcSpriteXY_NoHi

    ; Load the sprite offset
    LDY Object_SprRAM, x

    ; Do not do anything if koopa is vertically offscreen.
    LDA Objects_SprVVis, x
    LSR A
    BCS GreenKoopa_DrawOffsetInYReturn

    ; Check if the sprite is horizontally offscreen and do not apply the offset if so.
    LDA Objects_SprHVis, x
    STA Temp_Var3

    ; Apply the offset to the left sprite
    LDA Objects_SpriteY, x
    SEC
    SBC Temp_Var1
    ASL Temp_Var3
    BCS +
        STA Sprite_RAM+$00, y
    +

    ; Apply the offset to the right sprite
    ASL Temp_Var3
    BCS +
        STA Sprite_RAM+$04, y
    +

    ; Set left and right sprite X
    LDA Objects_SpriteX, x
    STA Sprite_RAM+$03, y
    CLC
    ADC #$08
    STA Sprite_RAM+$07, y

    ; Store flip bits into a temporary variable to use a bit operation to optimize horizontal flipped bit check later.
    LDA Objects_FlipBits, x
    STA Temp_Var1

    ; Combine flipped bits with common attributes and set sprites
    ORA Objects_SprAttr, x
    STA Sprite_RAM+$02, y
    STA Sprite_RAM+$06, y

    ; Finds the koopa's frames by current frame * 2 + koopa pattern offset
    LDA Objects_Frame, x
    ASL A
    TAX
    LDA GreenKoopa_Frames, x

    ; If horizontally flipped set right sprite pattern, otherwise set left sprite pattern
    BIT Temp_Var1
    BVS GreenKoopa_SetPatternFlipped
        ; Store left and right pattern
        STA Sprite_RAM+$01, y

        LDA GreenKoopa_Frames+1, x
        STA Sprite_RAM+$05, y

        JMP GreenKoopa_DrawOffsetInYFinished

    GreenKoopa_SetPatternFlipped:
        ; Store right and left pattern
        STA Sprite_RAM+$05, y

        LDA GreenKoopa_Frames+1, x ; Get the next pattern
        STA Sprite_RAM+$01, y

GreenKoopa_DrawOffsetInYFinished:
    LDX SlotIndexBackup

GreenKoopa_DrawOffsetInYReturn:
    RTS      ; Return


GreenKoopa_Shelled:
    ; Only do basic drawing if the game is paused.
    LDA Player_HaltGame
    BNE GreenKoopa_ShelledDraw

GreenKoopa_ShelledUpdate:
    ; Handle waking up the koopa when needed.
    JSR GreenKoopa_ShellWakeUp
    
    ; Perform standard movement
    CrossJumpToA 1, Object_Move

    ; If shell did not hit floor or ceiling
    LDA Objects_DetStat, x
    AND #$04
    BEQ GreenKoopa_ShelledCheckCeiling
    LDA Objects_YVel, x
    BMI GreenKoopa_ShelledCheckCeiling
        ; Save Y velocity
        PHA

        ; Align the shell to the ground
        JSR Object_HitGround

        LDA Objects_XVel, x
        PHP

        ; Get absolute value of X velocity and divide it in half
        BPL +
            NEG
        +
        LSR A

        ; If needed to negate before, negate again and set velocity
        PLP
        BPL +
            NEG
        +
        STA Objects_XVel, x

        ; Divide y velocity by 4
        PLA
        LSR A
        LSR A
        NEG
        CMP #-$02
        BGE GreenKoopa_ShelledCheckCeiling  ; If lightly moving upward, do not change velocity
            STA Objects_YVel, x

GreenKoopa_ShelledCheckCeiling:
    ; Rebound off ceiling if shell hit ceiling
    LDA Objects_DetStat, x
    AND #$08
    BEQ GreenKoopa_ShelledCheckWalls
        LDA #$10
        STA Objects_YVel, x

GreenKoopa_ShelledCheckWalls:
    ; Face the opposite direction if hit a wall
    LDA Objects_DetStat, x
    AND #$03
    BEQ GreenKoopa_ShelledStandardInteractions
        JSR Object_AboutFace

GreenKoopa_ShelledStandardInteractions:
    JSR GreenKoopa_CheckCommonCollision

GreenKoopa_ShelledBumpOffOthers:
    JSR GreenKoopa_BumpOffOthers

GreenKoopa_ShelledDeleteOfScreenAndDraw:
    JSR Object_DeleteOffScreen

GreenKoopa_ShelledDraw:
    ; Used the shelled frame
    LDA #$02
    STA Objects_Frame, x

    JSR Object_ShakeAndCalcSprite
    JSR GreenKoopa_Draw16x16Sprite

    LDX SlotIndexBackup
    ; Keep all attributes except horizontal flip
    LDA Sprite_RAM+$02, y
    AND #%10111111
    STA Sprite_RAM+$02, y

    ; Flip opposite sprite
    ORA #$40
    STA Sprite_RAM+$06, y

    ; Update the shell timer
    JSR GreenKoopa_SetShakeAwakeTimer

    ; If awake timer is not less than 50, do not apply any shaking effect
    LDA GreenKoopa_WakeUpTimer, x
    CMP #$50
    BGE GreenKoopa_ShellWakeUpReturn

    ; Generate a shaking effect by combining the timer with a bit mask on alternating frames
    LSR A
    LSR A
    LSR A
    LSR A
    TAY
    LDA GreenKoopa_WakeUpTimer, x
    AND GreenKoopa_ShakeBitMask, y
    BEQ GreenKoopa_ShellWakeUpReturn
        ; X, Y <- entity is vertically flipped, sprite ram offset
        LDA #$01
        LDY Objects_FlipBits, x
        BMI +
            LSR A
        +
        LDY Object_SprRAM, x  ; Y = object's Sprite_RAM offset
        TAX

        ; Draw left foot if left foot is on screen with the provided offset
        LDA Sprite_RAM+$00, y
        CMP #$f8
        BEQ GreenKoopa_ShakeDrawRightFoot
            CLC
            ADC GreenKoopa_ShakeYOffset, x
            CMP #$c5
            BGE GreenKoopa_ShakeApplyFeetAttributes
                STA Sprite_RAM+$08, y

        GreenKoopa_ShakeDrawRightFoot:
            LDA Sprite_RAM+$04, y
            CMP #$f8
            BEQ GreenKoopa_ShakeApplyFeetAttributes
                CLC
                ADC GreenKoopa_ShakeYOffset, x
                STA Sprite_RAM+$0C, y

    GreenKoopa_ShakeApplyFeetAttributes:
        ; Apply X position
        LDA Sprite_RAM+$03, y
        SEC
        SBC #$03
        STA Sprite_RAM+$0B, y
        LDA Sprite_RAM+$07, y
        CLC
        ADC #$03
        STA Sprite_RAM+$0F, y

        ; Set attributes
        LDA Sprite_RAM+$02, y
        AND #$80
        ORA #$03
        STA Sprite_RAM+$0A, y

        ; Flip one of the feet
        ORA #$40
        STA Sprite_RAM+$0E, y

        ; Set feet patters
        LDA #$f9
        STA Sprite_RAM+$09, y
        STA Sprite_RAM+$0D, y

        LDX SlotIndexBackup

GreenKoopa_ShellWakeUpReturn:
    RTS


GreenKoopa_ShellWakeUp:
    ; Don't do anything until the timer has expired
    LDA GreenKoopa_WakeUpTimer, x
    BNE GreenKoopa_ShellWakeUpReturn

GreenKoopa_ShakeOutOfShell:
    LDA GreenKoopa_State, x
    CMP #GreenKoopa_HELD
    BNE GreenKoopa_ShelledGoToNormalState

    GreenKoopa_ShelledCheckInsideWall:
        CrossJumpToA 1, Object_WorldDetectN1
        LDA Objects_DetStat, x
        BEQ GreenKoopa_ShelledGoToNormalState
            ; The shell is inside a wall, so die instantly.
            JSR GreenKoopa_KillShell
            BEQ GreenKoopa_ShelledWakeUpDirectionFinish  ; Always branch

GreenKoopa_ShelledGoToNormalState:
    ; Wake up and go towards the player
    LDA #GreenKoopa_NORMAL
    STA GreenKoopa_State, x
    JSR Level_ObjCalcXDiffs
    LDA GreenKoopa_ShelledWakeUpDirection, y
    STA Objects_FlipBits, x

GreenKoopa_ShelledWakeUpDirectionFinish:
    ; Do NOT return to caller!
    PLA
    PLA
    JMP GreenKoopa_ShelledDeleteOfScreenAndDraw


GreenKoopa_SetShakeAwakeTimer:
    ; If timer 3 >= $60, set timer 4 = 0 - 7.
    LDA GreenKoopa_WakeUpTimer, x
    CMP #$60
    BGE +
        AND #$07
        STA Objects_Timer4, x

    +
    RTS


GreenKoopa_Held:
    ; Only draw the shell if the player is dieing
    LDA Player_IsDying
    BEQ +
        JMP GreenKoopa_ShelledDraw
    +

    ; Handle waking up out of the shell
    JSR GreenKoopa_ShellWakeUp

    ; If the player is not holding B, then try to kick the shell
    BIT Pad_Holding
    BVC GreenKoopa_Kick

-
    JMP GreenKoopa_HeldUpdate


GreenKoopa_Kick:
    ; If the player is moving through a pipe, simply do a normal held action
    LDA Level_PipeMove
    BNE -

    ; Play the kick sound
    LDA Sound_QPlayer
    ORA #SND_PLAYERKICK
    STA Sound_QPlayer

    ; Have Player do kick frame
    LDA #$0C
    STA Player_Kick

    ; Set object timer 2 to $10
    LDA #$10
    STA GreenKoopa_Invincibility, x

    ; Clear Objects_KillTally
    LDA #$00
    STA Objects_KillTally, x

    LDA GreenKoopa_State, x
    CMP #GreenKoopa_HELD
    BNE GreenKoopa_StandingKick
        ; Detect 1 pixel in front of the kicked shell
        LDY #1
        LDA Player_FlipBits
        BNE +
            LDY #-1
        +
        STY Objects_XVel, x
        CrossJumpToA 1, Object_WorldDetectN1

        ; Kill the shell if it was kicked into a wall
        LDA Objects_DetStat, x
        AND #$03
        BEQ GreenKoopa_HeldKickNormal
            JSR GreenKoopa_KillShell
            JMP GreenKoopa_HeldDraw

    GreenKoopa_HeldKickNormal:
        ; Determine if the shell should be kicked left or right by the direction the player is flipped
        LDY #0
        LDA Player_FlipBits
        BEQ +
            INY
        +
        JMP GreenKoopa_KickApplyKick

GreenKoopa_StandingKick:
    ; Calculate which way the shell should be kicked and make the player face the shell
    JSR Level_ObjCalcXDiffs
    LDA GreenKoopa_KickPlayerDirection, y
    STA Player_FlipBits

GreenKoopa_KickApplyKick:
    ; Apply the kick velocity to the shell
    LDA GreenKoopa_KickVelocity, y
    STA Objects_XVel, x

    ; Check if the player is moving in the same direction, then we will add the half player's velocity as well
    EOR Player_XVel
    BMI +
        LDA Player_XVel
        STA Temp_Var1
        ASL Temp_Var1
        ROR A
        CLC
        ADC GreenKoopa_KickVelocity, y
        STA Objects_XVel, x
    +

    ; The shell is now kicked
    LDA #GreenKoopa_KICKED
    STA GreenKoopa_State, x

    ; Remove velocity of the shell
    LDA #$00
    STA Objects_YVel, x

    JMP GreenKoopa_HeldDraw


GreenKoopa_HeldUpdate:
    ; Keep holding the shell
    LDA #$01
    STA Player_IsHolding

    ; If the player is moving through a pipe, use the 10th offset by default, otherwise the 1st
    LDA Level_PipeMove
    BEQ +
        LDY #$0a
        BNE ++
    +
    LDY #$00

    ; Use the next offset if the player is facing the opposite direction
    LDA Player_FlipBits
    BNE +
        INY
    +

    ; If the player is entering a vertical pipe use the 12th or 13th offset instead
    LDA Player_PipeFace
    BEQ GreenKoopa_HeldApplyXOffset
        INY
        INY

        ; And use no offset for the last 5 ticks
        CMP #$05
        BLT ++
            INY
    ++

    ; The held entity takes the 5th sprite slot
    LDA #$10
    STA Object_SprRAM, x

GreenKoopa_HeldApplyXOffset:
    ; Set the x distance a fixed distance away from the player
    LDA Player_X
    CLC
    ADC GreenKoopa_HeldXOffset, y
    STA Objects_X, x
    LDA Player_XHi
    ADC GreenKoopa_HeldXHiOffset, y
    STA Objects_XHi, x

    ; Set the y distance a fixed distance relative to the player being super or not 
    LDA #$0d
    LDY Player_Suit
    BNE +
        LDA #$0f
    +
    CLC
    ADC Player_Y
    STA Objects_Y, x
    LDA #$00
    ADC Player_YHi
    STA Objects_YHi, x

    ; Match the velocity of the player
    LDA Player_XVel
    STA Objects_XVel, x
    LDA Player_YVel
    STA Objects_YVel, x

    ; Only check if every other frame and if the player is not entering a pipe
    LDA GreenKoopa_Invincibility, x
    ORA Level_PipeMove
    BNE GreenKoopa_HeldDraw     ; If timer 2 is not expired or Player is moving through pipes, jump to GreenKoopa_HeldDraw

    ; Check if the shell had collided with another entity, otherwise only draw the shell
    CrossJumpToA 1, Object_WorldDetectN1
    JSR Object_CalcSpriteXY_NoHi
    JSR ObjectToObject_HitTest
    BCC GreenKoopa_HeldDraw
        ; Play the sound for killing the two entities
        LDA Sound_QPlayer
        ORA #SND_PLAYERKICK
        STA Sound_QPlayer

        ; Kill the held shell and make it fly upward
        LDA #OBJSTATE_KILLED
        STA Objects_State, x
        LDA #-$30
        STA Objects_YVel, x

        ; Kill the affected entity and make it fly upward
        LDA #OBJSTATE_KILLED
        STA Objects_State, y
        LDA #-$30
        STA Objects_YVel, y

        ; Give the player some points
        LDA #$00
        JSR Score_Get100PlusPts

        ; Object will not collide again for 16 ticks (dampener I guess)
        LDA #16
        STA GreenKoopa_Invincibility, x

        ; Provide a velocity to be applied to the affected entity
        TYA
        TAX
        JSR Level_ObjCalcXDiffs
        LDA GreenKoopa_HeldCollisionXVel, y
        STA Objects_XVel, x

GreenKoopa_HeldDraw:
    LDX SlotIndexBackup
    JMP GreenKoopa_ShelledDraw


GreenKoopa_KillShell:
    ; Give the player 100 points
    LDA #$05
    JSR Score_PopUp

    ; Set object state to Killed
    LDA #OBJSTATE_KILLED
    STA Objects_State, x

    ; Fly upwards and stop horizontal movement
    LDA #-$40
    STA Objects_YVel, x
    LDA #$00
    STA Objects_XVel, x

    RTS


GreenKoopa_Kicked:
    LDA Player_HaltGame
    BEQ +
        ; Draw the enemy AND don't come back!
        JMP GreenKoopa_Draw

    +

    ; Handle normal movements
    CrossJumpToA 1, Object_Move
    
    ; Only draw sprites on the screen
    JSR Object_DetermineHorzVis

    ; Handle if the shell is on the ground
    LDA Objects_DetStat, x
    AND #$04
    BEQ +

        ; If the koopa is moving to the left or right, do not modify it otherwise move the shell relative to the player
        LDA Objects_XVel, x
        BNE ++
            JSR Level_ObjCalcXDiffs
            LDA GreenKoopa_BaseKickVelocity, y
            STA Objects_XVel, x

        ++

        ; Align the shell to the floor
        JSR Object_HitGround

        ; Begin dropping to the floor
        LDA #$0C
        STA Objects_YVel, x

    +

    ; Check if shell hit a wall
    LDA Objects_DetStat, x
    AND #$03
    BNE +
        JMP GreenKoopa_Kicked_CheckEntityCollision

    +

    ; The shell hit a wall...
    LDA Objects_SpriteX, x
    LDY Objects_XVel, x
    
    ; Handle the shell moving left or right
    BPL +
        ; Do different collision if moving fast enough (moving to the right)
        CMP #$06
        BLT GreenKoopa_Kicked_BounceOffBlocks
        BGE GreenKoopa_Kicked_BumpOffBlocks

    +

    ; Do different collision if moving fast enough (moving to the left)
    CMP #228
    BGE GreenKoopa_Kicked_BounceOffBlocks

GreenKoopa_Kicked_BumpOffBlocks:
    JSR Object_AnySprOffscreen
    BNE GreenKoopa_Kicked_BounceOffBlocks  ; If any sprite is off-screen, jump to GreenKoopa_Kicked_BounceOffBlocks

    ; Temp_Var13 = Object tile detect Y Hi
    LDA ObjTile_DetYHi
    STA Temp_Var13

    ; Temp_Var13 = Object tile detect Y Hi
    LDA ObjTile_DetYLo
    STA Temp_Var14

    ; Temp_Var15 = Object tile detect X Hi
    LDA ObjTile_DetXHi
    STA Temp_Var15

    ; Temp_Var16 = Object tile detect X Lo
    LDA ObjTile_DetXLo
    STA Temp_Var16

    ; Handle object bouncing off blocks
    LDA Object_TileWall2
    JSR GreenKoopa_BumpOffBlocks

    LDX SlotIndexBackup

GreenKoopa_Kicked_BounceOffBlocks:
    ; Play bump sound
    LDA Sound_QPlayer
    ORA #SND_PLAYERBUMP
    STA Sound_QPlayer

    ; Turn around
    JSR Object_AboutFace

GreenKoopa_Kicked_CheckEntityCollision:
    ; Check if the kicked shell was hit from below
    JSR GreenKoopa_CheckCommonCollision

    ; Handle running into other entities every other frame
    TXA
    CLC
    ADC Counter_1
    LSR A
    BCC GreenKoopa_Kicked_Draw
    JSR ObjectToObject_HitTest
    BCC GreenKoopa_Kicked_Draw

        ; Play object-to-object collision sound
        LDA Sound_QPlayer
        ORA #SND_PLAYERKICK
        STA Sound_QPlayer

        ; Knock object in same general direction as the kicked shell object
        LDA Objects_XVel, x
        ASL A
        LDA #$10
        BCC +
            LDA #-$10
        +
        STA Objects_XVel, y

        ; Slam and kill each other if both are kicked
        LDA GreenKoopa_State, y
        CMP #GreenKoopa_KICKED
        BNE +

            ; Award points
            LDA Objects_KillTally, y
            JSR Score_Get100PlusPts
            
            ; Kill this shell and make it flash
            JSR GreenKoopa_KillShellAndFlash

            ; Set X Velocity of our kicked object in the direction of the impacted object
            LDA Objects_XVel, y
            ASL A
            LDA #$10
            BCS ++
                LDA #-$10
            ++
            STA Objects_XVel, x

        +

        ; Kill the other shell and make it flash
        TYA
        TAX
        JSR GreenKoopa_KillShellAndFlash

        ; Award more points and increment score tally
        LDX SlotIndexBackup
        LDA Objects_KillTally, x
        INC Objects_KillTally, x
        JSR Score_Get100PlusPtsY


GreenKoopa_Kicked_Draw:
    ; Delete the shell if it went off screen
    JSR Object_DeleteOffScreen

    ; Set flip bits by the level no stop counter
    LDA Level_NoStopCnt
    LSR A
    AND #$03
    TAY
    LDA Objects_FlipBits, x
    AND #<~SPR_HFLIP
    ORA GreenKoopa_ShellAnimFlipBits, y
    STA Objects_FlipBits, x

    ; Set animation frame as appropriate
    LDA GreenKoopa_AnimFrame, y
    STA Objects_Frame, x

    ; Draw the kicked shell
    JSR Object_ShakeAndCalcSprite
    JSR GreenKoopa_Draw16x16Sprite

    ; Mirror the shell ever other frame
    TYA
    AND #$01
    BEQ +
        ; Keep all attributes except horizontal flip
        LDA Sprite_RAM+$02,Y
        AND #%10111111
        STA Sprite_RAM+$02,Y

        ; Flip opposite sprite
        ORA #$40
        STA Sprite_RAM+$06,Y

    +
    LDX SlotIndexBackup
    RTS


GreenKoopa_KillShellAndFlash:
    ; Set object state to Killed
    LDA #OBJSTATE_KILLED
    STA Objects_State, x

    ; Bounce up a bit
    LDA #-$30
    STA Objects_YVel, x

    ; Set ShellKillFlash vars
    LDA Objects_Y, x
    STA ShellKillFlash_Y
    LDA Objects_X, x
    STA ShellKillFlash_X
    LDA #$0a
    STA ShellKillFlash_Cnt

    RTS      ; Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GreenKoopa_BumpOffOthers
;
; This function is called every other frame and is responsible
; for checking collisions between the current Green Koopa entity
; and other entities. If a collision is detected, it will flip
; the direction of the current Green Koopa entity.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GreenKoopa_BumpOffOthers:
    ; Every other frame skip check.
    TXA
    CLC
    ADC Counter_1
    LSR A
    BCS GreenKoopa_BumpOffOthersCheck

GreenKoopa_BumpOffOthersSkip:
        RTS

GreenKoopa_BumpOffOthersCheck:
    ; If any sprites are vertically off-screen, don't bother checking
    LDA Objects_SprVVis, x
    BNE GreenKoopa_BumpOffOthersSkip  

    ; Else If two sprites are off-screen, don't bother checking
    LDA Objects_SprHVis, x
    AND #%11000000
    CMP #%11000000
    BEQ GreenKoopa_BumpOffOthersFinished
        ; Calculate the bounds of the object.
        JSR Object_CalcBoundBox2

    ; Else if this is the first object, don't bother checking
    TXA
    BEQ GreenKoopa_BumpOffOthersFinished

    ; Check the next object
    DEX

GreenKoopa_BumpOffOthersCheckNextEntity:
    LDA GreenKoopa_State, x

    ; Check if other entity is not normal or shelled, skip it.
    CMP #GreenKoopa_NORMAL
    BEQ GreenKoopa_OtherEntityIsNormalOrShelled
    CMP #GreenKoopa_SHELLED
    BNE GreenKoopa_OtherEntityFinishedCheck

    GreenKoopa_OtherEntityIsNormalOrShelled:
        LDY Level_ObjectID, x

        ; If this entity does not bounce off other objects, skip checking it
        LDA Object_AttrFlags, y
        AND #OAT_BOUNCEOFFOTHERS
        BEQ GreenKoopa_OtherEntityFinishedCheck

        ; Else if, entity variable 1 is set, skip checking it
        LDA Objects_Var1, x
        BNE GreenKoopa_OtherEntityFinishedCheck

        ; Else if, entity is off screen, skip checking it
        LDA Objects_SprVVis, x
        BNE GreenKoopa_OtherEntityFinishedCheck
        LDA Objects_SprHVis, x
        AND #%11000000
        CMP #%11000000
        BEQ GreenKoopa_OtherEntityFinishedCheck

        ; Else if, entity does not collide, don't bounce off it.
        JSR Object_CalcSpriteXY_NoHi
        JSR Object_CalcBoundBox
        JSR ObjectObject_Intersect
        BCC GreenKoopa_OtherEntityFinishedCheck

            ; Determine which side our entity is on.
            LDY SlotIndexBackup

            LDA Objects_X, x
            SBC Objects_X, y
            PHA                     ; Save difference between entities Xs
            LDA Objects_XHi, x
            SBC Objects_XHi, y
            STA Temp_Var1           ; Temp_Var1 = difference between entities X His
            ROL Temp_Var2           ; Sets carry if offset was negative

            ; Check if the collision will result in the object going offscreen.
            PLA
            ADC #$80
            LDA Temp_Var1
            ADC #$00
            BNE GreenKoopa_OtherEntityFinishedCheck

            ; Flip our entity as needed.
            LSR Temp_Var2
            LDY #$00
            BCS GreenKoopa_FlipDirection
                LDY #SPR_HFLIP

        GreenKoopa_FlipDirection:
            ; Apply the flip
            TYA
            LDY SlotIndexBackup
            STA Objects_FlipBits, y
            EOR #SPR_HFLIP
            STA Objects_FlipBits, x

GreenKoopa_OtherEntityFinishedCheck:
    ; Check the next entity until there are none
    DEX
    BPL GreenKoopa_BumpOffOthersCheckNextEntity

    ; Restore entity slot
    LDX SlotIndexBackup



ObjHit_GreenKoopa:
GreenKoopa_BumpOffOthersFinished:
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GreenKoopa_CheckCommonCollision
;
; Checks if the koopa was hit from below or by the player
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GreenKoopa_CheckCommonCollision:
    JSR Object_AnySprOffscreen
    BNE GreenKoopa_BumpOffOthersFinished

    ; If the koopa was not bumped then check if the player hit it
    LDA Object_TileFeet2
    CMP #TILEA_BLOCKBUMP_CLEAR
    BNE GreenKoopa_CheckPlayerCollision

    GreenKoopa_Bump
        ; Bounce the bumped koopa upwards
        LDA #-$30
        STA Objects_YVel, x

        ; Bump the koopa in the opposite direction of the player
        JSR Level_ObjCalcXDiffs
        LDA GreenKoopa_BumpVelocity, y
        STA Objects_XVel, x

        ; Flip the koopa upside down
        LDA #SPR_VFLIP
        STA Objects_FlipBits, x

        ; The player is awarded some points
        LDA #$00
        JSR Score_Get100PlusPts

        LDA GreenKoopa_State, x
        BEQ GreenKoopa_ShellKoopa
        GreenKoopa_BumpShell:
            ; Kill the shell
            LDA #OBJSTATE_KILLED
            STA Objects_State, x
            RTS

        GreenKoopa_ShellKoopa:
            ; Put the koopa into a shell
            LDA #GreenKoopa_SHELLED
            STA GreenKoopa_State, x
            LDA #$ff
            STA GreenKoopa_WakeUpTimer, x

GreenKoopa_CheckCollisionReturn:
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GreenKoopa_CheckPlayerCollision
;
; General routine for how the object responds to a Player
; colliding with it (good and bad)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GreenKoopa_CheckPlayerCollision:
    ; We cannot hit an enemy while we are invincible
    LDA GreenKoopa_Invincibility, x
    BNE GreenKoopa_CheckCollisionReturn

    ; Check collision and update player hit status accordingly
    JSR Object_HitTest
    LDA #$00
    STA Objects_PlayerHitStat, x
    BCC GreenKoopa_CheckCollisionReturn

    LDA Player_Slide
    BNE GreenKoopa_CollideSlide
        JMP GreenKoopa_CollideNormal

GreenKoopa_CollideSlide:
    JSR GreenKoopa_CollideInAir  ; Also include code like attribute set 2 bit 1 is set

    ; Turn the koopa into a shell if in normal state
    LDA GreenKoopa_State, x
    CMP #GreenKoopa_NORMAL
    BNE +
        JMP GreenKoopa_TurnIntoShell

    +
    LDA Objects_State, x
    CMP #OBJSTATE_NORMAL
    BEQ GreenKoopa_CheckCollisionReturn

    ; Kill the koopa
    STA Temp_Var4
    JSR GreenKoopa_Killed

    ; Overwrite the Y velocity to be random
    LDA RandomN, x
    AND #$1f
    ADC #-$4C
    STA Objects_YVel, x

    ; Ensure that the koopa was killed
    LDA #OBJSTATE_KILLED
    STA Objects_State, x

    ; Move the shell half the speed horizontally as the player
    LDA Player_XVel
    STA Temp_Var1
    ASL Temp_Var1
    ROR A
    CLC
    ADC Objects_XVel, x
    STA Objects_XVel, x
    RTS


GreenKoopa_CollideNormal:
    ; If the player is in the air, then run the air checks
    LDA Player_InAir
    BNE GreenKoopa_CollideInAir

    ; If the enemy is moving quickly downward (10+), then don't interact
    LDA Objects_YVel, x
    CMP #$0a
    BLS +
    -PlayerReactToKoopa:
        JMP GreenKoopa_PlayerReactToKoopa
+
    ; If the enemy hit the ground, react anyways
    LDA Objects_DetStat, x
    AND #$04
    BNE -PlayerReactToKoopa


GreenKoopa_CollideInAir:
    ; If the player is lower than GreenKoopa_STOMP_RANGE pixels below the koopa, interact.
    LDA Objects_Y, x
    SEC
    SBC #GreenKoopa_STOMP_RANGE
    ROL Temp_Var1
    CMP Player_Y
    PHP
    LSR Temp_Var1
    LDA Objects_YHi, x
    SBC #$00
    PLP
    SBC Player_YHi
    BMI -PlayerReactToKoopa

    ; If the player is moving downward or has p speed or has killed something, do not interact
    LDA Player_YVel
    BPL +
    LDA Player_FlyTime
    BNE +
        LDA Kill_Tally
        BEQ -PlayerReactToKoopa
+

    ; Register that the player hit the koopa from the top
    LDA #$01
    STA Objects_PlayerHitStat, x

    LDA Player_InWater
    BEQ GreenKoopa_InteractStomp
        ; The player cannot stomp the koopa in water unless kuribo or a statue
        LDA Player_Kuribo
        ORA Player_Statue
        BNE GreenKoopa_InteractStomp
        JMP GreenKoopa_PlayerReactGetHurt

GreenKoopa_InteractStomp:
    LDA Player_Statue
    ORA Player_Kuribo
    BEQ GreenKoopa_NormalStomp

    GreenKoopa_StrongStomp:
        JSR GreenKoopa_Stomp

        ; Kill the koopa
        LDA #OBJSTATE_KILLED
        STA Objects_State, x
        RTS

GreenKoopa_NormalStomp:
    LDA GreenKoopa_State, x
    CMP #GreenKoopa_SHELLED
    BNE GreenKoopa_Stomp


GreenKoopa_PlayerKickShell:
    ; Award the player points and increment the points until the player hits the ground
    LDA Kill_Tally
    INC Kill_Tally
    JSR Score_Get100PlusPts
    JSR GreenKoopa_Kick

    ; Clear Player kick
    LDA #$00
    STA Player_Kick

    RTS


GreenKoopa_Stomp:
    ; Cannot get stomped or kicked again for 8 frames
    LDA #$08
    STA GreenKoopa_Invincibility, x

    ; Bounce the player upwards
    LDA #-$40
    STA Player_YVel

    ; Play the squish sound
    LDA Sound_QPlayer
    ORA #SND_PLAYERSWIM
    STA Sound_QPlayer

    ; Award the player some points
    LDA Kill_Tally
    INC Kill_Tally
    JSR Score_Get100PlusPts

    ; Make the koopa become a shell
    JMP GreenKoopa_ShellKoopa


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GreenKoopa_Killed
;
; Damages the koopa such that it is killed or turns
; into a shell.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GreenKoopa_Killed:
    ; The koopa cannot be damaged or damage the player for 12 frames
    LDA #12
    STA GreenKoopa_Invincibility, x

    ; "Kick" sound
    LDA Sound_QPlayer
    ORA #SND_PLAYERKICK
    STA Sound_QPlayer

    LDA GreenKoopa_State, x
    BEQ GreenKoopa_TurnIntoShell
    CMP GreenKoopa_KICKED
    BEQ GreenKoopa_TurnIntoShell

    ; Do not give the player points if killed the shell while sliding.
    LDA Player_Slide
    BNE +
        LDA Kill_Tally
        JSR Score_Get100PlusPts
    +

    ; Kill the shell
    LDA #OBJSTATE_KILLED
    STA Objects_State, x
    
    BNE +   ; Always branch

GreenKoopa_TurnIntoShell
    ; Set the amount of time until the koopa wakes up
    LDA #$ff
    STA GreenKoopa_WakeUpTimer, x

    ; Turn the koopa into a shell
    LDA #GreenKoopa_SHELLED
    STA GreenKoopa_State, x
+

    ; Set the upward velocity of the shell depending on the value of Temp_Var4
    LDA #-$30
    LDY Temp_Var4
    CPY #$0f
    BEQ +
        LDA #-$50
    +
    STA Objects_YVel, x

    ; Set appropriate X Velocity based on facing direction of player when he killed the enemy
    JSR Level_ObjCalcXDiffs
    LDA GreenKoopa_BumpVelocity, y
    STA Objects_XVel, x

    ; Flip the shell upside down
    LDA Objects_FlipBits, x
    ORA #SPR_VFLIP
    STA Objects_FlipBits, x

    RTS


GreenKoopa_PlayerReactToKoopa:
    ; If the koopa is shelled, then we won't hurt the player
    LDA GreenKoopa_State, x
    CMP #GreenKoopa_SHELLED
    BNE GreenKoopa_PlayerReactGetHurt

        ; If not in a statue or kuribo, then kick the shell
        LDA Player_Kuribo
        ORA Player_Statue
        BEQ +
            JMP GreenKoopa_PlayerKickShell

        +
            ; Stop checks if holding something
            LDA Player_ISHolding_OLD
            BNE GreenKoopa_PlayerReactToKoopaReturn

            ; Hold shell if holding B, otherwise kick
            BIT Pad_Holding
            BVS GreenKoopa_HoldShell
                JMP GreenKoopa_Kick

        GreenKoopa_HoldShell:
            ; Put the koopa into the held state
            LDA #GreenKoopa_HELD
            STA GreenKoopa_State, x
            RTS


GreenKoopa_PlayerReactGetHurt:
    ; If invincible, a statue, the koopa is invincible, then do no checks
    LDA Player_FlashInv
    ORA Player_Statue
    ORA GreenKoopa_Invincibility, x
    ORA Player_StarInv
    BNE GreenKoopa_PlayerReactToKoopaReturn

    ; If koopa hurt and face player, otherwise hurt player if in front of kicked shell
    LDA GreenKoopa_State, x
    CMP #GreenKoopa_KICKED
    BNE GreenKoopa_KoopaHurtPlayer

        ; Determine direction of the player (0 -> left moving, 1 -> right moving) and no movement -> hurt player
        LDY #$00
        LDA Player_XVel
        BEQ GreenKoopa_KoopaHurtPlayer
        BPL +
            INY
        +
        STY Temp_Var1

        ; If player and koopa going in opposite directions, hurt the player
        EOR Objects_XVel, x
        BMI GreenKoopa_KoopaHurtPlayer
            ; If the player is on the opposite directional side of the shell, then give the player a pass
            JSR Level_ObjCalcXDiffs
            CPY Temp_Var1
            BNE GreenKoopa_PlayerReactToKoopaReturn
            JMP Player_GetHurt

GreenKoopa_KoopaHurtPlayer:
    ; Flip the koopa towards and hurt the player
    JSR Level_ObjCalcXDiffs
    LDA Objects_FlipBits, x
    AND #<~SPR_HFLIP
    DEY
    BEQ +
        ORA #SPR_HFLIP
    +
    STA Objects_FlipBits, x
    JMP Player_GetHurt

GreenKoopa_PlayerReactToKoopaReturn:
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GreenKoopa_Draw16x16Sprite
;
; Used to draw 16x16 object sprites.
; Temp_Var1: Object sprite Y
; Temp_Var2: Object sprite X
; Temp_Var3: Object's LR flag
; Temp_Var4: Object's attributes
; Temp_Var5: Objects_SprVVis
; Temp_Var6: Object's starting tiles index (and -> 'X')
; Temp_Var7: Object's Sprite_RAM offset (and -> 'Y')
; Temp_Var8: Objects_SprHVis
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GreenKoopa_Draw16x16Sprite:
    LDA Temp_Var5  ; Check sprite vertical visibility
    LSR A       ; Shift right (checking lowest bit)
    BCS ++ ; If this bit is set, this sprite piece is invisible, jump to ++ (RTS)

        LDA Temp_Var1  ; Get sprite Y

        BIT Temp_Var8  ; Testing bit 7 of horizontal sprite visibility
        
        ; If this sprite is horizontally off-screen don't render it
        BMI +
            STA Sprite_RAM+$00, y

        +

        ; If this sprite is horizontally off-screen don't render it
        BVS +
            STA Sprite_RAM+$04, y

        +

        ; Store X position of the sprite
        LDA Temp_Var2
        STA Sprite_RAM+$03, y
        CLC
        ADC #$08
        STA Sprite_RAM+$07, y

        ; Set the frames of the koopa
        LDA GreenKoopa_Frames, x
        STA Sprite_RAM+$01, y
        LDA GreenKoopa_Frames+1, x
        STA Sprite_RAM+$05, y

        ; Set the base horizontal flip flags
        LDA Temp_Var3
        ORA Temp_Var4
        STA Sprite_RAM+$02, y
        STA Sprite_RAM+$06, y

        ; Handle if the sprite is flipped
        BIT Temp_Var3
        BVC ++

            ; Swap sprite attributes
            LDA Sprite_RAM+$01, y
            PHA
            LDA Sprite_RAM+$05, y
            STA Sprite_RAM+$01, y
            PLA
            STA Sprite_RAM+$05, y

    ++
    RTS      ; Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GreenKoopa_BumpOffBlocks
;
; Handle a kicked shelled object bouncing off blocks.  Modifies
; Level_Tile_Whack as part of the logic (i.e. like the Player
; tail-attacked whatever block got hit)
; A = input detected tile by kicked shelled object
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GreenKoopa_BumpOffBlocks:
    LDX #$04     ; X = 4
    STA Level_Tile_GndL, x    ; Essentially store into Level_Tile_Whack

    ; Don't handle bumping off blocks while the player is bouncing
    LDA Player_Bounce
    BNE GreenKoopa_ReturnBumpOffBlocks

        ; Have the shell bump the blocks
        CrossJumpToA 8, Level_DoBumpBlocks

        ; Set bounce direction and flags if the block was bounced
        LDA Player_Bounce
        BEQ GreenKoopa_ReturnBumpOffBlocks
            LDA #$01
            STA Player_BounceDir
            STA Player_BounceObj

GreenKoopa_ReturnBumpOffBlocks:
    RTS      ; Return

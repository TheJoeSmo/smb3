
BumptyState_Undecided    = $00
BumptyState_LookAround   = $01
BumptyState_WalkInit     = $02
BumptyState_Walk         = $03
BumptyState_HopInit      = $04
BumptyState_Hop          = $05
BumptyState_Charge       = $06
BumptyState_Slide        = $07
BumptyState_GotBumped    = $08
BumptyState_Fly          = $09
BumptyState_Jump         = $0A
BumptyState_WaitingFlight= $0B

Bumpty_XVel:
    .byte $08, -$08
    .byte $20, -$20
    .byte $10, -$10

Bumpty_PlayerBumptyXVel:
    .byte $20, -$20

Bumpty_FacePlayerBit:    .byte SPR_HFLIP, $00

Bumpty_SpinFrames:       .byte $08, $09, $08, $07, $0A, $07, $08, $09, $08, $07, $0A

Bumpty_FlyingYVel:
    .byte 0, 0, -2, -5
    .byte -5, -10, -15, -20
    .byte -25, -20, -15, -10
    .byte -10, -5, 0, 0
    .byte 0, 0, 5, 10
    .byte 10, 15, 20, 25
    .byte 25, 20, 15, 10
    .byte 10, 5, 0, 0
    .byte 0, 0, 0, 0

Bumpty_FlyingFrame:
    .byte $0B, $0B, $0B, $0B
    .byte $0B, $0B, $0C, $0C
    .byte $0B, $0B, $0B, $0B
    .byte $0B, $0B, $0D, $0D
    .byte $0D, $0D, $0D, $0D
    .byte $0D, $0D, $0D, $0D
    .byte $0D, $0D, $0D, $0D
    .byte $0D, $0D, $0D, $0D

; B flying not flapping
; C flying and flapping
; D flying and falling

ObjInit_Bumpty:
    ; Start in a state to decide what to do
    LDA #BumptyState_Undecided
    STA Objects_Var5,X

    ; Start by flying if we are not touching the ground
    CrossJumpToA000 #5, Object_WorldDetect4
    LDA Objects_DetStat,X
    AND #$04
    BNE +
        ; Flip the direction the object is facing
        LDA Objects_FlipBits,X
        EOR #SPR_HFLIP
        STA Objects_FlipBits,X

        LDA #BumptyState_Fly
        STA Objects_Var5,X
+

    ; Define the patterns to be used
    LDA #BUMPTY_CHR_BANK
    STA PatTable_BankSel+6

    RTS

ObjNorm_Bumpty:
Bumpty_Update:
    ; Decrease the timer until an interaction can occur if not zero.
    LDA Objects_Var1,X
    BEQ +
        DEC Objects_Var1,X
+

    ; Handle bumping the player.
    JSR Object_HitTest
    BCC +
        JSR BumpPlayer
+
    LDA Objects_Var5,X
    JSR DynJump

    .word Bumpty_Undecided
    .word Bumpty_LookAround
    .word Bumpty_WalkInit
    .word Bumpty_Walk
    .word Bumpty_HopInit
    .word Bumpty_Hop
    .word Bumpty_Charge
    .word Bumpty_Slide
    .word Bumpty_GotBumped
    .word Bumpty_Fly
    .word Bumpty_Jump
    .word Bumpty_WaitingForFlight


Bumpty_Undecided:
    ; We need to look around the next frame.
    LDA #BumptyState_LookAround
    STA Objects_Var5,X 

    ; Remove all velocity.
    LDA #$00
    STA Objects_XVel,X

    ; We will look around for 20 frames.
    LDA #$30
    STA Objects_Timer,X

    ; Select an action randomly.
    LDA RandomN,X
    AND #$01
    BEQ +
        ; Set timer until next state
        LDA #$10
        STA Objects_Timer,X

        LDA #BumptyState_HopInit
        STA Objects_Var2,X
        JMP Bumpty_Update
+
    LDA #BumptyState_WalkInit
    STA Objects_Var2,X
    JMP Bumpty_Update


Bumpty_PrepareToHop:
    LDA #$03
    STA Objects_Frame,X

    ; Go towards the player
    JSR Bumpty_FacePlayer
    
    ; Handle movement and draw
    JMP Bumpty_Move


Bumpty_HopInit:
    LDA Objects_Timer,X
    BNE Bumpty_PrepareToHop

        ; Go to the hop state
        LDA #BumptyState_Hop
        STA Objects_Var5,X

        ; Do a little hop
        LDA #-$30
        STA Objects_YVel,X

        ; Always jump to move towards player
        BNE Bumpty_MoveTowardsPlayer 

Bumpty_WalkInit:
    ; Go to the walk state
    LDA #BumptyState_Walk
    STA Objects_Var5,X

Bumpty_MoveTowardsPlayer:
    ; Set timer until next state
    LDA #$50
    STA Objects_Timer,X

    ; Go towards the player
    JSR Bumpty_FacePlayer

    JMP Bumpty_Update

Bumpty_LookAround:
    ; Do not move around when looking around.
    LDA #$00
    STA Objects_XVel,X

    ; Wait until the timer is expired to calculate the player's position.
    LDA Objects_Timer,X
    BNE BumptyDraw_LookAround

        ; Determine what to do based off what we decided earlier.
        LDA Objects_Var2,X
        STA Objects_Var5,X
        JMP Bumpty_Update

BumptyDraw_LookAround:
    LDA Objects_Timer3,X
    BNE +
        ; Reset the counter
        LDA #$10
        STA Objects_Timer3,X

        ; Change the active state
        INC Objects_Var3,X

        ; Flip around
        JSR Object_FlipFace

        ; Look in the other direction
        LDA #$02
        STA Objects_Frame,X
+
    JMP Bumpty_Move


Bumpty_Walk:
Bumpty_Slide:
    ; Go the other way to avoid the other enemy.
    JSR Bumpty_CollideWithOthers

    ; Apply velocity
    LDY Objects_Var4,X
    LDA Bumpty_XVel,Y
    STA Objects_XVel,X

    ; Do the walking frames.
    LDA Objects_Timer,X
    TAY
    AND #$04
    LSR A
    LSR A
    STA Objects_Frame,X
    TYA
    BNE Bumpty_Move

        ; Decide what to do next.
        LDA #BumptyState_Undecided
        STA Objects_Var5,X

        JMP Bumpty_Update

Bumpty_Move:
    CrossJumpToA000 #5, Object_Move

    ; Check if hit ceiling
    LDA Objects_DetStat,X
    AND #$08
    BEQ +
        STA Objects_YVel,X

+
    ; Check if hit a wall and turn around if needed.
    LDA Objects_DetStat,X
    AND #$03
    BEQ +
    LDA Objects_XVel,X
    BEQ +
        JSR Bumpty_AboutFace

+
    ; Align to floor if needed
    LDA Objects_DetStat,X
    AND #$04
    BEQ +
        JSR Object_HitGround

+
    ; Handle going off the screen
    CrossJumpToA000 #5, Object_DeleteOffScreen

Bumpty_Draw:
    LDA Objects_Var5,X
    CMP #BumptyState_Fly
    BNE +
        JMP Bumpty_DrawFlying
+

    ; If the bumpty is falling and is not flying
    LDA Objects_YVel,X
    BEQ +
    BMI +
        LDA #$06
        STA Objects_Frame,X
+

    ; If the bumpty is going upwards and is not flying
    LDA Objects_YVel,X
    BPL +
        LDA #$05
        STA Objects_Frame,X

        CrossJumpToA000 #5, Object_ShakeAndCalcSprite

        ; Place the shoes below the body
        LDA Temp_Var1
        PHA
        CLC
        ADC #$0E
        STA Temp_Var1

        ; Place the shoes to the left or right of the body
        LDA Temp_Var3
        BEQ ++
            LDA Temp_Var2
            PHA
            CLC
            ADC #$02
            JMP +++
    ++
            LDA Temp_Var2
            PHA
            SEC
            SBC #$02
    +++
        STA Temp_Var2
        
        ; Draw the shoes of this
        CrossJumpToA000 #5, Object_Draw16x16Sprite

        ; Restore the x and y position of the sprite
        PLA
        STA Temp_Var2
        PLA
        STA Temp_Var1
        
        ; Use the next two sprites
        TYA
        CLC
        ADC #$08
        TAY

        ; Use the next frame
        LDA Temp_Var6
        SEC
        SBC #$02
        TAX

        ; Draw the body of this
        CrossJumpToA000 #5, Object_Draw16x16Sprite

        ; Restore index
        LDX SlotIndexBackup
        RTS
+

    ; Determine default attributes for the entity
    CrossJumpToA000 #5, Object_ShakeAndCalcSprite    
    CrossJumpToA000 #5, Object_Draw16x16Sprite

    ; Add foot to certain frames
    LDA Sprite_RAM+$01,Y
    CMP #$E7
    BNE +
        ; Check sprite visibility
        LDA Temp_Var5  
        LSR A
        BCS +
        BIT Temp_Var8
        BMI +

        ; Set the Y position of the sprite
        LDA Temp_Var1
        STA Sprite_RAM+$08,Y

        ; Place the shoe on the left or right of the sprite
        LDA Temp_Var3
        BEQ ++
            LDA Temp_Var2
            CLC
            ADC #$08
            JMP +++
    ++
            LDA Temp_Var2
            SEC
            SBC #$08
    +++
        STA Sprite_RAM+$0B,Y

        ; Set the pattern of the shoe
        LDA #$E5
        STA Sprite_RAM+$09,Y

        ; Apply attributes
        LDA Temp_Var3
        ORA Temp_Var4
        STA Sprite_RAM+$0A,Y
+ 

    ; Apply flipped bits to certain frames 
    LDA Sprite_RAM+$01,Y
    CMP #$EB
    BNE +
        LDA Sprite_RAM+$02,Y
        AND #$BF
        STA Sprite_RAM+$02,Y
        LDA Sprite_RAM+$06,Y
        ORA #$40
        STA Sprite_RAM+$06,Y

+
    ; Restore index
    LDX SlotIndexBackup
    RTS


Bumpty_DrawFlying:
    ; Determine default attributes for the entity
    CrossJumpToA000 #5, Object_ShakeAndCalcSprite    
    CrossJumpToA000 #5, Object_Draw16x16Sprite

    ; Add wing to certain frames
    LDA Sprite_RAM+$01,Y
    CMP #$D3
    BEQ ++
    CMP #$F5
    BEQ ++
    LDA Sprite_RAM+$05,Y
    CMP #$D3
    BEQ ++
    CMP #$F5
    BNE +
++
        ; Check sprite visibility
        LDA Temp_Var5  
        LSR A
        BCS +
        BIT Temp_Var8
        BMI +

        ; Set the Y position of the sprite
        LDA Temp_Var1
        STA Sprite_RAM+$08,Y

        ; Place the shoe on the left or right of the sprite
        LDA Temp_Var3
        BEQ ++
            LDA Temp_Var2
            SEC
            SBC #$08
            JMP +++
    ++
            LDA Temp_Var2
            CLC
            ADC #$10
    +++
        STA Sprite_RAM+$0B,Y

        ; Set the pattern of the shoe
        LDA #$D5
        STA Sprite_RAM+$09,Y

        ; Apply attributes
        LDA Temp_Var3
        ORA Temp_Var4
        STA Sprite_RAM+$0A,Y
+ 

    ; Add out stretched foot to certain frames
    LDA Sprite_RAM+$05,Y
    CMP #$F5
    BEQ ++
    LDA Sprite_RAM+$01,Y
    CMP #$F5
    BNE +
++
        ; Check sprite visibility
        LDA Temp_Var5  
        LSR A
        BCS +
        BIT Temp_Var8
        BMI +

        ; Set the Y position of the sprite
        LDA Temp_Var1
        STA Sprite_RAM+$0C,Y

        ; Place the shoe on the left or right of the sprite
        LDA Temp_Var3
        BEQ ++
            LDA Temp_Var2
            CLC
            ADC #$10
            JMP +++
    ++
            LDA Temp_Var2
            SEC
            SBC #$08
    +++
        STA Sprite_RAM+$0F,Y

        ; Set the pattern of the shoe
        LDA #$E5
        STA Sprite_RAM+$0D,Y

        ; Apply attributes
        LDA Temp_Var3
        ORA Temp_Var4
        STA Sprite_RAM+$0E,Y
+

    ; Place the shoes below the body on certain frames
    LDA Sprite_RAM+$01,Y
    CMP #$CD
    BEQ ++
    CMP #$D1
    BEQ ++
    LDA Sprite_RAM+$05,Y
    CMP #$CD
    BEQ ++
    CMP #$D1
    BNE +
++
       ; Check sprite visibility
        LDA Temp_Var5  
        LSR A
        BCS +
        BIT Temp_Var8
        BMI +

        ; Set the Y position of the sprite
        LDA Temp_Var1
        CLC
        ADC #$10
        STA Sprite_RAM+$10,Y
        STA Sprite_RAM+$14,Y

        ; Place the shoe on the left or right of the sprite
        LDA Temp_Var3
        BEQ ++
            LDA Temp_Var2
            CLC
            ADC #$02
            STA Sprite_RAM+$13,Y
            ADC #$04
            STA Sprite_RAM+$17,Y
            JMP +++
    ++
            LDA Temp_Var2
            CLC
            ADC #$02
            STA Sprite_RAM+$13,Y
            ADC #$04
            STA Sprite_RAM+$17,Y
    +++

        ; Set the pattern of the shoe
        LDA #$EF
        STA Sprite_RAM+$11,Y
        STA Sprite_RAM+$15,Y

        ; Apply attributes
        LDA Temp_Var3
        ORA Temp_Var4
        STA Sprite_RAM+$12,Y
        STA Sprite_RAM+$16,Y
+


    ; Restore index
    LDX SlotIndexBackup
    RTS


Bumpty_Hop:
    ; Go the other way to avoid the other enemy.
    JSR Bumpty_CollideWithOthers

    ; Wait until the entity touches the ground
    LDA Objects_DetStat,X
    AND #$04
    BEQ Bumpty_ChargeInit
        JMP Bumpty_Move

Bumpty_ChargeInit:
    JSR Bumpty_FacePlayer

    LDA #BumptyState_Charge
    STA Objects_Var5,X

    ; Set timer until next state
    LDA #$30
    STA Objects_Timer,X
    
    JMP Bumpty_Update

Bumpty_Charge:
    ; Go the other way to avoid the other enemy
    JSR Bumpty_CollideWithOthers

    ; Go towards the player faster
    LDY Objects_Var4,X
    LDA Bumpty_XVel+2,Y
    STA Objects_XVel,X

    LDA Objects_Timer,X
    BEQ Bumpty_SlideInit
        JMP Bumpty_Move

Bumpty_SlideInit:
    JSR Bumpty_FacePlayer

    ; Decide what to do next
    LDA #BumptyState_Slide
    STA Objects_Var5,X

    JMP Bumpty_Update

Bumpty_GotBumped:
    LDA Objects_Timer,X
    BEQ +

        ; Handle animating the bumpty spinning
        LSR A
        LSR A
        LSR A
        TAY
        LDA Bumpty_SpinFrames, Y
        STA Objects_Frame,X

        ; On certain frames we flip the direction of this
        LDA Objects_Timer,X
        CMP #$10
        BEQ ++
        CMP #$28
        BEQ ++
        CMP #$40
        BNE +++
    ++
            ; Flip the direction the object is facing
            LDA Objects_FlipBits,X
            EOR #SPR_HFLIP
            STA Objects_FlipBits,X
    +++

        ; Apply velocity
        LDY Objects_Var4,X
        LDA Bumpty_XVel+4,Y
        STA Objects_XVel,X

        JMP Bumpty_Move

+
    JMP Bumpty_Undecided


Bumpty_FacePlayer:
    JSR Level_ObjCalcXDiffs
    LDA Bumpty_FacePlayerBit,Y
    STA Objects_FlipBits,X
    STY Objects_Var4,X
Bumpty_CollideWithOthersFinish:
    RTS

Bumpty_CollideWithOthers:
    ; If this is off screen, do not check collision
    LDA Objects_SprHVis,X
    AND #%11000000
    CMP #%11000000
    BEQ Bumpty_CollideWithOthersFinish

    ; Calculate the bounding box of this for collision check
    JSR Object_CalcBoundBox2

    ; Only consider the primary enemies as this is an expensive check
    LDX #$04

Bumpty_ColliderLoop:
    ; Skip a checking collision against the same object
    CPX SlotIndexBackup
    BEQ +

    ; Only consider normal and shelled enemies
    LDA Objects_State,X
    CMP #OBJSTATE_NORMAL
    BEQ ++
    CMP #OBJSTATE_SHELLED
    BNE +
++
        LDY Level_ObjectID,X

        ; If this object does not bounce off others, do not consider it
        LDA Object_AttrFlags,Y
        AND #OAT_BOUNCEOFFOTHERS
        BEQ +

        ; If this object disabled bouncing off others, ignore it
        LDA Objects_SprVVis,X
        BNE +

        ; If collision is disabled, ignore the object
        LDA Objects_Var1,X
        BNE +

        ; If this object is off screen, ignore it
        LDA Objects_SprHVis,X
        AND #%11000000
        CMP #%11000000
        BEQ +

            ; Check for a collision
            JSR Object_CalcSpriteXY_NoHi
            JSR Object_CalcBoundBox
            JSR ObjectObject_Intersect
            BCC +

                LDY SlotIndexBackup

                ; Get the difference between the two objects
                LDA Objects_X,X
                SBC Objects_X,Y
                PHA
                LDA Objects_XHi,X
                SBC Objects_XHi,Y
                STA Temp_Var1
                ROL Temp_Var2
                PLA
                ADC #$80
                LDA Temp_Var1
                ADC #$00
                
                ; If the object is off the screen, skip it
                BNE +
                    JSR Bumpty_HandleCollision

+
    ; Check each enemy
    DEX
    BEQ +
        JMP Bumpty_ColliderLoop
+
    ; Restore the index
    LDX SlotIndexBackup
    RTS


Bumpty_HandleCollision:
    ; Temp_Var2 represents the which side the collision occurred on
    LSR Temp_Var2

    ; Temp_Var1 represents which flip is required to go the correct direction
    LDY #$00
    BCS +
        LDY #SPR_HFLIP
+
    TYA
    STA Temp_Var1

    ; Flip the direction of this object
    LDY SlotIndexBackup
    STA Objects_FlipBits,Y

    ; Get the object to move in the opposite direction
    ; Flip the velocity
    LDA Objects_XVel,Y
    NEG
    STA Objects_XVel,Y

    ; Flip the active direction
    LDA Objects_Var4,Y
    CLC
    ADC #$01
    AND #$01
    STA Objects_Var4,Y


    ; If the other object is a bumpty, change its direction too
    LDA Level_ObjectID,X
    CMP #OBJ_BUMPTY
    BNE +
        JSR Bumpty_AboutFace

        ; Apply bump interaction
        LDA #BumptyState_GotBumped
        STA Objects_Var5,X
        LDA #$50
        STA Objects_Timer,X
+

    ; Set the enemy to get bumped
    LDA #BumptyState_GotBumped
    STA Objects_Var5,Y

    ; How long the bump interaction lasts
    LDA #$50
    STA Objects_Timer,Y
    RTS
    

Bumpty_AboutFace:
    ; Flip the direction the object is facing
    LDA Objects_FlipBits,X
    EOR #SPR_HFLIP
    STA Objects_FlipBits,X
    
    ; Flip the velocity
    LDA Objects_XVel,X
    NEG
    STA Objects_XVel,X

    ; Flip the active direction
    LDA Objects_Var4,X
    CLC
    ADC #$01
    AND #$01
    STA Objects_Var4,X
    RTS

BumpPlayer:
    ; Bump the player
    JSR Level_ObjCalcXDiffs
    LDA Bumpty_PlayerBumptyXVel,Y
    STA Player_XVel

    ; Stop interacting for a while
    LDA #$10
    STA Objects_Timer2,X

    ; Handle bouncing the player upwards and bumping this
    LDA Player_Y
    PHA
    SEC
    ADC #$12
    STA Player_Y
    LDA Player_YHi
    PHA
    ADC #$00
    STA Player_YHi
    JSR Level_ObjCalcYDiffs
    PLA
    STA Player_YHi
    PLA
    STA Player_Y
    TYA
    BEQ +
        ; Bounce the player if they are above this
        LDA #-$40
        STA Player_YVel
        RTS

        ; Send this downwards
        LDA Objects_YVel,X
        CLC
        ADC #$10
        STA Objects_YVel,X
+
    ; Bump this if the player is not above
    JSR Bumpty_AboutFace
    LDA #BumptyState_GotBumped
    STA Objects_Var5,X
    LDA #$50
    STA Objects_Timer,X
    RTS

-
    LDA #$0D
    STA Objects_Frame,X
    SED
    JMP ++

Bumpty_Fly:
    ; If we hit the ground we need to jump
    LDA Objects_DetStat,X
    AND #$04
    BEQ +
        ; Wait a while before jumping
        LDA #$30
        STA Objects_Timer,X

        LDA #BumptyState_Jump
        STA Objects_Var5,X
        JMP Bumpty_Update

+
    LDA Objects_Timer2,X
    BNE -

    LDA Objects_Timer,X
    BNE +
        LDA #$B0
        STA Objects_Timer,X
+

    CMP #$60
    BNE +
        JSR Bumpty_AboutFace

        LDA #$0E
        STA Objects_Frame,X
        BNE ++
+
    AND #$1F
    TAY
    LDA Bumpty_FlyingYVel,Y
    STA Objects_YVel,X

    ; Determine frame animation
    LDA Bumpty_FlyingFrame,Y
    STA Objects_Frame,X

++
    ; Apply velocity
    LDY Objects_Var4,X
    LDA Bumpty_XVel,Y
    STA Objects_XVel,X
    
    JMP Bumpty_Move


Bumpty_Jump:
    LDA #$02
    STA Objects_Frame,X

    ; Only consider jumping if the timer has run it's course
    LDA Objects_Timer,X
    BNE +

    ; Wait until the bumpty touches the ground
    LDA Objects_DetStat,X
    AND #$04
    BEQ +
        ; Do a jump into the air
        LDA #-$30
        STA Objects_YVel,X

        LDA #BumptyState_WaitingFlight
        STA Objects_Var5,X 

    +
    JMP Bumpty_Move


Bumpty_WaitingForFlight:
    ; Apply velocity
    LDY Objects_Var4,X
    LDA Bumpty_XVel,Y
    STA Objects_XVel,X

    LDA Objects_YVel,X
    BNE +
        LDA #$B0
        STA Objects_Timer,X

        LDA #BumptyState_Fly
        STA Objects_Var5,X
    +
    JMP Bumpty_Move

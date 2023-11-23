; Starting rex direction
RexEnterFlip: .byte  SPR_HFLIP, $00

; Starting rex x velocity
RexEnterXVel:       .byte $08, -$08
RexSquashEnterXVel: .byte $0C, -$0C


ObjInit_Rex:
  LDA #$00
  
	; Determine the starting direction to walk
	JSR Level_ObjCalcXDiffs
	LDA RexEnterFlip,Y
	STA Objects_FlipBits,X

  ; Define the velocity
	LDA RexEnterXVel,Y
	STA Objects_XVel,X

  BEQ +

ObjInit_RexSquished:
  ; Determine the starting direction to walk
	JSR Level_ObjCalcXDiffs
	LDA RexEnterFlip,Y
	STA Objects_FlipBits,X

  ; Define the velocity
	LDA RexSquashEnterXVel,Y
	STA Objects_XVel,X

+
  ; Define the patterns to be used
  LDA #DINO_CHR_BANK
  STA PatTable_BankSel+5
	RTS


ObjSquashed_Rex:
  ; Simply draw the entity once the timer is 0
  LDA Objects_Timer3,X
  BEQ ObjSquashed_RexKill

  CrossJumpToA000 #1, Object_Move

    ; Check if hit ground, otherwise simply draw the entity
	LDA Objects_DetStat,X
	AND #$04
	BEQ ObjSquashed_RexSquashedAnimation

	JSR Object_HitGround	 ; Align to ground
	STA Objects_XVel,X	 ; Clear X velocity

ObjSquashed_RexSquashedAnimation:
    ; Set object frame to 3
	LDA #$03
	STA Objects_Frame,X

  CrossJumpToA000 #1, Object_ShakeAndDrawMirrored
  RTS

ObjSquashed_RexKill:
    JMP Object_SetDeadEmpty


ObjNorm_Rex:
    ; Alternate the walking animation every couple frames.
	LDA Counter_1
	AND #$08
	LSR A
	LSR A
	LSR A
	STA Objects_Frame,X

  ; Delete the entity if it off the screen.
	JSR Object_DeleteOffScreen

  ; Handle interactions with the world.
	JSR Rex_MoveCommon

  ; Check if bumped from underneath.
	CrossJumpToA000 #1, Object_HandleBumpUnderneath

	; Check if being stomped.
	LDA Objects_State,X
	CMP #OBJSTATE_SHELLED
	BNE Rex_Draw

      LDA Objects_XVel,X
      ASL A
      PHA

      JSR Level_PrepareNewObject
      
      LDA #OBJ_REX_SQUISHED
      STA Level_ObjectID,X
          
      LDA #OBJSTATE_NORMAL
      STA Objects_State,X
      
      LDA Objects_Y,X
      CLC
      ADC #17
      STA Objects_Y,X
      LDA Objects_YHi,X
      ADC #0
      STA Objects_YHi,X
      
      LDA Player_Kuribo
      BEQ Rex_NotInShoe
          ; Kill the rex instantly if the player is in a shoe.
          LDA #OBJSTATE_KILLED
          STA Objects_State,X
        
Rex_NotInShoe:
        PLA
        STA Objects_XVel,X

        CrossJumpToA000 #1, Object_ShakeAndDraw
        RTS
        
Rex_Draw:
	CrossJumpToA000 #1, Object_Draw16x32Sprite
	LDX SlotIndexBackup	 ; X = object slot index
	RTS


Rex_MoveCommon:
  ; Handle normal movements
	CrossJumpToA000 #1, Object_Move

    ; Handle hitting the ceiling.
	LDA Objects_DetStat,X
	AND #$08
	BEQ Rex_DidNotHitCeiling
	    STA Objects_YVel,X

Rex_DidNotHitCeiling:
    ; Turn around if hit a wall and moving.
	LDA Objects_DetStat,X
	AND #$03
	BEQ Rex_AlignToGround
	LDA Objects_XVel,X
	BEQ Rex_AlignToGround
	    JSR Object_AboutFace

Rex_AlignToGround:
    ; Aligns the object that impacts the ground onto the floor
    LDA Objects_DetStat,X
    AND #$04
    BEQ +
        JMP Object_HitGround
    +
    RTS

ObjNorm_RexSquashed:
	LDA Counter_1
	AND #$08
	LSR A
	LSR A
	LSR A
	STA Objects_Frame,X

	JSR Object_DeleteOffScreen

	JSR Rex_MoveCommon

	CrossJumpToA000 #1, Object_HandleBumpUnderneath
	
  CrossJumpToA000 #1, Object_ShakeAndDraw
	RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Attribution
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 
; This enemy was originally created by RussianMan with 
; help from AwesomeZack.  Additional edits were done by
; Joe Smo for the purpose of compatibility.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Thwimp_XSpeed:
db $10,$F0

ObjNorm_Thwimp:
	CrossJumpToA000 #3, Object_ShakeAndDrawMirrored
  JSR Object_DeleteOffScreen

	LDA Player_HaltGame
    BNE @Re
	
	CrossJumpToA000 #3, Player_HitEnemy
	
	; Apply diff gravity when grounded
	JSR Object_ApplyYVel
	CrossJumpToA000 #3, Object_ApplyXVel
	CrossJumpToA000 #3, Object_WorldDetect4

	LDA Objects_DetStat,X
	AND #$0C
	BEQ @Gravity
	LDY #$10
	AND #$08
	BNE @AlmostStore

  JSR Object_HitGround

  ; Grounded
  LDA #$01
  STA Objects_Frame,X

  ; Reset y-speed and x-speed
  LDA #$00
	STA Objects_XVel,X
	STA Objects_YVel,X
	
	LDY Objects_Timer,X
	BEQ @RestoreTimer
	DEY
	BNE @Re
	
	INC Objects_Var1,X
	LDA Objects_Var1,X
	AND #$01
	TAY
	LDA Thwimp_XSpeed,Y
	STA Objects_XVel,X
	
	LDA #Thwimp_JumpSpeed
	BNE @Store
	RTS

@AlmostStore	
  ; Change animation
  LDA #$00
  STA Objects_Frame,X
  
  TYA
	BNE @Store
	
@Gravity	
  ; Change animation
  LDA #$00
  STA Objects_Frame,X

	LDA Objects_YVel,X
	BMI @LessGravity
	CMP #Thwimp_MaxFallSpeed
	BCS @Store
	ADC #$05
	
@LessGravity
	CLC
	ADC #$03

@Store
	STA Objects_YVel,X
	
@Re
	RTS
	
@RestoreTimer	
	LDA #Thwimp_WaitTime
	STA Objects_Timer,X

	LDA Sound_QPlayer
	ORA #SND_PLAYERBUMP
	STA Sound_QPlayer
	RTS

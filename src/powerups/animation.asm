

    ; Defines 4 frames of animation to use while Player walks
Player_WalkFramesByPUp:
    .byte PF_WALKSMALL_BASE, PF_WALKSMALL_BASE+1, PF_WALKSMALL_BASE, PF_WALKSMALL_BASE+1    ; 0 - Small
    .byte PF_WALKBIG_BASE, PF_WALKBIG_BASE+1, PF_WALKBIG_BASE+2, PF_WALKBIG_BASE+1      ; 1 - Big
    .byte PF_WALKBIG_BASE, PF_WALKBIG_BASE+1, PF_WALKBIG_BASE+2, PF_WALKBIG_BASE+1      ; 2 - Fire
    .byte PF_WALKSPECIAL_BASE, PF_WALKSPECIAL_BASE+1, PF_WALKSPECIAL_BASE+2, PF_WALKSPECIAL_BASE+1  ; 3 - Leaf
    .byte PF_WALKSPECIAL_BASE, PF_WALKSPECIAL_BASE+1, PF_WALKSPECIAL_BASE+2, PF_WALKSPECIAL_BASE+1  ; 4 - Frog
    .byte PF_WALKSPECIAL_BASE, PF_WALKSPECIAL_BASE+1, PF_WALKSPECIAL_BASE+2, PF_WALKSPECIAL_BASE+1  ; 5 - Tanooki
    .byte PF_WALKBIG_BASE, PF_WALKBIG_BASE+1, PF_WALKBIG_BASE+2, PF_WALKBIG_BASE+1      ; 6 - Hammer

    ; Frames used during the "power up" sequence from small -> Big
Player_GrowFrames:
    .byte PF_WALKBIG_BASE+2, PF_MIDGROW_HALFWAY, PF_WALKBIG_BASE+2, PF_MIDGROW_HALFWAY, PF_WALKBIG_BASE+2
    .byte PF_MIDGROW_HALFWAY, PF_MIDGROW_SMALL, PF_MIDGROW_HALFWAY, PF_MIDGROW_SMALL, PF_MIDGROW_HALFWAY
    .byte PF_MIDGROW_SMALL, PF_MIDGROW_HALFWAY

    ; Stores frame to be used while traversing a pipe
    ; Order is small, small + kuribo, other, other + kuribo
PipeMove_Frame:
    .byte PF_INPIPE_SMALL, PF_INPIPE_SMALLKURIBO, PF_INPIPE_BIG, PF_INPIPE_BIGKURIBO

    ; Frame used when Player is "skidding"
Player_SkidFrame:
    .byte PF_SKID_SMALL, PF_SKID_BIG    ; First value is for small, the other for everything else

Player_SwimActiveFrames:
    ; Everything but small
    .byte PF_SWIMACTIVE_BIG, PF_SWIMACTIVE_BIG+1, PF_SWIMACTIVE_BIG+2, PF_SWIMACTIVE_BIG, PF_SWIMACTIVE_BIG+1, PF_SWIMACTIVE_BIG+2
    ; Small
    .byte PF_SWIMIDLE_SMALL, PF_SWIMIDLE_SMALL+1, PF_SWIMIDLE_SMALL+2, PF_SWIMIDLE_SMALL, PF_SWIMIDLE_SMALL+1, PF_SWIMIDLE_SMALL+2

    ; Player sprite frames for swimming; first four are all power-up/suits
    ; EXCEPT small, and the other four are for small
Player_SwimIdleFrames:
    .byte PF_SWIMIDLE_BIG, PF_SWIMIDLE_BIG+1, PF_SWIMIDLE_BIG-8, PF_SWIMIDLE_BIG+1  ; Everything but small
    .byte PF_SWIMIDLE_SMALL, PF_SWIMIDLE_SMALL, PF_SWIMIDLE_SMALL+3, PF_SWIMIDLE_SMALL+3    ; Small

    ; Player's tail attack frames
Player_TailAttackFrames:
    .byte PF_TAILATKGROUND_BASE, PF_TAILATKGROUND_BASE+1, PF_TAILATKGROUND_BASE, PF_TAILATKGROUND_BASE+2, PF_TAILATKGROUND_BASE ; On ground
    .byte PF_TAILATKINAIR_BASE, PF_TAILATKINAIR_BASE-5, PF_TAILATKINAIR_BASE, PF_TAILATKINAIR_BASE-4, PF_TAILATKINAIR_BASE  ; In air

    ; Frames for when Player is in Kuribo's shoe
Player_KuriboFrame:
    .byte PF_KURIBO_SMALL, PF_KURIBO_BIG    ; First value is for small, the other for everything else

    ; Player duck frame
Player_DuckFrame:
    ; First value is for everything EXCEPT Raccoon power; value on right is for raccoon power
    .byte PF_DUCK_NOTRACCOON,  PF_DUCK_RACCOON

    ; The three sprite frames for when Player shoots a fireball/hammer
Player_FireOnGround:    .byte PF_THROWONGROUND_BASE, PF_THROWONGROUND_BASE+3, PF_THROWONGROUND_BASE+2
Player_FireInAir:   .byte PF_THROWINAIR_BASE, PF_THROWINAIR_BASE+1, PF_THROWINAIR_BASE+2

    ; Frames used while frog hopping
Player_FrogHopFrames:
    .byte PF_FROGHOP_BASE, PF_FROGHOP_BASE+2, PF_FROGHOP_BASE+1, PF_FROGHOP_BASE

    ; Frames used when Player is running at high speed!
Player_SpreadEagleFrames:
    .byte PF_RUNBIG_BASE, PF_RUNBIG_BASE+1, PF_RUNBIG_BASE+2, PF_RUNBIG_BASE+1  ; Player is not small
    .byte PF_RUNSMALL_BASE, PF_RUNSMALL_BASE+1, PF_RUNSMALL_BASE, PF_RUNSMALL_BASE+1    ; Player is small


    ; The raccoon power uses rotations of three frames based on different conditions
Player_TailWagFlyFrames:
    .byte PF_TAILWAGFLY_BASE+2, PF_TAILWAGFLY_BASE+1, PF_TAILWAGFLY_BASE    ; Flying
    .byte PF_TAILWAGFLY_BASE+1, PF_TAILWAGFLY_BASE+2, PF_TAILWAGFLY_BASE    ; Flying, apex
    .byte PF_JUMPRACCOON, PF_JUMPRACCOON, PF_JUMPRACCOON            ; Jump/fall
    .byte PF_TAILWAGFALL+2, PF_TAILWAGFALL+1, PF_TAILWAGFALL        ; Flutter wag

Player_HoldingFrames:
    .byte PF_HOLDBIG_BASE, PF_HOLDBIG_BASE+1, PF_HOLDBIG_BASE+2, PF_HOLDBIG_BASE+1  ; Player is not small
    .byte PF_HOLDSMALL_BASE, PF_HOLDSMALL_BASE+1, PF_HOLDSMALL_BASE, PF_HOLDSMALL_BASE+1    ; Player is small

Player_TwisterSpinFrames:
    .byte PF_SPINSMALLORFROG_BASE+12, PF_SPINSMALLORFROG_BASE, PF_SPINSMALLORFROG_BASE+12, PF_SPINSMALLORFROG_BASE  ; small or frog
    .byte PF_SPINSLIDESUITS_BASE+10, PF_SPINSLIDESUITS_BASE, PF_SPINSLIDESUITS_BASE+10, PF_SPINSLIDESUITS_BASE+1    ; suits that slide
    .byte PF_SPINOTHER_BASE, PF_SPINOTHER_BASE+2, PF_SPINOTHER_BASE, PF_SPINOTHER_BASE+3    ; otherwise

    ; Airship "caught anchor" frame or general vine climbing
Player_ClimbFrame:
    .byte PF_CLIMB_SMALL    ; Small
    .byte PF_CLIMB_BIG  ; Big
    .byte PF_CLIMB_BIG  ; Fire
    .byte PF_CLIMB_BIG  ; Leaf
    .byte PF_CLIMB_FROG ; Frog
    .byte PF_CLIMB_BIG  ; Tanooki
    .byte PF_CLIMB_BIG  ; Hammer

    ; Airship jump frame used by power up
Airship_JumpFrameByPup:
    .byte PF_JUMPFALLSMALL      ; Small
    .byte PF_JUMPBIG        ; Big
    .byte PF_JUMPBIG        ; Fire
    .byte PF_JUMPRACCOON        ; Leaf
    .byte PF_WALKSPECIAL_BASE+2 ; Frog
    .byte PF_JUMPRACCOON        ; Tanooki
    .byte PF_JUMPBIG        ; Hammer

Player_VibeDisableFrame:
    .byte PF_WALKSMALL_BASE     ; Small
    .byte PF_WALKBIG_BASE+2     ; Big
    .byte PF_WALKBIG_BASE+2     ; Fire
    .byte PF_WALKSPECIAL_BASE+2 ; Leaf
    .byte PF_WALKSPECIAL_BASE   ; Frog
    .byte PF_WALKSPECIAL_BASE+2 ; Tanooki
    .byte PF_WALKBIG_BASE+2     ; Hammer
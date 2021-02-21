object_killed:
    JSR Object_FallAndDelete    ; Have object fall and delete if it gets too low (at which point we don't return)

    LDY ObjGroupRel_Idx  ; Y = object's group relative index

    LDA ObjectGroup_KillAction,Y
    AND #%00001111
    BEQ Object_DoKillAction  ; If kill action is zero, jump to Object_DoKillAction (i.e. do NOT set frame 2)

    CPX #$05
    BGE Object_DoKillAction  ; If object slot >= 5 (i.e. not a "general" objects), jump to Object_DoKillAction (i.e. do NOT set frame 2)

    PHA      ; Save kill action

    LDA #$02
    STA Objects_Frame,X  ; Set frame to 2

    PLA      ; Restore kill action

    ; Do the kill action
Object_DoKillAction:
    JSR DynJump

    ; THESE MUST FOLLOW DynJump FOR THE DYNAMIC JUMP TO WORK!!
    .word Object_StandardKill   ; 0: Standard kill (does not set frame 2)
    .word Object_CalcAndDrawKilled  ; 1: Standard sprite draw and kill
    .word Object_DrawMirroredKilled ; 2: Draw mirrored sprite
    .word Object_Draw16x32Killed    ; 3: Draw tall sprite
    .word Object_DrawTallHFlipped   ; 4: Draw tall object horizontally flipped
    .word Object_NormalAndKilled    ; 5: Do "Normal" state and killed action (sinking/vert flip)
    .word Object_GiantKilled    ; 6: Giant enemy death
    .word Object_PoofDie        ; 7: Do "poof" dying state while killed
    .word Object_DrawAndMoveNotHalt ; 8: Draw and do movements unless gameplay halted
    .word Object_NormalWhileKilled  ; 9: Just do "Normal" state while killed

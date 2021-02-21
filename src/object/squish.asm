ObjState_Squashed:
    LDA Objects_Timer3,X
    BEQ PRG000_D090  ; If timer 3 is expired, jump to PRG000_D090

    JSR Object_Move  ; Perform standard object movements

    LDA Objects_DetStat,X
    AND #$04
    BEQ PRG000_D07E  ; If object did NOT hit ground, jump to PRG000_D07E

    JSR Object_HitGround     ; Align to ground
    STA Objects_XVel,X  ; Clear X velocity

PRG000_D07E:

    ; Set object frame to 3
    LDA #$03
    STA Objects_Frame,X

    LDA Level_ObjectID,X
    CMP #OBJ_GOOMBA
    BNE PRG000_D08D  ; If object is not a goomba, jump to PRG000_D08D (ObjectGroup_PatternSets, i.e. the "giant" enemy alternative)

    JMP Object_ShakeAndDrawMirrored  ; Draw goomba as mirrored sprite and don't come back

PRG000_D08D:
    JMP ObjectGroup_PatternSets  ; Do the giant enemy draw routine and don't come back

PRG000_D090:
    JMP Object_SetDeadEmpty  ; Jump to Object_SetDeadEmpty (mark object as dead/empty)

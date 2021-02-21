
object_squish:
    LDA objects_timer_3,x
    BNE +
    JMP Object_SetDeadEmpty  ; Remove the object
+

    JSR Object_Move  ; Perform standard object movements

; Allign to the ground
    LDA objects_detection_flags,x
    AND #object_hit_ground
    BEQ +
    JSR Object_HitGround
    STA objects_x_velocity,x

+

; Set object frame to 3
    LDA #$03
    STA objects_animation_frame,x

    LDA objects_ids,x
    CMP #OBJ_GOOMBA
    BNE +  ; If object is not a goomba, jump to + (ObjectGroup_PatternSets, i.e. the "giant" enemy alternative)

    JMP Object_ShakeAndDrawMirrored  ; Draw goomba as mirrored sprite and don't come back
+
    JMP ObjectGroup_PatternSets  ; Do the giant enemy draw routine and don't come back

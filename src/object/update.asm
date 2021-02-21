    LDA Objects_State,X
    BEQ PRG000_CA40  ; If this object is "dead/empty", jump to PRG000_CA40

    CMP #$08
    BEQ PRG000_CA81  ; If this object's state = 8 ("Poof" Dying), jump to PRG000_CA81

    LDY #$04     ; Y = 4

    ; Try to locate the group that this object ID belongs to
    ; Groups are defined by ObjectID_BaseVals, every 36 values.
PRG000_CA51:
    LDA Level_ObjectID,X    ; Get object ID
    CMP ObjectID_BaseVals,Y ; Compare to this base value
    BGE PRG000_CA5C  ; If this object ID >= the base value, jump to PRG000_CA5C

    ; Object ID is smaller, thus not this group...

    DEY      ; Y--
    BNE PRG000_CA51  ; If Y > 0, loop!

PRG000_CA5C:

    ; Y contains index to the base value for this group of object IDs
    ; A contains the object's ID

    INY      ; Y++
    SEC
    SBC ObjectID_BaseVals-1,Y ; Subtract next group's ID to make this object's ID relative to group

    STA ObjGroupRel_Idx ; Set ObjGroupRel_Idx to this group-relative index value

    ; Y is now a value of 1 to 5, and that value dictates the page
    ; where this object's code can be found...
    STY PAGE_A000    ; Set new page
    TAY     ; Object group-relative index -> 'Y'

    JSR PRGROM_Change_A000   ; Set page @ A000 to appropriate object page...

    LDA Objects_DisPatChng,X
    BNE PRG000_CA81  ; If pattern bank enforcement is disabled, jump to PRG000_CA81

    ; Object's can request a particular pattern set to be available to them.
    ; They may set either the fifth or sixth bank of CHRROM, which is specified
    ; by bit 7.

    LDX #$00     ; X = 0 (fifth CHRROM bank)
    LDA ObjectGroup_PatTableSel,Y    ; Load CHRROM bank request for this object, if any
    BEQ PRG000_CA7F  ; If CHRROM bank request is zero, no change, jump to PRG000_CA7F
    BPL PRG000_CA7A  ; If CHRROM bank request does not have bit 7 set, jump to PRG000_CA7A
    INX      ; Otherwise, X = 1 (sixth CHRROM bank)

PRG000_CA7A:
    AND #$7f     ; Bit 7 is used to specify which bank, so filter it here
    STA PatTable_BankSel+4,X     ; Store pattern bank

PRG000_CA7F:
    LDX SlotIndexBackup         ; Restore X as the object slot index

PRG000_CA81:
    JSR AScrlURDiag_CheckWrapping   ; Handle diagonal autoscroll's scroll wrappping
    JSR Object_DetermineVertVis ; Set flags based on which sprites of this object are vertically visible
    JSR Object_DetermineHorzVis ; Set flags based on which sprites of this object are horizontally visible

    LDA Objects_State,X  ; Get object state...

    JSR DynJump

    ; THESE MUST FOLLOW DynJump FOR THE DYNAMIC JUMP TO WORK!!
    .word ObjState_DeadEmpty    ; 0 - Dead/Empty
    .word ObjState_Initializing ; 1 - Initializing
    .word ObjState_Normal       ; 2 - Normal operation
    .word ObjState_Shelled      ; 3 - Shelled
    .word ObjState_Held     ; 4 - Held by Player
    .word ObjState_Kicked       ; 5 - Kicked
    .word ObjState_Killed       ; 6 - Killed
    .word ObjState_Squashed     ; 7 - Object was squashed (NOTE: Really only intended for Goomba/Giant Goomba)
    .word ObjState_PoofDying    ; 8 - "Poof" Dying

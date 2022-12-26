npc_message_lo = Objects_Var1
npc_message_hi = Objects_Var2
npc_State  = Objects_Var4
npc_offset = Objects_Var5
npc_timer = Objects_Timer
npc_dialog_address = ToadTalk_VH


jabem_npc_found:
    ;            C    a    t    b    a    s    k    e    t    s    !
    .byte $FE, $B2, $D0, $CD, $D1, $D0, $CC, $DA, $D4, $CD, $CC, $EA, $FE, $FE, $FE

    ;            Y    o    u         f    o    u    n    d         m    e    .
    .byte $FE, $C8, $DE, $CE, $FE, $D5, $DE, $CE, $DD, $D3, $FE, $DC, $D4, $E9, $FE

    ;            M    e    s    s    a    g    e         m    e         o    n
    .byte $FE, $BC, $D4, $CC, $CC, $D0, $D6, $D4, $FE, $DC, $D4, $FE, $DE, $DD, $FE

    ;            D    i    s    c    o    r    d         f    o    r
    .byte $FE, $B3, $D8, $CC, $D2, $DE, $CB, $D3, $FE, $FE, $FE, $FE, $FE, $FE, $FE

    ;            t    h    e         g    r    a    n    d
    .byte $FE, $CD, $D7, $D4, $FE, $D6, $CB, $D0, $DD, $D3, $FE, $FE, $FE, $FE, $FE

    ;            p    r    i    z    e    !
    .byte $FE, $DF, $CB, $D8, $8F, $D4, $EA, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE

kanga_npc_found:
    ;            P    i    c    k         a         b    o    x    .
    .byte $FE, $BF, $D8, $D2, $DA, $FE, $D0, $FE, $D1, $DE, $88, $E9, $FE, $FE, $FE

    ;            I    t    s         c    o    n    t    e    n    t    s
    .byte $FE, $B8, $CD, $CC, $FE, $D2, $DE, $DD, $CD, $D4, $DD, $CD, $CC, $FE, $FE

    ;            w    i    l    l         h    e    l    p         y    o    u
    .byte $FE, $81, $D8, $DB, $DB, $FE, $D7, $D4, $DB, $DF, $FE, $8C, $DE, $CE, $FE

    ;            o    n         y    o    u    r         w    a    y    .
    .byte $FE, $DE, $DD, $FE, $8C, $DE, $CE, $CB, $FE, $81, $D0, $8C, $E9, $FE, $FE

    ;
    .byte $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE

    ;
    .byte $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE

; 4x3 sprite, last 4 are for padding
jabem_npc_patterns:
    .byte $01, $83, $85, $01, $A1, $A3, $A5, $A7, $C1, $C3, $C5, $C7, $00, $00, $00, $00 ; frame 0
    .byte $01, $8B, $8D, $01, $A9, $AB, $AD, $AF, $C9, $CB, $CD, $CF, $00, $00, $00, $00 ; frame 1
    .byte $01, $93, $95, $01, $B1, $B3, $B5, $B7, $D1, $D3, $D5, $D7, $00, $00, $00, $00 ; frame 2
    .byte $01, $9B, $9D, $01, $B9, $BB, $BD, $BF, $D9, $DB, $DD, $DF ; frame 3

; Moved to PRG001 for memory optimization
; Sprite X offsets per sprite, horizontally flipped or not
;jabem_npc_sprite_x:             .byte $00, $08, $10, $18, $00, $08, $10, $18, $00, $08, $10, $18
;jabem_npc_sprite_x_flipped:     .byte $18, $10, $08, $00, $18, $10, $08, $00, $18, $10, $08, $00

; Sprite Y offsets per sprite, vertically flipped or not
;jabem_npc_sprite_y:             .byte $00, $00, $00, $00, $10, $10, $10, $10, $20, $20, $20, $20
;jabem_npc_sprite_y_flipped:     .byte $20, $20, $20, $20, $10, $10, $10, $10, $00, $00, $00, $00

; Similar to jabem_npc_sprite_vertical_visibility, marks sprite that should be
; invisible if marked horizontally invisible
;jabem_npc_sprite_horizontally_visibility:
;    .byte $80, $40, $20, $10

; Sprites are drawn straight through; this marks the
; ones that should not be handled if vertically invisible
;jabem_npc_sprite_vertical_visibility:
;    .byte $01, $01, $01, $01    ; Top sprites
;    .byte $02, $02, $02, $02    ; Middle sprites
;    .byte $04, $04, $04, $04    ; Bottom sprites

; Alternate sprite offset each frame for better flickering
;jabem_npc_sprite_offsets:
;    .byte $50, $54, $58, $5C    ; Top sprites
;    .byte $60, $64, $68, $6C    ; Middle sprites
;    .byte $70, $74, $78, $7C    ; Bottom sprites
;    .byte $00, $00, $00, $00    ; Unused, for alignment only (switches between these sets via 4 ASLs)
;    .byte $DC, $D8, $D4, $D0    ; Top sprites
;    .byte $EC, $E8, $E4, $E0    ; Middle sprites
;    .byte $FC, $F8, $F4, $F0    ; Bottom sprites

; Pointers to specific messages.
jabem_npc_messages_lo:  .byte <jabem_npc_found, <kanga_npc_found
jabem_npc_messages_hi:  .byte >jabem_npc_found, >kanga_npc_found

; Set proper flip bit to face Player
jabem_npc_flip_bit:     .byte SPR_HFLIP, $00

jabem_npc_dialog_box_row_1:    .byte $94, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $96
jabem_npc_dialog_box_row_2:    .byte $92, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $93
jabem_npc_dialog_box_row_3:    .byte $95, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $91, $97
jabem_npc_dialog_box_row_offsets:
    .byte (jabem_npc_dialog_box_row_1 - jabem_npc_dialog_box_row_1), (jabem_npc_dialog_box_row_2 - jabem_npc_dialog_box_row_1), (jabem_npc_dialog_box_row_2 - jabem_npc_dialog_box_row_1), (jabem_npc_dialog_box_row_2 - jabem_npc_dialog_box_row_1)
    .byte (jabem_npc_dialog_box_row_2 - jabem_npc_dialog_box_row_1), (jabem_npc_dialog_box_row_2 - jabem_npc_dialog_box_row_1), (jabem_npc_dialog_box_row_2 - jabem_npc_dialog_box_row_1), (jabem_npc_dialog_box_row_3 - jabem_npc_dialog_box_row_1)
jabem_npc_dialog_box_offset_end


; Selects the pattern table index 4 for the NPC
jabem_npc_pattern_set_4:
    .byte #128   ; Jabem
    .byte #130   ; Kanga

; Selects the pattern table index 5 for the NPC
jabem_npc_pattern_set_5:
    .byte #129   ; Jabem
    .byte #131   ; Kanga


object_jabem_npc_init:
    LDY Objects_YHi, x
    STY npc_offset, x

    ; Use the right graphics for the NPC
    LDA jabem_npc_pattern_set_4, y
    STA PatTable_BankSel+4
    LDA jabem_npc_pattern_set_5, y
    STA PatTable_BankSel+5

    ; Always appear on the bottom half of the screen.
    LDA #$01
    STA Objects_YHi, x

    ; Stop the timer
    STA Level_TimerEn

    ; Halt the Player
    LDA #$FF
    STA Player_HaltTick

    LDA #$00
    STA Map_UseItem     ; Clear item usage flag
    STA Player_Behind   ; Player is not behind anything
    STA ToadTalk_CPos   ; Clear the Toad character position counter

    ; Set the starting VRAM addresses
    LDA #$28
    STA npc_dialog_address
    LDA #$c8
    STA npc_dialog_address+1

    RTS      ; Return


object_jabem_npc_update:
    ; Update graphics
    LDA #$5E
    STA PatTable_BankSel+1

    ; Face the player
    JSR jabem_npc_player_to_left_or_right
    LDA jabem_npc_flip_bit, y
    STA Objects_FlipBits,X

    ; Do Toad's dialog message
    JSR jabem_npc_dialog_update

    LDA Player_HaltTick
    ORA InvFlip_Counter
    BNE +  ; If Player is still halted or inventory is open, jump

    LDA Pad_Input
    AND #$10
    BEQ +  ; If Player is NOT pressing START, jump

    ; Flip open inventory
    LDA #$01
    STA Inventory_Open

    ; Start on first inventory item
    LSR A   ; A = 0
    STA InvStart_Item

+
    LDA InvFlip_Counter
    CMP #$04
    BNE +  ; If Inventory is fully open, jump

    LDA Pad_Input
    AND #%11110011
    BEQ +  ; If Player is not pressing anything (besides up/down), jump

    ; Force like Player pressed 'B' (close inventory)
    LDA #$40
    STA Pad_Input

+
    JMP jabem_npc_draw


jabem_npc_dialog_update:
    LDA npc_State, x  ; Get current dialog state
    JSR DynJump
    
    .word jabem_npc_draw_dialog_box
    .word jabem_npc_update_dialog_box
    .word jabem_npc_finished


jabem_npc_draw_dialog_box:
    LDX Graphics_BufCnt  ; X = current graphics buffer counter

    ; Store the current VRAM address into the buffer
    LDA npc_dialog_address
    STA Graphics_Buffer, x
    LDA npc_dialog_address+1
    STA Graphics_Buffer+1, x

    ; Store the next row address (+32 bytes to next row)
    CLC
    ADC #$20    ; 32 bytes to next row
    STA npc_dialog_address+1
    BCC +
    INC npc_dialog_address  ; Apply carry
+

    LDA #jabem_npc_dialog_box_row_2 - jabem_npc_dialog_box_row_1    ; run count per row
    STA Graphics_Buffer+2, x
    STA Temp_Var1       ; -> Temp_Var1

    LDY ToadTalk_CPos    ; Y = current dialog box row
    LDA jabem_npc_dialog_box_row_offsets, y
    TAY         ; Y = offset to this row index

-
    ; Store next pattern in dialog box
    LDA jabem_npc_dialog_box_row_1, y
    STA Graphics_Buffer+3, x

    INY      ; Y++ (next pattern for dialog box)
    INX      ; X++ (next index in graphics buffer)

    DEC Temp_Var1   ; Temp_Var1--
    BNE -  ; While Temp_Var1 > 0, loop!

    ; Insert terminator
    LDA #$00
    STA Graphics_Buffer+3, x

    ; X += 3
    INX
    INX
    INX
    STX Graphics_BufCnt

    LDX SlotIndexBackup     ; X = object slot index

    INC ToadTalk_CPos    ; Next row

    LDA ToadTalk_CPos
    CMP #jabem_npc_dialog_box_offset_end - jabem_npc_dialog_box_row_offsets
    BLT +  ; If row count < 8, return

    ; Dialog box is complete

    LDY npc_offset, x
    
    ; Toad's Var1 and Var2 store the current pointer to the text he's reciting
    LDA jabem_npc_messages_lo, y
    STA npc_message_lo, x
    LDA jabem_npc_messages_hi, y
    STA npc_message_hi, x

    ; Reset the VRAM address for the dialog text
    LDA #$28
    STA npc_dialog_address
    LDA #$e9
    STA npc_dialog_address+1

    ; Toad's timer = $08
    LDA #$08
    STA npc_timer, x

    INC npc_State, x  ; npc_State = 1 (next dialog state)

+
jabem_npc_finished:
    RTS      ; Return


jabem_npc_update_dialog_box:
    LDA npc_timer, x
    BNE +++  ; If timer not expired, return

    ; Store address of text -> Temp_Var1/2
    LDA npc_message_lo, x
    STA Temp_Var1
    LDA npc_message_hi, x
    STA Temp_Var2

    INC npc_message_lo, x  ; Next character
    BNE +
    INC npc_message_hi, x  ; Apply carry

+
    LDY #$00        ; Y = 0
    LDA (Temp_Var1), y   ; Get character here
    TAY         ; -> 'Y'
    CPY #$FE
    BEQ +     ; If this is a "space", jump

    ; Play "blip" sound every other letter
    LDA ToadTalk_VL
    LSR A
    BCC +

    ; Play text "blip" sound
    LDA Sound_QLevel1
    ORA #SND_LEVELBLIP
    STA Sound_QLevel1

+
    TYA

    LDY Graphics_BufCnt  ; Y = graphics buffer counter
    STA Graphics_Buffer+3, y  ; Store into buffer

    ; Insert one character into graphics buffer
    LDA npc_dialog_address
    STA Graphics_Buffer, y   ; address high
    LDA #$01
    STA Graphics_Buffer+2, y ; run length
    LSR A
    STA Graphics_Buffer+4, y ; terminator
    TYA
    CLC
    ADC #$04
    STA Graphics_BufCnt ; count
    LDA npc_dialog_address+1
    STA Graphics_Buffer+1, y ; address low

    INC npc_dialog_address+1  ; Next VRAM byte
    AND #$1f        ; Get current column
    CMP #$17
    BNE ++     ; If we're not in column 23, jump to PRG024_A25B

    ; Line break!
    LDA npc_dialog_address+1
    ADC #$10        ; Add enough bytes to get to next row
    STA npc_dialog_address+1
    BCC +
    INC npc_dialog_address ; Apply carry
+

    CMP #$a9
    BNE ++  ; If we haven't reached the last character, jump

    INC npc_State, x  ; npc_State = 2 (next dialog state)

    LDA #$00
    STA ToadTalk_CPos

++
    ; Reset timer until next character.
    LDA #$02
    STA npc_timer, x

+++
    RTS      ; Return


; Draw a 48x32 sprite.
jabem_npc_draw:
    JSR Object_CalcSpriteXY_NoHi    ; Calculate the Sprite X and Y Low parts

    ; Temp_Var1 = Bowser's Sprite Y
    LDA Objects_SpriteY, x
    STA Temp_Var1

    ; Temp_Var2 = Bowser's Sprite X
    LDA Objects_SpriteX, x
    STA Temp_Var2

    ; Temp_Var3 and Temp_Var4 = Bowser's FlipBits
    LDA Objects_FlipBits, x
    STA Temp_Var3
    STA Temp_Var4

    ; Temp_Var5 = Bowser's horizontal visibility flags
    LDA Objects_SprHVis, x
    STA Temp_Var5

    ; Temp_Var6 = Bowser's vertical visibility flags
    LDA Objects_SprVVis, x
    STA Temp_Var6

    LDY Objects_Frame, x

    LDA Objects_FlipBits, x
    AND #SPR_VFLIP
    STA Temp_Var3   ; Temp_Var3 = $00 or SPR_VFLIP, depending whether Bowser is flipped vertically

    ORA #SPR_HFLIP
    STA Temp_Var4   ; Always set horizontal flip in Temp_Var4

    LDA Objects_Frame, x
    ASL A
    ASL A
    ASL A
    ASL A
    STA Temp_Var15  ; Temp_Var15 = frame * 16

    LDA #$00
    STA Temp_Var16

-

    ; This determines which Sprite_RAM offset table set we use.
    ; Either 0 or 16, alternating every other frame.
    LDA Counter_1
    AND #$01
    ASL A
    ASL A
    ASL A
    ASL A
    CLC
    ADC Temp_Var16  ; Temp_Var16 = current sprite we're on
    TAY      ; -> 'Y'

    LDA jabem_npc_sprite_offsets, y
    TAY      ; Index -> 'Y'

    LDX Temp_Var16  ; X = current sprite

    LDA Temp_Var6      ; Get Bowser's vertical visibility flags
    AND jabem_npc_sprite_vertical_visibility, x
    BNE ++     ; If this sprite should not be drawn due to vertically being off-screen, jump

    ; Sprites are 0 through 12, so each horizontal sprite is by modulus 4
    TXA
    AND #$03    ; Essentially mod 4
    TAX
    LDA Temp_Var5   ; Temp_Var5 = 0 to 3 based on which horizontal sprite we're doing

    AND jabem_npc_sprite_horizontally_visibility, x
    BNE ++  ; If this sprite should not be drawn due to beging horizontally off-screen, jump

    LDA Temp_Var15
    CLC
    ADC Temp_Var16  ; Temp_Var16 = (Bowser's frame * 16 [Temp_Var15]) + (which sprite we're on)
    TAX      ; -> 'X'

    ; Store pattern of this Bowser sprite
    LDA jabem_npc_patterns, x
    STA Sprite_RAM+1, y

    LDX Temp_Var16  ; X = Temp_Var16

    LDA Temp_Var3
    BPL +  ; If not vertically flipped, jump

    ; Otherwise, use the vertically flipped lookups
    TXA
    CLC
    ADC #jabem_npc_sprite_y_flipped - jabem_npc_sprite_y
    TAX

+
    LDA Temp_Var1      ; A = Temp_Var1 (Sprite Y)
    CLC
    ADC jabem_npc_sprite_y, x    ; Offset Y as appropriate for this sprite
    STA Sprite_RAM, y    ; Set sprite Y

    LDX Temp_Var16     ; X = Temp_Var16
    TXA
    AND #$03        ; Get which horizontal sprite (of 4) we're on
    CMP #$02        ; Horizontal sprite 2 would be the beginning of the "right half" of Bowser

    LDA Temp_Var3      ; A = Temp_Var3 (Bowser's flip bits)
    BLT +     ; If we are on the left half of Bowser, jump

    LDA Temp_Var4      ; A = Temp_Var4 (Bowser's flip bits alternate)

+
    ORA #SPR_PAL3       ; Lock in palette 3
    STA Sprite_RAM+2, y  ; Store sprite attributes

    LDA Temp_Var3
    AND #SPR_HFLIP
    BEQ +  ; If Bowser is not horizontally flipped, jump

    ; Otherwise, use the horizontally flipped lookups
    TXA
    CLC
    ADC #jabem_npc_sprite_x_flipped - jabem_npc_sprite_x
    TAX

+
    LDA Temp_Var2       ; A = Temp_Var2 (Sprite X)
    CLC
    ADC jabem_npc_sprite_x, x     ; Offset X as appropriate for this sprite
    STA Sprite_RAM+3, y   ; Set sprite X

++
    INC Temp_Var16      ; Temp_Var16++ (next sprite)

    ; Loop for each of the 12 sprites
    LDA Temp_Var16
    CMP #12
    BNE -

    LDX SlotIndexBackup     ; Restore the index of the agent
    RTS

jabem_npc_player_to_left_or_right:
    ; Backup X position
    LDA Objects_X, x
    PHA

    ; +8 Bowser's X; calculation of which side the Player is on is offset
    CLC
    ADC #$08
    STA Objects_X, x
    JSR Level_ObjCalcXDiffs

    ; Restore Bowser's X
    PLA
    STA Objects_X, x

    RTS      ; Return

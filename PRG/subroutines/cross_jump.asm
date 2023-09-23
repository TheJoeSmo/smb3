;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CrossJumpA
;
; Allows for a routine to be called for the A000 bank.
;
; Parameters
; ----------
; A: The bank of the routine
; CrossJumpAddr: The address of the routine to be called
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CrossJumpToSubroutineA000:
    ; Remember the bank to jump to
    STA CrossJumpBank
    
    ; Push the current bank to the stack
    LDA PAGE_A000
    PHA

    ; Change the bank to the desired bank
    LDA CrossJumpBank
    STA PAGE_A000
    JSR PRGROM_Change_A000

    ; Run the subroutine indirectly
    JSR CrossJump

    ; Store processor flags
    PHP
    PLA
    STA CrossJumpFlags

    ; Change the bank back to the origional bank
    PLA
    STA PAGE_A000
    JSR PRGROM_Change_A000

    ; Restore flags from the routine
    LDA CrossJumpFlags
    PHA
    PLP
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CrossJumpC
;
; Allows for a routine to be called for the A000 bank.
;
; Parameters
; ----------
; A: The bank of the routine
; CrossJumpAddr: The address of the routine to be called
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CrossJumpToSubroutineC000:
    ; Remember the bank to jump to
    STA CrossJumpBank
    
    ; Push the current bank to the stack
    LDA PAGE_C000
    PHA

    ; Change the bank to the desired bank
    LDA CrossJumpBank
    STA PAGE_C000
    JSR PRGROM_Change_C000

    ; Run the subroutine indirectly
    JSR CrossJump

    ; Store processor flags
    PHP
    PLA
    STA CrossJumpFlags

    ; Change the bank back to the origional bank
    PLA
    STA PAGE_C000
    JSR PRGROM_Change_C000

    ; Restore flags from the routine
    LDA CrossJumpFlags
    PHA
    PLP
    RTS

; Used to provide an artificial subroutine
CrossJump:
    JMP (CrossJumpAddr)

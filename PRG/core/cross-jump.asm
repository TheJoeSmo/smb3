CrossJumpToA:
  STA CrossJumpBank

  ; Push the current bank onto the stack
  LDA PAGE_A000
  PHA

  ; Change bank
  LDA CrossJumpBank
  STA PAGE_A000
  JSR PRGROM_Change_A000

  JSR CrossJump

  ; Store flags
  PHP
  PLA
  STA CrossJumpBank

  ; Change bank back
  PLA
  STA PAGE_A000
  JSR PRGROM_Change_A000

  ; Restore flags
  LDA CrossJumpBank
  PHA
  PLP
  RTS

CrossJumpToC:
  STA CrossJumpBank

  ; Push the current bank onto the stack
  LDA PAGE_C000
  PHA

  ; Change bank
  LDA CrossJumpBank
  STA PAGE_C000
  JSR PRGROM_Change_C000

  JSR CrossJump

  ; Store flags
  PHP
  PLA
  STA CrossJumpBank

  ; Change bank back
  PLA
  STA PAGE_C000
  JSR PRGROM_Change_C000

  ; Restore flags
  LDA CrossJumpBank
  PHA
  PLP
  RTS

CrossJump:
  JMP (CrossJumpPointer)

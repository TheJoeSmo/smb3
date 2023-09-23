.macro CrossJumpToA _1, _2
    LDA #<_2
    STA CrossJumpAddr
    LDA #>_2
    STA CrossJumpAddr+1
    LDA #<_1
    JMP CrossJumpToSubroutineA000
.endm

.macro CrossJumpToC _1, _2
    LDA #<_2
    STA CrossJumpAddr
    LDA #>_2
    STA CrossJumpAddr+1
    LDA #<_1
    JMP CrossJumpToSubroutineC000
.endm

.macro CrossJumpToSubroutineA _1, _2
    LDA #<_2
    STA CrossJumpAddr
    LDA #>_2
    STA CrossJumpAddr+1
    LDA #<_1
    JMP CrossJumpToSubroutineA000
.endm

.macro CrossJumpToSubroutineC _1, _2
    LDA #<_2
    STA CrossJumpAddr
    LDA #>_2
    STA CrossJumpAddr+1
    LDA #<_1
    JMP CrossJumpToSubroutineC000
.endm

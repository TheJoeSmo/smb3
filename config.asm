; Enemy Definitions
INCLUDE_REX = 1
INCLUDE_BUMPTY = 1
INCLUDE_THWIMP = 1

; Levels
INCLUDE_TEST_LEVELS = 0
INCLUDE_DEMO_LEVELS = 0

;----------------------
; Properties
IS_EXPANDED_ROM = 0 || INCLUDE_REX || INCLUDE_BUMPTY || INCLUDE_THWIMP
NUMBER_OF_PRG_BANKS = 32 ;16 + (16 * IS_EXPANDED_ROM)
NUMBER_OF_CHR_BANKS = 32 ;16 + (16 * IS_EXPANDED_ROM)
UNUSED_EXTENDED_CHR_BANKS = 128 - (INCLUDE_REX != 0) - (INCLUDE_BUMPTY != 0) - (INCLUDE_THWIMP != 0)
KEEP_USED_LEVELS = !(INCLUDE_TEST_LEVELS || INCLUDE_DEMO_LEVELS)

;----------------------
; Enemy options
Thwimp_MaxFallSpeed = $40
Thwimp_JumpSpeed = $A0
Thwimp_WaitTime = $40

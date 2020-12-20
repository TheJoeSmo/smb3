Player_DrawAndDoActions29:
    JSR PChg_C000_To_29  ; Change page @ C000 to 29

    LDA #$00
    STA Player_InPipe   ; Player_InPipe = 0

    JSR Player_DrawAndDoActions  ; Draw Player and do actions (going to coin heaven, the airship intro, going through pipes, ...)

    INC Player_InPipe    ; Player_InPipe = 1

PRG008_A224:

    ; If Player did NOT enter a pipe, we jump here...

    ; Pull return address (so we do NOT return to the original Player_DrawAndDoActions
    ; call, thus not setting Player_InPipe flag... seems like a stupid way to
    ; conditionalize that, but hey, I didn't program in the 80s...)
    PLA
    PLA

    JMP PChg_C000_To_0   ; Jump to PChg_C000_To_0 (switch C000 back to page 0 and return)
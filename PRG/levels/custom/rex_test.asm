; Original address was $BB82
; rex's layout data
	.byte $93, $BC			 ; Next Area Layout Offset
	.byte $06, $C0			 ; Next Area Enemy & Item Offset
	.byte $EA				 ; Level Size Index | Y-Start Index
	.byte $80				 ; BG Pal | Enemy Pal | X-Start Index | Unused
	.byte $81				 ; Pipe Ends Level | VScroll Index | Vertical Flag | Next Area Object Set
	.byte $01				 ; Level Entry Action | Graphic Set
	.byte $00				 ; Time Index | Unused | Music Index

	.byte $00, $00, $03		 ; White Mushrooms, Flowers and Stars @ (0, 0)
	.byte $1A, $00, $C0, $26 ; Flat Ground @ (0, 26)
	.byte $11, $07, $E3		 ; Background Clouds @ (7, 17)
	.byte $16, $01, $00		 ; Background Hills A @ (1, 22)
	.byte $17, $05, $01		 ; Background Hills B @ (5, 23)
	.byte $19, $0A, $92		 ; Background Bushes @ (10, 25)
	.byte $33, $0E, $21		 ; '?' Blocks with single coins @ (14, 19)
	.byte $36, $0B, $21		 ; '?' Blocks with single coins @ (11, 22)
	.byte $33, $0F, $01		 ; '?' with Leaf @ (15, 19)
	.byte $10, $14, $E2		 ; Background Clouds @ (20, 16)
	.byte $34, $1A, $20		 ; '?' Blocks with single coins @ (26, 20)
	.byte $37, $16, $A2		 ; Downward Pipe (CAN'T go down) @ (22, 23)
	.byte $13, $20, $13		 ; White Block Platform (Extends to ground) @ (32, 19)
	.byte $15, $1D, $23		 ; Orange Block Platform (Extends to ground) @ (29, 21)
	.byte $17, $19, $34		 ; Green Block Platform (Extends to ground) @ (25, 23)
	.byte $15, $11, $42		 ; Blue Block Platform (Extends to ground) @ (17, 21)
	.byte $17, $0F, $22		 ; Orange Block Platform (Extends to ground) @ (15, 23)
	.byte $11, $28, $E2		 ; Background Clouds @ (40, 17)
	.byte $13, $2D, $E4		 ; Background Clouds @ (45, 19)
	.byte $19, $27, $C1, $1C ; Flat Ground @ (39, 25)
	.byte $18, $2A, $95		 ; Background Bushes @ (42, 24)
	.byte $36, $2C, $20		 ; '?' Blocks with single coins @ (44, 22)
	.byte $18, $20, $35		 ; Green Block Platform (Extends to ground) @ (32, 24)
	.byte $38, $29, $01		 ; '?' with Leaf @ (41, 24)
	.byte $15, $36, $00		 ; Background Hills A @ (54, 21)
	.byte $16, $33, $01		 ; Background Hills B @ (51, 22)
	.byte $16, $3B, $01		 ; Background Hills B @ (59, 22)
	.byte $11, $49, $E2		 ; Background Clouds @ (73, 17)
	.byte $1A, $48, $C0, $15 ; Flat Ground @ (72, 26)
	.byte $18, $41, $91		 ; Background Bushes @ (65, 24)
	.byte $19, $4A, $92		 ; Background Bushes @ (74, 25)
	.byte $2C, $4B, $80		 ; Coins @ (75, 12)
	.byte $2E, $49, $80		 ; Coins @ (73, 14)
	.byte $30, $47, $80		 ; Coins @ (71, 16)
	.byte $32, $45, $80		 ; Coins @ (69, 18)
	.byte $34, $43, $80		 ; Coins @ (67, 20)
	.byte $25, $53, $82		 ; Coins @ (83, 5)
	.byte $27, $5C, $81		 ; Coins @ (92, 7)
	.byte $09, $52, $64		 ; Orange Block Platform (Floating) @ (82, 9)
	.byte $0B, $5D, $BC		 ; Cloud Platform @ (93, 11)
	.byte $0C, $58, $B3		 ; Cloud Platform @ (88, 12)
	.byte $35, $5E, $41		 ; Wooden Blocks @ (94, 21)
	.byte $14, $53, $46		 ; Blue Block Platform (Extends to ground) @ (83, 20)
	.byte $16, $51, $26		 ; Orange Block Platform (Extends to ground) @ (81, 22)
	.byte $18, $4F, $36		 ; Green Block Platform (Extends to ground) @ (79, 24)
	.byte $28, $5A, $0B		 ; Brick with 1-up @ (90, 8)
	.byte $37, $5C, $01		 ; '?' with Leaf @ (92, 23)
	.byte $27, $65, $83		 ; Coins @ (101, 7)
	.byte $28, $60, $83		 ; Coins @ (96, 8)
	.byte $1A, $60, $C0, $04 ; Flat Ground @ (96, 26)
	.byte $1A, $68, $C0, $47 ; Flat Ground @ (104, 26)
	.byte $27, $6C, $80		 ; Coins @ (108, 7)
	.byte $28, $6E, $80		 ; Coins @ (110, 8)
	.byte $29, $6A, $80		 ; Coins @ (106, 9)
	.byte $11, $67, $E4		 ; Background Clouds @ (103, 17)
	.byte $37, $64, $40		 ; Wooden Blocks @ (100, 23)
	.byte $37, $68, $40		 ; Wooden Blocks @ (104, 23)
	.byte $38, $63, $41		 ; Wooden Blocks @ (99, 24)
	.byte $38, $68, $41		 ; Wooden Blocks @ (104, 24)
	.byte $39, $62, $42		 ; Wooden Blocks @ (98, 25)
	.byte $39, $68, $42		 ; Wooden Blocks @ (104, 25)
	.byte $19, $6C, $92		 ; Background Bushes @ (108, 25)
	.byte $26, $71, $80		 ; Coins @ (113, 6)
	.byte $28, $73, $80		 ; Coins @ (115, 8)
	.byte $17, $76, $01		 ; Background Hills B @ (118, 23)
	.byte $38, $70, $A1		 ; Downward Pipe (CAN'T go down) @ (112, 24)
	.byte $37, $74, $A2		 ; Downward Pipe (CAN'T go down) @ (116, 23)
	.byte $37, $7C, $12		 ; Bricks @ (124, 23)
	.byte $37, $7F, $0D		 ; Brick with P-Switch @ (127, 23)
	.byte $38, $7B, $14		 ; Bricks @ (123, 24)
	.byte $39, $7A, $15		 ; Bricks @ (122, 25)
	.byte $27, $8D, $9B		 ; Downward Pipe (CAN go down) @ (141, 7)
	.byte $33, $8D, $41		 ; Wooden Blocks @ (141, 19)
	.byte $37, $8D, $A2		 ; Downward Pipe (CAN'T go down) @ (141, 23)
	.byte $37, $8D, $41		 ; Wooden Blocks @ (141, 23)
	.byte $11, $88, $32		 ; Green Block Platform (Extends to ground) @ (136, 17)
	.byte $17, $86, $22		 ; Orange Block Platform (Extends to ground) @ (134, 23)
	.byte $39, $80, $10		 ; Bricks @ (128, 25)
	.byte $38, $83, $10		 ; Bricks @ (131, 24)
	.byte $39, $83, $11		 ; Bricks @ (131, 25)
	.byte $1A, $8B, $A2		 ; Gap @ (139, 26)
	.byte $12, $91, $E2		 ; Background Clouds @ (145, 18)
	.byte $38, $91, $A1		 ; Downward Pipe (CAN'T go down) @ (145, 24)
	.byte $12, $94, $02		 ; Background Hills C @ (148, 18)
	.byte $40, $9B, $09		 ; Level Ending @ (155, 0)
	.byte $E8, $42, $80		 ; Jump object @ (0, 0)
	.byte $FF				 ; delimiter
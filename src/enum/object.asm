;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Object Enumeration
; Joe Smo 12/21/2020
; Includes for all enumeration for the objects
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

objects_states				= Objects_State
objects_ids					= Level_ObjectID
object_index 				= SlotIndexBackup
object_sprite_x				= Objects_SpriteX
objects_y					= Objects_Y
objects_lo_y				= Objects_Y
objects_hi_y				= Objects_YHi
objects_x					= Objects_X
objects_lo_x				= Objects_X
objects_hi_x				= Objects_XHi
objects_x_velocity			= Objects_XVel
objects_y_velocity			= Objects_YVel
objects_x_subpixel			= Objects_XVelFrac
objects_v1					= Objects_Var1
objects_v2					= Objects_Var2
objects_v3					= Objects_Var3
objects_v4					= Objects_Var4
objects_v5					= Objects_Var5
objects_v6					= Objects_Var6
objects_v7 					= Objects_Var7
objects_v10					= Objects_Var10
objects_v11					= Objects_Var11
objects_v12					= Objects_Var12
objects_v13					= Objects_Var13
objects_v14					= Objects_Var14
objects_timer				= Objects_Timer
objects_no_collide_timer	= Objects_Timer2
objects_sprite_attributes	= Objects_SprAttr
objects_attributes 			= Objects_FlipBits
objects_animation_frame 	= Objects_Frame
objects_flashing_counter	= Objects_ColorCycle
objects_detection_flags 	= Objects_DetStat
object_hit_right_wall		= %00000001
object_hit_left_wall		= %00000010
object_hit_wall 			= %00000011
object_hit_ground			= %00000100
object_hit_ceiling			= %00001000
object_hit_partition		= %10000000
    ; Object's detection bits:
    ;   $01-hit wall right
    ;   $02-hit wall left
    ;   $04-hit ground
    ;   $08-hit ceiling
    ;   $80-object touching "32 pixel partition" floor (if active)
objects_enforce_page_chg 	= Objects_DisPatChng
objects_splash_disable_cnt	= ObjSplash_DisTimer
objects_quicksand_death_cnt	= Objects_QSandCtr
objects_in_water			= Objects_InWater
    ;   Bit 0 - Set if Player's bbox bottom is HIGHER than object's bbox bottom
    ;   Bit 1 - Set if Player's bbox left edge is to the LEFT of object's bbox left edge
    ;   Bit 4 - Set if Player tail attacked an object
objects_player_info			= Objects_PlayerHitStat
objects_timer_3				= Objects_Timer3
objects_timer_4 			= Objects_Timer4
objects_slope_position		= Objects_Slope
objects_target_x			= Objects_TargetingXVal
objects_target_y			= Objects_TargetingYVal
objects_giant_handling		= Objects_IsGiant
objects_offscreen_test		= Objects_UseShortHTest
objects_health				= Objects_HitCount
objects_sprite_visability	= Objects_SprHVis
objects_sprite_offset		= Object_SprRAM
object_sprite_y 			= Objects_SpriteY
objects_sprite_v_visability	= Objects_SprVVis


sprite_data 				= Sprite_RAM
sprite_data_y				= Sprite_RAM
sprite_data_graphic			= Sprite_RAM+1
sprite_data_attributes		= Sprite_RAM+2
sprite_pal_0				= %00000000
sprite_pal_1				= %00000001
sprite_pal_2				= %00000010
sprite_pal_3				= %00000011
sprite_priority				= %00100000
sprite_horizontal_flip		= %01000000
sprite_vertical_flip		= %10000000
sprite_data_x				= Sprite_RAM+3
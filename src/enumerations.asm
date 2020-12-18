; This file contains custom enumeration used to provide better variable names

is_statue					= Player_Statue ; if ~0 then is a statue
tail_swipe_counter			= Player_TailAttack ; counter from 0-12
invis_summer_sault			= Player_Flip ; if the player in_air and invis
hit_ceiling					= Player_HitCeiling ; if player just hit the ceiling
is_ducking					= Player_IsDucking
pipe_movement				= Level_PipeMove
is_sloped					= Level_SlopeEn
pswitch_cnt					= Level_PSwitchCnt
is_kuribo					= Player_Kuribo
slippery_type				= Player_Slippery
white_block_cnt				= Player_WhiteBlkCnt
is_behind					= Player_Behind
is_behind_enabled			= Player_Behind_En
is_sliding					= Player_Slide
is_sinking					= Player_SandSink
is_in_pipe 					= Player_InPipe
in_air						= Player_InAir ; if player is in the air
last_in_air					= Player_InAir_OLD
is_paused 					= Player_HaltGame
player_action_pause 		= Player_HaltTick
is_dying					= Player_IsDying
player_frame 				= Player_Frame
player_invisability_flash	= Player_FlashInv
player_star_wear_off		= Player_StarOff
player_sprite_offset		= Player_SprOff ; Where the player sprite shows up in spr ram
player_offscreen 			= Player_OffScreen
player_suit_queue			= Player_QueueSuit

player_pipe_x				= Pipe_PlayerX
player_pipe_y				= Pipe_PlayerY

player_sprite_pointer		= Player_SprWorkL

end_level_counter			= Player_EndLevel
is_shaking_counter			= Player_VibeDisable

player_direction			= Player_FlipBits ; 0 == left, #$40 == right
last_player_direction		= Player_FlipBits_OLD

in_water					= Player_InWater
is_above_below_water		= FloatLevel_PlayerWaterStat
swim_counter				= Player_SwimCnt
sliding_x_vel				= Player_SlideRate

tileset						= Level_TilesetIdx ; tilesets starting at Plains
tileset_num					= Level_Tileset
tileset_alt					= Level_Tileset ; tilesets starting at overworld
pipes_by_tileset			= Temp_Var16
is_vertical					= Level_7Vertical
level_viberate				= Level_Vibration

head_block					= Level_Tile_Head
left_block					= Level_Tile_GndL
right_block					= Level_Tile_GndR
front_block					= Level_Tile_InFL ; front block at feet level

player_lives				= Player_Lives
player_count				= Total_Players
player_cur					= Player_Current
cur_player 					= Player_Current
player_movement_direction	= Player_MoveLR
player_x					= Player_X
player_x_hi					= Player_XHi
player_y					= Player_Y
player_y_hi					= Player_YHi
player_x_vel				= Player_XVel
player_y_vel				= Player_YVel
player_slide				= Player_SlideRate ; the amount added for 'sliding' (does not persist)
player_slope				= Player_Slopes
is_going_uphill				= Player_UphillFlag
is_going_uphill_speed		= Player_UphillSpeedIdx
player_sprite_y				= Player_SpriteY
player_sprite_x 			= Player_SpriteX
player_splash_disable		= Splash_DisTimer
splash_counter				= Splash_Counter
splash_y_flag				= Splash_NoScrollY
splash_y_pos				= Splash_Y
splash_x_pos				= Splash_X
bubbles_count				= Bubble_Cnt
bubble_y					= Bubble_Y
bubble_y_hi					= Bubble_YHi
bubble_x					= Bubble_X
bubble_x_hi					= Bubble_XHi
running_max_speed			= Player_RunFlag
p_speed_charge				= Player_Power
can_jump_in_air				= Player_AllowAirJump 	; allows jumping off enemies and whatnot
can_fly_counter				= Player_FlyTime

has_micro_goombas			= Player_mGoomba
player_walking_frames		= Player_WalkAnimTicks

invinsability_counter		= Player_StarInv

is_wagging_tail				= Player_WagCount

active_inputs				= Pad_Holding
new_inputs					= Pad_Input

is_holding					= Player_IsHolding
is_climbing					= Player_IsClimbing

wand_state 					= Level_GetWandState
active_powerup				= Player_Suit

debug_enable 				= Debug_Flag

no_exit_to_map				= Level_PipeNotExit
level_junction_type			= Level_JctCtl
return_status_from_level	= Map_ReturnStatus

player_partition_detection	= Player_PartDetEn
is_above_level				= Player_AboveTop
temp_17						= Temp_VarNP0

tile_memory_offset			= Level_TileOff


temp_tile					= Level_Tile

horz_scroll_lock			= LevelJctBQ_Flag

is_stuck_in_wall			= Player_LowClearance

							; object info
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

							; block update queues
block_event_lo_y			= Level_BlockChgYLo
block_event_hi_y			= Level_BlockChgYHi

block_event_lo_x			= Level_BlockChgXLo
block_event_hi_x			= Level_BlockChgXHi

skip_status_bar				= Level_SkipStatusBarUpd 	; stops the status bar from being updated for a frame
block_event_queue			= Level_ChgTileEvent 	; queues a block event to occur

							; toad house stuff
toad_house_type				= THouse_Treasure
mario_items					= Inventory_Items
mario_cards					= Inventory_Cards
luigi_items					= Inventory_Items2

							; rng
cur_random					= RandomN

							; scroll information
vertical_scroll_lo			= Level_VertScroll
alt_level_scroll_lo			= Level_VertScroll
vertical_scroll_hi 			= Level_VertScrollH
horizontal_scroll_settings	= Level_AScrlConfig

							; sound engine
player_sound_queue			= Sound_QPlayer
map_sound_queue				= Sound_QMap

							; common routines

Get_hurt					= Player_GetHurt

							; tileset names

ts_toad_house				= #$06

tick_counter				= Counter_1

							; tile addressing

tile_address_offset			= TileAddr_Off
block_size					= LL_ShapeDef
tile_address				= Map_Tile_AddrL
tile_layout_address			= Level_LayPtr_AddrL
level_generator_address		= Level_LayPtrOrig_AddrL

							; world

world_idx					= World_Num
world_stored				= Map_Completions
world_mario_block			= World_Map_Tile
falling_to_king_flag		= Player_FallToKing

world_x_hi					= World_Map_XHi
world_x_lo					= World_Map_X
world_y_lo					= World_Map_Y
world_to_warp				= Map_Warp_PrevWorld
world_last_y				= Map_Entered_Y
world_last_y_lo				= Map_Entered_Y
world_last_x_hi				= Map_Entered_XHi
world_last_x_lo				= Map_Entered_X
world_prev_x_lo				= Map_Previous_X
world_prev_x_hi				= Map_Previous_XHi
world_prev_y_lo				= Map_Previous_Y

world_bonus_spawn_x_lo		= Map_BonusAppX
world_bonus_spawn_x_hi		= Map_BonusAppXHi
world_bonus_spawn_y_lo		= Map_BonusAppY


world_last_direction		= Map_Previous_Dir
world_direction				= World_Map_Dir

alt_level_object_pointer	= Level_ObjPtr_AddrL
level_object_pointer		= Level_ObjPtrOrig_AddrL

world_custom_enter			= Map_EnterViaID

world_operation				= Map_Operation
world_warp_wind				= Map_WarpWind_FX
world_previous_horizontal_scroll_lo = Map_Prev_XOff
world_previous_horizontal_scroll_lo2= Map_Prev_XOff2
world_previous_horizontal_scroll_hi = Map_Prev_XHi
world_previous_horizontal_scroll_hi2= Map_Prev_XHi2

world_level_enter_effect	= Map_EnterLevelFX
world_boarder_loop_count	= Map_EntTran_BorderLoop
world_enter_count			= World_EnterState

world_enter_vram_high		= Map_EntTran_BVAddrH
world_enter_vram_low		= Map_EntTran_BVAddrL
world_enter_vram_counter	= Map_EntTran_LRCnt
world_transition_counter	= Map_EntTran_Cnt
world_vert_extrema_counter	= Map_EntTran_TBCnt

bonus_game_to_play			= Bonus_GameType
bonus_game_host				= Bonus_GameHost
world_enter_level_or_vs		= Map_Enter2PFlag


							; level

level_timer_count 			= Level_TimerTick
level_time_lo 				= Level_TimerLSD
level_time_mi 				= Level_TimerMid
level_time_hi 				= Level_TimerMSD

level_clear_pattern			= ClearPattern
level_collectables			= Level_BlockGrabHitMem
viberation_offset			= Vert_Scroll_Off
vertical_scroll				= Vert_Scroll
vertical_scroll_lo			= Vert_Scroll
vertical_scroll_hi			= Vert_Scroll_Hi
level_generator_pointer		= Level_LayPtr_AddrL

level_alt_generators		= Level_AltLayout
level_alt_objects			= Level_AltObjects
level_screens				= Level_Width
level_origional_screens		= Level_SizeOrig
level_block_palette_colors	= PalSel_Tile_Colors
level_sprite_palette_colors	= PalSel_Obj_Colors
level_starting_x			= Level_SelXStart
level_scroll_type			= Level_FreeVertScroll
level_juntion_vertical_scroll       = Level_Jct_VS
level_juntion_vertical_scroll_hi    = Level_Jct_VSHi
level_alt_tileset				= Level_AltTileset
level_init_action				= Level_InitAction
level_background_pages			= Level_BG_Page1_2
background_music				= SndCur_Music2
background_music_restore		= Level_MusicQueueRestore
level_alt_y_start				= Level_JctYLHStart
level_alt_x_start				= Level_JctXLHStart

coins_collected_inside_level	= Coins_ThisLevel
coins_for_white_toad_house		= Map_BonusCoinsReqd
world_bonus_type				= Map_BonusType

								; timer

timer_enabled					= Level_TimerEn
timer_high_value				= Level_TimerMSD


								; PPU

horizontal_scroll_lo			= Horz_Scroll
horizontal_scroll_hi			= Horz_Scroll_Hi

left_scroll_column				= Scroll_ColumnL
right_scroll_column				= Scroll_ColumnR
scroll_last_direction			= Scroll_LastDir

temp_world_scroll				= Scroll_Temp

ppu_update_disable				= UpdSel_Disable

								; verse levels
vs_game_count					= Map_2PVsGame

								; junctions

junction_horz_scroll_hi			= Level_Jct_HSHi 	; Level junction horizontal scroll high value
junction_horz_scroll_lo			= Level_Jct_HS 		; Level junction horizontal scroll value
junction_vert_scroll_hi			= Level_Jct_VSHi 	; Level junction vertical scroll high value
junction_vert_scroll_lo			= Level_Jct_VS 		; Level junction vertical scroll value

graphics_buffer_idx 			= Graphics_BufCnt
graphics_buffer 				= Graphics_Buffer
status_bar_update_frame 		= StatusBar_UpdFl


; object functions

object_handle_movement			= Object_Move
object_handle_ground			= Object_HitGround
determine_horizontal_player_relativity	= Level_ObjCalcXDiffs
object_face_other_direction		= Object_FlipFace
object_handle_external_collision	= Object_HandleBumpUnderneath
object_quick_calc_position		=Object_CalcSpriteXY_NoHi

music_queue_2					= Sound_QMusic2
extends Node

@export var shadow_radius: int = 2
@export var end_screen : PackedScene

@onready var tilemap_floor: TileMapLayer = $TileMapLayerFloor
@onready var tilemap_shadow: TileMapLayer = $TileMapLayerShadow
@onready var player: CharacterBody2D = $Player
@onready var lvl_generator: Node2D = $LvlGenerator
@onready var arena_time_manager: ArenaTimeManager = $ArenaTimeManager

const SHADOW_OFF_TILE = Vector2i(24,16)

func _ready() -> void:
	arena_time_manager.timeout.connect(_on_timeout)
	if player:
		player.healt_manager.died.connect(_on_died)
	pass
	
func clear_shadow():
	var player_tile_pos = player.position / 16 
	var ligth_tile_start = player_tile_pos - Vector2(shadow_radius,shadow_radius)
	var ligth_tile_end = player_tile_pos + Vector2(shadow_radius,shadow_radius)	
	for x in range(ligth_tile_start.x, ligth_tile_end.x):
		for y in range(ligth_tile_start.y, ligth_tile_end.y):
			tilemap_shadow.set_cell(Vector2i(x, y), 2, Vector2i(24,16))
	pass

func _process(delta: float) -> void:
	if player:
		clear_shadow()
	pass

func get_new_mob_pos():
	if lvl_generator:
		return lvl_generator.get_new_mob_pos()
		
func _on_died():
	if end_screen:
		var end_screen_instance = end_screen.instantiate() as EndScreen
		get_parent().add_child(end_screen_instance)
		end_screen_instance.set_type(EndScreen.SCREEN_TYPE.END)
	
func _on_timeout():
	if end_screen:
		var end_screen_instance = end_screen.instantiate() as EndScreen
		get_parent().add_child(end_screen_instance)
		end_screen_instance.set_type(EndScreen.SCREEN_TYPE.TIMEOUT)

func _on_tree_exiting() -> void:
	Global.set_total_award()

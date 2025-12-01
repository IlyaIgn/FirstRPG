extends Node

@export var tilemap_shadow: TileMapLayer
@export var shadow_radius: int = 2
@onready var player: CharacterBody2D = $Player
@onready var lvl_generator: Node2D = $LvlGenerator

@export var end_screen : PackedScene

const SHADOW_OFF_TILE = Vector2i(24,16)

func _ready() -> void:
	lvl_generator.generate_lootbox()
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
	return lvl_generator.get_new_mob_pos()
	
func _on_died():
	var end_screen_instance = end_screen.instantiate()
	get_parent().add_child(end_screen_instance)
	

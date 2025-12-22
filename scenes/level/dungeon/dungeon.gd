extends Node

@export var shadow_radius: int = 2
@export var end_screen : PackedScene

@onready var tilemap_floor: TileMapLayer = $TileMapLayerFloor
@onready var player: CharacterBody2D = $Player
@onready var lvl_generator: Node2D = $LvlGenerator
@onready var arena_time_manager: ArenaTimeManager = $ArenaTimeManager

const SHADOW_OFF_TILE = Vector2i(24,16)

#func _process(delta: float) -> void:
	#if color_rect and player:
		#var local_pos = color_rect.to_local(player.global_position)
		#color_rect.set("shader_parameter/player_pos", local_pos)
	#pass

func _ready() -> void:
	arena_time_manager.timeout.connect(_on_timeout)
	if player:
		player.healt_manager.died.connect(_on_died)
	pass

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
	DungeonState.save_dungeon_award()

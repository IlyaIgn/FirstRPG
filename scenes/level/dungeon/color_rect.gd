extends ColorRect

@export var player: Player
@export var arena_time_manager: ArenaTimeManager 

func _process(delta: float) -> void:
	var player_screen_pos =  player.get_global_transform_with_canvas().get_origin()	
	material.set_shader_parameter("light_pos", player_screen_pos)
	print(arena_time_manager.timer.time_left)
	material.set_shader_parameter("light_radius", arena_time_manager.timer.time_left)
	pass

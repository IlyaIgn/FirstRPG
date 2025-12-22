extends ColorRect
@export var player: Player

func _process(delta: float) -> void:
	var player_screen_pos =  player.get_global_transform_with_canvas().get_origin()	
	material.set_shader_parameter("light_pos", player_screen_pos)
	pass

extends Node2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	var end_screen = get_parent().get_parent().end_screen
	if end_screen:
		var end_screen_instance = end_screen.instantiate() as EndScreen
		get_parent().get_parent().add_child(end_screen_instance)
		end_screen_instance.set_type(EndScreen.SCREEN_TYPE.EXIT)

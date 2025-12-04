extends Node2D

@export var end_screen : PackedScene
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if end_screen:
		var end_screen_instance = end_screen.instantiate() as EndScreen
		get_parent().add_child(end_screen_instance)
		end_screen_instance.set_type(EndScreen.SCREEN_TYPE.DUNGEON)

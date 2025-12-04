extends Node2D
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	Callable(get_tree().change_scene_to_file).call_deferred("res://scenes/level/dungeon/dungeon.tscn")

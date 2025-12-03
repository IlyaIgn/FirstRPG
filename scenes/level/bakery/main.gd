extends Node2D
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	print("ENTER")
	get_tree().change_scene_to_file("res://scenes/level/dungeon/dungeon.tscn")
	queue_free()
	pass # Replace with function body.

extends CanvasLayer
class_name EndScreen

func _ready() -> void:
	get_tree().paused = true

func _on_restart_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level/bakery/Main.tscn")
	queue_free()
	pass # Replace with function body.


func _on_quit_btn_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.as

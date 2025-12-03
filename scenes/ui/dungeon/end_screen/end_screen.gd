extends CanvasLayer
class_name EndScreen

@onready var name_lbl: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/NameLbl

func _ready() -> void:
	name_lbl.text = "Game Over"
	get_tree().paused = true

func _on_restart_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level/bakery/Main.tscn")
	queue_free()
	pass # Replace with function body.

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
	queue_free()
	pass # Replace with function body.as

func set_tile_txt(txt):
	name_lbl.text = txt

extends CanvasLayer
class_name EndScreen

enum SCREEN_TYPE {END, TIMEOUT, DUNGEON, EXIT}
var current_type = SCREEN_TYPE.END

@onready var name_lbl: Label = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/NameLbl
@onready var first_btn: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/FirstBtn
@onready var second_btn: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/SecondBtn

func _ready() -> void:
	get_tree().paused = true

func set_type(new_screen_type : SCREEN_TYPE) -> void:
	current_type = new_screen_type
	if current_type == SCREEN_TYPE.END:
		name_lbl.text = "Game Over"
		first_btn.text = "Restart"
		second_btn.text = "Home"
		pass
	elif current_type == SCREEN_TYPE.TIMEOUT:
		name_lbl.text = "TIMEOUT"
		first_btn.text = "Restart"
		second_btn.text = "Home"
		pass
	elif current_type == SCREEN_TYPE.DUNGEON:
		name_lbl.text = "GO TO DUNGEON"
		first_btn.text = "GO TO"
		second_btn.text = "Back"
		pass
	elif current_type == SCREEN_TYPE.EXIT:
		name_lbl.text = "DO YOU WANT EXIT"
		first_btn.text = "GO HOME"
		second_btn.text = "Back"
		pass
	pass

func _on_first_btn_pressed() -> void:
	if current_type == SCREEN_TYPE.END:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/level/dungeon/dungeon.tscn")
		queue_free()
	elif current_type == SCREEN_TYPE.TIMEOUT:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/level/dungeon/dungeon.tscn")
		queue_free()
		pass
	elif current_type == SCREEN_TYPE.DUNGEON:
		get_tree().paused = false
		if Global.take_award("wick", 1):
			get_tree().change_scene_to_file("res://scenes/level/dungeon/dungeon.tscn")
		queue_free()
	elif current_type == SCREEN_TYPE.EXIT:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/level/bakery/bakery.tscn")
		queue_free()
	pass # Replace with function body.
	
func _on_second_btn_pressed() -> void:
	if current_type == SCREEN_TYPE.END:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/level/bakery/bakery.tscn")
		queue_free()
	elif current_type == SCREEN_TYPE.TIMEOUT:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/level/bakery/bakery.tscn")
		queue_free()
		pass
	elif current_type == SCREEN_TYPE.DUNGEON:
		get_tree().paused = false
		queue_free()
	elif current_type == SCREEN_TYPE.EXIT:
		get_tree().paused = false
		queue_free()
	pass # Replace with function body.as

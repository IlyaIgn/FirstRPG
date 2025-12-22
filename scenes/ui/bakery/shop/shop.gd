extends CanvasLayer

@onready var flour_value: Label = $Panel/VBoxContainer/MarginContainer/VBoxContainer/Yeast2/StorageContainer/Flour/Value
@onready var water_value: Label = $Panel/VBoxContainer/MarginContainer/VBoxContainer/Yeast2/StorageContainer/Water/Value
@onready var yeast_value: Label = $Panel/VBoxContainer/MarginContainer/VBoxContainer/Yeast2/StorageContainer/Yeast/Value
@onready var wick_value: Label = $Panel/VBoxContainer/MarginContainer/VBoxContainer/Yeast2/Wick
@onready var gold_value: Label = $Panel/VBoxContainer/MarginContainer/VBoxContainer/MarginContainer/Gold


func _process(delta: float) -> void:
	flour_value.text = "Мука: " + str(Global.get_total_award()["flour"]) 
	water_value.text ="Вода: "  + str(Global.get_total_award()["water"])
	yeast_value.text ="Дрожжи: "  + str(Global.get_total_award()["yeast"])
	wick_value.text ="Фетиль: "  + str(Global.get_total_award()["wick"])
	gold_value.text ="Золото: "  + str(Global.get_total_award()["gold"])
	pass
	
func _on_button_pressed() -> void:
	if Global.take_award("gold", 1):
		Global.give_award("wick", 1)
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	queue_free()
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	if Global.take_award("gold", 5):
		Global.wick_lvl += 1
	pass # Replace with function body.

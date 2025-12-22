extends CanvasLayer

@onready var flour_value: Label = $MarginContainer/VBoxContainer/Yeast2/StorageContainer/Flour/Value
@onready var water_value: Label = $MarginContainer/VBoxContainer/Yeast2/StorageContainer/Water/Value
@onready var yeast_value: Label = $MarginContainer/VBoxContainer/Yeast2/StorageContainer/Yeast/Value
@onready var wick_value: Label = $MarginContainer/VBoxContainer/Yeast2/Wick
@onready var gold_value: Label = $MarginContainer/VBoxContainer/MarginContainer/Gold

@export var shop : PackedScene

func _process(delta: float) -> void:
	flour_value.text = "Мука: " + str(Global.get_total_award()["flour"]) 
	water_value.text ="Вода: "  + str(Global.get_total_award()["water"])
	yeast_value.text ="Дрожжи: "  + str(Global.get_total_award()["yeast"])
	wick_value.text ="Фетиль: "  + str(Global.get_total_award()["wick"])
	gold_value.text ="Золото: "  + str(Global.get_total_award()["gold"])
	pass


func _on_texture_button_pressed() -> void:
	var shop_instance = shop.instantiate()
	add_child(shop_instance)
	pass # Replace with function body.

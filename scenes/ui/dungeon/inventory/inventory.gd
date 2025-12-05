extends MarginContainer

@onready var flour_count_label: Label = $PanelContainer/MarginContainer/HBoxContainer2/FlourValue

func _process(delta: float) -> void:
	flour_count_label.text = str(Global.get_dungeon_award())

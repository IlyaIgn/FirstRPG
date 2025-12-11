extends CanvasLayer

@onready var label: Label = $MarginContainer/Label

func _process(delta: float) -> void:
	label.text = "Мука: " + str(Global.get_total_award()["flour"]) + "\nЗолото: "  + str(Global.get_total_award()["gold"])
	pass

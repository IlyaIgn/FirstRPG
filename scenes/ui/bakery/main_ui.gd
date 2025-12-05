extends CanvasLayer

@onready var label: Label = $MarginContainer/Label

func _process(delta: float) -> void:
	label.text = "Мука:" + str(Global.get_total_award())
	pass

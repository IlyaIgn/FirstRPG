extends CanvasLayer

@onready var label: Label = $MarginContainer/Label

func _process(delta: float) -> void:
	label.text = "Мука:" + str(Global.current_flor_aamount)
	pass

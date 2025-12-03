extends Label

func _process(delta: float) -> void:
	text = "Мука:" + str(Global.current_flor_aamount)

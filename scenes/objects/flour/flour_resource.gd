extends Node2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.flour_collected.emit(randi_range(1,3))
	queue_free()

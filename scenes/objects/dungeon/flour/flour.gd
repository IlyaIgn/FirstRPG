extends Node2D

#var tween : Tween
var current_weight : int = randi_range(1,3)

func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.flour_collected.emit(1)
	queue_free()

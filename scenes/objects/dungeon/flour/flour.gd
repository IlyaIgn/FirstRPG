extends Node2D

#var tween : Tween

func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.give_award()
	queue_free()

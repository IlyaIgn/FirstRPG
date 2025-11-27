extends Node2D

var current_weight : int = randi_range(1,3)

func play_open_animation():
	var anim = get_node("AnimationPlayer") as AnimationPlayer
	anim.play("open")

func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.flour_collected.emit(current_weight)
	queue_free()

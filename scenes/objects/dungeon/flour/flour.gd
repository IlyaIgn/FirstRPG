extends Node2D

#var tween : Tween

func _on_area_2d_area_entered(area: Area2D) -> void:
	DungeonState.give_dungeon_award("flour", 1)
	queue_free()

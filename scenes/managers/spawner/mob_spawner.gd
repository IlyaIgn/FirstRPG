extends Node2D

@export var mob_scene : PackedScene
@export var player : Node2D

func _on_timer_timeout() -> void:
	if not player:
		return
	
	var spawn_pos = get_parent().get_new_mob_pos()
	var enemy = mob_scene.instantiate()
	enemy.global_position = spawn_pos
	get_parent().add_child(enemy)

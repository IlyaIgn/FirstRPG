extends Node2D

@export var mob_scene : PackedScene
@export var player : Node2D

func _on_timer_timeout() -> void:
	
	if not player:
		return
	
	var player_pos = player.global_position
	var spawn_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_distance = randf_range(380, 500)
	var spawn_pos = player_pos + (spawn_direction * spawn_distance)
	
	var enemy = mob_scene.instantiate() as Node2D
	enemy.global_position = spawn_pos
	get_parent().add_child(enemy)

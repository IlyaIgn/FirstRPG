extends Node2D

@export var mob_scene : PackedScene
@export var player : Node2D

func get_spawn_pos():
	
	var spawn_position = Vector2.ZERO
	var random_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	var random_distance = randi_range(100,150)
	
	for i in 36:
		spawn_position = player.global_position + (random_direction * random_distance)
		var raycast = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		var intersection = get_tree().root.world_2d.direct_space_state.intersect_ray(raycast)
		if intersection.is_empty():
			break
		else:
			if i == 35:
				return Vector2.ZERO
			random_direction = random_direction.rotated(deg_to_rad(10))
	
	return spawn_position

func _on_timer_timeout() -> void:
	if not player:
		return
	
	var spawn_pos = get_spawn_pos()
	if spawn_pos == Vector2.ZERO:
		print("Error spawn")
		return
	#var spawn_pos = get_parent().get_new_mob_pos()
	
	var enemy = mob_scene.instantiate()
	enemy.global_position = spawn_pos
	get_parent().add_child(enemy)

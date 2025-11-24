extends Node2D

@export var attack_range : int = 100
@export var attack_abbility : PackedScene

func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("Player") as Node2D
	if player == null:
		return
		
	var player_pos = player.global_position
		
	var mobs = get_tree().get_nodes_in_group("Mobs")
	mobs = mobs.filter( func (mob : Node2D):
		return mob.global_position.distance_squared_to(player_pos) < pow(attack_range, 2)
	)
	
	if mobs.size() == 0:
		return
		
	mobs.sort_custom(func(a: Node2D, b : Node2D):
		var a_distance = a.global_position.distance_squared_to(player_pos)
		var b_distance = b.global_position.distance_squared_to(player_pos)
		return a_distance < b_distance
	)
	
	var enemy_pos = mobs[0].global_position
	var attack_instance = attack_abbility.instantiate() as Node2D
	player.get_parent().add_child(attack_instance)
	attack_instance.global_position = (player_pos+enemy_pos) / 2
	attack_instance.look_at(enemy_pos)
	pass

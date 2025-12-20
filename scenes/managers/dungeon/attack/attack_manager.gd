extends Node2D
class_name AttackController

@onready var timer: Timer = $Timer

var can_attack = false

func _ready() -> void:
	var regular_attack = DungeonState.regular_attack_abilities
	if not regular_attack:
		return
	timer.wait_time = regular_attack.condition
	DungeonState.unique_attack.connect(unique_attack)
	
func spawn_regular_attack(regular_attack) -> bool:
	var player = get_tree().get_first_node_in_group("Player") as Node2D
	if player == null:
		return false
		
	var player_pos = player.global_position
		
	var mobs = get_tree().get_nodes_in_group("Mobs")
	mobs = mobs.filter( func (mob : Node2D):
		return mob.global_position.distance_squared_to(player_pos) < pow(regular_attack.attack_range, 2)
	)
	
	if mobs.size() == 0:
		return false
		
	mobs.sort_custom(func(a: Node2D, b : Node2D):
		var a_distance = a.global_position.distance_squared_to(player_pos)
		var b_distance = b.global_position.distance_squared_to(player_pos)
		return a_distance < b_distance
	)
	
	var enemy_pos = mobs[0].global_position
	
	var attack_instance = regular_attack.attack_scene.instantiate()
	attack_instance.direction = (enemy_pos - player_pos).normalized()
	player.get_parent().add_child(attack_instance)
	attack_instance.hit_box.damage = regular_attack.damage
	attack_instance.global_position = player_pos
	return true
	
func spawn_unique_attack(unique_attack):
	var player = get_tree().get_first_node_in_group("Player") as Node2D
	if player == null:
		return
		
	var player_pos = player.global_position
	
	var attack_instance = unique_attack.attack_scene.instantiate()
	player.get_parent().add_child(attack_instance)
	attack_instance.global_position = player_pos
	
	pass
		
func unique_attack():
	var unique_attack = DungeonState.unique_attack_abilities
	if not unique_attack:
		return
	
	if DungeonState.unique_attack_progress != unique_attack.condition:
		return
		
	spawn_unique_attack(unique_attack)
	DungeonState.give_dungeon_award("experience", -unique_attack.condition)
	
func _process(delta: float) -> void:
	var regular_attack = DungeonState.regular_attack_abilities
	if regular_attack:
		DungeonState.regular_attack_progress = min(regular_attack.condition, timer.wait_time - timer.time_left)
		if DungeonState.regular_attack_progress == regular_attack.condition and spawn_regular_attack(regular_attack):
			timer.start(regular_attack.condition)
			
	var unique_attack = DungeonState.unique_attack_abilities
	if unique_attack:
		DungeonState.unique_attack_progress = min(unique_attack.condition, DungeonState.dungeon_award["experience"])
	
	pass

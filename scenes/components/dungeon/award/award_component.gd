extends Node2D

@export var award_scene : PackedScene
@export var health_component : Node

func _ready() -> void:
	(health_component as HealtManager).died.connect(give_award)
	
func give_award():
	if not award_scene:
		return
		
	var spawn_pos = (owner as Node2D).global_position
	
	var award_instance = award_scene.instantiate() as Node2D
	owner.get_parent().add_child(award_instance)
	award_instance.global_position = spawn_pos

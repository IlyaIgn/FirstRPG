extends Node2D

@export var award_scene : PackedScene

func give_award():
	var award_instance = award_scene.instantiate() as Node2D
	owner.add_child(award_instance)
	award_instance.play_give_animation()

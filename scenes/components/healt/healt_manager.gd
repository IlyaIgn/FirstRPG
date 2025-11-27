extends Node2D

signal died()

@export var max_health : int = 20
var current_healt : int

func  _ready() -> void:
	current_healt = max_health
	
func damage(damage_count):
	current_healt = max(current_healt - damage_count, 0)
	check_heath()
	
func check_heath():
	if current_healt == 0:
		died.emit()
		owner.queue_free()

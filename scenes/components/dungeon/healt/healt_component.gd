extends Node2D
class_name HealtManager

signal died()
signal health_change(current_healt)

@export var max_health : int = 20
var current_healt : int

func  _ready() -> void:
	current_healt = max_health
	
func get_max_health():
	return max_health
	
func damage(damage_count):
	current_healt = max(current_healt - damage_count, 0)
	health_change.emit(current_healt)
	Callable(check_heath).call_deferred()
	
func check_heath():
	if current_healt == 0:
		died.emit()

extends Node2D
class_name ArenaTimeManager

@onready var timer: Timer = $Timer

signal timeout()

func get_time_elapsed():
	return timer.wait_time - timer.time_left

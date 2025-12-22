extends Node2D
class_name ArenaTimeManager

@onready var timer: Timer = $Timer

signal timeout()

func _ready() -> void:
	timer.wait_time = Economics.wicks_lvl[str(Global.wick_lvl)]
	timer.start()
	pass

func get_time_elapsed():
	return timer.wait_time - timer.time_left

func _on_timer_timeout() -> void:
	timeout.emit()

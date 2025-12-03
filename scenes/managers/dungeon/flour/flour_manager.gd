extends Node2D

var flour_count = 0

func _ready() -> void:
	Global.flour_collected.connect(on_collected_flour)
	
func on_collected_flour(_flour_count):
	flour_count += _flour_count
	print("Flour: ", flour_count)
	pass

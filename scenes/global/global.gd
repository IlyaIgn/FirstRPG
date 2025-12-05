extends Node2D

var dungeon_flour_amount = 0
var total_flour_amount = 0

signal flour_collected(flour_count:int)

func give_award():
	dungeon_flour_amount += randi_range(1,3)
	flour_collected.emit(dungeon_flour_amount)
	
func get_dungeon_award():
	return dungeon_flour_amount
	
func set_total_award():
	total_flour_amount += dungeon_flour_amount
	dungeon_flour_amount = 0
	
func get_total_award():
	return total_flour_amount

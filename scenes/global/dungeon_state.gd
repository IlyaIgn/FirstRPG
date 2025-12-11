extends Node2D

var dungeon_award = {
	"flour": 0,
	"experience": 0
}

@export var regular_attack_abilities : AttackAbility 
var regular_attack_progress : float
@export var unique_attack_abilities : AttackAbility
var unique_attack_progress : int 
signal unique_attack()

signal dungeon_award_changed()

func give_dungeon_award(award_name, award_amount):
	dungeon_award[award_name] += award_amount
	dungeon_award_changed.emit()
	
func get_dungeon_award():
	return dungeon_award
	
func save_dungeon_award():
	Global.total_resource["flour"] += dungeon_award["flour"]
	dungeon_award["flour"] = 0
	

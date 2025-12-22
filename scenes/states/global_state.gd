extends Node2D

var total_resource = {
	"gold": 0,
	"wick": 10,
	"flour": 1,
	"water": 0,
	"yeast": 0
}

var wick_lvl = 1

func get_total_award():
	return total_resource
	
func give_award(award_name, award_amount) -> bool:
	total_resource[award_name] += award_amount
	return true
	
func take_award(award_name, award_amount) -> bool:
	if total_resource[award_name] - award_amount >= 0:
		total_resource[award_name] -= award_amount
		return true
	return false

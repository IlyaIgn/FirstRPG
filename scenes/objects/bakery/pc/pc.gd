extends Node2D

@export var lvl_steps : Array
var can_sell = false
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

func _process(delta: float) -> void:
	if can_sell and Global.total_resource["flour"] > 0:
		texture_progress_bar.value += 1
		if texture_progress_bar.max_value == texture_progress_bar.value:
			texture_progress_bar.value = 0
			Global.total_resource["gold"] += 1
			Global.total_resource["flour"] -= 1
			

func _on_area_2d_area_entered(area: Area2D) -> void:
	texture_progress_bar.visible = true
	can_sell = true
	pass


func _on_area_2d_area_exited(area: Area2D) -> void:
	texture_progress_bar.visible = false
	can_sell = false
	pass # Replace with function body.

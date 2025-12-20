extends Node2D
class_name SwordAbility

@onready var hit_box: HitBox = $HitBox

var radius = 5
var base_direction = Vector2.RIGHT

func _ready() -> void:
	var tween_animation = get_tree().create_tween()
	tween_animation.tween_method(rotate_amin, 0.0, 2, 0.7)
	tween_animation.tween_callback(queue_free)
	
	#tween_animation.tween_property(sprite_2d, "rotation", deg_to_rad(360 * 2), 3).from(0)
	#tween_animation.tween_property(path_follow_2d, "unit_offset", 1, 0.5).from(0.0)
	#tween_animation.tween_property($Sprite2D, "scale", Vector2(), 1.0)
	#tween_animation.tween_callback(sprite_2d.queue_free)

	pass


func rotate_amin(rotations : float):	
	var current_direction = base_direction.rotated(rotations * TAU)
	global_position = global_position + (current_direction * radius)
	rotation = rotations * TAU
	
func _on_hit_box_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

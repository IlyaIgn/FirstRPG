extends Area2D
class_name HeartBox

@export var healt_manager : HealtManager

func _on_area_entered(area: Area2D) -> void:
	if not area is HitBox:
		return
		
	if not healt_manager:
		return
		
	var hitbox = area as HitBox
	healt_manager.damage(hitbox.damage)
	owner.queue_free()
	pass # Replace with function body.

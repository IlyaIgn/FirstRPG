extends Node2D
class_name EggAbility

@onready var hit_box: HitBox = $HitBox
@export var speed = 100
var direction = Vector2.RIGHT

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_hit_box_area_entered(area: Area2D) -> void:
	queue_free()
	pass # Replace with function body.

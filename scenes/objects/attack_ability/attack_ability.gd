extends Node2D

@export var speed = 100
var direction = Vector2.RIGHT

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()

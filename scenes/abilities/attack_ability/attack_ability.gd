extends Node2D

@export var speed = 100
var direction = Vector2.RIGHT

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	print(direction)
	position += direction * speed * delta

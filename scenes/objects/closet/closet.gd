extends Node2D
class_name ClosetObj

@onready var current_timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal opened()

func _ready() -> void:
	current_timer.paused = true
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	current_timer.paused = false

func _on_area_2d_area_exited(area: Area2D) -> void:
	current_timer.paused = true

func _on_timer_timeout() -> void:
	animated_sprite_2d.play("open")

func _on_animated_sprite_2d_animation_finished() -> void:
	opened.emit()

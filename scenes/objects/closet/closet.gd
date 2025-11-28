extends Node2D

@onready var current_timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var award: Node2D = $Award
@onready var progress_bar: ProgressBar = $ProgressBar
@export var healt_sec : int = 10

func _ready() -> void:
	progress_bar.max_value = current_timer.wait_time
	current_timer.wait_time = healt_sec
	current_timer.paused = true
	pass
	
func _process(delta: float) -> void:
	if progress_bar:
		progress_bar.value = current_timer.time_left
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	current_timer.paused = false

func _on_area_2d_area_exited(area: Area2D) -> void:
	current_timer.paused = true

func _on_timer_timeout() -> void:
	animated_sprite_2d.play("open")

func _on_animated_sprite_2d_animation_finished() -> void:
	if progress_bar:
		progress_bar.queue_free()
	award.give_award()

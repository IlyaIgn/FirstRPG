extends CharacterBody2D

@export var speed : int = 200
@export var lock_time_sec : int = 4
var is_lock = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_lock:
		var direction = move_player()
		velocity = direction * speed
		play_animation(direction)
		move_and_slide()

func move_player():
	var player = get_tree().get_first_node_in_group("Player") as Node2D
	return Vector2(player.global_position - global_position).normalized()
	
func play_animation(direction: Vector2):
	var animation_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")
	animation_sprite.flip_h = false
	if direction == Vector2.ZERO:
		animation_sprite.play("idle")
	elif direction.x > 0:
		animation_sprite.play("walk")
	else:
		animation_sprite.play("walk")
		animation_sprite.flip_h = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	var animation_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")
	var mob_timer = get_node("Timer") as Timer
	if mob_timer:
		mob_timer.start(lock_time_sec)
		animation_sprite.play("lock")
		is_lock = true


func _on_timer_timeout() -> void:
	var animation_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")
	is_lock = false
	animation_sprite.play("idle")
	pass # Replace with function body.

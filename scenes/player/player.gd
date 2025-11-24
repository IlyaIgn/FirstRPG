extends CharacterBody2D

@export var speed : int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = move_player()
	velocity = direction * speed
	play_animation(direction)
	move_and_slide()


func move_player():
	var direction_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var direction_y = Input.get_action_strength("move_down") - Input.get_action_raw_strength("move_up")
	
	var direction_x_y = Vector2(direction_x, direction_y).normalized()
	return direction_x_y
	
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

extends CharacterBody2D
class_name Player

@onready var healt_manager: Node2D = $HealtManager

@export  var progress_bar: ProgressBar
@export var player_speed : int = 150
@export var nav_agent : NavigationAgent2D
var acceleration = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if progress_bar:
		progress_bar.max_value = healt_manager.get_max_health()
		progress_bar.value = healt_manager.get_max_health()
	(healt_manager as HealtManager).died.connect(_on_died)
	(healt_manager as HealtManager).health_change.connect(_on_healt_change)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = move_player()
	var target_velocity = direction * player_speed
	velocity = velocity.lerp(target_velocity, acceleration)
	play_animation(direction)
	move_and_slide()
	
func move_player():
	var direction_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var direction_y = Input.get_action_strength("move_down") - Input.get_action_raw_strength("move_up")
	
	var direction_x_y = Vector2(direction_x, direction_y).normalized()
	
	#if direction_x_y != Vector2.ZERO:
		#print(direction_x_y)
		
	return direction_x_y
	
func play_animation(direction: Vector2):
	var animation_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")
	animation_sprite.flip_h = false
	if direction == Vector2.ZERO:
		animation_sprite.play("idle")
	elif direction.x > 0:
		animation_sprite.play("walk_side")
	else:
		animation_sprite.play("walk_side")
		animation_sprite.flip_h = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	healt_manager.damage(5)
	pass # Replace with function body.

func _on_healt_change(current_healt) -> void:
	if progress_bar:
		progress_bar.value = current_healt
		
	pass # Replace with function body.
	
func _on_died() -> void:
	queue_free()
	pass # Replace with function body.

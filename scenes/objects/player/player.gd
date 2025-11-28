extends CharacterBody2D

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var healt_manager: Node2D = $HealtManager

@export var move_by_mouse : bool = false
@export var player_speed : int = 150
@export var nav_agent : NavigationAgent2D
var acceleration = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.max_value = healt_manager.get_max_health()
	progress_bar.value = healt_manager.get_max_health()
	(healt_manager as HealtManager).died.connect(_on_died)
	(healt_manager as HealtManager).health_change.connect(_on_healt_change)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if move_by_mouse:
		return
		
	var direction = move_player()
	var target_velocity = direction * player_speed
	velocity = velocity.lerp(target_velocity, acceleration)
	play_animation(direction)
	move_and_slide()
	
func _physics_process(delta: float) -> void:
	if not move_by_mouse:
		return
		
	if NavigationServer2D.map_get_iteration_id(nav_agent.get_navigation_map()) == 0:
		return
		
	if nav_agent.is_navigation_finished() or nav_agent.is_target_reached():
		play_animation(Vector2.ZERO)
		return
		
	var next_pos = nav_agent.get_next_path_position()
	var direction_to_target = global_position.direction_to(next_pos)
	
	play_animation(direction_to_target)
	
	velocity = direction_to_target * player_speed
	nav_agent.velocity = direction_to_target * player_speed
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_by_click"):
		nav_agent.target_position=get_global_mouse_position()
		
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
		animation_sprite.play("walk_side")
	else:
		animation_sprite.play("walk_side")
		animation_sprite.flip_h = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	healt_manager.damage(5)
	pass # Replace with function body.

func _on_healt_change(current_healt) -> void:
	progress_bar.value = current_healt
	pass # Replace with function body.
	
func _on_died() -> void:
	queue_free()
	pass # Replace with function body.

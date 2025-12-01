extends CharacterBody2D

@onready var progress_bar: ProgressBar = $ProgressBar

@export var need_lock : bool = false
@export var speed : int = 200
@export var lock_time_sec : int = 4
@onready var healt_manager: Node2D = $HealtManager
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_lock = true

func _ready() -> void:
	progress_bar.max_value = healt_manager.get_max_health()
	progress_bar.value = healt_manager.get_max_health()
	(healt_manager as HealtManager).died.connect(_on_died)
	(healt_manager as HealtManager).health_change.connect(_on_healt_change)
	animation_player.play("spawn")
	pass # Replace with function body.

func _process(delta: float) -> void:
	if is_lock:
		return
		
	var player = get_tree().get_first_node_in_group("Player") as Node2D
	if not player:
		return
		
	nav_agent.target_position=player.global_position
		
func _physics_process(delta: float) -> void:		
	if is_lock:
		return
		
	if NavigationServer2D.map_get_iteration_id(nav_agent.get_navigation_map()) == 0:
		return
		
	if nav_agent.is_navigation_finished() or nav_agent.is_target_reached():
		play_animation(Vector2.ZERO)
		return
		
	var next_pos = nav_agent.get_next_path_position()
	var direction_to_target = global_position.direction_to(next_pos)
	
	play_animation(direction_to_target)
	
	velocity = direction_to_target * speed
	nav_agent.velocity = direction_to_target * speed
	move_and_slide()
	
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
	if need_lock:
		var animation_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")
		var mob_timer = get_node("Timer") as Timer
		if mob_timer:
			mob_timer.start(lock_time_sec)
			animation_sprite.play("lock")
			is_lock = true
	else:
		healt_manager.damage(5)

func _on_timer_timeout() -> void:
	var animation_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")
	is_lock = false
	animation_sprite.play("idle")
	pass # Replace with function body.

func _on_healt_change(current_healt) -> void:
	progress_bar.value = current_healt
	pass # Replace with function body.
	
func _on_died() -> void:
	queue_free()
	pass # Replace with function body.

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "spawn":
		is_lock = false;

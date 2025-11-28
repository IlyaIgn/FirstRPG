extends CharacterBody2D

@onready var progress_bar: ProgressBar = $ProgressBar

@export var need_lock : bool = false
@export var speed : int = 200
@export var lock_time_sec : int = 4
@onready var healt_manager: Node2D = $HealtManager

var is_lock = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.max_value = healt_manager.get_max_health()
	progress_bar.value = healt_manager.get_max_health()
	(healt_manager as HealtManager).died.connect(_on_died)
	(healt_manager as HealtManager).health_change.connect(_on_healt_change)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if need_lock and is_lock:
		return
		
	var direction = move_player()
	if direction:
		velocity = direction * speed
		play_animation(direction)
		move_and_slide()

func move_player():
	var player = get_tree().get_first_node_in_group("Player") as Node2D
	if player:
		return Vector2(player.global_position - global_position).normalized()
	else:
		return
	
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

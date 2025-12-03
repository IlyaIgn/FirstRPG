extends CanvasLayer

@export var player : Player
@export var time_manager : ArenaTimeManager

@onready var time_label: Label = $VBoxContainer/Time/Label
@onready var health_progress_bar: ProgressBar = $VBoxContainer/HealthProgress/ProgressBar

func _ready() -> void:
	if player:
		health_progress_bar.max_value = player.healt_manager.max_health
	
func _process(delta: float) -> void:
	if time_label and time_manager:
		var time_sec = time_manager.get_time_elapsed()
		time_label.text = format_timer(time_sec)
	if player:
		health_progress_bar.value = player.healt_manager.current_healt


func format_timer(seconds : int):
	var min = floor(seconds / 60)
	var sec = seconds - (min * 60)
	return str(min) + ":" + "%02d" % sec

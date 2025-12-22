extends CanvasLayer

@export var player : Player
@export var time_manager : ArenaTimeManager

@onready var flour_value: Label = $InfoContainer/StorageContainer/Flour/Value
@onready var water_value: Label = $InfoContainer/StorageContainer/Water/Value
@onready var yeast_value: Label = $InfoContainer/StorageContainer/Yeast/Value

@onready var health_progress_bar: ProgressBar = $HealthProgress/ProgressBar

func _ready() -> void:
	if player:
		health_progress_bar.max_value = player.healt_manager.max_health
	
func _process(delta: float) -> void:
	if player:
		health_progress_bar.value = player.healt_manager.current_healt
		
	flour_value.text = "Мука: " + str(DungeonState.get_dungeon_award()["flour"])
	water_value.text ="Вода: "  + str(DungeonState.get_dungeon_award()["water"])
	yeast_value.text ="Дрожжи: "  + str(DungeonState.get_dungeon_award()["yeast"])
		

func format_timer(seconds : int):
	var min = floor(seconds / 60)
	var sec = seconds - (min * 60)
	return str(min) + ":" + "%02d" % sec

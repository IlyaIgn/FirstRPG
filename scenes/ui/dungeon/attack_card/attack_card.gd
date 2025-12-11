extends PanelContainer
class_name  AttackCard

var attack_id: String
var attack_type: int
enum AttackType { REGULAR, UNIQUE }
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

func _process(delta: float) -> void:
	if attack_type == AttackType.REGULAR:
		texture_progress_bar.value = DungeonState.regular_attack_progress
	elif attack_type == AttackType.UNIQUE:
		texture_progress_bar.value = DungeonState.unique_attack_progress


func _on_button_pressed() -> void:
	if attack_type == AttackType.UNIQUE:
		DungeonState.unique_attack.emit()
		

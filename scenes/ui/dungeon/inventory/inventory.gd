extends MarginContainer

@onready var container: VBoxContainer = $container
@export var attack_card : PackedScene

func _ready() -> void:
	if attack_card:
		var regular_attack = DungeonState.regular_attack_abilities
		var regular_attack_card_instance = attack_card.instantiate() as AttackCard
		container.add_child(regular_attack_card_instance)
		regular_attack_card_instance.attack_id = regular_attack.id
		regular_attack_card_instance.sprite_2d.texture = regular_attack.attack_image
		regular_attack_card_instance.texture_progress_bar.rounded = false
		regular_attack_card_instance.texture_progress_bar.max_value = regular_attack.condition
		regular_attack_card_instance.attack_type = AttackCard.AttackType.REGULAR
				
		var unique_attack = DungeonState.unique_attack_abilities
		if unique_attack:
			var unique_attack_card_instance = attack_card.instantiate() as AttackCard
			container.add_child(unique_attack_card_instance)
			unique_attack_card_instance.attack_id = unique_attack.id
			unique_attack_card_instance.sprite_2d.texture = unique_attack.attack_image
			unique_attack_card_instance.texture_progress_bar.rounded = false
			unique_attack_card_instance.texture_progress_bar.max_value = unique_attack.condition
			unique_attack_card_instance.attack_type = AttackCard.AttackType.UNIQUE
	pass

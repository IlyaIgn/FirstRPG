extends Node2D

enum AWARD_TYPE {FLOUR, WATER, YEAST}
var type = randi_range(0,3) as AWARD_TYPE
var amount = randi_range(1,3)

@onready var sprite_2d: Sprite2D = $Sprite2D

const FLOUR = preload("uid://dx0s4luvu2ew1")
const WATER = preload("uid://c50cdp4nndvye")
const YEAST = preload("uid://tulronyk16be")

#var tween : Tween

func _ready() -> void:
	if type == AWARD_TYPE.FLOUR:
		sprite_2d.texture = FLOUR
		sprite_2d.scale = Vector2(0.05,0.05)
	elif type == AWARD_TYPE.WATER:
		sprite_2d.texture = WATER
		sprite_2d.scale = Vector2(0.15,0.15)
	elif type == AWARD_TYPE.YEAST:
		sprite_2d.texture = YEAST
		sprite_2d.scale = Vector2(1.2,1.2)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if type == AWARD_TYPE.FLOUR:
		DungeonState.give_dungeon_award("flour", 1)
	elif type == AWARD_TYPE.WATER:
		DungeonState.give_dungeon_award("water", 1)
	elif type == AWARD_TYPE.YEAST:
		DungeonState.give_dungeon_award("yeast", 1)
	queue_free()

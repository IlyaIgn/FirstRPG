extends Resource
class_name AttackAbility

@export var id : String
@export var name : String
@export_multiline var description : String
@export var attack_scene : PackedScene
@export var attack_image : Texture
@export var damage : int
@export var attack_range : int

@export_enum("REGULAR", "UNIQUE") var type: int
@export var condition : int # in sec or amount

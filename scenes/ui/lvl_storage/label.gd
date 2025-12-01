extends Label

var flour_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.flour_collected.connect(_on_flour_change)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_flour_change(_flour_count):
	flour_count += _flour_count
	text = str(flour_count)
	pass

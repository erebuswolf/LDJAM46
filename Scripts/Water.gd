extends CardBase


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	label = "Water"
	TexturePath = "res://aseprite/Water.png"
	._ready()
	pass # Replace with function body.


func _Effect():
	get_tree().call_group("plant", "healBasic")
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

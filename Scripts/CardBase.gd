extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

class_name  CardBase

var label = "Empty Label"
var TexturePath = "res://aseprite/Water.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("cards")
	var texture1 = load(TexturePath)
	($Button/Icon as TextureRect).texture = texture1
	($Label as RichTextLabel).text = label
	$Button.connect("pressed", self, "_Effect")
	pass # Replace with function body.

func _Effect():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

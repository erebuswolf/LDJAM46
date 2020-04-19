extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var myText : String

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("TopText")
	pass # Replace with function body.

func setString(param: String):
	myText = param
	bbcode_text = myText;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

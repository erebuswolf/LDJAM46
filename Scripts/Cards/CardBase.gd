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
	($Control/Button/Icon as TextureRect).texture = texture1
	($Control/Label as RichTextLabel).push_align(RichTextLabel.ALIGN_CENTER)
	label = "[center]"+label+"[/center]"
	($Control/Label as RichTextLabel).bbcode_text = label
	$Control/Button.connect("pressed", self, "_Effect")
	$Control/Button.connect("pressed", self, "_iterateEffect")
	pass # Replace with function body.

func _Effect():
	pass
	
func _iterateEffect():
	get_tree().call_group("main", "iterateChoiceCounter")

func disableAndMove():
	$Control/Button.disabled = true
	$Control/AnimationPlayer.play("RemoveCard")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

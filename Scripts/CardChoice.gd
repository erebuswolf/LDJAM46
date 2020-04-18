extends Node2D


class_name CardChoice

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var DescriptiveText = "Blank Descriptive Text"
var PossibleCards : Array;
var cardBase = preload("res://Scenes/Card.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

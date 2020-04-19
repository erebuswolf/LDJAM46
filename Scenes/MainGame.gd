extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var playerHealth = 3

var playerFruitEaten = 0
var kingFruitEaten = 0
var churchFruitEaten = 0
var peopleFruitEaten = 0

var rng = RandomNumberGenerator.new()
var lastChoice = 0

var choice = preload("res://Scenes/CardChoice.tscn")
var choiceScripts = [load ("res://Scripts/WaterChoice.gd"),
	load ("res://Scripts/FertilizerChoice.gd"),
	load ("res://Scripts/DirtyWater.gd")]

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	SetNewChoice()
	pass # Replace with function body.

func SetNewChoice():
	var ch = choice.instance()
	ch.set_script(choiceScripts[0])
	add_child(ch)
	ch.position = Vector2(120,180)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

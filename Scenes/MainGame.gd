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

var choicesMade = 0

var choice = preload("res://Scenes/CardChoice.tscn")
var choiceScripts = [load ("res://Scripts/WaterChoice.gd"),
	load ("res://Scripts/FertilizerChoice.gd"),
	load ("res://Scripts/DirtyWater.gd")]

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	SetNewChoice(0)
	add_to_group("main")
	$PlantScene.connect("Lose", self, "loseLogic")
	pass # Replace with function body.

func SetNewChoice(param:int):
	var ch = choice.instance()
	ch.hide()
	ch.set_script(choiceScripts[param])
	add_child(ch)
	ch.position = Vector2(120,160)

func GetNextChoice():
	SetNewChoice(1)

func iterateChoiceCounter():
	choicesMade += 1
	get_tree().call_group("cards", "disableAndMove")
	print(choicesMade)
	

func loseLogic():
	print ("you lost")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

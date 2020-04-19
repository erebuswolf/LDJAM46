extends Node2D

class_name MainGame
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal MouseClick

var playerHealth = 3

var playerFruitEaten = 0


var favor = [false, false, false]

var fruitCount = [0,0,0]

var rng = RandomNumberGenerator.new()
var lastChoice = 0

var choicesMade = 0

var choice = preload("res://Scenes/CardChoice.tscn")
var choiceScripts = [load ("res://Scripts/Choices/WaterChoice.gd"),
	load ("res://Scripts/Choices/FertilizerChoice.gd"),
	load ("res://Scripts/Choices/EatChoice.gd"),
	load ("res://Scripts/Choices/FruitChoice.gd")]
	
var eatPlantLines = ["The fruit is intoxicating. Your senses are delighfully heightened. Tingling, you are ready for the next day.",
"You hear voices. Is it the plant? Dead loves ones? They cheer you on. The plant must be kept healthy and safe.",
"The next day the Acolytes find your body. Your wrists are sliced open, but there is no blood. The plant looks well watered and very healthy."]

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	SetNewChoice(0)
	add_to_group("main")
	$PlantScene.connect("Lose", self, "loseLogic")
	pass # Replace with function body.

func SetNewChoice(param:int):
	lastChoice = param
	yield(self,"MouseClick")
	var ch = choice.instance()
	ch.set_script(choiceScripts[param])
	ch.position = Vector2(1000,1000)
	add_child(ch)

func GetNextChoice():
	var thisChoice = lastChoice
	while(thisChoice == lastChoice):
		thisChoice = rng.randi_range(0,choiceScripts.size()-1)
	SetNewChoice(3)

func iterateChoiceCounter():
	choicesMade += 1
	get_tree().call_group("cards", "disableAndMove")
	print(choicesMade)
	
func _process(delta):
	pass
		
func _input(event):
	if(event is InputEventMouseButton and event.is_pressed()):
		emit_signal("MouseClick")
		
func EatFruit():
	playerFruitEaten += 1
	playerHealth = clamp(playerHealth + 1, 0,3)
	get_tree().call_group("TopText","setString", eatPlantLines[clamp(playerFruitEaten-1,0,2)])
	if(playerFruitEaten >= 3):
		loseLogic()
	
func EatScraps():
	playerHealth = clamp(playerHealth + 1, 0,3)
	get_tree().call_group("TopText","setString", "The scraps will get you by...")
	
func Starve():
	playerHealth -=1
	var topString = "The hunger consumes you, but you carry on..."
	
	if(playerHealth == 1):
		topString = "The hunger is maddening. If you do not eat soon you will perish"
		
	get_tree().call_group("TopText","setString", topString)
	
	
	if (playerHealth <= 0):
		loseLogic()

func loseLogic():
	print ("you lost")
	
func spendFavor(faction):
	favor[faction] = false

func offeredFruit(faction):
	fruitCount[faction] += fruitCount[faction]
	favor[faction] = true
	if(fruitCount[faction] >= 3):
		#lose game
		pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

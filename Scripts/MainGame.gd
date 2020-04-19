extends Node2D

class_name MainGame
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal MouseClick

var lost = false

var playerHealth = 2

var playerFruitEaten = 0

var favor = [false, false, false]

var fruitCount = [0, 0, 0]

var rng = RandomNumberGenerator.new()
var lastChoice = 0

var choicesMade = 0

var turnsSinceFruit = 0

var choice = preload("res://Scenes/CardChoice.tscn")
var choiceScripts = [load ("res://Scripts/Choices/WaterChoice.gd"),
	load ("res://Scripts/Choices/FertilizerChoice.gd"),
	load ("res://Scripts/Choices/EatChoice.gd"),
	load ("res://Scripts/Choices/FruitChoice.gd"),
	load("res://Scripts/Choices/QuitChoice.gd")]
	
	
var eatPlantLines = ["The fruit is intoxicating. Your senses are delighfully heightened. Tingling, you are ready for the next day.",
"You hear voices. Is it the plant? Dead loved ones? They cheer you on. The plant must be kept healthy and safe.",
"The next day the Acolytes find your body. Your wrists are slit open, but there is no blood. The plant looks well watered and very healthy."]


var EatPlantHeights = [120,120,120]

var factionEatLines = [["The Priest claims the fruit brings the clergy closer to the divine. The church will spare you a small portion of water if needed.",
"Indescribable chanting is heard from the church that night. The next day the priest comes to visit. He smiles hungrily at you and requests you bring more of the fruit when ready. The church will spare you a small portion of water if needed.",
"The church has declared the plant to be holy in origin, a miracle... which they must protect. They ransacked your encampment and took it in the night. They left no survivors."],
["The strange and delectable fruit is the talk of the court. You have won the favor of the king, for now.",
"The King enjoys the fruit alone in his chambers. Strange sounds echo through the castle halls all night. You have won the favor of the king, for now.",
"The King is dead. His mouth dripped with the juices of the fruit as he slammed his head into a wall screaming words no one can bring themselves to repeat. The royal alchemist claims it was a madness brought on by poison. The royal guard comes for you in the morning. You are executed for regicide."],
["The townsfolk enjoy this new fruit. None can agree what it tastes like. They agree to a small delivery of manure to you if you need.",
"No one speaks of last night. The intoxication of the fruit lead to unspeakable debauchery. The townsfolk want more. They agree to a small delivery of manure to you if you need. ",
"Half the town is dead. What started as an orgy ended as a sacrifice. The survivors look distrustfully at you with hollow eyes. The plant is gone. You aren’t sure where they are hiding it, but you fear if you do not leave today, you will not survive to the next dawn."]]

var endingText = "Your master has returned! You greet him with tears in your eyes. He is very pleased to see the plant is still alive. He says your initiation will begin soon. But, for now he is moving the plant to a new location to keep it from prying eyes."

var FactionEatHeights = [[120,240,200],[120,200,280],[120,200,240]]


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
	choicesMade += 1
	get_tree().call_group("DayCounter", "SetDayCount",choicesMade)
	var ch = choice.instance()
	ch.set_script(choiceScripts[param])
	ch.position = Vector2(1000, 1000)
	add_child(ch)
	
	
func unevenRoll():
	var rand = rng.randf_range(0,100)
	var pick = 0
	if(rand < 4):
		pick = 3
	elif(rand < 33):
		pick = 1
	elif(rand < 66):
		pick = 2
	return pick

func GetNextChoice():
	if (lost):
		SetNewChoice(4)
		return
	
	if (choicesMade >= 30):
		yield(self,"MouseClick")
		get_tree().call_group("TopPanel","setHeight",240)
		get_tree().call_group("TopText","setString", endingText)
		SetNewChoice(4)
		return
		
	var thisChoice = lastChoice
	if ($PlantScene.demonicCounter >= 2):
		if($PlantScene.health == 3 && turnsSinceFruit >2):
			thisChoice = 3
		elif(($PlantScene.health == 4 && lastChoice != 3) or ($PlantScene.wasGivenDemonFood)):
			thisChoice = 3
			$PlantScene.wasGivenDemonFood = false
			
	if (thisChoice == lastChoice):
		while(thisChoice == lastChoice):
			thisChoice = unevenRoll()
			
	if (thisChoice == 3):
		turnsSinceFruit = 0
		
	SetNewChoice(thisChoice)

func iterateChoiceCounter():
	turnsSinceFruit += 1
	get_tree().call_group("cards", "disableAndMove")
	
func _process(delta):
	pass
		
func _input(event):
	if(event is InputEventMouseButton and event.is_pressed()):
		emit_signal("MouseClick")
		
func EatFruit():
	playerFruitEaten += 1
	playerHealth = clamp(playerHealth + 2, 0,3)
	
	get_tree().call_group("TopPanel","setHeight",EatPlantHeights[clamp(playerFruitEaten-1,0,2)])
	get_tree().call_group("TopText","setString", eatPlantLines[clamp(playerFruitEaten-1,0,2)])

	if(playerFruitEaten >= 3):
		loseLogic()
	
func EatScraps():
	playerHealth = clamp(playerHealth + 1, 0,2)
	get_tree().call_group("TopText","setString", "The scraps will get you by...")
	
func Starve():
	playerHealth -=1
	var topString = "The hunger consumes you, but you carry on..."
	
	if(playerHealth == 1):
		topString = "The hunger is maddening. If you do not eat soon you will perish"
	elif(playerHealth <= 0):
		topString = "Starvation overcomes you. They find your emaciated corpse curled up next to the plant."
	get_tree().call_group("TopText","setString", topString)
	
	if (playerHealth <= 0):
		loseLogic()

func loseLogic():
	get_tree().call_group("TopText","setLargeSize")
	lost = true
	
func spendFavor(faction):
	favor[faction] = false
	
func Feast():
	spendFavor(Factions.Faction.King)
	var topString = "The libations are overflowing. You are blessed to have curried the kings favor. You wake drunk, and sated"
	
	playerHealth = clamp(playerHealth + 2, 0,3)
	get_tree().call_group("TopText","setString", topString)

func offeredFruit(faction):
	get_tree().call_group("TopPanel","setHeight", FactionEatHeights[faction][fruitCount[faction]])
	favor[faction] = true
	get_tree().call_group("TopText","setString", factionEatLines[faction][fruitCount[faction]])
	
	fruitCount[faction] += 1
	if(fruitCount[faction] >= 3):
		loseLogic()
		#lose game
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

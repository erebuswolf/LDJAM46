extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal Lose

var health = 2
var demonicCounter = 0

var wasGivenDemonFood = false

var backgrounds = ["323c39","222034","000000","45283c"]
var textures = [load("res://aseprite/Plant1.png"),
	load("res://aseprite/Plant2.png"),
	load("res://aseprite/Plant3.png"),
	load("res://aseprite/Plant5.png"),
	load("res://aseprite/Plant6.png")]
	
var BottomStrings = ["The plant is Dead. Your master will likely kill you.",
	"The plant is on death's door!",
	"The plant is wilting",
	"You are uncomfortable looking at the plant",
	"The plant hurts your head to look at"]
	
	
var TopStrings = ["The plant looks worse for it.",
	"The plant is unchanged",
	"The plant is recovering",
	"The plant recovered greatly",
	"The plant's power grows",]

# Called when the node enters the scene tree for the first time.
func _ready():
	setPlantAndBackground()
	add_to_group("plant")
	pass # Replace with function body.

func healBasic():
	var healAmnt = 0;
	if (health < 2):
		health += 1
		healAmnt = 1
	
	setTopString(healAmnt)
	setPlantAndBackground()
	
func healDemonic():
	var healAmnt = 0
	if (health < 2):
		health +=2
		healAmnt = 2
	else:
		healAmnt = 1
		health += 1
	
	health = clamp(health, 0, 4)
	demonicCounter += 1
	
	wasGivenDemonFood = true
	
	setTopString(healAmnt)
	setPlantAndBackground()
	
func takeDamage():
	health -= 1
	if (health <= 0):
		emit_signal("Lose")
		
	setTopString(-1)
	setPlantAndBackground()
	
func setTopString(param:int):
	var TopString = TopStrings[clamp(param+1,0,4)]
	if (health >=4 and param > 0 and param < 2):
		TopString = TopStrings[4]

	var BottomString = BottomStrings[clamp(health,0,5)]
	
	if (health ==0):
		get_tree().call_group("TopText","setString",BottomString)
	else:
		get_tree().call_group("TopText","setString", TopString + "\n"+BottomString)

func setPlantAndBackground():
	var c = Color(backgrounds[clamp(abs(health-2),0,2)])
	if(health == 3):
		 c = Color(backgrounds[3])
	
	VisualServer.set_default_clear_color(c)
	$Sprite.texture = textures[clamp(health,0,5)]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal Lose

var health = 3
var demonicCounter = 0
var backgrounds = ["323c39","45283c","000000"]
var textures = [load("res://aseprite/Plant1.png"),
	load("res://aseprite/Plant2.png"),
	load("res://aseprite/Plant3.png"),
	load("res://aseprite/Plant4.png"),
	load("res://aseprite/Plant5.png"),
	load("res://aseprite/Plant6.png")]
	
var BottomStrings = ["The plant is Dead. Your master will likely kill you.",
	"The plant is on death's door!",
	"The plant is wilting",
	"The plant looks healthy",
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
	if (health < 3):
		health += 1
		healAmnt = 1
	
	setTopString(healAmnt)
	setPlantAndBackground()
	
func healDemonic():
	var healAmnt = 0
	if (health < 3):
		health +=2
		healAmnt = 2
	else:
		healAmnt = 1
		health += 1
	
	health = clamp(health, 0, 5)
	demonicCounter += 1
	
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
	if (health == 5):
		TopString = TopStrings[4]
	

	var BottomString = BottomStrings[clamp(health,0,5)]
	
	get_tree().call_group("TopText","setString", TopString + "\n"+BottomString)

func setPlantAndBackground():
	VisualServer.set_default_clear_color(Color(backgrounds[clamp(abs(health-3),0,2)]))
	$Sprite.texture = textures[clamp(health,0,5)]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

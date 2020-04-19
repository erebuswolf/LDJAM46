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

# Called when the node enters the scene tree for the first time.
func _ready():
	setPlantAndBackground()
	add_to_group("plant")
	pass # Replace with function body.

func healBasic():
	if (health < 3):
		health += 1
	setPlantAndBackground()
	
func healDemonic():
	if (health < 3):
		health +=2
	else:
		health += 1	
		
	health = clamp(health, 0, 5)
	demonicCounter += 1
	setPlantAndBackground()
	
func takeDamage():
	health -= 1
	if (health <= 0):
		emit_signal("Lose")
	setPlantAndBackground()
	
		

func setPlantAndBackground():
	VisualServer.set_default_clear_color(Color(backgrounds[clamp(abs(health-3),0,2)]))
	$Sprite.texture = textures[clamp(health,0,5)]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

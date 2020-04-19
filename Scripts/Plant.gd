extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal Lose

var health = 3
var demonicCounter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("plant")
	pass # Replace with function body.

func healBasic():
	if (health < 3):
		health += 1
		
func healDemonic():
	health +=2
	health = clamp(health, 0, 5)
	demonicCounter += 1
	
func takeDamage():
	health -= 1
	if (health <= 0):
		emit_signal("Lose")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

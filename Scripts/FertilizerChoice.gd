extends CardChoice

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cardCount =0

func _init():
	DescriptiveText = "The plant needs fresh Soil. This is all we could find..."
	PossibleCards = [load ("res://Scripts/DeadAnimals.gd")
	,load ("res://Scripts/Sand.gd"),
	load ("res://Scripts/Manure.gd")]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	getRandomCards()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

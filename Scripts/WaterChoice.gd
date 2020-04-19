extends CardChoice

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init():
	DescriptiveText = "The plant needs water.\nThis is all we could find..."
	PossibleCards = [load ("res://Scripts/Water.gd"),
	load ("res://Scripts/Blood.gd"),
	load ("res://Scripts/DirtyWater.gd")]

# Called when the node enters the scene tree for the first time.
func _ready():
	getRandomCards()
	pass # Replace with function body.
	
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

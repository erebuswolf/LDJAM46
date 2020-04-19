extends CardChoice

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init():
	DescriptiveText = "Play again?"
	PossibleCards = [load ("res://Scripts/Cards/PlayAgain.gd"),
	load ("res://Scripts/Cards/Quit.gd")]

# Called when the node enters the scene tree for the first time.
func _ready():
	_addCard(cardBase.instance(), PossibleCards[0], 75)
	_addCard(cardBase.instance(), PossibleCards[1], 325 ) #575
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

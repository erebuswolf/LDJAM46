extends CardChoice

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init():
	DescriptiveText = "The plant has borne fruit!\n...Who should we offer it to?"
	PossibleCards = [load ("res://Scripts/Cards/Church.gd"),
	load ("res://Scripts/Cards/King.gd"),
	load ("res://Scripts/Cards/Townsfolk.gd")]

# Called when the node enters the scene tree for the first time.
func _ready():
	_addCard(cardBase.instance(), PossibleCards[0], 75)
	_addCard(cardBase.instance(), PossibleCards[1], 325 )
	_addCard(cardBase.instance(), PossibleCards[2], 575 )
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

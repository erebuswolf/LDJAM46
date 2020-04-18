extends CardChoice

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cardCount =0

# Called when the node enters the scene tree for the first time.
func _ready():
	DescriptiveText = "The plant needs fresh Soil. This is all we could find..."
	PossibleCards = [load ("res://Scripts/DeadAnimals.gd")
	,load ("res://Scripts/Sand.gd"),
	load ("res://Scripts/Manure.gd")]
	getRandomCards()
	pass # Replace with function body.

func _addCard(card, script, offset):
	card.set_script(script);
	$Panel.add_child(card)
	card.rect_position = Vector2(offset, 40) 
	
func getRandomCards():
	get_tree().call_group("cards", "queue_free")
	
	var card1 = rng.randi_range(0,PossibleCards.size()-1)
	var card2 = card1
	while(card2 == card1):
		card2 = rng.randi_range(0,PossibleCards.size()-1)
	print ("cards",card1, card2)
	_addCard(cardBase.instance(), PossibleCards[card1], 75 +cardCount)
	_addCard(cardBase.instance(), PossibleCards[card2], 325 + cardCount) #575

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

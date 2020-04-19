extends Node2D


class_name CardChoice

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var DescriptiveText = "Blank Descriptive Text"
var PossibleCards : Array;
var cardBase = preload("res://Scenes/Card.tscn")
var rng = RandomNumberGenerator.new()

enum Choices {WaterChoice, FertilizerChoice, EatingChoice, OfferingChoice}

func _init():
	rng.randomize()
	print("init")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	DescriptiveText = "[center]"+DescriptiveText+"[/center]"
	get_tree().call_group("TopText","setString", DescriptiveText)
	print ("added to scene...")
	pass # Replace with function body.
	
func getRandomCards():
	var card1 = 0 #rng.randi_range(0,PossibleCards.size()-1)
	var card2 = card1
	while(card2 == card1):
		card2 = rng.randi_range(0,PossibleCards.size()-1)
	print ("cards",card1, card2)
	_addCard(cardBase.instance(), PossibleCards[card1], 75)
	_addCard(cardBase.instance(), PossibleCards[card2], 325 ) #575


func _addCard(card, script, offset):
	card.set_script(script);
	$Panel/Container.add_child(card)
	card.rect_position = Vector2(offset, 60) 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

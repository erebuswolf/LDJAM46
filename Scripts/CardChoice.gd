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
	$Panel/AnimationPlayer.play("SlideIn")
	show()
	print ("added to scene...")
	pass # Replace with function body.
	
func getRandomCards():
	var card1 = rng.randi_range(0,PossibleCards.size()-1)
	var card2 = card1
	while(card2 == card1):
		card2 = rng.randi_range(0,PossibleCards.size()-1)
	print ("cards",card1, card2)
	_addCard(cardBase.instance(), PossibleCards[card1], 75)
	_addCard(cardBase.instance(), PossibleCards[card2], 325 ) #575


func _addCard(card, script, offset):
	card.set_script(script);
	$Panel/Container.add_child(card)
	card.get_child(0).get_child(0).connect("pressed", self, "_cardPressed")
	card.rect_position = Vector2(offset, 60) 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _cardPressed():
	print("card pressed")
	var timer = Timer.new()
	$Panel/AnimationPlayer.play("SlideAway")
	add_child(timer)
	timer.wait_time = 1
	timer.one_shot = true
	timer.connect("timeout", self, "_onTimerTimeout")
	timer.start()
	pass

func _onTimerTimeout():
	print("timer hit")
	
	get_tree().call_group("main","GetNextChoice")
	queue_free()
	pass

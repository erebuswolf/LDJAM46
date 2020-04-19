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
	
# Called when the node enters the scene tree for the first time.
func _ready():
	DescriptiveText = "[center]"+DescriptiveText+"[/center]"
	get_tree().call_group("TopText","setString", DescriptiveText)
	
	get_tree().call_group("TopPanel","setStartSize")
	var showTimer = Timer.new()
	showTimer.wait_time = .1
	showTimer.connect("timeout",self, "showAndStart")
	showTimer.one_shot = true
	add_child(showTimer)
	$Panel/AnimationPlayer.play("SlideIn")
	showTimer.start()
	pass # Replace with function body.
	
func showAndStart():
	position = Vector2(120,160)
	
func getRandomCards(favored:bool):
		
	var card1 = unevenRoll()
	
	var card2 = card1
	while(card2 == card1):
		card2 = unevenRoll()
	_addCard(cardBase.instance(), PossibleCards[card1], 75)
	_addCard(cardBase.instance(), PossibleCards[card2], 325 ) #575
	if (favored) :
		_addCard(cardBase.instance(), PossibleCards[PossibleCards.size()-1], 575 )

func unevenRoll():
	var rand = rng.randf_range(0,100)
	var pick = 2
	if(rand < 10):
		pick = 0
	elif(rand < 55):
		pick = 1
	return pick

func _addCard(card, script, offset):
	card.set_script(script);
	$Panel/Container.add_child(card)
	card.get_child(0).get_child(0).connect("pressed", self, "_cardPressed")
	card.rect_position = Vector2(offset, 60) 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _cardPressed():
	var timer = Timer.new()
	$Panel/AnimationPlayer.play("SlideAway")
	add_child(timer)
	timer.wait_time = 1
	timer.one_shot = true
	timer.connect("timeout", self, "_onTimerTimeout")
	timer.start()
	pass

func _onTimerTimeout():
	get_tree().call_group("main","GetNextChoice")
	queue_free()
	pass

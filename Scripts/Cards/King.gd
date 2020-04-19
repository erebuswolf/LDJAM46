extends CardBase


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init():
	label = "The\nKing"
	TexturePath = "res://aseprite/King.png"
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _Effect():
	get_tree().call_group("main", "offeredFruit", Factions.Faction.King)
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

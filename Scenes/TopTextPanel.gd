extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("TopPanel")
	pass # Replace with function body.

func setLargeSize():
	rect_size = Vector2(800,250)
	print ("set large")

func setStartSize():
	rect_size = Vector2(800,120)
	print ("set start")
	
func setHeight(Height):
	rect_size = Vector2(800, Height)
	print ("set start")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout",self,"nextScene")
	$Panel/Sprite/AnimationPlayer.play("FadeIn and OUt")
	pass # Replace with function body.

func nextScene():
	get_tree().change_scene("res://Scenes/MainGame.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

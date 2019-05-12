extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var ting = false

func _on_PlayButton_pressed():
	if not ting:
		$Tween.interpolate_property($ColorRect, "modulate", Color(0, 0, 0, 0), Color(0, 0, 0, 1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
		ting = true
		$StartPlayer.play()


func _on_Tween_tween_completed(object, key):
	get_tree().change_scene("res://Node2D.tscn")

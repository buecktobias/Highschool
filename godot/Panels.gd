extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var img = 0
const NUM_IMGS = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("cont"):
		img += 1
		if img >= NUM_IMGS:
			get_tree().change_scene("res://MainMenu.tscn")
		else:
			var c = get_children()
			$Tween.interpolate_property(c[img-1], "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), .5, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.interpolate_property(c[img-1], "scale", Vector2(1, 1), Vector2(1.5, 1.5), .5, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.interpolate_property(c[img], "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), .5, Tween.TRANS_LINEAR, Tween.EASE_IN, .5)
			$Tween.interpolate_property(c[img], "scale", Vector2(1.5, 1.5), Vector2(1, 1), .5, Tween.TRANS_LINEAR, Tween.EASE_IN, .5)
			$AudioStreamPlayer.play()

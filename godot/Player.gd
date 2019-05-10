extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var x_speed = 500
var gravity = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.	

func lose():
	get_tree().change_scene("LoseScreen.tscn")

func win():
	get_tree().change_scene("WinScreen.tscn")
	
func movement():
	var movement = Vector2()
	movement.y += gravity
	if Input.is_action_pressed("ui_left"):
		movement.x -= x_speed
	elif Input.is_action_pressed("ui_right"):
		movement.x += x_speed
	move_and_slide(movement)
		
func _process(delta):
	movement()
	

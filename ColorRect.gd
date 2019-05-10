extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var x_speed = 20
var y_speed = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func gravitation(delta):
	rect_position += delta*Vector2(0, y_speed)
	
func movement(delta):
	if Input.is_action_pressed("ui_left"):
		rect_position -= delta*Vector2(x_speed, 0)
	if Input.is_action_pressed("ui_right"):
		rect_position += delta*Vector2(x_speed, 0)	
	
func _process(delta):
	movement(delta)
	gravitation(delta)

extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player
var x_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position.x = rand_range(-300, 300)
	self.position.y = rand_range(-450, 450)
	x_speed = rand_range(-2, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var factor = min(float(get_viewport().size.y)/800, float(get_viewport().size.x)/600)
	self.position.x += delta * x_speed
	if get_global_transform_with_canvas().origin.y < -50*factor + (get_viewport().size.y-800*factor)/2:
		self.position.y += 900
		self.position.x = rand_range(-300, 300)
		x_speed = rand_range(-2, 2)

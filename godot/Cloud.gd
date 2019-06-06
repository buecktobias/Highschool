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
	self.position.x += delta * x_speed
	if self.position.y < -50:
		self.position.y += 900
		self.position.x = rand_range(-300, 300)
		x_speed = rand_range(-2, 2)

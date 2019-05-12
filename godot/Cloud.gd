extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player
var x_speed
var y_speed_factor

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position.x = rand_range(200, 400)
	self.position.y = rand_range(-450, 600)
	x_speed = rand_range(5, 15)
	y_speed_factor = rand_range(200, 400)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x += delta * x_speed
	self.position.y -= delta * player.y_speed / y_speed_factor
	if self.position.x < 100 or self.position.x > 500:
		self.x_speed *= -1
	if self.position.y < player.position.y - 200 - 170:
		self.position.y = player.position.y + 600 + 170

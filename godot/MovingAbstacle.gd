extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var x_speed = 0
# Called when the node enters the scene tree for the first time.

func _ready():
	x_speed = rand_range(-5,5)
	
	
func _process(delta):
	position.x += x_speed
	

func _on_MovingObstacle_body_entered(body):
	if body.is_in_group("Player"):
		var player = body
		player.lose()
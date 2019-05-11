extends Area2D

export (float) var min_speed = 50
export (float) var max_speed = 100

var speed
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = rand_range(min_speed, max_speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.y - 210  > self.position.y:
		self.queue_free()
	position.y -= delta*speed

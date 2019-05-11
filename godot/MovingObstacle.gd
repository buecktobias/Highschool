extends Area2D

enum DIRECTION {LEFT, RIGHT}

export (float) var min_speed = 50
export (float) var max_speed = 250
var speed
var direction
var player
func _ready():
	var directions = [DIRECTION.LEFT, DIRECTION.RIGHT]
	var random = int(round(rand_range(0,1)))
	direction = directions[random]
	speed = rand_range(min_speed, max_speed)
	if direction == DIRECTION.LEFT:
		scale.x = -4

func _process(delta):
	if player.position.y - 210  > self.position.y:
		self.queue_free()
	match direction:
		DIRECTION.LEFT:
			position.x -= delta*speed
			if position.x < 0:
				direction = DIRECTION.RIGHT
				scale.x = 4
		DIRECTION.RIGHT:
			position.x += delta*speed
			if position.x > 600:
				direction = DIRECTION.LEFT
				scale.x = -4
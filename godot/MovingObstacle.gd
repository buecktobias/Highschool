extends Area2D

enum DIRECTION {LEFT, RIGHT}

export (float) var min_speed = 50
export (float) var max_speed = 250
var speed
export (DIRECTION) var direction = DIRECTION.RIGHT

func _ready():
	speed = rand_range(min_speed, max_speed)
	if direction == DIRECTION.LEFT:
		scale.x = -4

func _process(delta):
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
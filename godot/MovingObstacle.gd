extends Area2D

enum DIRECTION {LEFT, RIGHT}

export (float) var speed = 100
export (DIRECTION) var direction = DIRECTION.RIGHT

func _ready():
	if direction == DIRECTION.LEFT:
		scale.x = -4

func _process(delta):
	match direction:
		DIRECTION.LEFT:
			position.x -= delta*speed
			if position.x < 50:
				direction = DIRECTION.RIGHT
				scale.x = 4
		DIRECTION.RIGHT:
			position.x += delta*speed
			if position.x > 550:
				direction = DIRECTION.LEFT
				scale.x = -4
extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player
enum Direction{LEFT, RIGHT, UP, DOWN}
enum State{FROM_CENTER, TO_CENTER, IN_CENTER}
var center_position
var state
var direction
const speed = 100
const max_distance = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	center_position = Vector2(self.position.x, self.position.y)


func random_direction():
	return Direction.values()[randi() % len(Direction.values())]
# Called every frame. 'delta' is the elapsed time since the previous frame.


func move(delta):
	if self.direction == Direction.LEFT:
		self.position.x -= delta * self.speed
		
	elif self.direction == Direction.RIGHT:
		self.position.x += delta * self.speed
		
	elif self.direction == Direction.UP:
		self.position.y -= delta * self.speed
		
	elif self.direction == Direction.DOWN:
		self.position.y += delta * self.speed


func manhattan_distance(position1, position2):
	var x_difference = abs(position1.x - position2.x)
	var y_difference = abs(position1.y - position2.y)
	return x_difference + y_difference
	

func reverse_state():
	self.state = State.FROM_CENTER if self.state == State.TO_CENTER else State.TO_CENTER


func reverse_direction():
	if self.direction == Direction.LEFT:
		self.direction = Direction.RIGHT
	elif self.direction == Direction.RIGHT:
		self.direction = Direction.LEFT
	elif self.direction == Direction.UP:
		self.direction = Direction.DOWN
	elif self.direction == Direction.DOWN:
		self.direction = Direction.UP


func _process(delta):
	var center_tolerance = 0.2
	if manhattan_distance(self.position, self.center_position) < center_tolerance:
		self.position= self.center_position
		self.state = State.IN_CENTER
		self.direction = random_direction()

	elif manhattan_distance(position, self.center_position) >= max_distance:
		reverse_state()
		reverse_direction()
		
	move(delta)
	
	if player.position.y - 210  > self.position.y:
		self.queue_free()

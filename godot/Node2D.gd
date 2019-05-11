extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

const RANDOM_WALL = preload("res://RandomWall.tscn")
const BIRD = preload("res://Birb.tscn")
const ELEMENTS = [RANDOM_WALL, BIRD]
const SCREEN_WIDTH = 600
const GAP_BETWEEN_STAGES = 200
const LEVEL_SIZE = 1_000
func _ready():
	print("test")
	for y in range(0, LEVEL_SIZE, GAP_BETWEEN_STAGES):
		var x = int(round(rand_range(0,SCREEN_WIDTH)))
		var random_element = ELEMENTS[round(rand_range(0,len(ELEMENTS)-1))]
		var object = random_element.instance()
		object.position.x = x
		object.position.y = y
		self.add_child(object)
		print(y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

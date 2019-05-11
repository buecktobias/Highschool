extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
const RANDOM_WALL = preload("res://RandomWall.tscn")
const BIRD = preload("res://Birb.tscn")
const BEE = preload("res://Bee.tscn")
const ELEMENTS = [RANDOM_WALL, RANDOM_WALL, RANDOM_WALL, BIRD, BIRD, BEE, BEE]
const SCREEN_WIDTH = 600
const GAP_BETWEEN_STAGES = 200
const LEVEL_SIZE = 100_000
func _ready():
	randomize()
	var screen_width = OS.get_screen_size(OS.get_current_screen()).x
	var window_width = OS.get_window_size().x
	OS.set_window_position(Vector2((screen_width / 2) - (window_width / 2),0))
	for y in range(0, LEVEL_SIZE, GAP_BETWEEN_STAGES):
		var x = int(round(rand_range(0,SCREEN_WIDTH)))
		var random_element = ELEMENTS[round(rand_range(0,len(ELEMENTS)-1))]
		var object = random_element.instance()
		object.position.x = x
		object.position.y = y
		self.add_child(object)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_lose():
	$LoseTimer.wait_time = 1
	$LoseTimer.start()


func _on_Player_win():
	get_tree().change_scene("WinScreen.tscn")


func _on_LoseTimer_timeout():
	get_tree().change_scene("LoseScreen.tscn")

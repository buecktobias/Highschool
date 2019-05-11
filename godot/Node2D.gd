extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
const RANDOM_WALL = preload("res://RandomWall.tscn")
const BIRD = preload("res://Birb.tscn")
const BEE = preload("res://Bee.tscn")
export (NodePath) var player_path
const ELEMENTS = [RANDOM_WALL, BEE, BIRD]
const SCREEN_WIDTH = 600
const GAP_BETWEEN_STAGES = 200
const LEVEL_SIZE = 100_000

var last_player_position_obstacle_added_y = -800
var player
var position_last_obstacle_placed_y
func random_element(list_of_chances):
	assert len(ELEMENTS) == len(list_of_chances)
	var elements_for_random = []
	for i in range(len(list_of_chances)):
		var chance = list_of_chances[i]
		var element = ELEMENTS[i]
		for j in range(chance):
			elements_for_random.append(element)
	return elements_for_random[int(round(rand_range(0, len(elements_for_random)-1)))]


func sum(list):
	var sum = 0
	for num in list:
		sum += num
	return sum
	
func calculate_chances(y_position):
	var smaller_y = (y_position + 500) / 1_000
	
	var elements_num = []
	for i in range(len(ELEMENTS)):
		var power = i + 1
		var num = pow(smaller_y, power)
		elements_num.append(num)
	var sum_elemts_num = sum(elements_num)
	var chances = []
	for num in elements_num:
		chances.append(int(round(100 * (num / sum_elemts_num))))
	return chances


func create_random_element(y):
		var x = int(round(rand_range(0,SCREEN_WIDTH)))
		var random_element = random_element(calculate_chances(player.position.y))
		var object = random_element.instance()
		object.player = player
		object.position.x = x
		object.position.y = y
		self.add_child(object)
		position_last_obstacle_placed_y = y
		last_player_position_obstacle_added_y += GAP_BETWEEN_STAGES
func _ready():
	randomize()
	player = get_node(player_path)
	var screen_width = OS.get_screen_size(OS.get_current_screen()).x
	var window_width = OS.get_window_size().x
	OS.set_window_position(Vector2((screen_width / 2) - (window_width / 2),0))
	for y in range(0, GAP_BETWEEN_STAGES * 5, GAP_BETWEEN_STAGES):
		create_random_element(y)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.y - GAP_BETWEEN_STAGES > last_player_position_obstacle_added_y:
		create_random_element(position_last_obstacle_placed_y + GAP_BETWEEN_STAGES)
		


func _on_Player_lose():
	$LoseTimer.wait_time = 1
	$LoseTimer.start()


func _on_Player_win():
	get_tree().change_scene("WinScreen.tscn")


func _on_LoseTimer_timeout():
	get_tree().change_scene("LoseScreen.tscn")

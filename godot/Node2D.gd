extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
const RANDOM_WALL = preload("res://RandomWall.tscn")
const BIRD = preload("res://Birb.tscn")
const BEE = preload("res://Bee.tscn")
const DRONE = preload("res://Drone.tscn")
const PENGUIN = preload("res://Penguin.tscn")

const BEANS = preload("res://CanOfBeans.tscn")

const CLOUD = preload("res://Cloud.tscn")

export (NodePath) var player_path
const ELEMENTS = [BEE, BIRD, DRONE]
const SCREEN_WIDTH = 600
const SCREEN_HEIGHT = 800
const GAP_BETWEEN_STAGES = 200
const LEVEL_SIZE = 100_000

var last_player_position_obstacle_added_y = -800
var player
var position_last_obstacle_placed_y


func sum(list):
	var sum = 0
	for num in list:
		sum += num
	return sum


func range_map(value, start_min, start_max, end_min, end_max):
    var start_range = start_max - start_min
    var end_range = end_max - end_min
    return end_min + (float(value - start_min) / float(start_range) * end_range)


func get_random_element():
	var function_value = range_map(player.position.y, -float(SCREEN_HEIGHT), float(LEVEL_SIZE), 0.0, 10.0)
	
	var element_values = []
	for i in range(len(ELEMENTS)):
		var power = 1 + (i * 1)
		var element_value = pow(function_value, power)
		element_values.append(element_value)
	
	var element_value_sum = sum(element_values)
	var random_chance = rand_range(0, 1)
	var chance_sum = 0
	for element_index in range(len(element_values)):
		var element_value = element_values[element_index]
		var element_chance = element_value / element_value_sum if element_value_sum != 0 else 0
		chance_sum += element_chance
		if random_chance < chance_sum:
			return ELEMENTS[element_index]
	return ELEMENTS[len(ELEMENTS) - 1]


func spawn_random_element(y):
	var x = int(round(rand_range(0, SCREEN_WIDTH)))
	# chance for beans
	if randi() % 100 < 30:
		var beans = BEANS.instance()
		beans.player = player
		beans.position.x = int(floor(x + 300)) % SCREEN_WIDTH
		beans.position.y = y + GAP_BETWEEN_STAGES / 2
		self.add_child(beans)
	# increasing chance for a penguin
	if rand_range(0, 1) < player.position.y / LEVEL_SIZE:
		var penguin = PENGUIN.instance()
		penguin.player = player
		penguin.position.x = x
		penguin.position.y = y
		self.add_child(penguin)
	var object
	# chance for a wall
	if randi() % 100 < 30:
		object = RANDOM_WALL.instance()
	# use remaining chance for one of all the other elements
	else:
		object = get_random_element().instance()
	object.player = player
	object.position.x = x
	object.position.y = y
	self.add_child(object)
	position_last_obstacle_placed_y = y
	last_player_position_obstacle_added_y += GAP_BETWEEN_STAGES


func spawn_clouds():
	var CLOUDS_PER_LAYER = 4
	for i in range(CLOUDS_PER_LAYER):
		var cloud = CLOUD.instance()
		cloud.player = player
		var random_scale = rand_range(0.6, 1.0)
		cloud.scale.x = random_scale
		cloud.scale.y = random_scale
		#self.add_child(cloud)
		$ParallaxBackground/CloudsLayer.add_child(cloud)
	for i in range(CLOUDS_PER_LAYER):
		var cloud = CLOUD.instance()
		cloud.player = player
		var random_scale = rand_range(0.6, 1.0)
		cloud.scale.x = random_scale
		cloud.scale.y = random_scale
		#self.add_child(cloud)
		$ParallaxBackground/CloudsLayer2.add_child(cloud)
	for i in range(CLOUDS_PER_LAYER):
		var cloud = CLOUD.instance()
		cloud.player = player
		var random_scale = rand_range(0.6, 1.0)
		cloud.scale.x = random_scale
		cloud.scale.y = random_scale
		#self.add_child(cloud)
		$ParallaxBackground/CloudsLayer3.add_child(cloud)

func _fit_to_screen():
	var factor = min(float(get_viewport().size.y)/800, float(get_viewport().size.x)/600)
	scale.x = factor
	scale.y = factor
	$ParallaxBackground.prepare_scale_camera()

func _ready():
	randomize()
	player = get_node(player_path)
	var screen_width = OS.get_screen_size(OS.get_current_screen()).x
	var window_width = OS.get_window_size().x
	OS.set_window_position(Vector2((screen_width / 2) - (window_width / 2), 0))
	for y in range(0, GAP_BETWEEN_STAGES * 5, GAP_BETWEEN_STAGES):
		spawn_random_element(y)
	spawn_clouds()
	$MainCamera/Tween.interpolate_property($MainCamera/ColorRect, "modulate", Color(0, 0, 0, 1), Color(0, 0, 0, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$MainCamera/Tween.start()
	_fit_to_screen()
	get_viewport().connect("size_changed", self, "_fit_to_screen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.y - GAP_BETWEEN_STAGES > last_player_position_obstacle_added_y:
		spawn_random_element(position_last_obstacle_placed_y + GAP_BETWEEN_STAGES)


func _on_Player_lose():
	$LoseTimer.wait_time = 1
	$LoseTimer.start()
	$AudioStreamPlayer.stop()
	PlayerData.set("current_score", 400.0 + round(player.position.y))


func _on_Player_win():
	get_tree().change_scene("WinScreen.tscn")


func _on_LoseTimer_timeout():
	#get_tree().change_scene("LoseScreen.tscn")
	var l = preload("res://LoseScreen.tscn").instance()
	$MainCamera.add_child(l)

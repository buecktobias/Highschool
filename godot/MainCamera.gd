extends Node2D

export (NodePath) var player_path
export (int) var offset_to_player = 200

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)
	ScreenEffects.submit_shaker($Shaker)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y = max(player.position.y + offset_to_player, position.y)

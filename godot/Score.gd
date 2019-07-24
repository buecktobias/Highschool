extends RichTextLabel

export (NodePath) var player_path
var player

var VIEWPORT_HEIGHT

const format_string = "[b][color=#FFFF40]%s[/color][/b]"

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)
	VIEWPORT_HEIGHT = get_viewport().size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.y > -(VIEWPORT_HEIGHT / 2):
		bbcode_text = format_string % str((float(VIEWPORT_HEIGHT - 800) / 2) + round(player.position.y))

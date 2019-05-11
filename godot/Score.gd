extends RichTextLabel

export (NodePath) var player_path
var player

const format_string = "[b][color=yellow]%s[/color][/b]"

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bbcode_text = format_string % str(300 + round(player.position.y))

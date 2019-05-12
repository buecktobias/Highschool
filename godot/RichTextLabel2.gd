extends RichTextLabel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const format_string = "[b][color=#FFFF40]%s[/color][/b]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func display():
	if PlayerData.is_set("high_score"):
		bbcode_text = format_string % str(PlayerData.get("high_score"))
	else:
		bbcode_text = format_string % str(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	display()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

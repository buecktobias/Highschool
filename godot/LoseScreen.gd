extends Node2D

const format_string = "[b][color=#FFFF40]%s[/color][/b]"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Initween.interpolate_property(self, "position", Vector2(-300, 400), Vector2(-300, -400), 1.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Initween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerData.is_set("current_score"):
		$RichTextLabel2.bbcode_text = format_string % str(PlayerData.get("current_score"))

var ting = false

func _on_PlayButton_pressed():
	if not ting:
		$Tween.interpolate_property($ColorRect, "modulate", Color(0, 0, 0, 0), Color(0, 0, 0, 1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
		ting = true
		$StartPlayer.play()


func _on_Tween_tween_completed(object, key):
	get_tree().change_scene("res://Node2D.tscn")

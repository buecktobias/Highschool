extends Node2D

const format_string = "[b][color=#FFFF40]%s[/color][/b]"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Initween.interpolate_property(self, "position", Vector2(-300, 400), Vector2(-300, -400), 1.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Initween.start()
	if PlayerData.is_set("current_score"):
		if not PlayerData.is_set("high_score") or PlayerData.get("current_score") > PlayerData.get("high_score"):
			PlayerData.set("high_score", PlayerData.get("current_score"))
			$HappyPlayer.play()
			$HappyTween.interpolate_property($Shaker, "scale", Vector2(3, 3), Vector2(1, 1), .5, Tween.TRANS_LINEAR, Tween.EASE_IN, 2.5)
			$HappyTween.interpolate_property($Shaker, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), .5, Tween.TRANS_LINEAR, Tween.EASE_IN, 2.5)
			$HappyTween.start()
		else:
			$SadPlayer.play()
	else:
		$SadPlayer.play()

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


func _on_HappyTween_tween_completed(object, key):
	$ScoreDisplay.display()
	$Shaker.shake(3, 7200)


func _on_Button_pressed():
	PlayerData.set("high_score", 0)
	$ScoreDisplay.display()

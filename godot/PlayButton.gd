extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayButton_button_down():
	$Normal.visible = false
	$Hovered.visible = false
	$Pressed.visible = true


func _on_PlayButton_button_up():
	$Normal.visible = false
	$Hovered.visible = true
	$Pressed.visible = false


func _on_PlayButton_mouse_entered():
	$Normal.visible = false
	$Hovered.visible = true
	$Pressed.visible = false
	$HighlightPlayer.play()


func _on_PlayButton_mouse_exited():
	$Normal.visible = true
	$Hovered.visible = false
	$Pressed.visible = false

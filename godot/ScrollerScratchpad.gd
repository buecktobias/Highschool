extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for o in get_children():
		if "player" in o:
			o.player = $Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_lose():
	$LoseTimer.wait_time = 1
	$LoseTimer.start()
	$AudioStreamPlayer.stop()


func _on_Player_win():
	get_tree().change_scene("WinScreen.tscn")


func _on_Timer_timeout():
	get_tree().change_scene("LoseScreen.tscn")

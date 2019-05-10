extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#var player = get_node("/root/Node2D/Player")
	
	#player.hide()
#	pass


func _on_StaticObstacle_body_entered(body):
	if body.is_in_group("Player"):
		var player = body
		player.die()

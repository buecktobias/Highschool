extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.y - 210  > self.position.y:
		self.queue_free()

var _collected = false

func _on_CanOfBeans_body_entered(body):
	if not _collected and body.is_in_group("Player"):
		body.can_collected()
		#queue_free()
		$Sprite.hide()
		_collected = true
		$CPUParticles2D.emitting = false
		$BeanPlayer.play()
		$DeathTimer.start()

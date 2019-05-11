extends KinematicBody2D

signal win
signal lose

var y_acceleration = 4
var y_speed = 80
var x_speed = 500
var _is_dead = false

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.	
const DEATH_EFFECT = preload("res://PlayerDeath.tscn")

func lose(killer):
	#get_tree().change_scene("LoseScreen.tscn")
	emit_signal("lose")
	hide()
	_is_dead = true
	ScreenEffects.shake(15, 1.0, true)
	var d = DEATH_EFFECT.instance()
	d.position = position
	if killer.position.x > position.x:
		d.scale.x = -1
	get_parent().add_child(d)

func win():
	#get_tree().change_scene("WinScreen.tscn")
	emit_signal("win")

const ROT = PI/10

func _process(delta):
	if not _is_dead:
		var movement = Vector2()
		y_speed += delta * y_acceleration
		movement.y += y_speed
		if Input.is_action_pressed("ui_left"):
			movement.x -= x_speed
			$Tween.stop_all()
			$Tween.interpolate_property(self, "rotation", rotation, -ROT, .07, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.start()
		elif Input.is_action_pressed("ui_right"):
			movement.x += x_speed
			$Tween.stop_all()
			$Tween.interpolate_property(self, "rotation", rotation, ROT, .07, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.start()
		else:
			$Tween.stop_all()
			$Tween.interpolate_property(self, "rotation", rotation, 0, .07, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.start()
		move_and_slide(movement)
	

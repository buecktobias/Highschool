extends KinematicBody2D

signal win
signal lose

const window_width = 600

var y_acceleration = 4
var y_speed = 80
var x_speed = 500
var _is_dead = false

func _ready():
	pass

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
		var half_width = self.scale.x * 32 / 2
		# hard coded adjustment
		half_width /= 3
		if Input.is_action_pressed("ui_left"):
			$Tween.stop_all()
			$Tween.interpolate_property(self, "rotation", rotation, -ROT, .07, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.start()
			movement.x -= x_speed
			if position.x + (delta * movement.x) + half_width < 0:
				position.x = window_width + half_width
				return  # to prevent move_and_slide
		elif Input.is_action_pressed("ui_right"):
			$Tween.stop_all()
			$Tween.interpolate_property(self, "rotation", rotation, ROT, .07, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.start()
			movement.x += x_speed
			if position.x + (delta * movement.x) - half_width > window_width:
				position.x = -half_width
				return  # to prevent move_and_slide
		else:
			$Tween.stop_all()
			$Tween.interpolate_property(self, "rotation", rotation, 0, .07, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.start()
		move_and_slide(movement)
	

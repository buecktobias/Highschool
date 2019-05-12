extends KinematicBody2D

signal win
signal lose
signal jumps_update
signal jumps_init

const window_width = 600

var y_acceleration = 4
var y_speed = 0
var gravity = 980
var y_max_speed = 80
var x_speed = 500
var _is_dead = false

var max_extra_jumps = 2
var extra_jumps = 2

func _ready():
	call_deferred("emit_signal", "jumps_init", extra_jumps, max_extra_jumps)

# Called every frame. 'delta' is the elapsed time since the previous frame.	
const DEATH_EFFECT = preload("res://PlayerDeath.tscn")

func lose(killer):
	if not _is_dead:
		emit_signal("lose")
		hide()
		_is_dead = true
		ScreenEffects.shake(15, 1.0, true)
		var d = DEATH_EFFECT.instance()
		d.position = position
		get_parent().add_child(d)

func win():
	#get_tree().change_scene("WinScreen.tscn")
	emit_signal("win")

func can_collected():
	extra_jumps = min(extra_jumps+1, max_extra_jumps)
	emit_signal("jumps_update", extra_jumps, max_extra_jumps)

const ROT = PI/10

func _process(delta):
	if not _is_dead:
		y_max_speed += delta * y_acceleration
		y_speed = min(y_speed + delta*gravity, y_max_speed)
		if Input.is_action_just_pressed("jump"):
			if extra_jumps > 0:
				y_speed = -600
				$JumpTween.interpolate_property($AnimationPlayer, "playback_speed", 10, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
				$JumpTween.start()
				extra_jumps -= 1
				$FartPlayer.play()
				emit_signal("jumps_update", extra_jumps, max_extra_jumps)
			else:
				$NoAmmoPlayer.play()
		var movement = Vector2()
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
				#return  # to prevent move_and_slide
		elif Input.is_action_pressed("ui_right"):
			$Tween.stop_all()
			$Tween.interpolate_property(self, "rotation", rotation, ROT, .07, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.start()
			movement.x += x_speed
			if position.x + (delta * movement.x) - half_width > window_width:
				position.x = -half_width
				#return  # to prevent move_and_slide
		else:
			$Tween.stop_all()
			$Tween.interpolate_property(self, "rotation", rotation, 0, .07, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.start()
		move_and_slide(movement)

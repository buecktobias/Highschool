extends KinematicBody2D

signal win
signal lose

var x_speed = 500
var y_speed = 80
var y_acceleration = 2
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

func _process(delta):
	y_speed += delta *  y_acceleration
	if not _is_dead:
		var movement = Vector2()
		movement.y += y_speed
		if Input.is_action_pressed("ui_left"):
			movement.x -= x_speed
		elif Input.is_action_pressed("ui_right"):
			movement.x += x_speed
		move_and_slide(movement)
	

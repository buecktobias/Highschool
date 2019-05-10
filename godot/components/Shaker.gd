tool
extends Node2D

var _affected_node = null
var _dir
var _intensity
var _bi_shake = true
var remaining_time = 0
var is_shaking = false

func _get_configuration_warning():
	if get_children().size() == 1:
		return 'No shakable child'
	elif get_children().size() > 2:
		return 'Too many children'
	return ''

func _ready():
	_affected_node = get_children()[1]

func _physics_process(delta):
	if Engine.editor_hint:
		return
	
	if is_shaking:
		if _bi_shake:
			_affected_node.position = .707*(rand_range(-2, 2)*_intensity*Vector2(1, 0) + rand_range(-2, 2)*_intensity*Vector2(0, 1))
		else:
			_affected_node.position = rand_range(-2, 2)*_intensity*_dir
		remaining_time -= delta
		if remaining_time <= 0:
			is_shaking = false
			_affected_node.position = Vector2(0, 0)

func shake(intensity, duration, damped = false, dir = null):
	if is_shaking and intensity < _intensity:
		return
	is_shaking = true
	if dir == null:
		_bi_shake = true
	else:
		_bi_shake = false
		_dir = dir.normalized()
	if damped:
		$Tween.interpolate_property(self, "_intensity", intensity, 0, duration, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$Tween.start()
	else:
		_intensity = intensity
	remaining_time = duration

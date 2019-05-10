tool
extends Node

export (NodePath) var affected_node

var _affected_node = null
var _color
var _flash_on

func _get_configuration_warning():
	if not affected_node:
		return 'Affected node not set'
	return ''

func _ready():
	_affected_node = get_node(affected_node)

func flash(color, flash_duration, duration = -1):
	if duration == -1:
		duration = flash_duration
	$FlashTimer.stop()
	$DurationTimer.stop()
	_color = color
	_affected_node.modulate = color
	_flash_on = true
	$FlashTimer.wait_time = flash_duration
	$DurationTimer.wait_time = duration
	$FlashTimer.start()
	$DurationTimer.start()

func stop():
	$FlashTimer.stop()
	$DurationTimer.stop()
	_affected_node.modulate = Color(1, 1, 1, 1)

func _on_FlashTimer_timeout():
	if _flash_on:
		_affected_node.modulate = Color(1, 1, 1, 1)
		_flash_on = false
	else:
		_affected_node.modulate = _color
		_flash_on = true


func _on_DurationTimer_timeout():
	_affected_node.modulate = Color(1, 1, 1, 1)
	$FlashTimer.stop()

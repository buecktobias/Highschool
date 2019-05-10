tool
extends ColorRect

func _get_configuration_warning():
	if not get_parent().is_class("Camera2D"):
		return 'ScreenFlasher is not child of a Camera2D node'
	return ''

func _ready():
	rect_position = -1.0/2.0*get_parent().get_viewport_rect().size
	rect_size = get_parent().get_viewport_rect().size

func flash(col, in_time, duration, out_time):
	$Tween.interpolate_property(self, "color", Color(1, 1, 1, 0), col, in_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property(self, "color", col, Color(1, 1, 1, 0), out_time, Tween.TRANS_LINEAR, Tween.EASE_IN, in_time+duration)
	$Tween.start()

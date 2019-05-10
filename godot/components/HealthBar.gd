tool
extends Node2D

export (Color) var health_color = Color(0, 1, 0)
export (Color) var empty_color = Color(0, 0, 0)
export (Color) var border_color = Color(.25, .25, .25)
export (Vector2) var border = Vector2(3, 3)
export (Vector2) var size = Vector2(100, 12)
export (NodePath) var subject
export (String) var signal_name = "health_update"

func _get_configuration_warning():
	_set_properties()
	if not subject:
		return 'Subject node not set'
	elif not signal_name:
		return 'Signal name not set'
	return ''

func _ready():
	_set_properties()
	get_node(subject).connect(signal_name, self, "on_health_update")

func _set_properties():
	$HealthDisplay.color = health_color
	$Background.color = empty_color
	$Border.color = border_color
	$HealthDisplay.margin_left = border.x
	$HealthDisplay.margin_top = border.y
	$HealthDisplay.margin_right = size.x - border.x
	$HealthDisplay.margin_bottom = size.y - border.y
	$Background.margin_left = border.x
	$Background.margin_top = border.y
	$Background.margin_right = size.x - border.x
	$Background.margin_bottom = size.y - border.y
	$Border.margin_left = 0
	$Border.margin_top = 0
	$Border.margin_right = size.x
	$Border.margin_bottom = size.y

func on_health_update(health, max_health):
	$HealthDisplay.rect_scale = Vector2(clamp(float(health)/max_health, 0, 1), 1)
	$Flasher.flash(Color(1, 0, 0), .05)

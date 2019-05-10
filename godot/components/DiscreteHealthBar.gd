tool
extends Node2D

export (NodePath) var subject
export (NodePath) var filled_element
export (NodePath) var empty_element
export (String) var init_signal = "health_init"
export (String) var update_signal = "health_update"
export (float) var element_offset = 10

var health = 0
var max_health = 0

var filleds
var empties

func _get_configuration_warning():
	_set_properties()
	if not subject:
		return 'Subject node not set'
	elif not filled_element:
		return 'Filled element node not set'
	elif not empty_element:
		return 'Empty element node not set'
	return ''

func _ready():
	_set_properties()
	get_node(subject).connect(init_signal, self, "on_health_init")
	get_node(subject).connect(update_signal, self, "on_health_update")

func on_health_init(h, mh):
	max_health = mh
	_set_properties()
	health = h
	_set_display()

func on_health_update(h, mh):
	if mh != max_health:
		max_health = mh
		_set_properties()
		health = h
		_set_display()
	elif h != health:
		health = h
		_set_display()

func _set_properties():
	for c in $ElementContainer.get_children():
		c.queue_free()
	filleds = []
	empties = []
	var fe = get_node(filled_element)
	var ee = get_node(empty_element)
	for i in range(max_health):
		var e = ee.duplicate()
		e.position = Vector2(element_offset * i, 0)
		e.visible = false
		empties.push_back(e)
		add_child(e)
		var f = fe.duplicate()
		f.position = Vector2(element_offset * i, 0)
		f.visible = true
		filleds.push_back(f)
		add_child(f)

func _set_display():
	for i in range(max_health):
		if i < health:
			filleds[i].visible = true
			empties[i].visible = false
		else:
			filleds[i].visible = false
			empties[i].visible = true

extends Node

export (String) var trigger_group = ""
export (String) var method_name = "hit"
export (bool) var pass_self = false

var _parent

func _ready():
	_parent = get_parent()
	_parent.connect("body_entered", self, "on_entered")
	_parent.connect("area_entered", self, "on_entered")

func on_entered(other):
	if (trigger_group == "" or other.is_in_group(trigger_group)) and other.has_method(method_name):
		if pass_self:
			other.call(method_name, _parent)
		else:
			other.call(method_name)

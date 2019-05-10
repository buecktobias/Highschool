extends Node

var _screen_shaker = null
var _screen_flasher = null

func _ready():
	pass

func submit_shaker(s):
	_screen_shaker = s
	
func submit_flasher(f):
	_screen_flasher = f

func shake(intensity, duration, damped = false, dir = null):
	_screen_shaker.shake(intensity, duration, damped, dir)

func frame_freeze(duration):
	OS.delay_msec(duration*1000)

func flash(col, in_time, duration, out_time):
	_screen_flasher.flash(col, in_time, duration, out_time)

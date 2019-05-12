extends Node

var _dict = {}
var _loc = {}
var _loaded = false
export (String) var saveName = "SaveGame" setget set_saveName

func set_saveName(sn):
	_dict = {}
	_loaded = false
	saveName = sn


func _ready():
	pass

func get(key):
	_assertLoaded()
	return _dict[key]

func set(key, value):
	_assertLoaded()
	_dict[key] = value
	_save()

func is_set(key):
	_assertLoaded()
	return _dict.has(key)

func session_get(key):
	#_assertLoaded()
	return _loc[key]

func session_set(key, value):
	#_assertLoaded()
	_loc[key] = value
	_save()

func session_is_set(key):
	#_assertLoaded()
	return _loc.has(key)

func _assertLoaded():
	if not _loaded:
		_load()
		_loaded = true

func _save():
	var f = File.new()
	f.open(_getFileName(), File.WRITE)
	f.store_line(JSON.print(_dict))
	f.close()

func _load():
	var f = File.new()
	if not f.file_exists(_getFileName()):
		return
	f.open(_getFileName(), File.READ)
	var s = f.get_line()
	_dict = JSON.parse(s).result
	f.close()

func _getFileName():
	return "user://" + saveName + ".dat"
	

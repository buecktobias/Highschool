extends AudioStreamPlayer

export (AudioStreamSample) var sample0
export (AudioStreamSample) var sample1
export (AudioStreamSample) var sample2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	match randi()%3:
		0: stream = sample0
		1: stream = sample1
		2: stream = sample2
	play()
	$Timer.wait_time = rand_range(1, 4)
	$Timer.start()

extends ParallaxBackground

export (NodePath) var camera_path

var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node(camera_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset.y = 880*floor(camera.position.y/8800)

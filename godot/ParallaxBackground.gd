extends ParallaxBackground

export (NodePath) var camera_path

var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node(camera_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if camera_path:
		$SkyLayer.motion_offset.y = 778.81*(floor(camera.position.y/778.81*$SkyLayer.motion_scale.y)+.5)
		$WallsLayer.motion_offset.y = 778.81*(floor(camera.position.y/778.81*$WallsLayer.motion_scale.y)+.5)

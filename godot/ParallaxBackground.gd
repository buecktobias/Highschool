extends ParallaxBackground

export (NodePath) var camera_path

var camera

func prepare_scale_camera():
	scale = get_parent().scale
	offset.x = get_viewport().size.x*(1-scale.x)/2
	offset.y = get_viewport().size.y*(1-scale.y)/2

func prepare_scale_no_camera():
	scale = Vector2(1, 1)
	offset.x = float(get_viewport().size.x - 600)/2 + 300
	offset.y = float(get_viewport().size.y - 800)/2 + 400
	scale = get_parent().scale

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node(camera_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if camera_path:
		$SkyLayer.motion_offset.y = 778.81*(floor(camera.position.y/778.81*$SkyLayer.motion_scale.y*scale.y)+.5)
		$WallsLayer.motion_offset.y = 778.81*(floor(camera.position.y/778.81*$WallsLayer.motion_scale.y*scale.y)+.5)

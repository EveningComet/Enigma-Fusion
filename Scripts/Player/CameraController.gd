## Controls the camera for a player.
class_name CameraController extends SpringArm3D

## The current thing this camera should be focused on.
var target: Node3D

var mouse_sensitivity:      float = 0.1 # TODO: Clamp this between 0.1 and 1. Also, make this a global setting.
var controller_sensitivity: float = 2.5 # TODO: Make this a global setting.

# The minimum and maximum allowed tilt for this camera
var min_pitch: float = -75.0
var max_pitch: float = 75.0

var wrap_0:   float = 0.0
var wrap_max: float = 360.0

func _ready() -> void:
	set_as_top_level(true)
	target = get_parent()
	add_excluded_object(get_parent())

func _process(delta: float) -> void:
	move_camera( delta )

func move_camera(delta: float) -> void:
	var target_pos: Vector3 = target.global_position + Vector3(0, 7, 5)
	global_position = target_pos

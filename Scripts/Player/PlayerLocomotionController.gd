## Manages the player's movement.
class_name PlayerLocomotionController extends StateMachine

@export var camera_controller: CameraController

## The parent character body that will be controlled.
var cb: CharacterBody3D

func set_me_up() -> void:
	cb = get_parent()
	super()

func _physics_process(delta: float) -> void:
	curr_state.physics_update( delta )

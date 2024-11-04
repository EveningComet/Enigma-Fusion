## Manages the player's movement.
class_name PlayerLocomotionController extends StateMachine

@export var camera_controller: CameraController
@export var input_controller:  PlayerInputController
@onready var skin_handler: SkinHandler = get_parent().get_node("SkinHandler")

## The parent character body that will be controlled.
@onready var cb: CharacterBody3D = get_parent()

func set_me_up() -> void:
	super()

func _physics_process(delta: float) -> void:
	curr_state.physics_update( delta )

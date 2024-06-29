## Handles the movement for characters. Doesn't really do anything on its own.
class_name LocomotionController extends StateMachine
# TODO: Convert this to a proper state machine.

var cb: CharacterBody3D

func _ready() -> void:
	cb = get_parent()

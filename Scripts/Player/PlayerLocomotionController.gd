## Class responsible for controlling the player's movement.
class_name PlayerLocomotionController extends StateMachine

var cb: CharacterBody3D

func set_me_up() -> void:
	cb = get_parent()
	super()
	

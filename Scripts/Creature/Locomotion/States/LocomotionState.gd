## A base class for a state that handles movement for a character.
class_name LocomotionState extends State

## Every state needs to check for movement in some way.
var cb: CharacterBody3D

# Air, Speed, & Friction
@export var move_speed:      float = 10   # How fast this state moves
@export var ground_accel:    float = 60.0
@export var ground_friction: float = 50.0
@export var air_accel:       float = 20.0
@export var air_friction:    float = 20.0
@export var rot_speed:       float = 10.0 # How fast we rotate

# Every state needs to keep track of their movement vector and input
var velocity:  Vector3 = Vector3.ZERO

## Handle our animations.
var animation_tree: AnimationTree 

func setup_state(new_sm: LocomotionController) -> void:
	super(new_sm)
	cb             = new_sm.cb

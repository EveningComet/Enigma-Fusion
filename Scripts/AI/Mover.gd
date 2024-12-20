## Component used to help AI with movement.
class_name Mover extends Node

@export_category("Movement Control Variables")
## How fast to move in this state. (Has nothing to do with stats.)
@export var move_speed: float = 10.0
## How fast it takes the character to get to their top speed.
@export var accel:      float = 60.0
## When not moving, this will help make the character stop moving.
@export var friction:   float = 50.0
@export var rot_speed:  float = 10.0

@export_category("Jump & Gravity")
@export var max_jump_height:   float = 3   # How high we can jump
@export var min_jump_height:   float = 1   # How low we can jump
@export var time_to_jump_apex: float = 0.4 # How long, in seconds, it takes us to reach the height of our jump
var _max_jump_velocity: float = 0
var _min_jump_velocity: float = 0
var _gravity:           float = 9.8

var _target_velocity: Vector3 = Vector3.ZERO
var _new_velocity:    Vector3 = Vector3.ZERO
var _last_dir: Vector3 = Vector3.ZERO

@onready var _skin_handler: SkinHandler     = get_parent().get_node("SkinHandler")
@onready var _cb:           CharacterBody3D = get_parent()
@onready var nav_agent:     NavigationAgent3D = get_parent().get_node("NavigationAgent3D")

func _ready() -> void:
	# Initialize the _gravity
	_gravity = (2 * max_jump_height) / (time_to_jump_apex * time_to_jump_apex)
	_max_jump_velocity = sqrt(2 * _gravity * max_jump_height)
	_min_jump_velocity = sqrt(2 * _gravity * min_jump_height)
	
	nav_agent.velocity_computed.connect( _on_velocity_computed )

## Responsible for animating the character.
func _handle_animations(delta: float) -> void:
	if _cb.is_on_floor() == true:
		_skin_handler.animation_tree["parameters/locomotion/playback"].travel("movement")
		var modified_dir = _target_velocity * _cb.transform.basis
		_skin_handler.animation_tree.set(
			"parameters/locomotion/movement/blend_position",
			Vector2(modified_dir.x, -modified_dir.z) / move_speed
		)
	
	if _cb.is_on_floor() == false:
		_skin_handler.animation_tree["parameters/locomotion/playback"].travel("falling")

func set_target_position(pos: Vector3) -> void:
	nav_agent.set_target_position(pos)

func _physics_process(delta: float) -> void:	
	if nav_agent.is_navigation_finished() == true:
		_new_velocity = Vector3.ZERO
	else:
		var next_path_position: Vector3 = nav_agent.get_next_path_position()
		_new_velocity = _cb.global_position.direction_to(next_path_position)
		_last_dir     = _new_velocity
	
	_apply_acceleration(delta)
	_apply_friction(delta)
	_handle_animations(delta)
	_target_velocity.y -= _gravity * delta	
	if _cb.is_on_floor() == true:
		_target_velocity.y = 0.0
	
	orient_to_direction(-_last_dir, delta)
	_on_velocity_computed(_target_velocity)

## Used to make the character face the direction.
func orient_to_direction(desired_dir: Vector3, delta: float) -> void:
	var left_axis      = Vector3.UP.cross(desired_dir)
	var rotation_basis = Basis(left_axis, Vector3.UP, desired_dir).get_rotation_quaternion()
	var q_from         = _cb.transform.basis.get_rotation_quaternion()
	_cb.basis          = Basis(q_from.slerp(rotation_basis, rot_speed * delta))
	
	# Prevent weird stuff from happening
	_cb.transform.basis = _cb.transform.basis.orthonormalized()

## Applies the movement with smoothing.
func _apply_acceleration(delta: float) -> void:
	if _new_velocity != Vector3.ZERO:
		_target_velocity.x = _target_velocity.move_toward(_new_velocity * move_speed, accel * delta).x
		_target_velocity.z = _target_velocity.move_toward(_new_velocity * move_speed, accel * delta).z

## Makes the stopping smooth.
func _apply_friction(delta: float) -> void:
	if _new_velocity == Vector3.ZERO:
		_target_velocity.x = _target_velocity.move_toward(Vector3.ZERO, friction * delta).x
		_target_velocity.z = _target_velocity.move_toward(Vector3.ZERO, friction * delta).z

func _on_velocity_computed(safe_velocity: Vector3) -> void:
	_cb.set_velocity(safe_velocity)
	_cb.move_and_slide()

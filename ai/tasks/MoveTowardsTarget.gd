## BT task that tells a character to move towards someone.
extends BTAction

## How close to a target desitination before stopping.
@export var target_destination_distance: float = 3.0
@export var target_var: StringName = &"target"
var velocity: Vector3 = Vector3.ZERO

var _max_distance_squared: float

func _setup() -> void:
	_max_distance_squared = target_destination_distance * target_destination_distance

func _tick(delta: float) -> Status:
	
	# TODO: if target_destination_distance reached, return SUCCESS
	var target = blackboard.get_var(target_var)
	var direction: Vector3 = agent.get_parent().global_position.direction_to(target.global_position)
	
	var dist_sqr = agent.get_parent().global_position.distance_squared_to( target.global_position )
	agent.mover.orient_to_direction(-direction, delta)
	if dist_sqr > _max_distance_squared:
		velocity = direction
		agent.mover.set_input(velocity)
	else:
		velocity = Vector3.ZERO
		agent.mover.set_input(velocity)
	
	return RUNNING

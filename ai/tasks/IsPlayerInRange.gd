## Behavior tree task that keeps track of how far away the player is. Mainly used
## by party members to make them follow the player.
extends BTAction

## If the player is further away than this distance, then stop everything
## and get closer to them.
@export var max_allowed_distance: float = 20.0

var target_var: StringName = &"target"

var _max_distance_squared: float

func _setup() -> void:
	_max_distance_squared = max_allowed_distance * max_allowed_distance

func _tick(delta: float) -> Status:
	# TODO: Better way of getting the player.
	var player = agent.get_parent().owner.get_node("Player")
	if player != null:
		
		var dist_sqr = agent.get_parent().global_position.distance_squared_to(
			player.global_position
		)
		if dist_sqr <= _max_distance_squared:
			blackboard.set_var(target_var, player)
			return SUCCESS
	
	return FAILURE

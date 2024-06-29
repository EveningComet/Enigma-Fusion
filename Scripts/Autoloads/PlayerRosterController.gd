## Keeps track of the player's party and the currently benched allies.
extends Node

## Including the player character, this is how many characters that can be
## actively fighting at one time.
const MAX_ACTIVE_TEAM_SIZE: int = 6

## Including the player's current active party, how many characters can the
## player have at once?
var max_roster_size: int = 6

# TODO: Data type for the array.
var active_party: Array = []
var reserves: Array     = []

func add_to_active_party() -> void:
	pass

func remove_from_active_party() -> void:
	pass

func delete() -> void:
	pass

## Give the player and their team experience points.
func give_experience_points(amt: int) ->  void:
	pass

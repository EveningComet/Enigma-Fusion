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
var roster: Array     = []

func add_to_roster(character) -> void:
	# Do not add characters that already exist within the roster
	if roster.has(character) == true:
		return
		
	roster.append(character)
	if active_party.size() < MAX_ACTIVE_TEAM_SIZE:
		add_to_active_party(character)

func add_to_active_party(character_to_add) -> void:
	active_party.append(character_to_add)
	Eventbus.active_party_changed.emit( active_party )

func remove_from_active_party(character_to_remove) -> void:
	active_party.erase(character_to_remove)
	Eventbus.active_party_changed.emit(active_party)

func delete() -> void:
	pass

func contains_character(character_to_check) -> bool:
	# TODO: Proper data types.
	if roster.has(character_to_check):
		return true
	return false

## Give the player and their team experience points.
func give_experience_points(amt: int) ->  void:
	for pm in roster:
		pass

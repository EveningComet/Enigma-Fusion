## A character that can take damage and die in the game world. This class stores
## a collection of components that will be needed by such a character.
class_name Combatant extends Node

## Fired whenever a stat changes on this character and something needs to
## know about it.
signal stat_changed(com: Combatant)

## The stats component for a character.
@export var stats: Stats = Stats.new(self)

## Stores the instanced data related to a creature.
@export var instance_data: CreatureInstance

func take_damage(damage_data: int) -> void:
	# TODO: Damage data should be more than just an int.
	stats.take_damage(damage_data)
	if OS.is_debug_build() == true:
		var p_name: String = get_parent().name
		print("Combatant :: %s is taking damage." % [p_name])

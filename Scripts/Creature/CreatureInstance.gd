## Stores an instance of data that will be needed by a creature.
class_name CreatureInstance extends Node

@export var blueprint: CreatureBlueprint

func initialize(
	base_bp:  CreatureBlueprint,
	parent_a: CreatureBlueprint = null,
	parent_b: CreatureBlueprint = null) -> void:
		# Stat growth = base creature bp + floor( (parent_a_stat + parent_b_stat) / 2)
		
		pass

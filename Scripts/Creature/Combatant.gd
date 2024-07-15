## A character that can take damage and die in the game world.
class_name Combatant extends Node

@export var stats: Stats

func take_damage() -> void:
	if OS.is_debug_build() == true:
		var p_name: String = get_parent().name
		print("Combatant :: %s is taking damage." % [p_name])

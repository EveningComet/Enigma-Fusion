## Component that descibes the owner of something.
class_name FactionOwner extends Node

enum Factions
{
	Player,
	Enemy
}

@export var faction: Factions

func copy_faction(f_owner: FactionOwner) -> void:
	faction = f_owner.faction

func set_as_player() -> void:
	faction = Factions.Player

func is_same_faction(f_owner: FactionOwner) -> bool:
	return faction == f_owner.faction

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

func is_player_owned() -> bool:
	return faction == Factions.Player

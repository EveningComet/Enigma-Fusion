## Handles how and when the player interacts with hostile NPCs.
class_name HostileTalkResolver extends Node

func _ready() -> void:
	Eventbus.begin_conversation_with_enemy.connect( on_begin_conversation )

func on_begin_conversation(target) -> void:
	if target.has_node("Combatant") == false:
		return
	
	PlayerRosterController.add_to_roster(target)

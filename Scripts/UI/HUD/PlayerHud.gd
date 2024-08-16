## Displays the vitals of the player's current party.
class_name PlayerHud extends Control

## The node that houses the player character.
@export var player_node: Node3D

@export var skill_bar: SkillBar

@export var party_member_slot_prefab: PackedScene

## Stores the visuals of the displayed party.
@export var party_container: Container

@export var hostile_talk_slot: HostileTalkSlot

func _ready() -> void:
	Eventbus.active_party_changed.connect( on_active_party_changed )
	var hostile_talk_handler = player_node.get_node("PlayerHostileTalkHandler")
	hostile_talk_slot.set_player_hostile_talk_handler(
		hostile_talk_handler
	)
	
	# Set up the skillbar
	skill_bar.set_player_skills(player_node.get_node("PlayerSkillHandler"))

func on_active_party_changed(curr_party: Array) -> void:
	# Clean out the old slots
	for slot in party_container.get_children():
		slot.queue_free()
		
	# Create a slot for each party member
	for pm in curr_party:
		var pmui_slot: PartyMemberUISlot = party_member_slot_prefab.instantiate()
		var combatant: Combatant = pm
		pmui_slot.curr_char = combatant
		party_container.add_child(pmui_slot)

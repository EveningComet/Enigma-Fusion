## Displays the vitals of the player's current party.
class_name PlayerHud extends Control

## The node that houses the player character.
@export var player_node: Node3D

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

func on_active_party_changed(curr_party: Array) -> void:
	if OS.is_debug_build() == true:
		print("PlayerHud :: Active party changed!")
	
	# Create a slot for each party member
	for pm in curr_party:
		var pmui_slot: PartyMemberUISlot = party_member_slot_prefab.instantiate()
		pmui_slot.char_name_label.set_text( pm.name )
		party_container.add_child(pmui_slot)

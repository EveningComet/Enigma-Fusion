## Handles how and when the player interacts with hostile NPCs.
class_name HostileTalkResolver extends Node

## Prefab of the object that will keep track of all objects within our radius
@export var time_stop_area_prefab: PackedScene
var curr_time_stop_area: Area3D = null

## The enemy the player is currently trying to add to their team.
var curr_target

func _ready() -> void:
	Eventbus.begin_conversation_with_enemy.connect( on_begin_conversation )

func on_begin_conversation(target) -> void:
	if target.has_node("Combatant") == false:
		return
	
	curr_target = target
	
	# Spawn the time stop collider and have it freeze things
	curr_time_stop_area = time_stop_area_prefab.instantiate() as TimeStopArea
	curr_time_stop_area.set_as_top_level(true)
	get_parent().add_child(curr_time_stop_area)
	curr_time_stop_area.global_position = target.global_position
	curr_time_stop_area.monitoring = true
	
	# Start the conversation
	# TODO: Change what node is used here.
	if curr_target.has_node("Combatant") == true:
		Dialogic.signal_event.connect(on_enemy_conversation_ended)
		Dialogic.start(curr_target.get_node("Combatant").instance_data.base_blueprint.sequence)
		Dialogic.timeline_ended.connect( on_dialogic_dialogue_ended )
		Globals.is_movement_disabled = true

func on_dialogic_dialogue_ended() -> void:
	# Clean up
	Dialogic.signal_event.disconnect( on_enemy_conversation_ended )
	Dialogic.timeline_ended.disconnect( on_dialogic_dialogue_ended )
	curr_time_stop_area.queue_free()
	curr_time_stop_area = null
	curr_target = null
	
	# Wait a tiny bit to prevent jumping
	# TODO: Wait for a physics frame instead?
	await get_tree().create_timer(0.1, false, true).timeout
	Globals.is_movement_disabled = false

func on_enemy_conversation_ended(argument: String) -> void:
	if argument.to_lower().contains("success") == true:
		PlayerRosterController.add_to_roster(curr_target.get_node("Combatant"))

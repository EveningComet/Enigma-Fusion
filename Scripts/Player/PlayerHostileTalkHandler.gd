## Used to handle talking with hostile NPCs.
class_name PlayerHostileTalkHandler extends Node

signal player_pressed_hostile_talk_button()

@export var cooldown_timer: Timer

## How long, in seconds, before the player can talk to another enemy.
@export var cooldown_time:  float = 30.0

@export var interaction_radius: Area3D

func _ready() -> void:
	cooldown_timer.start(0)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("talk") and cooldown_timer.is_stopped() == true:
		player_pressed_hostile_talk_button.emit()
		cooldown_timer.start(cooldown_time)
		
		# TODO: Have the player aim for the enemy they want to talk to.
		# Find the nearest character to talk to
		var potential_targets: Array = interaction_radius.get_overlapping_bodies()
		potential_targets.erase(get_parent())
		for e in potential_targets:
			if e.name == "Test Enemy":
				PlayerRosterController.add_to_roster(e)
		

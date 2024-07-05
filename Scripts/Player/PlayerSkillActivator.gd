## Middleman for activating the player's skills.
class_name PlayerSkillActivator extends Node

## The object storing the skills.
@export var skill_handler: SkillHandler

func _ready() -> void:
	# TODO: Find a cleaner way to do this.
	await get_tree().process_frame
	PlayerRosterController.add_to_roster(get_parent())

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		pass
	
	if Input.is_action_just_pressed("skill_action_3"):
		pass
	
	if InputEventJoypadButton:
		if Input.is_action_pressed("use_extra_skills") and Input.is_action_just_pressed("skill_action_3"):
			pass
	
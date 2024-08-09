## Modified skill handler component to keep track of the player's skills, and
## allows the player to use their activatable skills.
class_name PlayerSkillHandler extends SkillHandler

@export var camera_controller: CameraController

func _ready() -> void:
	super()
	#TODO: Find a cleaner way to do this.
	await get_tree().physics_frame
	PlayerRosterController.add_to_roster(get_parent())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use_skill_slot_1"):
		activate_skill(0)

## Get the aiming direction for the player.
func get_aim_dir() -> Vector3:
	return camera_controller.aim_cast.global_transform * camera_controller.aim_cast.target_position

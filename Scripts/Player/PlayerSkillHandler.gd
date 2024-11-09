## Modified skill handler component to keep track of the player's skills, and
## allows the player to use their activatable skills.
class_name PlayerSkillHandler extends SkillHandler

@export var camera_controller: CameraController

@onready var _input_controller: PlayerInputController = get_parent().get_node("PlayerInputController")

func _ready() -> void:
	super()
	_input_controller.use_skill_slot.connect( _on_use_skill )
	
	#TODO: Find a cleaner way to do this.
	await get_tree().physics_frame
	PlayerRosterController.add_to_roster(get_parent().get_node("Combatant"))

## Get the aiming direction for the player.
func get_aim_dir() -> Vector3:
	return camera_controller.aim_cast.global_transform * camera_controller.aim_cast.target_position

func _on_use_skill(index: int) -> void:
	#  Create a targeting data object with all the needed information
	if index < active_skills.size():
		var targeting_data: TargetingData = TargetingData.new()
		targeting_data.activator  = get_parent()
		targeting_data.origin     = get_parent().global_position
		targeting_data.target_v   = get_aim_dir()
		execute_skill(active_skills[index], targeting_data)

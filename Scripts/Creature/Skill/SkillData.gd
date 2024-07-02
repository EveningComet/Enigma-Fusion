## Stores data related to skills.
class_name SkillData extends Resource

@export_category("Base Info")
@export var localization_name: String = "New Skill"
@export_multiline var localization_description: String = "New description."

@export_category("Definitions")
## Can this skill be activated?
@export var is_passive: bool = false

## How long, in seconds, before this skill can be used again?
@export var base_cooldown: float = 1.0

## How much does it cost to perform this skill?
@export var base_cost: int = 5

## How long, in seconds, before the activator is allowed to attack or use
## another skill.
@export var execution_time: float = 0.0

## Collection of components that define what a skill does.
@export var effects: Array[SkillEffect] = []

## Perform this action.
func execute(activator, targets) -> void:
	for e: SkillEffect in effects:
		pass

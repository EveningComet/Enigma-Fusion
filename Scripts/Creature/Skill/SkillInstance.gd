## Stores an instance of a skill.
class_name SkillInstance extends Resource

var skill: SkillData

var curr_cooldown: float = 0.0

func _init(skill_to_instance: SkillData) -> void:
	skill = skill_to_instance

func tick(delta: float) -> void:
	curr_cooldown -= delta
	curr_cooldown = clamp(curr_cooldown, 0.0, skill.base_cooldown)

func is_cooldown_finished() -> bool:
	return curr_cooldown <= 0.0

func reset() -> void:
	curr_cooldown = skill.base_cooldown

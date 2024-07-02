## Stores a collection of monitored_skills for a character.
class_name SkillHandler extends Node

signal skill_executed(skill: SkillInstance)

@export var skills_to_instance: Array[SkillData]

## Houses the current, active skills on a character.
var monitored_skills: Array[SkillInstance]

func _ready() -> void:
	for sd: SkillData in skills_to_instance:
		var si: SkillInstance = SkillInstance.new(sd)
		monitored_skills.append(si)

func _physics_process(delta: float) -> void:
	handle_cooldowns(delta)

func handle_cooldowns(delta: float) -> void:
	for si: SkillInstance in monitored_skills:
		if si.skill.is_passive == false:
			si.tick(delta)

func activate_skill(s_to_activate: SkillInstance) -> void:
	skill_executed.emit(s_to_activate)
	s_to_activate.reset()
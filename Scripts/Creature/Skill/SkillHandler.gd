## Stores the skills for a character.
class_name SkillHandler extends Node

## The skills the player currently has on their character.
@export var curr_skills: Array[SkillInstance] = []

## The skills in the player's current activatable skills.
@export var active_skills: Array[SkillInstance] = []

## Used as a quick way to get a character's stats.
@onready var combatant: Combatant = get_parent().get_node("Combatant")

func _ready() -> void:
	# Create empty slots to allow for swapping and the like
	var copy_of_active_skills: Array[SkillInstance] = []
	copy_of_active_skills.append_array(active_skills)
	active_skills.clear()
	for i in Utils.MAX_ACTIVE_SKILLS:
		active_skills.append( null )
	for i in range(copy_of_active_skills.size()):
		active_skills.insert(i, copy_of_active_skills[i])

func _physics_process(delta: float) -> void:
	_tick_cooldowns( delta )

func _tick_cooldowns(delta: float) -> void:
	for s in active_skills:
		if s != null:
			s.tick(delta)
			
func execute_skill(skill: SkillInstance, targeting_data: TargetingData) -> void:
	if skill.is_cooldown_finished() == true and \
	combatant.stats.get_curr_sp() >= skill.skill.base_cost:
		skill.execute(targeting_data)

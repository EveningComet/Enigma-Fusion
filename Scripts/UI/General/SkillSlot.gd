## Stores a skill at a given time.
class_name SkillSlot extends PanelContainer

@export var curr_skill: SkillData:
	get: return curr_skill
	set(value):
		curr_skill = value

@export var display_icon: TextureRect

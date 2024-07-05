## Defines what a skill does.
class_name SkillEffect extends Resource

## The base output of this effect. Some effects will not need this.
@export var power_scale: float = 1.0

@export var use_special_stat: bool = false

func get_facing_dir(dir: Vector3):
	pass

func get_power(com: Combatant) -> float:
	return 0.0

## Have the particular skill effect do its thing.
func execute(activator, targets) -> void:
	pass

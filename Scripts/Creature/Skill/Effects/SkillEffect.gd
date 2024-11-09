## A component that defines how a skill works.
class_name SkillEffect extends Resource

@export_category("Base Info")
## Based on the stat being scaled, how much damage, healing, etc. to perform.
@export var power_scale: float = 1.0

## What stat does this use? Used as an enum to allow for 
@export var stat_used: StatHelper.StatTypes = StatHelper.StatTypes.PhysicalPower

# Not all effects will deal damage, but this needs to be in the base class for
# convenience
@export_category("Damage Data")
## Dictates what type of damage this skill does.
@export var damage_type: StatHelper.DamageTypes = StatHelper.DamageTypes.Base

## If the target has at least one debuff applied to them, how much extra damage
## should be applied?
@export var bonus_damage_scale_on_debuffs_present: float = 0.0

## Scales the percentage of damage that should be healed for the attacker.
@export_range(0.0, 1.0) var attacker_heal_percentage: float = 0.0

func execute(targeting_data: TargetingData) -> void:
	pass

## Get the power output using a character's stats.
func get_power(activator: Stats):
	match stat_used:
		# Edge case to prevent hp and sp from being used in calculations
		StatHelper.StatTypes.CurrentHP, StatHelper.StatTypes.CurrentSP:
			return 1
		
		StatHelper.StatTypes.PhysicalPower:
			return _get_physical_power(activator)
		
		StatHelper.StatTypes.SpecialPower:
			return _get_special_power(activator)
		
		# TODO: Return a calculated value depending on the stat.
		_:
			return 1

func _get_physical_power(activator: Stats) -> int:
	return floor( activator.get_physical_power() * power_scale )

func _get_special_power(activator: Stats) -> int:
	return floor( activator.get_special_power() * power_scale )

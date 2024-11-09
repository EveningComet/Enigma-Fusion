## Skill effect that spawns a projectile.
class_name SESpawnProjectile extends SkillEffect

## The projectile this skill will spawn.
@export var projectile_prefab: PackedScene

func execute(targeting_data: TargetingData) -> void:
	var projectile: Projectile = projectile_prefab.instantiate()
	
	var stats: Stats = targeting_data.activator.get_node("Combatant").stats
	var damage_data: DamageData        = DamageData.new()
	damage_data.damage_type            = damage_type
	damage_data.activator              = stats
	damage_data.damage_amount          = get_power(stats)
	damage_data.base_power_scale       = power_scale
	damage_data.damage_heal_percentage = attacker_heal_percentage
	
	projectile.initialize(
		(targeting_data.target_v - targeting_data.origin).normalized(),
		damage_data,
		targeting_data.activator.get_node("FactionOwner"),
	)
	
	targeting_data.activator.owner.add_child(projectile)
	projectile.global_position = targeting_data.origin
	projectile.add_collision_exception_with(targeting_data.activator)
	
	projectile.look_at(targeting_data.activator.global_transform.origin + targeting_data.target_v + Vector3.UP, Vector3.UP)

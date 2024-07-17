## Skill effect that spawns a projectile.
class_name SpawnProjectile extends SkillEffect

## The projectile this skill will spawn.
@export var projectile_prefab: PackedScene

func execute(activator, targets) -> void:
	var projectile: Projectile = projectile_prefab.instantiate()
	activator.get_parent().add_child(projectile)
	
	# TODO: Proper spawning of projectile location and handling of direction.
	# e.g: spawn at the fire point of a gun.
	projectile.global_position = activator.global_position + Vector3.UP
	projectile.set_shooter(activator)
	var direction: Vector3 = -activator.global_transform.basis.z
	projectile.set_direction(-activator.global_transform.basis.z)
	projectile.look_at(activator.global_transform.origin + Vector3.UP + direction, Vector3.UP)

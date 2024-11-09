## An object that moves and can damage characters.
class_name Projectile extends CharacterBody3D

@export var move_speed: float = 15.5

## How long, in seconds, before this object should destroy itself?
@export var max_lifetime: float = 10.0
var _curr_lifetime:       float = 0.0

var _direction: Vector3 = Vector3.ZERO

var damage_data: DamageData

@export var faction_owner: FactionOwner

func _ready() -> void:
	set_as_top_level(true)

func _physics_process(delta: float) -> void:
	
	velocity = _direction * delta * move_speed
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider()
		if collider:
			
			if collider.has_node("Combatant"):
				var com: Combatant        = collider.get_node("Combatant")
				var f_owner: FactionOwner = collider.get_node("FactionOwner")
				if faction_owner.is_same_faction(f_owner) == false:
					com.take_damage(damage_data)
			
			# Destroy the projectile
			queue_free()
	
	# Tick and delete when enough time has passed
	_curr_lifetime += delta
	if _curr_lifetime >= max_lifetime:
		queue_free()

func initialize(dir: Vector3, dd: DamageData, f_owner: FactionOwner) -> void:
	_direction = dir
	damage_data = dd
	faction_owner.copy_faction(f_owner)

## What to do when this projectile collides with something?
func on_hit() -> void:
	pass

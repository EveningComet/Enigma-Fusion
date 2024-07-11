## When colliding with an enemy, and they are able to talk, this will enter the
## talking state for the player.
class_name HostileTalkStarter extends Area3D

@export var speed: float = 10.0

## How long this exists before destroying itself.
@export var max_lifetime: float = 3.0
var curr_lifetime: float = 0.0

var velocity: Vector3 = Vector3.ZERO

func _ready() -> void:
	set_as_top_level(true)
	body_entered.connect( on_body_entered )
	
func _physics_process(delta: float) -> void:
	global_position += velocity * speed * delta
	curr_lifetime += delta
	if curr_lifetime >= max_lifetime:
		queue_free()

func set_direction(dir: Vector3) -> void:
	velocity = dir

func on_body_entered(body) -> void:
	if body.has_node("Combatant"):
		var combatant: Combatant = body.get_node("Combatant")
		if PlayerRosterController.contains_character(body) == false:
			
			# Collided with an enemy the player can talk to, fire the event
			Eventbus.begin_conversation_with_enemy.emit(body)
		
		# Pass through characters that already belong to the player
		else:
			return
	
	# Destroy after collision
	queue_free()

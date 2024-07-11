## Used to stop characters from moving when the player is talking to enemies.
class_name TimeStopArea extends Area3D

var targets: Array[Node3D]

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect( on_body_entered )
	body_exited.connect( on_body_exited )

func on_body_entered(body) -> void:
	targets.append(body)
	print("TimeStopArea :: Body ", body.name, " entered.")
	if body.has_node("Rotator"):
		body.get_node("Rotator").set_physics_process(false)

func on_body_exited(body) -> void:
	targets.erase(body)
	if body.has_node("Rotator"):
		body.get_node("Rotator").set_physics_process(true)

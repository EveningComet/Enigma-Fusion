## An area object that waits for the player to enter, and press the interact
## button
class_name ContextArea extends Area3D

signal player_interacted()

func _ready() -> void:
	body_entered.connect( on_body_entered )
	body_exited.connect(  on_body_exited )

func on_body_entered(body) -> void:
	# We can tell the player entered
	if body.has_node("PlayerInputController"):
		pass

func on_body_exited(body) -> void:
	# We can tell the player left
	if body.has_node("PlayerInputController"):
		pass

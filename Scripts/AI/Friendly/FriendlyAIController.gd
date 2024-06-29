## Controls how a friendly AI is allowed to operate.
class_name FriendlyAIController extends StateMachine

## How far away the AI is allowed to be from the currently controlled player
## before they must stop everything they're doing.
@export var max_distance_from_player: float = 35.0

func begin_conversation() -> void:
	pass

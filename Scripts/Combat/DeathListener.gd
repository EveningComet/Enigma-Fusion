## Responsible for keeping track of characters dying.
class_name DeathListener extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Eventbus.hp_depleted.connect( on_combatant_dying )

func on_combatant_dying(com: Combatant) -> void:
	# TODO: Testing.
	com.get_parent().queue_free()
	if OS.is_debug_build() == true:
		print("DeathListener :: %s is dying." % [com.get_parent().name])

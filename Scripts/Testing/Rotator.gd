class_name Rotator extends Node


@export var speed: float = 2.5

func _physics_process(delta: float) -> void:
	var parent = get_parent()
	parent.rotation.y += speed * delta
	parent.rotation.y = wrapf(parent.rotation.y, 0.0, 360.0)

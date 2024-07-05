## Used to handle talking with hostile NPCs.
class_name PlayerHostileTalkHandler extends Node

## Used to display the cooldown to the player.
signal player_pressed_hostile_talk_button()

@export var camera_controller: CameraController

@export var cooldown_timer: Timer

@export var hostile_talk_starter_prefab: PackedScene

## How long, in seconds, before the player can talk to another enemy.
@export var cooldown_time:  float = 30.0

@export var interaction_radius: Area3D

func _ready() -> void:
	cooldown_timer.start(0)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("talk") and cooldown_timer.is_stopped() == true:
		player_pressed_hostile_talk_button.emit()
		cooldown_timer.start(cooldown_time)
		
		# TODO: Have the player aim for the enemy they want to talk to.
		# Find the nearest character to talk to
		var hostile_talk_starter: HostileTalkStarter = hostile_talk_starter_prefab.instantiate()
		get_parent().add_child(hostile_talk_starter)
		
		# Make the object fly in the direction the camera is looking
		var dir: Vector3 = -camera_controller.global_transform.basis.z
		hostile_talk_starter.set_direction(dir)
		
		

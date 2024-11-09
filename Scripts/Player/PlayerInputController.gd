## Responsible for managing the player's input.
class_name PlayerInputController extends Node

signal use_skill_slot(index: int)

var input_dir: Vector3 = Vector3.ZERO

var jump_pressed:  bool = false
var jump_released: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use_skill_slot_1"):
		use_skill_slot.emit(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Disable input depending on the situation
	if Globals.is_movement_disabled == true:
		input_dir = Vector3.ZERO
		jump_pressed  = false
		jump_released = false
		return
		
	_update_input_dir()
	
	if Input.is_action_just_pressed("interact"):
		pass
	
	jump_pressed  = Input.is_action_just_pressed("jump")
	jump_released = Input.is_action_just_released("jump")

func _update_input_dir() -> void:
	input_dir = Vector3.ZERO
	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	input_dir = input_dir.normalized() if input_dir.length() > 1 else input_dir

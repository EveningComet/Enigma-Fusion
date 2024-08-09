## Shows the player if they're able to talk to a hostile NPC.
class_name HostileTalkSlot extends PanelContainer

@export var progress_bar: ProgressBar
@export var time_display_label: Label

var player_hostile_talk_handler: PlayerHostileTalkHandler

## The cooldown timer belonging to the player's enemy talking handler.
var timer: Timer

func _ready() -> void:
	set_physics_process(false)
	on_timer_timeout()

func set_player_hostile_talk_handler(new_th: PlayerHostileTalkHandler) -> void:
	player_hostile_talk_handler = new_th
	timer = player_hostile_talk_handler.timer
	timer.timeout.connect(on_timer_timeout)
	player_hostile_talk_handler.player_pressed_hostile_talk_button.connect(
		on_hostile_talk_button_pressed
	)

func _physics_process(delta: float) -> void:
	var time_left: float = timer.time_left
	var cooldown: float = player_hostile_talk_handler.cooldown_time
	progress_bar.value = int((timer.time_left / cooldown) * 100)
	time_display_label.set_text( "%3.1f" % timer.time_left )

func on_hostile_talk_button_pressed() -> void:
	time_display_label.show()
	set_physics_process(true)

func on_timer_timeout() -> void:
	set_physics_process(false)
	progress_bar.value = 0.0
	time_display_label.hide()

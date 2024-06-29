## A collection of UI components that display the vitals of a character to
## the player. This can be used to show characters in the active party
## and the reserves.
class_name PartyMemberUISlot extends PanelContainer

## The current character being kept track of.
@export var curr_char: Combatant:
	get: return curr_char
	set(value):
		curr_char = value
		char_name_label.set_text(curr_char.name)

@export var char_name_label: Label

# TODO: Reformat the bars to a reusable UI component.
@export var hp_bar: ProgressBar
@export var sp_bar: ProgressBar
@export var xp_bar: ProgressBar

func on_stat_changed() -> void:
	# Update the bar if the health, special points, or experience changed
	curr_char

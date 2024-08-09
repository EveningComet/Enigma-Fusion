## A collection of UI components that display the vitals of a character to
## the player. This can be used to show characters in the active party
## and the reserves.
class_name PartyMemberUISlot extends PanelContainer

## The current character being kept track of.
@export var curr_char: Combatant:
	get: return curr_char
	set(value):
		if curr_char != null:
			curr_char.stat_changed.disconnect( on_stat_changed )
		
		if value != null:
			curr_char = value
			char_name_label.set_text(curr_char.get_parent().name)
			curr_char.stat_changed.connect( on_stat_changed )
			on_stat_changed(curr_char)

@export var char_name_label: Label

# TODO: Reformat the bars to a reusable UI component.
@export var hp_bar: Vitalbar
@export var sp_bar: Vitalbar
@export var xp_bar: ProgressBar

func on_stat_changed(combatant: Combatant) -> void:
	# Update the bar if the health, special points, or experience changed
	hp_bar.update_display(
		curr_char.stats.get_curr_hp(), curr_char.stats.get_max_hp()
	)
	sp_bar.update_display(
		curr_char.stats.get_curr_sp(), curr_char.stats.get_max_sp()
	)

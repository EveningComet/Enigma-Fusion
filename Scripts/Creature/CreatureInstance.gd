## Stores an instance of data that will be needed by a creature.
class_name CreatureInstance extends Resource

signal experience_gained(growth_data: Array)

## Used to access the base stats and base stat growths for a character.
@export var base_blueprint: CreatureBlueprint

## Caching the character's stats so that it's easy to increase stats on level up.
@export var stats: Stats

## The current name for this creature.
var curr_name: String

# XP Data
var experience_growth_percentage: float = 1.10
var curr_level: int = 1
var curr_xp:    int = 0
var xp_required:     int = get_experience_required(curr_level)
var total_experience_points: int = 0

func set_stats(_stats: Stats) -> void:
	stats = _stats

## Return how much experience is required for this character to level up.
## Calculation is: 100 * (growth_percent^( current level - 1))
func get_experience_required(level: int) -> int:
	return round( 100 * pow(experience_growth_percentage, level - 1) )

## Give this character experience points.
func gain_experience(gain_amount: int) -> void:
	total_experience_points += gain_amount
	curr_xp += gain_amount
	var growth_data: Array = []
	
	# While the experience is high enough, keep leveling up.
	while curr_xp >= xp_required:
		curr_xp -= xp_required
		growth_data.append( [xp_required, xp_required] )
		level_up()
	growth_data.append( [curr_xp, xp_required] )
	
	# Notify anything about the change in experience
	experience_gained.emit( growth_data )

## Boost this character's level.
func level_up() -> void:
	
	# Boost the level and the required experience for the next level
	curr_level += 1
	xp_required = get_experience_required( curr_level )

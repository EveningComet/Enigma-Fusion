## Stores values and helpers for stats.
class_name StatHelper

## When fusing a character, this is what the parent growth stats will
## be divided by.
const STAT_GROWTH_FUSION_SCALER: int = 2

## Used for indexing and accessing certain stats.
enum StatTypes {
	# Attributes
	Vitality,
	Technique,
	Will,
	
	# Vitals
	MaxHP,
	CurrentHP,
	MaxSP,
	CurrentSP,
	
	# Defense / Resistances
	Defense,
	FireRes,
	WaterRes,
	EarthRes,
	AirRes,
	
	# Damage Modifiers
	FireMods,
	WaterMods,
	EarthMods,
	AirMods,
	
	# Other
	CritChance
}

## The different damage types that exist in the game.
enum DamageTypes {
	Regular,
	Fire,
	Water,
	Earth,
	Air,
	Pure
}

## Get the growth rates for a creature and account for fusion.
static func get_attribute_growth_rate(
	base_bp:  CreatureBlueprint,
	parent_a: CreatureBlueprint = null,
	parent_b: CreatureBlueprint = null
):
	pass

## Wrapper to work with/around resistances.
static var damage_to_res_map: Dictionary = {
	DamageTypes.Regular: StatTypes.Defense,
	DamageTypes.Fire:    StatTypes.FireRes,
	DamageTypes.Water:   StatTypes.WaterRes,
	DamageTypes.Earth:   StatTypes.EarthRes,
	DamageTypes.Air:     StatTypes.AirRes
}

## Stores a collection of different stats.
class_name Stats extends Resource

# Scaling values
const VITALITY_HP_SCALER:              int = 3
const VITALITY_DEFENSE_SCALER:         int = 2
const TECHNIQUE_PHYSICAL_POWER_SCALER: int = 2
const WILL_SP_SCALER:                  int = 3
const WILL_SPECIAL_POWER_SCALER:       int = 2

## A key value pair of the stats. {StatType = Stat Object}
var stats: Dictionary = {}

## The attached character.
var combatant: Combatant

func _init(_com: Combatant = null) -> void:
	combatant = _com
	initialize()

## Initialize with filler stats.
func initialize() -> void:
	# Attributes
	stats[StatHelper.StatTypes.Vitality]     = Stat.new(5)
	stats[StatHelper.StatTypes.Technique]    = Stat.new(5)
	stats[StatHelper.StatTypes.Will]         = Stat.new(5)
	
	initialize_vitals()
	initialize_derived_stats()
	#combatant.stat_changed.emit(combatant)

## Initialize the HP and SP.
func initialize_vitals() -> void:
	stats[StatHelper.StatTypes.MaxHP]     = Stat.new(
		stats[StatHelper.StatTypes.Vitality].get_calculated_value() * VITALITY_HP_SCALER
	)
	stats[StatHelper.StatTypes.CurrentHP] = get_max_hp()
	stats[StatHelper.StatTypes.MaxSP]     = Stat.new(
		stats[StatHelper.StatTypes.Will].get_calculated_value() * WILL_SP_SCALER
	)
	stats[StatHelper.StatTypes.CurrentSP] = get_max_sp()

## Initialize the derived stats. These will typically hold the "bonus" values.
func initialize_derived_stats() -> void:
	# Other stats
	stats[StatHelper.StatTypes.Defense]    = Stat.new(0)
	stats[StatHelper.StatTypes.Speed]      = Stat.new(0)
	stats[StatHelper.StatTypes.Perception] = Stat.new(0)
	stats[StatHelper.StatTypes.Evasion] = Stat.new(0)
	stats[StatHelper.StatTypes.CriticalHitChance] = Stat.new(0)
	
	# Initialize the "bonus" powers
	stats[StatHelper.StatTypes.PhysicalPower] = Stat.new(0)
	stats[StatHelper.StatTypes.SpecialPower]  = Stat.new(0)
	stats[StatHelper.StatTypes.HeatMods]      = Stat.new(0)
	stats[StatHelper.StatTypes.ColdMods]      = Stat.new(0)
	stats[StatHelper.StatTypes.ElectricityMods] = Stat.new(0)
	stats[StatHelper.StatTypes.PsychicMods]     = Stat.new(0)
	
	# Initialize the resistances
	for t in StatHelper.damage_to_res_map:
		var stat_type = StatHelper.damage_to_res_map[t]
		stats[stat_type] = Stat.new(0)

func get_max_hp() -> int:
	return round(stats[StatHelper.StatTypes.MaxHP].get_calculated_value())

func get_curr_hp() -> int:
	return stats[StatHelper.StatTypes.CurrentHP]

func get_max_sp() -> int:
	return round(stats[StatHelper.StatTypes.MaxSP].get_calculated_value())
	
func get_curr_sp() -> int:
	return stats[StatHelper.StatTypes.CurrentSP]

## Get the physical power of this character.
func get_physical_power() -> int:
	var technique_value: int = stats[StatHelper.StatTypes.Technique].get_calculated_value()
	var true_physical_power: Stat = Stat.new(
		technique_value * TECHNIQUE_PHYSICAL_POWER_SCALER
	)
	for mod: StatModifier in stats[StatHelper.StatTypes.PhysicalPower].get_modifiers():
		true_physical_power.add_modifier(mod)
	
	return floor( true_physical_power.get_calculated_value() )

## Get the special power of this character.
func get_special_power() -> int:
	var will_value: int = stats[StatHelper.StatTypes.Will].get_calculated_value()
	var true_special_power: Stat = Stat.new(
		will_value * WILL_SPECIAL_POWER_SCALER
	)
	for mod: StatModifier in stats[StatHelper.StatTypes.SpecialPower].get_modifiers():
		true_special_power.add_modifier(mod)
		
	return floor( true_special_power.get_calculated_value() )

## Return a float percentage for damage resistance.
func get_resistance(damage_type: StatHelper.DamageTypes) -> float:
	if StatHelper.damage_to_res_map.has(damage_type) == true:
		return stats[StatHelper.damage_to_res_map[damage_type]].get_calculated_value()
	return 0.0

## Get the "true" defense.
func get_defense() -> int:
	var vitality_stat: int = stats[StatHelper.StatTypes.Vitality].get_calculated_value()
	var true_defense:  Stat = Stat.new(vitality_stat * VITALITY_DEFENSE_SCALER)
	for mod: StatModifier in stats[StatHelper.StatTypes.Defense].get_modifiers():
		true_defense.add_modifier(mod)
	return floor(true_defense.get_calculated_value())

func get_speed() -> int:
	var vitality_value: int = stats[StatHelper.StatTypes.Vitality].get_calculated_value()
	var will_value:     int = stats[StatHelper.StatTypes.Will].get_calculated_value()
	var final_speed: Stat = Stat.new(vitality_value + will_value)
	for mod: StatModifier in stats[StatHelper.StatTypes.Speed].get_modifiers():
		final_speed.add_modifier(mod)
	
	return floor(final_speed.get_calculated_value() / 2.0)

func get_evasion() -> int:
	var vitality_value:  int = stats[StatHelper.StatTypes.Vitality].get_calculated_value()
	var technique_value: int = stats[StatHelper.StatTypes.Technique].get_calculated_value()
	var final_evasion: Stat = Stat.new(
		vitality_value + technique_value
	)
	for mod: StatModifier in stats[StatHelper.StatTypes.Evasion].get_calculated_value():
		final_evasion.add_modifier(mod)
	
	return floor( final_evasion.get_calculated_value() )

## Get this character's chance to hit value.
func get_perception() -> int:
	var technique_value: int = get_calculated_value(StatHelper.StatTypes.Technique)
	var will_value:      int = get_calculated_value(StatHelper.StatTypes.Will)
	var final_perception: Stat = Stat.new(
		technique_value + will_value
	)
	for mod: StatModifier in stats[StatHelper.StatTypes.Perception].get_modifiers():
		final_perception.add_modifier(mod)
	
	return final_perception.get_calculated_value()

## Wrapper/Helper for getting the calculated value for a cached stat.
func get_calculated_value(stat_type: StatHelper.StatTypes) -> float:
	match stat_type:
		# The current hp and sp are not stat objects!
		StatHelper.StatTypes.CurrentSP, StatHelper.StatTypes.CurrentHP:
			return stats[stat_type]
		
		# Everything else is safe to get
		_:
			return stats[stat_type].get_calculated_value()

## Wrapper for permanently increasing the base value of a particular stat.
## Mainly used to raise a character's attributes.
func raise_base_value_by(stat_raising: StatHelper.StatTypes, amt: int) -> void:
	stats[stat_raising].raise_base_value_by(amt)
	update_vitals()
	combatant.stat_changed.emit( combatant )

func add_modifier(stat_type: StatHelper.StatTypes, mod_to_add: StatModifier) -> void:
	stats[stat_type].add_modifier( mod_to_add )
	update_vitals()
	combatant.stat_changed.emit( combatant )

func remove_modifier(stat_type: StatHelper.StatTypes, mod_to_remove: StatModifier) -> void:
	stats[stat_type].remove_modifier( mod_to_remove )
	update_vitals()
	combatant.stat_changed.emit( combatant )

## Used to update the max hp and sp values when the related attributes are raised.
func update_vitals() -> void:
	var true_max_hp: Stat = Stat.new(
		stats[StatHelper.StatTypes.Vitality].get_calculated_value() * VITALITY_HP_SCALER
	)
	var true_max_sp: Stat = Stat.new(
		stats[StatHelper.StatTypes.Will].get_calculated_value() * WILL_SP_SCALER
	)
	
	for hp_mod: StatModifier in stats[StatHelper.StatTypes.MaxHP].get_modifiers():
		true_max_hp.add_modifier(hp_mod)
	for sp_mod: StatModifier in stats[StatHelper.StatTypes.MaxSP].get_modifiers():
		true_max_sp.add_modifier(sp_mod)
		
	# Update the cached stats and the values
	stats[StatHelper.StatTypes.MaxHP] = true_max_hp
	stats[StatHelper.StatTypes.MaxSP] = true_max_sp
	if get_curr_hp() > get_max_hp():
		stats[StatHelper.StatTypes.CurrentHP] = get_max_hp()
	if get_curr_sp() > get_max_sp():
		stats[StatHelper.StatTypes.CurrentSP] = get_max_sp()

func take_damage(dd: DamageData) -> void:
	var amount: int = dd.damage_amount
	var damage_type = dd.damage_type
	
	# Checking if damage needs to be increased based on negative status effects
	#if combatant.status_effect_holder.has_negative_statuses_present() == true:
		#amount = dd.get_debuff_scaled_damage()
	
	# Account for damage types and resistances.
	match damage_type:
		StatHelper.DamageTypes.Base:
			amount -= get_defense()
		
		# All other damage types get scaled
		_:
			var a = 1.0 - get_resistance(damage_type)
			amount = floor(float(amount) * a)
	
	# Finally apply the damage
	amount = max(1, amount)
	stats[StatHelper.StatTypes.CurrentHP] -= amount
	combatant.stat_changed.emit(combatant)
	
	# Lifesteal check
	if dd.damage_heal_percentage > 0.0:
		var lifesteal_v: int = dd.get_lifesteal_amount(amount, self)
		dd.activator.heal(lifesteal_v)
	
	# Notify anything about dying
	if get_curr_hp() <= 0:
		die()

func die() -> void:
	stats[StatHelper.StatTypes.CurrentHP] = 0
	combatant.stat_changed.emit(combatant)

func heal(amount: int) -> void:
	stats[StatHelper.StatTypes.CurrentHP] += amount
	if get_curr_hp() > get_max_hp():
		stats[StatHelper.StatTypes.CurrentHP] = get_max_hp()
	combatant.stat_changed.emit(combatant)

func remove_sp(amount: int) -> void:
	stats[StatHelper.StatTypes.CurrentSP] -= amount
	stats[StatHelper.StatTypes.CurrentSP] = max(
		get_curr_sp(),
		0
	)
	combatant.stat_changed.emit( combatant )

func regain_sp(amount: int) -> void:
	stats[StatHelper.StatTypes.CurrentSP] += amount
	if get_curr_sp() > get_max_sp():
		stats[StatHelper.StatTypes.CurrentSP] = get_max_sp()
	combatant.stat_changed.emit( combatant )

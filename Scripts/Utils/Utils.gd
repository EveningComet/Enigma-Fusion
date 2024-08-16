class_name Utils

## The max amount of activatable skills the player can have set
## in the skill bar at one time.
const MAX_ACTIVE_SKILLS: int = 6

## Create a creature.
static func create_creature(
	base_data: CreatureBlueprint,
	parent_a:  CreatureBlueprint = null,
	parent_b:  CreatureBlueprint = null) -> Combatant:
		# Create the base components for a creature
		var creature: Combatant        = Combatant.new()
		var stats:    Stats            = Stats.new(creature)
		var c_data:   CreatureInstance = CreatureInstance.new()
		c_data.base_blueprint = base_data
		
		var base_attributes: Dictionary
		
		# Stat growth =
		# base creature bp + floor( (parent_a_stat + parent_b_stat) / 2)
		if parent_a != null and parent_b != null:
			pass
		
		creature.instance_data = c_data
		return creature

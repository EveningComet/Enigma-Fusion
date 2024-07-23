## Defines what should happen when a creature hits an enemy.
class_name OnHitEnemyTrait extends TraitDefinition

@export_category("Lifesteal")
## Should the attacker be healed?
@export var applies_lifesteal: bool = false

## If the trait allows lifesteal, how much percentage of the damage gets healed?
@export_range(0.0, 1.0, 0.05) var lifesteal_damage_percent: float = 0.0

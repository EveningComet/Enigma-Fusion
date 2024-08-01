## Stores data related to a creature/monster/etc.
class_name CreatureBlueprint extends Resource

@export_category("Base Info")
@export var localization_name: String = "New Creature"
@export_multiline var localization_description: String = "Deep lore."

@export_category("Stats")
@export var starting_vitality:  int = 5
@export var starting_technique: int = 5
@export var starting_will:      int = 5

# Attributes boost on level up
@export var base_vitality_growth:  int = 5
@export var base_technique_growth: int = 5
@export var base_will_growth:      int = 5

@export var traits: Array[Trait] = []

@export_category("Drops")
@export var exp_on_death: int = 50

@export_category("Dialogue")
# TODO: Multiple sequences.
@export var sequence: DialogicTimeline

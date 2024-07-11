## Stores data related to a creature/monster/etc.
class_name CreatureBlueprint extends Resource

@export var localization_name: String = "New Creature"
@export_multiline var localization_description: String = "Deep lore."

@export_category("Stats")
@export var starting_vitality:  int = 5
@export var starting_technique: int = 5
@export var starting_will:      int = 5

@export var traits: Array[Trait] = []

@export_category("Dialogue")
# TODO: Multiple sequences.
@export var sequence: DialogicTimeline

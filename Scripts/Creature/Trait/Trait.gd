## Stores a collection of special modifiers.
class_name Trait extends Resource

@export_category("Base Info")
@export var           localization_name:        String = "New Trait"
@export_multiline var localization_description: String = "New description."

@export_category("Definition")
## The object that defines what this trait does.
@export var trait_definition: TraitDefinition

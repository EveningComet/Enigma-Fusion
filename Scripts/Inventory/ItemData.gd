## Stores a collection of information for something that can exist inside an
## inventory.
class_name ItemData extends Resource

@export_category("Base Info")
@export var localization_name:                  String = "New Item"
@export_multiline var localization_description: String = "New description."

@export var max_stack_size: int = 1

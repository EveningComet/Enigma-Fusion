## Stores a variety of information that will be needed to resolve actions.
class_name TargetingData extends Resource

## The character performing a particular action.
var activator

## Stores the starting position, if needed. Typically used for things such as warping,
## or shooting a projectile.
var origin: Vector3 = Vector3.ZERO

## Some skills will need to know a vector, such as teleports.
var target_v: Vector3 = Vector3.ZERO

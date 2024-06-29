## A class responsible for passing around needed data.
extends Node

## Fired when a character has run out of health.
signal hp_depleted(combatant: Combatant)

## Fired when the player tries talking to an NPC or an enemy.
signal begin_conversation(node)

## A class responsible for passing around needed data.
extends Node

## Fired when a character has run out of health.
signal hp_depleted(combatant: Combatant)

## Fired when the player changes what characters are in the active party.
signal active_party_changed(active_party: Array)

## Fired when the player tries talking to an NPC or an enemy.
signal begin_conversation(node)

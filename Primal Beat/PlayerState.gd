extends Node

# Represents a global state of the player.
# This is used as a singleton (AutoLoad) to connect the scene parts which change or react on the PlayerState

export var live = 3
export var health = 3

signal player_state_changed

# Will damage the player and evaluate the state
func damage_player(damage):
	health -= damage
	print('took %d damage - %d hearts left' % [damage, health])
	emit_signal("player_state_changed")
	
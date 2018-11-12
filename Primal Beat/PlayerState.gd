extends Node

# Represents a global state of the player.
# This is used as a singleton (AutoLoad) to connect the scene parts which change or react on the PlayerState

export var live = 3

var max_health = 3
export var health = 1

signal player_state_changed

# Will damage the player and evaluate the state
func damage_player(damage):
	health -= damage
	print('took %d damage - %d hearts left' % [damage, health])

	# Update the live status and supsequently the health status when the health reaches zero
	if health <= 0:
		live -= 1
		if live > 0:
			health = max_health

	emit_signal("player_state_changed")
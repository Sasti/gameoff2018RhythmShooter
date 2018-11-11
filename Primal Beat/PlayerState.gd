extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var live = 3
export var health = 3

signal player_state_changed

func _ready():
	pass

func _process(delta):
	pass

func damage_player(damage):
	health -= damage
	print('took %d damage - %d hearts left' % [damage, health])
	emit_signal("player_state_changed")
	
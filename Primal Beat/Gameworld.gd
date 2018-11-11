extends Node

var hearts = 3

func _ready():
	pass

func _process(delta):
	pass

func _on_player_damaged(damage):
	hearts -= damage
	print('took %d damage - %d hearts left' % [damage, hearts])

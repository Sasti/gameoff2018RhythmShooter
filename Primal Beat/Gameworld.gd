extends CanvasLayer

var hearts = 3
var damage_message = 'took %d damage - %d hearts left'

func _ready():
	pass

func _process(delta):
	pass

func _on_player_damaged(damage):
	hearts -= damage
	print(damage_message % [damage, hearts])

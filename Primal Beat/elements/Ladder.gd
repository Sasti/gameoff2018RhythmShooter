extends Sprite

const player_interaction_script = preload("../scripts/player_interaction.gd")
onready var player_interaction = player_interaction_script.new()

signal player_entered
signal player_left

func _on_ladder_area_entered(area):
	if player_interaction._is_player_area(area):
		emit_signal("player_entered")

func _on_ladder_area_exited(area):
	if player_interaction._is_player_area(area):
		emit_signal("player_left")

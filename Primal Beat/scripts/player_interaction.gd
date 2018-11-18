extends Object

func _is_player_area(area):
	if area.name == "PlayerHitbox":
		return true
	else:
		return false
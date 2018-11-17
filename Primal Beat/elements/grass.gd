extends Node2D

export(Vector2) var spawnOffset = Vector2()
export(PackedScene) var spawnedEnemy

func _on_spawn_detection_area_entered(area):
	if _check_if_is_player_area(area):
		print("Player entered spawn area")

		_spawn_enemy()

func _on_noise_detection_area_entered(area):
	if _check_if_is_player_area(area):
		print("Player entered noise detection area")

func _on_grass_touch_detection_area_entered(area):
	if _check_if_is_player_area(area):
		print("Player entered the grass")

func _check_if_is_player_area(area):
	if area.name == "PlayerHitbox":
		return true
	else:
		return false

func _spawn_enemy():
	if spawnedEnemy != null:
		var enemyInstance = spawnedEnemy.instance()
		enemyInstance.position = position + spawnOffset
		
		var gameworldNode = get_tree().get_root().get_node("Root")
		if gameworldNode != null:
			gameworldNode.add_child(enemyInstance)
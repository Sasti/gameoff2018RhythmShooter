# A high-damage, slow melee mob with moderate range. Sleeps peacefully, but will attack relentlessly once provoked.
extends "res://enemies/Mob.gd"

# When asleep, the mob has a much shorter aggro range.
const STATE_SLEEPING = 'sleeping'

const DEFAULT_ANIMATION = 'sleeping'

const damage = 3

const DISENGAGE_WAIT_TIME = 4
const SPEED = 150
const FALLBACK_OFFSET = Vector2(0, 0)

func _init():
	mob_state = STATE_SLEEPING

func _on_aggro(area):
	# Wake up when the player bumps into the mob.
	if area.name == 'PlayerHitbox' and mob_state == STATE_SLEEPING:
		mob_state = STATE_IDLE

	if area.name == 'PlayerHitbox' and mob_state == STATE_IDLE:
		mob_state = STATE_AGGROED

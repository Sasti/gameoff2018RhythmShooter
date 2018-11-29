# A high-damage, slow melee mob with moderate range. Sleeps peacefully, but will attack relentlessly once provoked.
extends "res://enemies/Mob.gd"

const DAMAGE = 3
const DISENGAGE_WAIT_TIME = 4

const GRAVITY = 300.0
const SPEED = 100
const FALLBACK_OFFSET = Vector2(0, 0)

func _ready():
	set_state(STATE_SLEEPING)

func _on_aggro(area):
	# Wake up when the player bumps into the mob.
	if area.name == 'PlayerHitbox' and get_state() == STATE_SLEEPING:
		set_state(STATE_IDLE)

	if area.name == 'PlayerHitbox' and get_state() == STATE_IDLE:
		set_state(STATE_AGGROED)

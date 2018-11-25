# A flying enemy unaffected by gravity.
# Hovers in the air until the player enters its aggro range, then pursues the player.
# When it manages to reach the player's attack range, it will damage them, then die.
extends 'res://enemies/Mob.gd'

const damage = 1

const DISENGAGE_WAIT_TIME = 2.5
const SPEED = 350
const FALLBACK_OFFSET = Vector2(200, -550)

# A flying enemy unaffected by gravity.
# Hovers in the air until the player enters its aggro range, then pursues the player.
# When it manages to reach the player's attack range, it latches on, slowly draining their life.
extends RigidBody2D

# Whether the player has entered our aggro range
var aggroing = false

# Whether we are in range to attack the player
var attacking = false

# Where to move when aggroed
var target = Vector2()

# Movement parameters
var speed = 200
var velocity = Vector2()

func _ready():
	target = get_node('../Traveler')
	$MobHitArea.connect('area_entered', self, 'hit')

func _process(delta):
	velocity = (target.position - position).normalized() * speed

	if aggroing:
		move_and_collide(velocity)

func hit(object):
	queue_free()

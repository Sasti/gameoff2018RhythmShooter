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
	$MobAggroRange.connect('area_entered', self, 'aggroed')

func _process(delta):
	velocity = (target.position - position).normalized() * speed

	if aggroing:
		move_and_collide(velocity)

func hit(object):
	queue_free()

func aggroed(object):
	aggroing = true

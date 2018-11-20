# Default node type for a mob with basic attack pattern.
extends KinematicBody2D

const DEFAULT_ANIMATION = 'idle'

# No player in sight, just hanging around
const STATE_IDLE = 'idle'

# Player has entered aggro range, and the mob is in pursuit
const STATE_AGGROED = 'aggroed'

# The mob has reached the player's hitbox, resulting in a successful attack
const STATE_ATTACKING = 'attacking'

# After a successful attack, the mob falls back
const STATE_DISENGAGING = 'disengaging'

# Lifecycle states controlling mob behaviour. This is the default state.
var mob_state = STATE_IDLE

# Amount of damage the player suffers for each successful attack from this mob
const damage = 1

# Amount of seconds the mob will wait after disengaging before attacking the player again
const DISENGAGE_WAIT_TIME = 2

# Where to move when aggroed
var target = Vector2()

# Movement properties
const GRAVITY = 600
const SPEED = 250
const FALLBACK_OFFSET = Vector2(0, 0)

var velocity = Vector2()
var fallback_point = Vector2()

# Starts when disengaging after succesful attack. When it runs out, the mob engages again
var disengage_timer

func _ready():
	target = get_node('../Traveler')
	$MobHitArea.connect('area_entered', self, '_on_hit')
	$MobAggroRange.connect('area_entered', self, '_on_aggro')

	disengage_timer = Timer.new()
	disengage_timer.wait_time = DISENGAGE_WAIT_TIME
	disengage_timer.one_shot = true
	disengage_timer.connect('timeout', self, '_on_disengage_timeout')

	add_child(disengage_timer)

func _physics_process(delta):

	# velocity.y += GRAVITY * delta

	# Perform the actual movement
	# velocity = move_and_slide(velocity, Vector2(0, -1))

	if mob_state == STATE_AGGROED:
		_move_to_target(delta)
	elif mob_state == STATE_ATTACKING:
		_disengage()
	elif mob_state == STATE_DISENGAGING:
		_move_and_wait(delta)

	_animate()

func _animate():
	if mob_state == STATE_ATTACKING:
		$AnimatedSprite.animation = 'attacking'
	else:
		$AnimatedSprite.animation = DEFAULT_ANIMATION

	$AnimatedSprite.play()

func _move_to_target(delta):
	velocity = (target.position - position).normalized() * SPEED
	move_and_collide(velocity * delta)

func _disengage():
	fallback_point = global_position + FALLBACK_OFFSET
	PlayerState.damage_player(damage)
	mob_state = STATE_DISENGAGING

# Move to fallback position after attacking and start the timer for the next attack
func _move_and_wait(delta):
	if global_position != fallback_point:
		velocity = fallback_point.normalized() * SPEED
		move_and_collide(velocity * delta)

	if global_position >= fallback_point:
		mob_state = STATE_IDLE
		disengage_timer.start()

# Called when waiting after the timer has run out - start pursuing the player again
func _on_disengage_timeout():
	mob_state = STATE_AGGROED
	fallback_point = Vector2()

func _on_aggro(area):
	if area.name == 'PlayerAggroRange' and mob_state == STATE_IDLE:
		mob_state = STATE_AGGROED

func _on_hit(area):
	if area.name == 'PlayerHitbox' and mob_state == STATE_AGGROED:
		mob_state = STATE_ATTACKING

	if area.name == 'PlayerShotHitArea':
		queue_free()

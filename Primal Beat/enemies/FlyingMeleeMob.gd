# A flying enemy unaffected by gravity.
# Hovers in the air until the player enters its aggro range, then pursues the player.
# When it manages to reach the player's attack range, it will damage them, then die.
extends KinematicBody2D

signal player_damaged

# No player in sight, just hanging around
const STATE_IDLE = 'idle'

# The player aggro range has entered the mob's aggro range, and the mob is trying to reache the player
const STATE_AGGROED = 'aggroed'

# The mob has reached the player's hitbox, resulting in a successful attack
const STATE_ATTACKING = 'attacking'

# After a successful attack, the mob falls back
const STATE_DISENGAGING = 'disengaging'

# The mob has reached the fallback position and is waiting to attack again after the timer runs out
const STATE_HOVERING = 'hovering'

# Lifecycle states controlling mob behaviour
var mob_state = STATE_IDLE

# Amount of damage the player suffers for each successful attack from this mob
var damage = 1

# Where to move when aggroed
var target = Vector2()

# Movement parameters
var speed = 450
var velocity = Vector2()
var fallback_point = Vector2()

# Starts when disengaging after succesful attack. When it runs out, the mob engages again
var disengage_timer

func _ready():
	target = get_node('../Traveler')
	$MobHitArea.connect('area_entered', self, '_on_hit')
	$MobAggroRange.connect('area_entered', self, '_on_aggro')

	disengage_timer = Timer.new()
	disengage_timer.wait_time = 2
	disengage_timer.one_shot = true
	disengage_timer.connect('timeout', self, '_on_disengage_timeout')

	add_child(disengage_timer)

func _physics_process(delta):
	if mob_state == STATE_AGGROED:
		velocity = (target.position - position).normalized() * speed
		move_and_collide(velocity * delta)
	elif mob_state == STATE_ATTACKING:
		fallback_point = Vector2(global_position.x + 200, global_position.y - 1000)
		PlayerState.damage_player(damage)
		mob_state = STATE_DISENGAGING
	elif mob_state == STATE_DISENGAGING:
		velocity = fallback_point.normalized() * speed
		move_and_collide(velocity * delta)

		if global_position >= fallback_point:
			mob_state = STATE_HOVERING
			disengage_timer.start()

	elif mob_state == STATE_HOVERING:
		pass

func _on_aggro(area):
	if area.name == 'PlayerAggroRange':
		mob_state = STATE_AGGROED

func _on_hit(area):
	if area.name == 'PlayerHitbox':
		mob_state = STATE_ATTACKING

	if area.name == 'PlayerShotHitArea':
		queue_free()

func _on_disengage_timeout():
	mob_state = STATE_AGGROED
	fallback_point = Vector2()

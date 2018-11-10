# A flying enemy unaffected by gravity.
# Hovers in the air until the player enters its aggro range, then pursues the player.
# When it manages to reach the player's attack range, it will damage them, then die.
extends KinematicBody2D

signal player_damaged

var damage = 1

# Whether the player has entered our aggro range
var aggroed = false

# Whether we are in range to attack the player
var attacking = false

# Where to move when aggroed
var target = Vector2()

# Movement parameters
var speed = 450
var velocity = Vector2()

func _ready():
	target = get_node('../Traveler')
	$MobHitArea.connect('area_entered', self, '_on_hit')
	$MobAggroRange.connect('area_entered', self, '_on_aggro')

func _physics_process(delta):
	if aggroed and not attacking:
		velocity = (target.position - position).normalized() * speed
		move_and_collide(velocity * delta)

	if attacking:
		print('damaged player')
		emit_signal('player_damaged', damage)
		attacking = false
		queue_free()

func _on_hit(area):
	if area.name == 'PlayerHitbox':
		print('reached player')
		attacking = true

	if area.name == 'PlayerShotHitArea':
		print('mob hit by shot')
		queue_free()

func _on_aggro(area):
	if area.name == 'PlayerAggroRange':
		print('mob aggroed')
		aggroed = true

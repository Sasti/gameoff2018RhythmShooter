extends AnimatedSprite

const SPEED = 500

var direction

func _ready():
	$PlayerShotHitArea.connect('area_entered', self, 'hit')
	var player = get_node('/root/GameWorld/Traveler')

	if player.facing == player.FACING_LEFT:
		direction = -1
	else:
		direction = 1

func _process(delta):
	position.x += direction * (SPEED * delta)

	play()

func _on_Visibility_screen_exited():
	queue_free()

func hit(object):
	if object.name == 'MobHitArea':
		queue_free()

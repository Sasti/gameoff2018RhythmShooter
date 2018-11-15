extends AnimatedSprite

const SPEED = 500

var direction

func _ready():
	$PlayerShotHitArea.connect('area_entered', self, 'hit')
	var player = get_node('/root/GameWorld/Traveler')

	direction = player.facing

func _process(delta):
	position.x += direction * (SPEED * delta)
	play()

func _on_Visibility_screen_exited():
	queue_free()

func hit(object):
	if object.name == 'MobHitArea':
		queue_free()

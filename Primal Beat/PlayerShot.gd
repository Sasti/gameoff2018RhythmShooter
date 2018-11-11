extends AnimatedSprite

const SPEED = 500

func _ready():
	$PlayerShotHitArea.connect('area_entered', self, 'hit')

func _process(delta):
	position.x += SPEED * delta
	play()

func _on_Visibility_screen_exited():
	queue_free()

func hit(object):
	if object.name == 'MobHitArea':
		queue_free()

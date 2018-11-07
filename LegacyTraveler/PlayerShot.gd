extends AnimatedSprite

const SPEED = 2

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$PlayerShotHitArea.connect('area_entered', self, 'hit')

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	position.x += SPEED
	play()

func _on_Visibility_screen_exited():
	queue_free()

func hit(object):
	if object.name == 'MobHitArea':
		queue_free()

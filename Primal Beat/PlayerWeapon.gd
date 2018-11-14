extends AnimatedSprite

var player
var gameworld

# Horizontal position relative to the player
var anchorPoint

var shooting = false
var shot_timer
var shot

func _init():
	shot = load('res://PlayerShot.tscn')

func _ready():
	player = get_parent()
	gameworld = get_node('/root/GameWorld')

	anchorPoint = position.x

	shot_timer = Timer.new()
	shot_timer.wait_time = 0.5
	shot_timer.one_shot = true
	shot_timer.connect('timeout', self, 'on_timeout_complete')

	add_child(shot_timer)

# Allow shooting again after the timer has stopped
func on_timeout_complete():
	shooting = false

func _process(delta):
	if shooting:
		animation = 'shooting'
	else:
		animation = 'idle'

	if player.facing == -1:
		flip_h = true
	else:
		flip_h = false
	position.x = player.facing * anchorPoint

	if Input.is_action_just_pressed('ui_shoot'):
		var shotInstance = shot.instance()
		shotInstance.position = player.position
		gameworld.add_child(shotInstance)
		shooting = true
		shot_timer.start()

	play()

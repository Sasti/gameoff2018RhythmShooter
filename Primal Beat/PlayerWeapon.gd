extends AnimatedSprite

const BULLET_DELAY = 0.25

var player
var gameworld

var can_shoot = true
var shot_timer
var shot

func _init():
	shot = load("res://PlayerShot.tscn")

func _ready():
	player = get_parent()
	gameworld = get_node('/root')

	shot_timer = Timer.new()
	shot_timer.wait_time = BULLET_DELAY
	shot_timer.one_shot = true
	shot_timer.connect("timeout", self, "on_timeout_complete")

	add_child(shot_timer)

# Allow shooting again after the timer has stopped
func on_timeout_complete():
	can_shoot = true

func _process(delta):
	if Input.is_action_just_pressed("ui_shoot"):
		var shotInstance = shot.instance()
		shotInstance.position = player.position
		gameworld.add_child(shotInstance)

	if player.facing == player.FACING_LEFT:
		print('left')
	elif player.facing == player.FACING_RIGHT:
		print('right')

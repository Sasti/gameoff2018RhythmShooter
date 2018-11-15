extends KinematicBody2D

# acceleration for left/right
const RUN_SPEED = 400

# acceleration for going up
const JUMP_SPEED = -250

# acceleration for going down
const GRAVITY = 600

# Whether the character is jumping (allows us to control the animation)
var jumping = false

# Whether the character is facing left (-1) or right (1)
export var facing = 1

var velocity = Vector2()

func _physics_process(delta):
	# Downward movement for constant gravity pull
	velocity.y += GRAVITY * delta

	# Read user input and modify velocity as appropriate
	_get_input()

	# Perform the actual movement
	velocity = move_and_slide(velocity, Vector2(0, -1))

	if jumping and is_on_floor():
		jumping = false

	_animate()

func _get_input():
	# Reset to prevent the character from moving indefinitely
	velocity.x = 0

	var left = Input.is_action_pressed('ui_left')
	var right = Input.is_action_pressed('ui_right')
	var jump = Input.is_action_just_pressed('ui_jump')

	if left:
		velocity.x -= RUN_SPEED
		facing = -1
	if right:
		velocity.x += RUN_SPEED
		facing = 1
	if is_on_floor() and jump:
		jumping = true
		velocity.y = JUMP_SPEED

func _animate():
	if jumping:
		$AnimatedSprite.animation = 'jumping'
	elif velocity.x != 0:
		$AnimatedSprite.animation = 'running'
	else:
		$AnimatedSprite.animation = 'idle'

	# Horizontally flip animation when moving/facing left
	$AnimatedSprite.flip_h = velocity.x < 0 or facing == -1
	$AnimatedSprite.play()

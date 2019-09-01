extends KinematicBody2D

# acceleration for left/right
const RUN_SPEED = 400

# acceleration for left/right
const LADDER_SPEED = 250

# acceleration for going up
const JUMP_SPEED = -400

# acceleration for going down
const GRAVITY = 1600

# Whether the character is jumping (allows us to control the animation)
var jumping = false

# Counts the laders the player is currently touching. Usually this isn't higher then 2
var ladderCount = 0

# Whether the character is facing left (-1) or right (1)
export var facing = 1

var velocity = Vector2()

func _physics_process(delta):
	if !is_on_ladder():
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
	var up = Input.is_action_pressed('ui_up')
	var down = Input.is_action_pressed('ui_down')

	if left:
		velocity.x -= RUN_SPEED
		facing = -1
	if right:
		velocity.x += RUN_SPEED
		facing = 1
	if is_on_floor() and jump and !is_on_ladder():
		jumping = true
		velocity.y = JUMP_SPEED
	if is_on_ladder() and up:
		velocity.y = -LADDER_SPEED
	if is_on_ladder() and down:
		velocity.y = LADDER_SPEED
	if is_on_ladder() and !up and !down:
		# Make the player stop when he is on a ladder and doesn't give any inputs for up or down
		velocity.y = 0

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

func _on_Ladder_player_entered():
	ladderCount += 1
	print("Ladder entered. ladderCount $d", ladderCount)

func _on_Ladder_player_left():
	ladderCount -= 1
	ladderCount = clamp(ladderCount, 0, 1000)
	print("Ladder left. ladderCount $d", ladderCount)

func is_on_ladder():
	if ladderCount > 0:
		return true
	else:
		return false
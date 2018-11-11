extends KinematicBody2D

var runSpeed = 400
var jumpSpeed = -300

# acceleration for the down direction
var gravity = 600

var velocity = Vector2()

func _physics_process(delta):
	# Downward movement for constant gravity pull
	velocity.y += gravity * delta

	# Read user input and modify velocity as appropriate
	_get_input()

	# Perform the actual movement
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _get_input():
	# Reset to prevent the character from moving indefinitely
	velocity.x = 0

	var left = Input.is_action_pressed('ui_left')
	var right = Input.is_action_pressed('ui_right')
	var jump = Input.is_action_just_pressed('ui_jump')

	if left:
		velocity.x -= runSpeed
	if right:
		velocity.x += runSpeed
	if is_on_floor() and jump:
		velocity.y = jumpSpeed

extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var shot

# gravity represent the accelaration for the downwards direction
var gravity = 3

var speed = 5

func _init():
	shot = load("res://PlayerShot.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	var movementDelta = Vector2(0,0)
	
	if Input.is_action_pressed("ui_down"):
		movementDelta.y += speed
	
	if Input.is_action_pressed("ui_up"):
		movementDelta.y -= speed
		
	if Input.is_action_pressed("ui_right"):
		movementDelta.x += speed
		
	if Input.is_action_pressed("ui_left"):
		movementDelta.x -= speed

	movementDelta.y += gravity
	
	var collision = move_and_collide(movementDelta)
	
	if collision != null:
		# This is very clumsy and needs to be replaces.
		# I will replace it with a propper implementation as soon as I understand the engine better.
		# Probably something like acceleration + speed * delta etc. and clamp it to the max speed
		movementDelta.y = 0
		movementDelta.x = collision.remainder.x
		move_and_slide(collision.remainder)
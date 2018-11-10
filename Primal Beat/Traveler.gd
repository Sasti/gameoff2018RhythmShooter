extends KinematicBody2D

var shot
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
	if Input.is_action_pressed("ui_down"):
		position.y += speed

	if Input.is_action_pressed("ui_up"):
		position.y -= speed

	if Input.is_action_pressed("ui_right"):
		position.x += speed

	if Input.is_action_pressed("ui_left"):
		position.x -= speed

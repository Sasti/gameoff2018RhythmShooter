extends KinematicBody2D

var shot
var speed = 5

# gravity represent the accelaration for the downwards direction
var gravity = 3

func _init():
	shot = load("res://PlayerShot.tscn")

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	var movementDelta = Vector2(0,0)

	if Input.is_action_pressed("ui_down"):
		position.y += speed

	if Input.is_action_pressed("ui_up"):
		position.y -= speed

	if Input.is_action_pressed("ui_right"):
		position.x += speed

	if Input.is_action_pressed("ui_left"):
		position.x -= speed

extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var shot

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
		position.y += 1
	
	if Input.is_action_pressed("ui_up"):
		position.y -= 1
		
	if Input.is_action_pressed("ui_right"):
		position.x += 1
		
	if Input.is_action_pressed("ui_left"):
		position.x -= 1

extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	var shooting = Input.is_action_pressed("ui_shoot")
	
	if (shooting):
		var bullet = preload("res://PlayerShot.tscn").instance()
		bullet.position.x = position.x
		bullet.position.y = position.y
		add_child(bullet)

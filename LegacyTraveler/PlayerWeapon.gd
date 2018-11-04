extends AnimatedSprite

var bullet_delay = 0.25
var shot_timer 
var can_shoot = true

onready var shot_spawn = get_node("ShotSpawn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	shot_timer = Timer.new()
	shot_timer.wait_time = bullet_delay
	shot_timer.one_shot = true
	shot_timer.connect("timeout", self, "on_timeout_complete")
	
	add_child(shot_timer)

# Allow shooting again after the timer has stopped
func on_timeout_complete():
	can_shoot = true

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	var shooting = Input.is_action_pressed("ui_shoot")
	
	if (shooting && can_shoot):
		spawn_shot()

# Add a new shot instance to the scene
func spawn_shot():	
	var shot = load("res://PlayerShot.tscn").instance()
	
	shot.position = shot_spawn.position
	add_child(shot)
	
	can_shoot = false
	shot_timer.start()
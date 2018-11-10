extends Sprite

var bullet_delay = 0.25
var shot_timer 
var can_shoot = true

var shot

func _init():
	shot = load("res://PlayerShot.tscn")

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
	if Input.is_action_just_pressed("ui_shoot"):
		var shotInstance = shot.instance()
		shotInstance.position = get_parent().position
		
		var shotOffset = 110
		shotInstance.position.x = shotInstance.position.x + shotOffset
		get_parent().get_parent().add_child(shotInstance)

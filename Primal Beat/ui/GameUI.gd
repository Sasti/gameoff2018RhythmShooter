extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var current_lives = 3
export var max_lives = 3

export var current_health = 3
var max_health = 3

onready var hearts_bar_elements = get_tree().get_nodes_in_group("health_indicator")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	update()
	
func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	update()
	
func set_health(health):
	current_health = clamp(health, 0, max_health)

func set_lives(live):
	current_lives = clamp(live, 0, max_lives)

func update():
	var visible_hearts_counter = current_health
	for heart in hearts_bar_elements:
		if visible_hearts_counter > 0:
			heart.show()
		else:
			heart.hide()

		visible_hearts_counter -= 1

	get_node('lives_counter').text = String(current_lives)
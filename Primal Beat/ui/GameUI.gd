extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var current_lives = 3
export var max_lives = 3

export var current_health = 3
var max_health = 3

onready var hearts_bar_elements = get_tree().get_nodes_in_group('health_indicator')

func _ready():
	# Copy the intial state of the PlayerState singleton (AutoLoad)
	set_health(PlayerState.health)
	set_lives(PlayerState.live)
	
	# Register to the global PlayerState
	var err = PlayerState.connect('player_state_changed', self, '_on_player_state_changed')
	print(err)
	
	# Update the state of the ui to match the initial PlayerState
	update()
	
func set_health(health):
	current_health = clamp(health, 0, max_health)

func set_lives(live):
	current_lives = clamp(live, 0, max_lives)

# Handler function wich should be called when the PlayerState changed
func _on_player_state_changed():
	set_health(PlayerState.health)
	set_lives(PlayerState.live)
	update()

# Updates the visibility and visual properties of the visual nodes used to represent the state of the game
func update():
	var visible_hearts_counter = current_health
	for heart in hearts_bar_elements:
		if visible_hearts_counter > 0:
			heart.show()
		else:
			heart.hide()

		visible_hearts_counter -= 1

	get_node('lives_counter').text = String(current_lives)
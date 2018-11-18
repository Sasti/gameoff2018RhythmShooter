extends Polygon2D

const PlayerInteraction = preload("../scripts/player_interaction.gd")
onready var player_interaction = PlayerInteraction.new()

# Time used to idle the spikes
onready var spikes_idle_timer
export var spikes_idle_time = 1.0

# Controlls if the spikes are moving or are static
export var moving_spikes = true

# Indicates if the spikes are harmfull at the moment
var harmfull = true

# Speed which the spikes move in and out
export var spikes_speed = 100
var texture_direction = -1

# Should contain the indice of the vertex which holds the maximum UV.y coordinate for the texture
const MAX_V_INDICE = 3

# Should contain the indice of the vertex which holds the minumum UV.y coordinate for the texture
const MIN_V_INDICE = 0

onready var maximumV = uv[MAX_V_INDICE].y
onready var minimumV = uv[MIN_V_INDICE].y

# Indicates if the player is touching the damaging area
var _player_inside = false

func _ready():
	# Only add the timer if the spikes shall move
	if moving_spikes:
		spikes_idle_timer = Timer.new()
		spikes_idle_timer.wait_time = spikes_idle_time
		spikes_idle_timer.connect("timeout", self, "_on_spikes_idle_timeout")
		spikes_idle_timer.one_shot = true
		spikes_idle_timer.name = "SpikesIdleTimeout"
		add_child(spikes_idle_timer)

func _process(delta):
	if moving_spikes and harmfull:
		_update_active_state(delta)
	if _player_inside and harmfull:
		PlayerState.damage_player(1)
	
# Updates the position and active state of the spikes
func _update_active_state(delta):
	var uvBuff
	
	for i in range(uv.size()):
		uvBuff = uv[i]
		uvBuff.y += spikes_speed * texture_direction * delta
		uv[i] = uvBuff
	
	# Invert the direction when the move is complete
	if uv[3].y <= minimumV:
		_make_unharmfull()
		texture_direction = 1
	if uv[3].y >= maximumV:
		texture_direction = -1

func _make_unharmfull():
	harmfull = false

	# Start the spikes idle timer to make the spikes idle for some time
	spikes_idle_timer.start()

func _on_DamageArea_area_entered(area):
	if player_interaction.is_player_area(area):
		_player_inside = true

func _on_DamageArea_area_exited(area):
	if player_interaction.is_player_area(area):
		_player_inside = false

func _on_spikes_idle_timeout():
	# Reenables the spikes
	harmfull = true

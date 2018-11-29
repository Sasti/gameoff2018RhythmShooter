extends Sprite

# This script can be used to make a spripte wobble on the x-axis. For example a bush or gras can wave from
# left to right in the speed configured with wobbleSpeed and wobbleDistance.

# The size of the used texture. Needs to be an Vector2
var spriteSize

# The transformation applied in the editor. Should be 
onready var baseTransform = get_transform()
onready var elementScale = get_scale()

# deltaSum contains the sum of the delta time provided in the _physics_process call
var deltaSum = 0.0

# wobbleSpeed is the speed in which the wobble effect should happen
export var wobbleSpeed = 1.3
# wobbleDistance controlls the max wobble distance
export var wobbleDistance = 0.2
# wobbleDirection controlls in which direction the effect is applied. 1 > moves left; -1 > moved right; 0 > moves both directions
export var wobbleDirection = 1

func _ready():
	if region_enabled == true:
		# If the sprite uses a region, which means it shows a part of the texture in use, the spriteSize is actually the region size
		spriteSize = region_rect.size
	else:
		# This is the usual case where the sprite just show the whole content of the sprite
		spriteSize = get_texture().get_size()

func _physics_process(delta):
	deltaSum += delta
	
	var elementSize = Vector2(spriteSize.x * elementScale.x, spriteSize.y * elementScale.y)
	
	var transformUp = Transform2D()
	transformUp = transformUp.translated( Vector2(0, elementSize.y / 2) )
	
	var transformDown = Transform2D()
	transformDown = transformDown.translated( Vector2(0, -elementSize.y / 2) ) 
	
	var shering = Transform2D()
	# This vector represents the shering on the y axis. The grass shall not move in that direction so we set 
	# this part of the transformation to use just the unchanged y values.
	shering[0] = Vector2(1, 0)
	# This vector represets the shering on the x axis. The strength of the shering is calculated 
	# with a sin function so that it moves nicely in a loop. The calculation tries to make the 
	# configuration of the wobbleSpeed more user friendly by shortening the sin wave by 2 * PI. 
	# This will result in a sin function oscilation between 1 and -1 on second basis. 
	shering[1] = Vector2((sin(2 * PI * deltaSum / wobbleSpeed) + wobbleDirection) * wobbleDistance, 1)
	
	set_transform( transformUp * shering * transformDown * baseTransform )
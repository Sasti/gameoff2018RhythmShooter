extends Sprite

# The size of the used texture. Needs to be an Vector2
var spriteSize

# The transformation applied in the editor. Should be 
onready var baseTransform = get_transform()
onready var elementScale = get_scale()

var deltaSum = 0.0

export var wobbleSpeed = 1.3
export var wobbleDistance = 0.2
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
	shering[0] = Vector2(1, 0)
	shering[1] = Vector2((sin(2 * PI * deltaSum / wobbleSpeed) + wobbleDirection) * wobbleDistance, 1)
	
	set_transform( transformUp * shering * transformDown * baseTransform )
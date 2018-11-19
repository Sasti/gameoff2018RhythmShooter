extends Sprite

onready var baseTransform = get_transform()
onready var textureSize = get_texture().get_size()
onready var elementScale = get_scale()

var deltaSum = 0.0

export var wobbleSpeed = 1.3
export var wobbleDistance = 0.2
export var wobbleDirection = 1

func _physics_process(delta):
	deltaSum += delta
	
	var elementSize = Vector2(textureSize.x * elementScale.x, textureSize.y * elementScale.y)
	
	var transformUp = Transform2D()
	transformUp = transformUp.translated( Vector2(0, elementSize.y / 2) )
	
	var transformDown = Transform2D()
	transformDown = transformDown.translated( Vector2(0, -elementSize.y / 2) ) 
	
	var shering = Transform2D()
	shering[0] = Vector2(1, 0)
	shering[1] = Vector2((sin(deltaSum / wobbleSpeed) + wobbleDirection) * wobbleDistance, 1)
	
	set_transform( transformUp * shering * transformDown * baseTransform )
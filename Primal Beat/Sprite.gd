extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var baseTransform = get_transform()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

var deltaSum = 0.0

export var wobbleSpeed = 1.3
export var wobbleDistance = 0.2


func _physics_process(delta):
	deltaSum += delta
	
	var textureSize = get_texture().get_size()
	var elementScale = get_scale()
	
	var elementSize = Vector2(textureSize.x * elementScale.x, textureSize.y * elementScale.y)
	
	var transformUp = Transform2D()
	transformUp = transformUp.translated( Vector2(0, elementSize.y / 2) )
	
	var transformDown = Transform2D()
	transformDown = transformDown.translated( Vector2(0, -elementSize.y / 2) ) 
	
	var shering = Transform2D()
	shering[0] = Vector2(1, 0)
	shering[1] = Vector2(sin(deltaSum / wobbleSpeed) * wobbleDistance, 1)
	
	set_transform( transformUp * shering * transformDown * baseTransform )
extends AnimatedSprite2D
@export var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	$".".play("default")
 
func _process(delta):
	var movement = delta * speed
	self.position = self.position + (Vector2.LEFT * movement)

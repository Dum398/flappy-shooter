extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".play("default")
 
func _process(delta):
	$".".rotate(1)

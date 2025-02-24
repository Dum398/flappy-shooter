extends Area2D
@export var speed = 200
var _abs_time = 0
var _initial_pos = position
var _health = 1
func _ready():
	$AnimatedSprite2D.play("default")
 
func _process(delta):
	self._abs_time += delta
	var movement = delta * speed
	self.position = self.position + (Vector2.LEFT * movement)
	self.position.y = _initial_pos.y + sin(self._abs_time) * 100


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()

func _on_body_entered(body :Node2D):
	if self._health <= 0:
		return
	if body.has_method("add_damage"):
		body.add_damage(1, self)
		
func on_hit(shot :Node2D):
	self.queue_free()

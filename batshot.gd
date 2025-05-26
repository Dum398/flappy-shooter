extends Node2D

@export var speed = -1300


func _process(delta):
	var movement = delta * speed
	var forward = Vector2.RIGHT.rotated(self.rotation)
	self.position = self.position + (forward * movement)


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()


func _on_area_2d_body_entered(body):
	if body.has_method("add_damage"):
		body.add_damage(1, self)
	self.queue_free()   

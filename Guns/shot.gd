extends Node2D

## Rychlost laseru v px/s
@export var speed = 1300


func _process(delta):
	var movement = delta * speed
	self.position = self.position + (Vector2.RIGHT * movement)


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()


func _on_area_2d_area_entered(area :Node2D):
	if area.has_method("on_hit"):
		area.on_hit(self)
	self.queue_free()

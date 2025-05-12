extends Area2D
var speed=100

func _process(delta):
	var movement = delta * speed
	self.position = self.position + (Vector2.LEFT * movement)
func _on_body_entered(body):
	if body.has_method("add_damage"):
		body.health = 0
		body._dead = true
		body.player_death.emit()


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()

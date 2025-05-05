extends Area2D



func _on_body_entered(body):
	if body.has_method("add_damage"):
		body.health = 0
		body._dead = true
		body.player_death.emit()

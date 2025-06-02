extends Area2D
## Rychlost laseru v px/s
@export var speed = 1300
@export var explosion_distance = 150

func _process(delta):
	var movement = delta * speed
	var forward = Vector2.RIGHT.rotated(self.rotation)
	self.position = self.position + (forward * movement)


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()


func explode():
	var all_enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in all_enemies:
		var distance = enemy.global_position.distance_to(self.global_position)
		if distance <= explosion_distance:
			enemy.on_hit(null) 




func _on_area_entered(area):
	if area.has_method("on_hit"):
		area.on_hit(self)
		explode()
	self.queue_free()

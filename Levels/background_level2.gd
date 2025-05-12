extends Node2D
var _pipe_scene=preload ("res://pipe.tscn")

## Pohyb pozadí v px/s
@export var speed = 100:
	set(new_val):
		speed = new_val
		apply_speed()


func _ready():
	apply_speed()


func apply_speed():
	if find_child("Sky"): $Sky.autoscroll = Vector2(-speed / 2, 0)
	if find_child("Ground"): $Ground.autoscroll = Vector2(-speed, 0)
	for pipe in %pipes.get_children():
		pipe.speed = self.speed





func _on_area_2d_body_entered(body):
	if body.has_method("add_damage"):
		body.add_damage(1000, self)


func _on_pipespawntimer_timeout():
	var screen_size = get_viewport_rect().size
	var new_pipe = _pipe_scene.instantiate() as Node2D
	if randi_range(1, 10) >=5:
		new_pipe.rotation_degrees = 180
	new_pipe.position.x = screen_size.x + 50
	new_pipe.position.y = screen_size.y / randi_range(2, 4)
	new_pipe.speed = self.speed 
	%pipes.add_child(new_pipe)
	

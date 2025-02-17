extends Node2D


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

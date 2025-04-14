extends Node2D

## Čas mezi jednotlivymi výstřely ve vteřinách.
@export var cooldown_time := 0.5


@onready var _cooldown_timer := $Cooldown as Timer
var _shoot_scene := preload("res://Guns/shot.tscn")


func shoot_now():
	if not self._cooldown_timer.is_stopped():
		return
	for shot_origin in $shotorigins.get_children():
		var new_shot = _shoot_scene.instantiate()
		new_shot.global_position = shot_origin.global_position
		new_shot.global_rotation = shot_origin.global_rotation
		get_tree().current_scene.add_child(new_shot)
		
	self._cooldown_timer.start(self.cooldown_time)

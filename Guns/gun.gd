extends Node2D

## Čas mezi jednotlivymi výstřely ve vteřinách.
@export var cooldown_time := 0.5


@onready var _cooldown_timer := $Cooldown as Timer
var _shoot_scene := preload("res://Guns/shot.tscn")


func shoot_now():
	if not self._cooldown_timer.is_stopped():
		return
	
	var new_shot = _shoot_scene.instantiate()
	new_shot.global_position = self.global_position
	get_tree().current_scene.add_child(new_shot)
	
	self._cooldown_timer.start(self.cooldown_time)

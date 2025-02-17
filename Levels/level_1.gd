extends Node2D

var _dragon_scene = preload("res://Enemies/dragon.tscn")
var _bonus_scene = preload("res://Guns/Bonus/bonus.tscn")
var _bomb_scene = preload("res://Guns/Bonus/bomb_bonus.tscn")

var _dragon_health = 2


func _get_spawn_position():
	var screen_size = get_viewport_rect().size
	return Vector2(screen_size.x, (screen_size.y - 120) * randf())


func _on_enemy_spawn_timeout():
	var dragon = _dragon_scene.instantiate()
	
	dragon.position = self._get_spawn_position()
	dragon.health = self._dragon_health
	dragon.died.connect(func():
		$CanvasLayer/HUD.score += 1
	)
	self.add_child(dragon)


func _on_bonus_spawn_timeout():
	var bonus = _bonus_scene.instantiate()
	bonus.position = self._get_spawn_position()
	self.add_child(bonus)


func _on_difficulty_timer_timeout():
	self._dragon_health += 1


func _on_bomb_spawn_timeout():
	var bonus = _bomb_scene.instantiate()
	bonus.position = self._get_spawn_position()
	self.add_child(bonus)


func _on_player_bomb_count_changed(new_count :int):
	$CanvasLayer/HUD.bomb_count = new_count


func _on_player_player_death():
	$CanvasLayer/HUD.is_game_over = true


func _on_hud_deploy_bomb():
	$Player.try_bomb()

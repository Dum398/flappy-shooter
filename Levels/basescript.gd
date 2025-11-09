extends Node2D
var changenumber = 0
var _dragon_scene = preload("res://Enemies/dragon.tscn")
var _bonus_scene = preload("res://Bonus/bonus.tscn")

var currversion :String = "1.0.1beta"
var _bomb_scene = preload("res://Bonus/bomb_bonus.tscn")
var _star_scene = preload ("res://Bonus/star_bonus.tscn")
var _medkit_scene= preload ("res://Bonus/medkit_bonus.tscn")
var _level2_scene = preload("res://Levels/background_level2.tscn")
var _dragon_health = 2
var feathers = 0
var t1 = load("res://trail.jpg")
var t2 = load("res://trail1.jpg")
var t3 = load("res://trail2.jpg")
var t4 = load("res://trail3.jpg")
var t5 = load("res://trail_skoda_exclusive.jpg")
var s1: SpriteFrames = load("res://Player/Player.tres")
var s2: SpriteFrames = load("res://Player/Player2.tres")
var s3: SpriteFrames = load("res://Levels/gbird.tres")
var s4: SpriteFrames = load("res://Levels/ybird.tres")
var s5: SpriteFrames = load("res://Levels/pbird.tres")
@export var enemies :Array[PackedScene]
@export var weapons :Array[PackedScene]
func _change_level(level_scene :PackedScene):
	for node in $level_content.get_children():
		node.queue_free()
	var _level2 = _level2_scene.instantiate()
	$level_content.add_child(_level2)
func scorelevelchange():
	if $CanvasLayer/HUD.score >= 35:
		if changenumber <= 1:
			_change_level(_level2_scene)
			$Player._bomb_count = $Player._bomb_count + 1
			$Player._bomb_now()
			changenumber = changenumber + 1



func _process(delta):
	scorelevelchange()
func _get_spawn_position():
	var screen_size = get_viewport_rect().size
	return Vector2(screen_size.x, (screen_size.y - 120) * randf())
func _ready():
	$Medkit_spawn.start()

func _on_enemy_spawn_timeout():
	if self.enemies.size() == 0:
		return
		
	var dragon = self.enemies.pick_random().instantiate()
	dragon.position = self._get_spawn_position()
		
	dragon.health = self._dragon_health
	dragon.died.connect(func():
		$CanvasLayer/HUD.score += 1
	)
	self.add_child(dragon)
		


func _on_bonus_spawn_timeout():
#	var bonus = _bonus_scene.instantiate()
# 	bonus.position = self._get_spawn_position()  
#	self.add_child(bonus)  
	pass  

func _on_difficulty_timer_timeout():
	self._dragon_health += 1


func _on_bomb_spawn_timeout():
	var bonus = _bomb_scene.instantiate()
	bonus.position = self._get_spawn_position()
	self.add_child(bonus)
 
func _on_starspawn_timeout():
	var bonus = _star_scene.instantiate()
	bonus.position = self._get_spawn_position()
	self.add_child(bonus)

func _on_player_bomb_count_changed(new_count :int):
	$CanvasLayer/HUD.bomb_count = new_count


func _on_player_player_death():
	$CanvasLayer/HUD.is_game_over = true


func _on_hud_deploy_bomb():
	$Player.try_bomb()
	

func _on_player_health_changed(new_health :int):
	$CanvasLayer/HUD.player_health = new_health


func _on_weapon_spawn_timeout():
	
	if self.weapons.size() == 0:
		return
		
	var weapon = self.weapons.pick_random().instantiate()
	weapon.position = self._get_spawn_position()
		 

	
	self.add_child(weapon)


func _on_medkit_spawn_timeout():
	$Medkit_spawn.wait_time = randi_range(3, 6)
	var bonus = _medkit_scene.instantiate()
	bonus.position = self._get_spawn_position()
	self.add_child(bonus)
	$Medkit_spawn.start()


func _on_hud_skin_1():
	$Player/Icon.sprite_frames = s1


func _on_hud_skin_2():
	$Player/Icon.sprite_frames = s2

func _on_hud_skin_3():
	$Player/Icon.sprite_frames = s3


func _on_timer_timeout():
	$CanvasLayer/HUD/%VBoxContainer.visible = false
	$Player.freeze = false


func _on_hud_skin_4():
	$Player/Icon.sprite_frames = s4


func _on_hud_skin_5():
	$Player/Icon.sprite_frames = s5


func _on_hud_trail_1():
	$Player/%trail.visible = true
	$Player/%trail.texture = t1


func _on_hud_trail_2():
	$Player/%trail.visible = true
	$Player/%trail.texture = t2


func _on_hud_trail_3():
	$Player/%trail.visible = true
	$Player/%trail.texture = t3


func _on_hud_trail_4():
	$Player/%trail.visible = true
	$Player/%trail.texture = t4


func _on_hud_trail_5():
	$Player/%trail.visible = true
	$Player/%trail.texture = t5

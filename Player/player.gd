extends RigidBody2D
signal invincibility_changed(new_count :bool)
signal bomb_count_changed(new_count :int)
signal player_death()
signal health_changed(new_health :int)
signal unknownbonus
## Rychlost pohybu nahoru v px za vteřinu
@export var flap_strength := 400
@export var playerframes :SpriteFrames
@onready var _gun_list = $Guns
@onready var _anim = $Icon as AnimatedSprite2D

@export var health := 3:
	set(new_health):
		health = new_health
		health_changed.emit(new_health)

var _dead = false

var _invincible :bool = false:
	set(new_val):
		_invincible = new_val
		invincibility_changed.emit(new_val)
		if new_val == true:
			$InvincibilityTimer.start()

var _bomb_count :int = 0:
	set(new_count):
		_bomb_count = new_count
		bomb_count_changed.emit(new_count)


func _ready():
	self._bomb_count = 1
	$Icon.sprite_frames = playerframes



func _shoot_now():
	for single_gun in self._gun_list.get_children():
			single_gun.shoot_now()


func _bomb_now():
	get_tree().call_group("enemies", "on_hit", null)
	self._bomb_count -= 1
	
	var root = get_tree().current_scene as Node2D
	root.modulate = Color(0.5, 0, 0)
	RenderingServer.set_default_clear_color(Color(1, 0, 0))

	await get_tree().create_timer(0.2).timeout
	root.modulate = Color(1, 1, 1)
	RenderingServer.set_default_clear_color("4d4d4d")
	

func try_bomb():
	if _bomb_count < 1:
		return
	if self._dead:
		return
	self._bomb_now()


func _process(delta):
	if self._dead:
		if Input.is_action_just_pressed("ui_cancel"):
			get_tree().reload_current_scene()
		return
		
	if Input.is_action_pressed("shoot"):
		self._shoot_now()
	
	if Input.is_action_just_pressed("bomb"):
		self.try_bomb()
 

func _physics_process(delta):
	if self._dead:
		return
	
	if Input.is_action_just_pressed("ui_accept"):
		self.linear_velocity = Vector2.UP * self.flap_strength
		self._anim.play("default")
		


func add_damage(amount :int, who :Node2D):
	if self._invincible and who.has_method("on_hit"):
		who.on_hit(null)
		return
	if self._dead:
		return
	self.health = health - 1	
	
	
	if self.health == 0:
		self._dead = true
		self.linear_velocity = Vector2.UP * 500
		self.player_death.emit()


func add_bonus(bonus :BonusPickup):
	print("Have bonus")
	
	if bonus.bonus_type == BonusPickup.EBonusType.Speed:
		for single_gun in self._gun_list.get_children():
			single_gun.cooldown_time = clampf(single_gun.cooldown_time - 0.05, 0, 2)
	elif bonus.bonus_type == BonusPickup.EBonusType.Bomb:
		self._bomb_count += 1
	elif bonus.bonus_type == BonusPickup.EBonusType.Star:
		self._invincible = true
	elif bonus.bonus_type == BonusPickup.EBonusType.Weapon:
		self.Switch_weapons(bonus.weapon_scene)
	elif bonus.bonus_type == BonusPickup.EBonusType.Medkit:
		if self.health>=3:
			return
		self.health=self.health+1

		
	bonus.queue_free()
func _on_visible_on_screen_notifier_2d_screen_exited():
	self._dead = true
	self.player_death.emit()
	
func Switch_weapons(weapon_scene :PackedScene):
	for child in $Guns.get_children():
		child.queue_free()
	var new_weapon = weapon_scene.instantiate()
	$Guns.add_child(new_weapon)
func _on_invincibility_timer_timeout():
	self._invincible = false




	
	
	

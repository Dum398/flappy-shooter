extends Area2D

signal died

## Rychlost draka v px/s
@export var speed = 200

## Pocet zasahu pro smrt
@export var health = 2


func _ready():
	$AnimatedSprite2D.frame = randi_range(0, 8)
	$AnimatedSprite2D.play("default", (randf() / 2) + 0.8)


func _process(delta):
	var movement = delta * speed
	self.position = self.position + (Vector2.LEFT * movement)


func die_now():
	self.died.emit()
	
	# Spustim efekt vybuchu a pockam chvili
	$GPUParticles2D.emitting = true
	await get_tree().create_timer(0.1).timeout
	
	# Vypnu vybuch a pockam chvili
	$GPUParticles2D.emitting = false
	await get_tree().create_timer(0.3).timeout
	
	# Smazu draka
	self.queue_free()


# shot can be null
func on_hit(shot :Node2D):
	if self.health <= 0:
		return;
	
	if shot == null:
		# Pokud zásah nebyl střelou, umři hned.
		self.health = 0
		self.die_now()
		return
	
	self.health -= 1
	if not self.health <= 0:
		return
		
	self.die_now()


func _on_body_entered(body :Node2D):
	if self.health <= 0:
		return
	if body.has_method("add_damage"):
		body.add_damage(1, self)


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()

extends Area2D
class_name BonusPickup

enum EBonusType {
	Speed,
	Bomb,
	Star
}

@export var speed :int = 200
@export var bonus_type :EBonusType = EBonusType.Speed


func _ready():
	if $AnimatedSprite2D: $AnimatedSprite2D.play()

func _process(delta):
	self.position += Vector2.LEFT * self.speed * delta


func _on_body_entered(body :Node2D):
	if body.has_method("add_bonus"):
		body.add_bonus(self)


func _on_visible_on_screen_enabler_2d_screen_exited():
	self.queue_free()
